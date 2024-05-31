import random
import boto3
import io
import time
import requests
from django.contrib import messages
from django.shortcuts import redirect, render
from django.contrib.auth import logout
from django.conf import settings
from PIL import Image, ImageDraw, ImageFont
from django.core.files import File
from django.core.mail import EmailMultiAlternatives
from weapon_detection.settings import DEFAULT_FROM_EMAIL
from operator import itemgetter
import winsound


from .models import *

client=boto3.client('rekognition', 
                            aws_access_key_id=settings.AWS_ACCESS_KEY_ID,
                            aws_secret_access_key=settings.AWS_SECRET_ACCESS_KEY,
                            region_name=settings.REGION_NAME)


# Create your views here.
def user_register(request):
    if request.method == 'POST':
        name = request.POST.get('name')
        email = request.POST.get('email')
        mobile = request.POST.get('mobile')
        city = request.POST.get('city')
        picture = request.FILES['picture']
        password = request.POST.get('password')
        UserModel.objects.create(name=name,email=email,mobile=mobile,city=city,picture=picture,password=password)
        messages.success(request, 'User Registration Successful')
        return redirect('user_login')
    return render(request, 'user/user-register.html')

def user_login(request):
    if request.method == 'POST':
        email = request.POST.get('email')
        password = request.POST.get('password')
        try:
            obj = UserModel.objects.get(email=email,password=password)
            request.session['user_id']= obj.id
            messages.success(request, 'Login Successful')
            return redirect('user_dashboard')
        except:
            messages.error(request, 'Invalid Login Credentials')
            return redirect('user_login')
        
    return render(request, 'user/user-login.html')

def user_logout(request):
    logout(request)
    messages.success(request, 'Log out Successful')
    return redirect('index')

def dashboard(request):
    return render(request, 'user/user-dashboard.html')

def user_image_rekognition(request):
    user_id = request.session['user_id']
    user = UserModel.objects.get(pk=user_id)
    if request.method == 'POST':   
        
        # try:
            upload_img = request.FILES['image1']
            obj = ImageAnalysisModel.objects.create(upload_image=upload_img)
            photo = 'media/'+str(obj.upload_image)

            with open(photo, 'rb') as im:
                im_bytes = im.read()
                response = client.detect_labels(Image={'Bytes': im_bytes},  MaxLabels=50)
                print(response)
                print('---------------------')
                # print(textres)
                # Upload image to AWS 
                # response = rek_client.detect_labels(Image={'Bytes': im_bytes})
                # Get default font to draw texts
                font = 'EquipoizeSans-Regular.otf'
                # font = 'SF-UI-Display-Ultralight.otf'
                image = Image.open(io.BytesIO(im_bytes))
                font = ImageFont.truetype(font, size=40)
                draw = ImageDraw.Draw(image)
                # Get all labels
                w, h = image.size
                new_labels = [label for label in response['Labels'] if label['Name'] == 'Firearm'
                 or label['Name'] == 'Weapon' or label['Name'] == 'Gun' or label['Name'] == 'Handgun'
                 or label['Name'] == 'Handgun' or label['Name'] == 'Grenade' or label['Name'] == 'Ammunition'
                    or label['Name'] == 'Blade' or label['Name'] == 'Dagger' or label['Name'] == 'Person'
                 ]
                weapon = False
                for label in new_labels:
                    name = label['Name']
                    
                        
                        
                    # Draw all instancex box, if any
                    for instance in label['Instances']:
                        bbox = instance['BoundingBox']
                        x0 = int(bbox['Left'] * w) 
                        y0 = int(bbox['Top'] * h)
                        x1 = x0 + int(bbox['Width'] * w)
                        y1 = y0 + int(bbox['Height'] * h)
                        draw.rectangle([x0, y0, x1, y1], outline=(255, 0, 0), width=5)
                        draw.text((x0, y1), name, font=font, fill=(255, 0, 0))
                for label in new_labels:
                    if  label['Name'] == 'Firearm'or label['Name'] == 'Weapon' or label['Name'] == 'Gun' or \
                        label['Name'] == 'Handgun' or label['Name'] == 'Handgun' or \
                        label['Name'] == 'Grenade' or label['Name'] == 'Ammunition' \
                        or label['Name'] == 'Blade' or label['Name'] == 'Dagger':
                        weapon = True
                        # html_content = "<p>Weapons<strong>Found</strong></p><span></span>"
                        # from_mail = DEFAULT_FROM_EMAIL

                        # to_mail = ["fazalsirprojects@gmail.com"]
                        # print('success')
                        # try:
                        #     msg = EmailMultiAlternatives(
                        #         "Weapons Detection Status", html_content, from_mail, to_mail)
                        #     msg.attach_alternative(html_content, "text/html")
                        #     msg.send()
                        # except:
                        #     pass
                        # #SMS API CODE
                        # url = "https://www.fast2sms.com/dev/bulkV2"
                        # # create a dictionary
                        # my_data = {'sender_id': 'FSTSMS', 
                        #                 'message': 'Weapons Found', 
                        #                 'language': 'english', 
                        #                 'route': 'q', 
                        #                 'numbers':'8555887986',
                        # }
                            
                        #     # create a dictionary
                        # headers = {
                        #         'authorization': "RiE8PuQDhbLnUkKe43p5vHsta0dFTyqcoNS7xrAwC9zO2WjgVG875H0JStiefd23jxPM4aLVzrEYmvOI",
                        #         'Content-Type': "application/x-www-form-urlencoded",
                        #         'Cache-Control': "no-cache"
                        # }
                        #     # make a post request
                        # responses = requests.request("POST",
                        #                                 url,
                        #                                 data = my_data,
                        #                                 headers = headers)
                        messages.info(request, 'Weapons Found')
                        
                        break
                if weapon == False:
                    dem = {}
                    dem['Name'] = 'Weapon'
                    dem['Confidence'] = 0
                    new_labels.append(dem)
                    messages.info(request, 'Weapons Not Found')
                # canvas.paste(qrcode_img)
                # buffer=BytesIO()
                # canvas.save(buffer,"PNG")
                randnumber = random.randint(0,9999)
                buffer = io.BytesIO()
                image.save(buffer, 'PNG')
                obj.modified_image = f'image{randnumber}.jpg'
                obj.modified_image.save(f'image{randnumber}.jpg',File(buffer),save=False)
                obj.save()
                # canvas.close()
                        
            # print(response)
            labels = response['Labels']
            # print(type(labels))
            # obj.labels = labels
            # obj.save()
            
            # sorted_list = sorted(labels, key=itemgetter('Confidence'),reverse=True)
            status = 'image'
            if weapon == True:
                frequency = 2500  # Set Frequency To 2500 Hertz
                duration = 1500  # Set Duration To 1000 ms == 1 second
                winsound.Beep(frequency, duration)
            return render(request , 'user/user-rekognition-result.html',{
                'labels':labels,
                'obj':obj,
                'status':status,
                'weapon':weapon
                })
        # except:
        #     messages.error(request, 'Invalid Request! Please Try Again Later')
        #     return redirect('user_image_rekognition')
    return render(request, 'user/user-image-rekognition.html')

def user_video_rekognition(request):

    if request.method == 'POST':

        # Create an S3 client
        s3 = boto3.client('s3', 
                                aws_access_key_id=settings.AWS_ACCESS_KEY_ID,
                                aws_secret_access_key=settings.AWS_SECRET_ACCESS_KEY,
                                region_name=settings.REGION_NAME)

        # Set the video and bucket name
        upload_video = request.FILES['video']
        print(upload_video.name,'yessssssssssssssssssssssssss')
        obj = ImageAnalysisModel.objects.create(upload_video=upload_video)
        video = 'media/'+str(obj.upload_video)
        # video = "videoplayback.mp4"
        bucket_name = settings.BUCKET_NAME

        # Upload the video to the S3 bucket
        s3.upload_file(video, bucket_name, upload_video.name)


        # Start label detection
        response = client.start_label_detection(
            Video={
                'S3Object': {
                    'Bucket': bucket_name,
                    'Name': upload_video.name
                }
            },
            NotificationChannel={
                'SNSTopicArn': settings.SNS_TOPIC_ARN,
                'RoleArn': settings.ROLE_ARN
            }
        )


        job_id = response['JobId']

        # Wait for the label detection to complete
        while True:
            response = client.get_label_detection(JobId=job_id)
            status = response['JobStatus']
            if status == 'SUCCEEDED':
                break
            elif status == 'FAILED':
                # raise Exception("Label detection failed")
                messages.info(request, 'Object Detection Failed')
                return redirect('user_video_rekognition')
            time.sleep(5)
        # print(response)
        # Get the label detection results
        labels = response['Labels']
        weapon = False
        new_labels = [label for label in labels if label["Label"]['Name'] == 'Person' or
         label["Label"]['Name'] == 'Firearm' or label["Label"]['Name'] == 'Weapon'
         or label["Label"]['Name'] == 'Gun' or label["Label"]['Name'] == 'Handgun'
         or label["Label"]['Name'] == 'Grenade' or label["Label"]['Name'] == 'Ammunition'
         or label["Label"]['Name'] == 'Blade' or label["Label"]['Name'] == 'Dagger'
         ]
        
        s_lable = []
        
        for label in new_labels:
            if label["Label"]['Name'] == 'Weapon':
                s_lable.append(label)
                weapon=True
                print('yesssssssssssssssssssssss')
                messages.info(request, 'Weapon(s) Found')
                break
        
        if weapon == False:
            dem = {}
            label = {}
            label['Name'] = 'Weapon'
            label['Confidence'] = 0
            dem['Label'] = label
            s_lable.append(dem)
            messages.info(request, 'Weapon(s) Not Found')
       
        if weapon == True:
                frequency = 2500  # Set Frequency To 2500 Hertz
                duration = 1500  # Set Duration To 1000 ms == 1 second
                winsound.Beep(frequency, duration)
        return render(request , 'user/user-rekognition-result.html',{
            'labels':s_lable, 
            'obj':obj,
            'weapon':weapon
        })

    return render(request, 'user/user-video-rekognition.html')

def user_result(request,id):
    return render(request, 'user/user-rekognition-result.html')

def user_my_profile(request):
    user_id = request.session['user_id']
    user = UserModel.objects.get(pk=user_id)
    if request.method == 'POST':
        name = request.POST.get('name')
        mobile = request.POST.get('mobile')
        password = request.POST.get('password')
        user.name = name
        user.mobile=mobile
        user.password=password
        try:
            user.picture = request.FILES['picture']
        except:
            pass
        user.save()
        messages.success(request, 'Profile Updated Successfully')
        return redirect('user_my_profile')
    context = {}
    context['user']=user
    return render(request, 'user/user-my-profile.html',context)


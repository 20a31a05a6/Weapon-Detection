from django.db import models

# Create your models here.
class UserModel(models.Model):
    name = models.CharField(max_length=100)
    email = models.EmailField()
    mobile = models.CharField(max_length=12)
    city = models.CharField(max_length=100)
    picture = models.ImageField(upload_to='images/')
    password = models.CharField(max_length=100)

    class Meta:
        db_table = 'user_details'


   

class ImageAnalysisModel(models.Model):
    upload_image = models.ImageField(upload_to='uploads/',null=True)
    modified_image = models.ImageField(upload_to='modified/',null=True)
    upload_video = models.FileField(upload_to='uploads/videos/',null=True)
    labels = models.TextField(null=True)

    class Meta:
        db_table = 'image_analysis'


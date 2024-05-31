from django.urls import path
from . import views as userViews

urlpatterns = [
    path('dashboard',userViews.dashboard,name='user_dashboard'),
    path('user-image-rekognition',userViews.user_image_rekognition,name='user_image_rekognition'),
    path('objects-rekognition-result/<str:id>',userViews.user_result,name='user_result'),
    path('login',userViews.user_login,name='user_login'),
    path('logout',userViews.user_logout,name='user_logout'),
    path('register',userViews.user_register,name='user_register'),
    path('profile',userViews.user_my_profile,name='user_my_profile'),
    path('user-video-rekognition',userViews.user_video_rekognition,name='user_video_rekognition'),
]
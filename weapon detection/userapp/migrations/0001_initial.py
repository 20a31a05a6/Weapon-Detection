# Generated by Django 4.1.5 on 2023-01-23 05:41

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='ImageAnalysisModel',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('upload_image', models.ImageField(null=True, upload_to='uploads/')),
                ('modified_image', models.ImageField(null=True, upload_to='modified/')),
                ('upload_video', models.FileField(null=True, upload_to='uploads/videos/')),
                ('labels', models.TextField(null=True)),
            ],
            options={
                'db_table': 'image_analysis',
            },
        ),
        migrations.CreateModel(
            name='UserModel',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('email', models.EmailField(max_length=254)),
                ('mobile', models.CharField(max_length=12)),
                ('city', models.CharField(max_length=100)),
                ('picture', models.ImageField(upload_to='images/')),
                ('password', models.CharField(max_length=100)),
            ],
            options={
                'db_table': 'user_details',
            },
        ),
    ]
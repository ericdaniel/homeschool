# Generated by Django 3.1.8 on 2021-04-25 04:43

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [("students", "0003_auto_20210422_1433")]

    operations = [
        migrations.RemoveField(model_name="enrollment", name="uuid"),
        migrations.RemoveField(model_name="grade", name="uuid"),
        migrations.RemoveField(model_name="student", name="uuid"),
    ]

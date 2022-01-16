from dataclasses import field
from django.db import models

# Create your models here.
class Food(models.Model):
    class Meta:
        unique_together = (('UUID', 'name', 'datePurchased'),)
    UUID = models.ForeignKey(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=50)
    type = models.CharField(max_length=20)
    datePurchased = models.DateField()
    daysBeforeExpire = models.IntegerField()

class Recipe(models.Model):
    class Meta:
        unique_together = (('id', 'UUID'),)
    UUID = models.ForeignKey(User, on_delete=models.CASCADE)
    id = models.CharField(max_length=50, primary_key=True)
    name = models.CharField(max_length=100)
    imageUrl = models.CharField(max_length=200)

class ShoppingListItem(models.Model):
    class Meta:
        unique_together = (('name', 'UUID'),)
    UUID = models.ForeignKey(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=50)
    type = models.CharField(max_length=20)
    daysBeforeExpire = models.IntegerField()

class User(models.Model):
    UUID = models.UUIDField(primary_key=True)


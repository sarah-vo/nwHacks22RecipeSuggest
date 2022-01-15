from dataclasses import field
from django.db import models

# Create your models here.
class Food(models.Model):
    class Meta:
        unique_together = (('name', 'datePurchased'),)

    name = models.CharField(max_length=50)
    type = models.CharField(max_length=20)
    datePurchased = models.DateField()
    daysBeforeExpire = models.IntegerField()

    def __str_(self):
        return self.name + ", bought" + self.datePurchased

class Recipe(models.Model):
    id = models.CharField(max_length=50, primary_key=True)
    name = models.CharField(max_length=100)
    imageUrl = models.CharField(max_length=200)

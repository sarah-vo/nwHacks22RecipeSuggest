from .models import Food, Recipe
from rest_framework import serializers

class FoodSerializers(serializers.ModelSerializer):
    class Meta:
        model = Food
        fields = ['name', 'type', 'datePurchased', 'daysBeforeExpire' ]

class RecipeSerializers(serializers.ModelSerializer):
    class Meta:
        model = Recipe
        fields = ['id', 'name', 'imageUrl']
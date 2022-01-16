from http.client import HTTPResponse
from django.shortcuts import render
from rest_framework import viewsets, permissions

from .models import Food, Recipe
from .serializer import FoodSerializers, RecipeSerializers

# Create your views here.
class FoodViewSet(viewsets.ModelViewSet):
    queryset = Food.objects.all()
    serializer_class = FoodSerializers
    permisison_classes = [permissions.IsAuthenticated]

class RecipeViewSet(viewsets.ModelViewSet):
    queryset = Recipe.objects.all()
    serializer_class = RecipeSerializers
    permisison_classes = [permissions.IsAuthenticated]
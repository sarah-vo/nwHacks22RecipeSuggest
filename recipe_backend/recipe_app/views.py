from http.client import HTTPResponse
from django.shortcuts import render
from rest_framework import viewsets, permissions

from .models import Food, Recipe
from .serializer import FoodSerializers

# Create your views here.
class FoodViewSet(viewsets.ModelViewSet):
    queryset = Food.objects.all(),
    serializer_class = FoodSerializers
    permisison_classes = [permissions.IsAuthenticated]
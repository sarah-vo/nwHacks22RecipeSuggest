from http.client import HTTPResponse
from django.shortcuts import render
from rest_framework import viewsets, permissions

from .models import *
from .serializer import *

# Create your views here.
class FoodViewSet(viewsets.ModelViewSet):
    queryset = Food.objects.all()
    serializer_class = FoodSerializers
    permisison_classes = [permissions.IsAuthenticated]

class ShoppingListItemViewSet(viewsets.ModelViewSet):
    queryset = ShoppingListItem.objects.all()
    serializer_class = ShoppingListItemSerializers
    permisison_classes = [permissions.IsAuthenticated]

class RecipeViewSet(viewsets.ModelViewSet):
    queryset = Recipe.objects.all()
    serializer_class = RecipeSerializers
    permisison_classes = [permissions.IsAuthenticated]

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializers
    permisison_classes = [permissions.IsAuthenticated]

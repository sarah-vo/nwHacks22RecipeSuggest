from django.urls import path, include
from . import views
from rest_framework import routers

router = routers.DefaultRouter()
router.register(r'food', views.FoodViewSet)
router.register(r'shoppinglistitem', views.ShoppingListItemViewSet)
router.register(r'recipe', views.RecipeViewSet)
router.register(r'user', views.UserViewSet)



urlpatterns = [
    path('', include(router.urls)),
    path('api-auth/', include('rest_framework.urls'))
]
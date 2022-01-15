from django.db.models.query import QuerySet
from rest_framework import generics
from rest_framework.serializers import Serializer
from .models import Todo
from .serializers import TodoSerializer

class TodoGetCreate(generics.ListCreateAPIView):
    queryset = Todo.objects.all()
    serializer_class = TodoSerializer

class TodoUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = Todo.objects.all()
    serializer_class = TodoSerializer
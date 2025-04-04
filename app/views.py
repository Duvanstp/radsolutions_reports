from django.shortcuts import render
from django.http import JsonResponse

def main(request):
    data = {
        "mensaje": "Hola desde RadSolutions"
    }
    return JsonResponse(data)


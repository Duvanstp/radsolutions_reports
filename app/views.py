from django.shortcuts import render
from django.http import JsonResponse

def main(request):
    context = {
        "titulo": "Página Principal",
        "mensaje": "Bienvenido a RadSolutions Reports"
    }
    return render(request, 'main.html', context)


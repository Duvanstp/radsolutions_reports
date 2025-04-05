from django.shortcuts import render, redirect, get_object_or_404
from django.http import JsonResponse
from django.contrib.auth.decorators import login_required
from django.urls import reverse_lazy
from django.views.generic import ListView, CreateView, UpdateView, DeleteView, DetailView
from django.contrib.auth.mixins import LoginRequiredMixin
from .models import User, Report
from django.contrib.auth.forms import UserCreationForm
from django import forms
from django.contrib.auth.views import LoginView
from django.urls import reverse
from django.contrib.auth import logout

# Forms
class UserForm(UserCreationForm):
    class Meta:
        model = User
        fields = ['username', 'first_name', 'last_name', 'email']

class ReportForm(forms.ModelForm):
    class Meta:
        model = Report
        fields = ['title', 'description', 'pdf_file']

# Login view
class CustomLoginView(LoginView):
    template_name = 'login.html'
    
    def get_success_url(self):
        return reverse('home')

# Logout view
def logout_view(request):
    logout(request)
    return redirect('login')

def main(request):
    if not request.user.is_authenticated:
        # Si el usuario no está autenticado, mostrar una página de bienvenida sencilla
        context = {
            "titulo": "Bienvenido a RadSolutions Reports",
            "mensaje": "Inicia sesión para acceder al sistema"
        }
        return render(request, 'welcome.html', context)
    
    # Si el usuario está autenticado, mostrar la página principal con acceso a todas las funcionalidades
    context = {
        "titulo": "Página Principal",
        "mensaje": "Bienvenido a RadSolutions Reports"
    }
    return render(request, 'main.html', context)

# User Views
class UserListView(LoginRequiredMixin, ListView):
    model = User
    template_name = 'users/user_list.html'
    context_object_name = 'users'
    login_url = '/login/'

class UserDetailView(LoginRequiredMixin, DetailView):
    model = User
    template_name = 'users/user_detail.html'
    context_object_name = 'user'
    login_url = '/login/'

class UserCreateView(LoginRequiredMixin, CreateView):
    model = User
    form_class = UserForm
    template_name = 'users/user_form.html'
    success_url = reverse_lazy('user_list')
    login_url = '/login/'

class UserUpdateView(LoginRequiredMixin, UpdateView):
    model = User
    form_class = UserForm
    template_name = 'users/user_form.html'
    success_url = reverse_lazy('user_list')
    login_url = '/login/'

class UserDeleteView(LoginRequiredMixin, DeleteView):
    model = User
    template_name = 'users/user_confirm_delete.html'
    success_url = reverse_lazy('user_list')
    login_url = '/login/'

# Report Views
class ReportListView(LoginRequiredMixin, ListView):
    model = Report
    template_name = 'reports/report_list.html'
    context_object_name = 'reports'
    login_url = '/login/'

class ReportDetailView(LoginRequiredMixin, DetailView):
    model = Report
    template_name = 'reports/report_detail.html'
    context_object_name = 'report'
    login_url = '/login/'

class ReportCreateView(LoginRequiredMixin, CreateView):
    model = Report
    form_class = ReportForm
    template_name = 'reports/report_form.html'
    success_url = reverse_lazy('report_list')
    login_url = '/login/'
    
    def form_valid(self, form):
        form.instance.user = self.request.user
        return super().form_valid(form)

class ReportUpdateView(LoginRequiredMixin, UpdateView):
    model = Report
    form_class = ReportForm
    template_name = 'reports/report_form.html'
    success_url = reverse_lazy('report_list')
    login_url = '/login/'

class ReportDeleteView(LoginRequiredMixin, DeleteView):
    model = Report
    template_name = 'reports/report_confirm_delete.html'
    success_url = reverse_lazy('report_list')
    login_url = '/login/'


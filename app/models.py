from django.contrib.auth.models import AbstractUser
from django.db import models
from django.core.files.storage import default_storage
from django.conf import settings
from app.mystorage import PDFStorage


class User(AbstractUser):
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.first_name} {self.last_name} ({self.email})"


class Report(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="reports")
    title = models.CharField(max_length=200)
    description = models.CharField(max_length=400, blank=True, null=True)
    pdf_file = models.FileField(upload_to="reports_pdfs/", storage=PDFStorage())  # usa DEFAULT_FILE_STORAGE automáticamente
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Report by {self.user.first_name}: {self.title}"

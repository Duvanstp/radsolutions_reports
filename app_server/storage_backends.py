from storages.backends.s3boto3 import S3Boto3Storage

class MediaStorage(S3Boto3Storage):
    location = 'media'
    file_overwrite = False
    default_acl = 'public-read'
    
    def get_available_name(self, name, max_length=None):
        return super().get_available_name(name, max_length=max_length) 
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import path, include

from catalog import settings
from .yasg import urlpatterns as doc_urls

urlpatterns = [
    path('admin/', admin.site.urls),
    path('handbook/', include('handbook.urls')),
]

urlpatterns += doc_urls

if settings.DEBUG:
    import debug_toolbar
    urlpatterns = [
        path('__debug__/', include(debug_toolbar.urls)),
    ] + urlpatterns

    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
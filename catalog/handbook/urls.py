from os import path

from handbook.views import index

urlpatterns = [
    path('', index)
]

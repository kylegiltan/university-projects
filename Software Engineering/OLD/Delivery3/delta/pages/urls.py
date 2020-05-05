# pages/urls.py
from django.urls import path

from .views import HomePageView, AboutPageView # new
#this is the urls that is has to choose from for a view
urlpatterns = [
    path('about/', AboutPageView.as_view(), name='about'), # new
    path('', HomePageView.as_view(), name='home'),
    #path('', ResetPageView.as_view(), name = 'reset'),
]

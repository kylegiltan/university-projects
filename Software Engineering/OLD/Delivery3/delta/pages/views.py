from django.shortcuts import render
from django.http import HttpResponse
from django.views.generic import TemplateView




# Create your views here.
#each one is a different html page
#chooses the view based on the url chosen

class HomePageView(TemplateView):
    template_name = 'home.html'

class AboutPageView(TemplateView):
    template_name = 'about.html'

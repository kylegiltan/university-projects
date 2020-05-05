from django.shortcuts import render

# Create your views here.

def home(request):
    context = {}
    return render(request, 'question/home.html', context)

def create(request):
    context = {}
    return render(request, 'question/create.html', context)

def vote(request, poll_id):
    context = {}
    return render(request, 'question/vote.html', context)

def results(request, poll_id):
    context = {}
    return render(request, 'question/results.html', context)

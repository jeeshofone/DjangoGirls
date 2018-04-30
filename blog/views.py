from django.shortcuts import render
from django.shortcuts import get_object_or_404
from django.shortcuts import redirect
from django.utils import timezone
from .models import Post
from .forms import PostForm


def post_list(request):
    posts = Post.objects.filter(published_date__lte=timezone.now())
    posts = posts.order_by('-published_date')
    return render(request, 'blog/post_list.html', {'posts': posts})


def post_draft_list(request):
    posts = Post.objects.filter(published_date__isnull=True).order_by('created_date')
    return render(request, 'blog/post_draft_list.html', {'posts': posts})


def post_detail(request, pk):
    post = get_object_or_404(Post, pk=pk)
    return render(request, 'blog/post_detail.html', {'post': post})


def post_new(request):
    if request.method == "POST":
        form = PostForm(request.POST)
        if form.is_valid():
            return __post_details_from(__post_save(form, request.user))
    else:
        form = PostForm()
    return render(request, 'blog/post_edit.html', {'form': form})


def post_edit(request, pk):
    post = get_object_or_404(Post, pk=pk)
    if request.method == "POST":
        form = PostForm(request.POST, instance=post)
        if form.is_valid():
            return __post_details_from(__post_save(form, request.user))
    else:
        form = PostForm(instance=post)
    return render(request, 'blog/post_edit.html', {'form': form})


def post_publish(request, pk):
    post = get_object_or_404(Post, pk=pk)
    post.publish()
    return redirect('post_detail', pk=pk)


def __post_save(form, user):
    post = form.save(commit=False)
    post.author = user
    post.published_date = timezone.now()
    post.save()
    return post


def __post_details_from(post):
    return redirect('post_detail', pk=post.pk)

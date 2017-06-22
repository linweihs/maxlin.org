---
layout: layout
class: home
---

<h2 class="bordered">Blog</h2>
<ul>
    {% for post in site.posts %}
        {% if post.categories contains 'blog' %}
    <li>
        <a href="{{ post.url }}">{{ post.title }}</a>
        <time datetime="{{post.date | date: "%Y-%m-%d"}}">
            {{ post.date | date: "%B %e, %Y" }}
        </time>
    </li>
        {% endif %}
    {% endfor %}
</ul>
<h2 class="bordered">Code</h2>
<ul>
    {% for post in site.posts %}
        {% if post.categories contains 'code' %}
    <li>
        <a href="{{ post.url }}">{{ post.title }}</a>
        <time datetime="{{post.date | date: "%Y-%m-%d"}}">
            {{ post.date | date: "%B %e, %Y" }}
        </time>
    </li>
        {% endif %}
    {% endfor %}
</ul>

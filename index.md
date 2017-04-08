---
layout: layout
class: home
---

<h2 class="bordered">Blog</h2>
<ul>
    {% for post in site.posts %}
    <li>
        <a href="{{ post.url }}">{{ post.title }}</a>
        <time datetime="{{post.date | date: "%Y-%m-%d"}}">
            {{ post.date | date: "%B %e, %Y" }}
        </time>
    </li>
    {% endfor %}
</ul>

---
title: Syntax Highlighter and Markdown 
layout: post
class: post
category: blog
comments: true
---
## Syntax Highligher

Pick One: [Rouge](http://rouge.jneen.net/), [highlight.js](https://highlightjs.org/)

### Usage:
* Rouge

    ```bash
    # default to thankful_eyes style
    $ rougify style > rouge.css 
    
    # available styles 
    $ rougify help style
    usage: rougify style [<theme-name>] [<options>]
    
    Print CSS styles for the given theme.  Extra options are
    passed to the theme.  Theme defaults to thankful_eyes.
    
    options:
      --scope(default: .highlight) a css selector to scope by
    
    available themes:
      base16, base16.dark, base16.monokai, base16.monokai.light, base16.solarized, base16.solarized.dark, colorful, github, gruvbox, gruvbox.light, molokai, monokai, monokai.sublime, thankful_eyes, tulip
    
    # specify style
    $ rougify style colorful > rouge.css
    ```
    
    Insert to html header
    
    ```html
    <link rel="stylesheet" href="/path/to/styles/rouge.css">
    ```

* highlight.js

    Download css stylesheet.
    Available [color themes](http://jmblog.github.io/color-themes-for-highlightjs/)
    
    ```html
    <!-- insert to header -->
    <link rel="stylesheet" href="/path/to/styles/default.css">
    
    <!-- insert to bottom of body -->
    <script src="/path/to/highlight.pack.js"></script>
    <script>hljs.initHighlightingOnLoad();</script>
    ```

### Code Snippet Usage

Highlight with your favorite languages.

<pre>
```java
public class HelloWorld {

    public static void main(String[] args) {
        // Prints "Hello, World" to the terminal window.
        System.out.println("Hello, World");
    }

}
```
</pre>

becomes..

```java
public class HelloWorld {

    public static void main(String[] args) {
        // Prints "Hello, World" to the terminal window.
        System.out.println("Hello, World");
    }
}
```

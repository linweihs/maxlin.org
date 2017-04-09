# Tech stacks
* [Jekyll](https://jekyllrb.com/), [nodejs](https://nodejs.org/en/), [nginx](https://nginx.org/en/)(Reverse proxy)
 
# Environment
OS: Ubuntu

### Homebrew (optional) (recommended on Mac)
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## nodejs
Incredible simple way to install latest nodejs is by nvm

### Install node using nvm 
```
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash
```
Activate nvm by typing the following at the command line.
It set env variables and path in ~/.bashrc
```
. ~/.nvm/nvm.sh
```

Use nvm to install the version of Node.js you intend to use by typing the following at the command line.
```
nvm install 6.10.1
```

### Install node using brew

```
brew install node@6
```

you can always search for versions available on brew.
e.g.
```
brew search node
```

# Running Server
```
node app.js <port>
```
OR
```
npm start # defined in package.json
```

## Jekyll
```
gem install jekyll bundler

```
Make sure gcc -v and make -v are available, otherwise see error.

## Nginx
 
On the Ubuntu node, run ...
```
apt-get install nginx
```
configuration path
```
/etc/nginx/nginx.conf
```
status, start, reload, etc
```
sudo service nginx status
```
how to configure...[tutorial](https://www.linode.com/docs/websites/nginx/how-to-configure-nginx)

## Supervisor (daemontools)
```
apt-get install supervisor
```

# Data 
* Most of the data are served static page, so I wrote in html, markdown languages.
* Jekyll generate HTLM files.


# CSS
* Bootstrap 3
* font-awesome (glyph)
* customize fontsize, fontfamily using bootstrap.less
* Build bootstrap with less
* modify variables.less to suit the needs
* fonts: [Google fonts](https://fonts.google.com/)

Tutorial
* http://www.helloerik.com/bootstrap-3-less-workflow-tutorial
* https://doc.bccnsoft.com/docs/bootstrap-docs/less.html#compiling

```
npm install -g less less-plugin-clean-css
cd less
lessc --clean-css bootstrap.less /css/bootstrap.min.css
```

## Changing the icon font location
Bootstrap assumes icon font files will be located in the ../fonts/ directory, relative to the compiled CSS files.


# Directory Layout
```
├── Gemfile
├── Gemfile.lock
├── README.md
├── _config.yml          --> Jekyll config file
├── _includes            --> Jekyll directory for storing partials
│   ├── about.html
│   ├── contact.html
│   ├── education.html
│   ├── hey.html
│   ├── imalso.html
│   └── workExperience.html
├── _layouts             --> Jekyll directory for storing scaffolding 
│   ├── default.html
│   ├── layout.html
│   └── post.html
├── _posts               --> Jekyll directory for storing blog posts
│   ├── 2017-04-07-First-blog-post.markdown
│   └── 2017-04-08-Hello-Blog.markdown
├── _site                --> Jekyll generate html files after running build
├── app.js               --> my nodejs app
├── css                  
│   ├── bootstrap.min.css
│   └── font-awesome.min.css
├── fonts                --> storing glyph from font-awesome
│   ├── FontAwesome.otf
│   ├── fontawesome-webfont.eot
│   ├── fontawesome-webfont.svg
│   ├── fontawesome-webfont.ttf
│   ├── fontawesome-webfont.woff
│   ├── fontawesome-webfont.woff2
│   ├── glyphicons-halflings-regular.eot
│   ├── glyphicons-halflings-regular.svg
│   ├── glyphicons-halflings-regular.ttf
│   ├── glyphicons-halflings-regular.woff
│   └── glyphicons-halflings-regular.woff2
├── images               --> store images
│   ├── profilepic_1.png
│   └── profilepic_2.jpg
├── less
│   ├── bootstrap/       --> bootstram 3 less file stay untouch
│   ├── mystyle.less     --> overwrite custom setting by variables
│   ├── mytype.less      --> same above
│   └── myvariables.less --> same above
├── index.md             --> jekyll starting page 
├── nginx.conf           --> my nginx conf
├── package.json
└── resume               --> cusom folder to store resume pages
    └── index.md
```

### Action items
1. Run nodejs by supervisor
2. Run nodejs on locahost only, not exposed to WWW
3. Way to publish content easily through cmd or CI/CD
4. Nginx configuration on SSL.

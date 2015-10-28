# tufte-jekyll theme

The *Tufte-Jekyll* blog theme is based on the github repository by Edward Tufte [here](https://github.com/edwardtufte/tufte-css), which was orginally created by Dave Leipmann, but is now labeled under Edward Tufte's moniker. I borrowed freely from the Tufte-CSS repo and have transformed many of the typographic and page-structural features into a set of custom Liquid tags that make creating content using this style much easier than writing straight HTML. Essentially, if you know markdown, and mix in a few custom Liquid tags, you can be creating a website with this document style in short order.

## Demo

A sample site with self-documenting content is available [here](http://clayh53.github.io/tufte-jekyll/) on github pages.

## Installation

I'm not going to go into great detail here. I am just going to assume that anyone interested in either Jekyll, Edward Tufte's work or Github has some basic skills. I created this with Ruby 2.2.0 and Jekyll 2.5.3. There is absolutely nothing exotic going on here, so you can probably make any recent version of Jekyll work with this setup.

So copy, pull, download a zipfile or whatever and fire it up. 

```
%> cd ~/thatPlaceYouPutIt/tufte-jekyll
%> jekyll build
%> jekyll serve -w
```

And then point your browser at localhost:4000/tufte-jekyll/

## Configuration

### Jekyll site building options

I have created a very simple site options file in the ```/_data``` directory that contains two settings currently. The file in the github repo looks like this:
```
mathjax: true
lato_font_load: true
```
Removing either 'true' value will prevent the jekyll site building process from adding links to either the Mathjax library or the Google Fonts Lato font as a fallback for the Gill Sans. Set these values to blank if you want to really streamline your page loading time.

### SASS

I am using Sass to create the css file used by this theme. If you would like to change things like fonts, text colors, background colors and so forth, edit the ```_scss/_settings.scss``` file. This file gets loaded first when Jekyll constructs the master CSS file from the tufte.scss SASS file, and contains SASS variables that influence the appearance of the site. The one variable that may be of interest to some is the ```$link-style``` variable, which can be set to either ```underline``` or ```color```. This will determine if your links are styled using the ```$contrast-color``` variable with no underlining, or whether they are styled using light underlining as seen on the [*tufte-css*](https://github.com/edwardtufte/tufte-css) repo.  


### Social icons

You can edit the ```_data/social.yml``` file and put in your own information for the footer links

### Silly-ass badge in the upper left

In the ```/assets/img``` directory is a file called ```badge_1.png```. This file's parent is ```badge_1.psd``` and is an editable photoshop file with layers for the letters comprising the initials. Change them to suit your fancy. Or just substitute another badge in its place. You can edit the ```/_includes/header.html``` file and change the file that it points too. Find your favorite Tufte emoji and fly your freak flag proudly.



## Some things about the things

I needed to create several custom Liquid tags to wrap content in the right kind of tags. You will create your posts in the normal way in the ```_posts``` directory, and then edit them with Github-Flavored Markdown. To all that GFM goodness, you can use the following custom Liquid tags in your content area. 

Note that these tags *have been altered* from Version 1 of this theme to accommodate some responsive features, namely the ability to reveal hidden sidenotes, margin notes and margin figures by tapping either a superscript or a symbol on small screens. This requires you to add a parameter to the tag that is a unique *ID* for each tag instance on the page. What the id is called is not important, but it is important that it be unique for each individual element on the page. I would recommend in the interest of sanity to give names that are descriptive, like ```'sn-id-1'``` or ```'mf-id-rhino'```.

### Sidenote

This tag inserts a *sidenote* in the content, which is like a footnote, only its in the spacious right-hand column. It is automatically numbered, starting over on each page. Just put it in the content like you would insert a footnote like so:

```
blah lorem blah{% sidenote 'sidenote-id' 'This is a random sidenote'%} blah blah
```
And it will add the html spans and superscripts. On smaller screens, tapping on the number will reveal the sidenote!

### Margin note

This tag is essentially the same as a sidenote, but heh, no number. Like this:

```
lorem nobeer toasty critters{% marginnote 'margin-note-id' 'Random thought when drinking'%} continue train of thought
```
On smaller screens, tapping on the <span>&#8853;</span> symbol will open up the margin note.

### Full width image

This tag inserts an image that spans both the main content column and the side column. Full-width IOW:

```
blah blah {% fullwidth '/url/to/image' 'A caption for the image'}
```

### Main column image

This tag inserts an image that is confined to the main content column:

```
blah blah{% maincolumn '/path/to/image' 'This is the caption' %} blah
```
No need for an ID in this tag because it doesn't have any doohickies that open and close on narrow screens.

### Margin figure

This tag inserts and image in the side column area. Note that an id needs to be specified:

```
blah blah {% marginfigure 'margin-figure-id' '/path/to/image' 'This is the caption' %} blah
```
This needs an ID parameter so that it can be clicked and opened on small screens.

### New thought

This tag will render its contents in small caps. Useful at the beginning of new sections:

```
{% newthought 'This will be rendered in small caps %} blah blah
```
### Mathjax

Totally used this functionality from a [gist by Jessy Cowan-Sharpe](https://gist.github.com/jessykate/834610) to make working with Mathjax expressions a little easier. Short version, wrap inline math in a tag pair thusly: ```{% m %}mathjax expression{% em %}``` and wrap bigger block level stuff with ```{% math %}mathjax expression{% endmath %}```

As a side note - if you do not need the math ability, navigate to the ```_data/options.yml``` file and change the mathjax to 'false' and it will not load the mathjax javascript.

### Which brings me to this

Getting this thing to display properly on *Github Pages* revealed an issue with path names. So here is the deal: In the ```/_config.yml``` file is a setting called *baseurl*. This is used by the Jekyll engine to construct all the proper links in the static site. This is all well and good for the bones of the site. Right now it is set to '*tufte-jekyll*' and all the links are created assuming that is the root path. On your local installation, if you tire of typing in ```localhost:4000/tufte-jekyll``` all you need to do is change that baseurl parameter to '/'.

However... When writing content that includes images that are inside the custom Liquid tags, you must hard-code the *entire* path for your intended site configuration. One might think it possible to enter an image path something like ```{{site.baseurl}}/assets/img/someimage.png``` and it would be properly fleshed out. But my Liquid tags are pretty dumb, and they do not recursively call the Liquid engine to properly build the url. At the present, my N00b status in the Ruby language has prevented me from fixing this problem. So what you will need to do is explicitly embed the ```site.baseurl``` in the url. So for one of the image tags, you might code it as:

```
{% marginfigure 'mf-id-1' '/tufte-jekyll/assets/img/rhino.png' 'F.J. Cole, “The History of Albrecht Dürer’s Rhinoceros in Zoological Literature,” *Science, Medicine, and History: Essays on the Evolution of Scientific Thought and Medical Practice* (London, 1953), ed. E. Ashworth Underwood, 337-356. From page 71 of Edward Tufte’s *Visual Explanations*.'  %}
```

Here are some discussions about the reason behind the baseurl business:

* [Jekyll docs](http://jekyllrb.com/docs/configuration/)
* [Parker Moore](http://blog.parkermoore.de/2014/04/27/clearing-up-confusion-around-baseurl/)
* [Andrew Shell](http://blog.andrewshell.org/understanding-baseurl/)

### Rakefile

I have added a boilerplate Rakefile directly from the [jekyll-rake-boilerplate repo](https://github.com/gummesson/jekyll-rake-boilerplate). This saves you a small amount of time by prepending the date on a post name and populated the bare minimum of YAML front matter in the file. Please visit the link to the repo to find out how it runs. One thing to note is that there should be *no* space between the task and the opening bracket of your file name. ```rake post["Title"]``` will work while ```rake post ["Title"]``` will not. 

There is another rakefile (UploadtoGithub.Rakefile) included that only has one task in it - an automated upload to a *Github Pages* location of the site. This is necessary because of the plugins used by this theme. It does scary stuff like move your ```_site``` somewhere safe, delete everything, move the ```_site``` back and then do a commit to the ```gh-pages``` branch of your repository. You can read about it [here](http://blog.nitrous.io/2013/08/30/using-jekyll-plugins-on-github-pages.html). You would only need to use this if you are using Github project pages to host your site. Integration with the existing Rakefile is left as an exercise for the reader.

### To-do list

One very cool option would be for someone to monkey with the SASS file so that when the full-width page option is picked *margin notes* and *side notes* can be used, but opened by the same clicking technique as is implemented on smaller screens.




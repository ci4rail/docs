# docs
Documentation for Ci4Rail products.

## Base Template
As entrypoint the template minimal-mistakes was selected:
Version 3d3cb58a2efa2c8b1ed4d9f93f48419e9e0aedec from 03.03.2021.


## Run theme locally

Preconditions:
See [jekyll docs](https://jekyllrb.com/docs/installation/) for instructions how to install jekyll on your machine.


Start server locally:
```
bundle update
bundle exec jekyll serve
```

Visit `http://localhost:4000/` to see webside.

> Note: Run `bundle exec jekyll serve --drafts` to view the template page on `http://localhost:4000/template/` for impression how to design a side and how it will look like.


## View Latest Version
Latest version (main brauch) is published on:
https://docs.ci4rail.com/


## Pre-Commit Hooks

Pre-commit hooks are used to ensure a minimum level of quality in each commit.

Pre-commit hook require a installation of Python Pip on the system. If not already installed, do this before:
* On Windows, this is included in [Python installation](https://www.python.org/downloads/)
* On Linux install Pip directly e.g. `apt install python3-pip`

Afterwards install pre-commit:

```
pip3 install pre-commit
```

Install pre-commit hooks in repository:
```
pre-commit install
```

> Note: After each fresh checkout of a repository `pre-commit install` has to be repeated.

## How to Change Documentation Content
The repository contains a lot of stuff, but only a view directories are required for documentation adaption:
```
├── assets
│   ├── css
│   ├── images <----------- Place here your figures you want to include into the docs
│   └── js
├── _data <---------------- Contains the main menu displayed on the top of the webside
│   └── sidebars <--------- Contains the sidebar and subsidebars
├── _drafts <-------------- Containts template file
├── _includes
├── _layouts
├── node_modules
├── _pages
├── _posts
├── _quick-start-guide <--- Contains all doc files from quick start guide section
├── _sass
├── _site
├── _user-manual  <-------- Contains all doc files from user manual section
├── _video-categories <---- Place here files to group videos in categories
└── _videos <-------------- Place here files to point to videos in well known vido platforms
```

> Please [run theme locally](#run-theme-locally) to see how your changes will behave on the production website.

> Please ensure to install pre-commit hooks every new checkout of the repository to ensure a minimum level of quality every commit. See [Pre-Commit Hooks](#pre-commit-hooks) for install instructions.

> For inspiration what can be done with doc pages in this template have a look at the template file `_drafts/template.md` which is generated to `http://localhost:4000/template/` when running the server with `--drafts` option.

> Don't use more than 5 heading depths.

### Naming Convention for Page Titles
Use well known practices to define a page title, see e.g. [How to Write a News Article: Headlines](https://spcollege.libguides.com/c.php?g=254319&p=1695321).

Also consider correct capitalizing for headlines, see e.g. [How Should I Capitalize my Headlines](https://www.hipb2b.com/blog/how-should-i-capitalize-my-headlines).

### Naming Conventions for File Names and Folders

- use only small letters
- DO NOT USE SPACES!
- no soderzeichen
- separate words with `-` e.g. "total great stuff" -> total-great-stuff.jpg
- naming shall reflect the content
- DO not add pictures greater than > 500 KB
- name of doc page shall contain title, but shorts can be used


### how to add pictures
TODO

### How to Modify a Page
Assume that the website has the following sidebar and you want to customize the page marked in orange:

<img src=".readme/sidebar.png" alt="Sidebar" height="300px">

Get the url of the page and use the path behind the base path
<pre><code>http://localhost:4000/<strong style="color:red">user-manual/edge-solutions/moducop/use/installing-accessories</strong>/
</code></pre>

to find the page in the directory structure by just ignoring the `_`, leading numbering and the fileending:

<pre><code>_<strong style="color:red">user-manual/</strong>03-<strong style="color:red">edge-solutions/</strong>02-<strong style="color:red">moducop/</strong>03-<strong style="color:red">use/</strong>03-<strong style="color:red">installing-accessories</strong>.md
</code></pre>

Each docuentation file has a YAML front matter at the top, eg.:

```yaml
---
title: Installing Accessories
permalink: /user-manual/edge-solutions/moducop/use/installing-accessories/
excerpt: How to install accessories on ModuCop.
last_modified_at: 2021-04-13
---
```
This is used to define page metadata:
* **title:** Headline of the page, shown at the top of the page below the breadcrumps and in the browser tab
* **permalink:** Together with the base path this results in the page url, e.g. https://docs.ci4rail.com[permalink]
* **excerpt:** A short description of the page content
* **last_modified_at:** Needs to be updated manually and shows when the page was updated the last time

Add the content below the front matter.

### How to Add a Page
Assume that the website has the following sidebar and you want to add another page with the title `Demo Page` after the page highlighted in orange on the same level:

<img src=".readme/sidebar.png" alt="Sidebar" height="300px">

Get the url of the page and use the path behind the base path
<pre><code>http://localhost:4000/<strong style="color:red">user-manual/edge-solutions/moducop/use/installing-accessories</strong>/
</code></pre>

to find the page in the directory structure by just ignoring the `_`, leading numbering and the fileending:

<pre><code>_<strong style="color:red">user-manual/</strong>03-<strong style="color:red">edge-solutions/</strong>02-<strong style="color:red">moducop/</strong>03-<strong style="color:red">use/</strong>03-<strong style="color:red">installing-accessories</strong>.md
</code></pre>

Copy the file in the same directory and give it a name in the following format:
```
[NUMBER]-[TITLE_SMALL_WITH_SLASH].md
```

The `NUMBER` at the front of the filename ensures that the `paginaton` tool is able to determine the correct order of the files for the `Previous` and `Next` buttons displayed on the bottom of each file.

It is not important, that the `NUMBER` values are gapless. There can be gaps in case pages are planned in the future which might fill these.

`TITLE_SMALL_WITH_SLASH` shall be the title converted in small letters where spaces are replaced with `-`.

So a good name for our examle file would be `04-demo-page.md`.

The next step is to adapt the front matter at the top of the file. In this case the front matter initially was:
```yaml
---
title: Installing Accessories
permalink: /user-manual/edge-solutions/moducop/use/installing-accessories/
excerpt: How to install accessories on ModuCop.
last_modified_at: 2021-04-13
---
```
A adaption for the demonstration would be:
```yaml
---
title: Demo Page
permalink: /user-manual/edge-solutions/moducop/use/demo-page/
excerpt: This is a page for demonstration.
last_modified_at: 2021-04-14
---
```
Remove all below the front matter, as this is the documentation content.

Already now, the page can be visited on the homepage, as the permalink in the front matter defines the url together with the base path. Hosting the webside on your local machine, this would be `http://localhost:4000/user-manual/edge-solutions/moducop/use/demo-page/`.

But, as you may see, there is stil no reference on the sidebar right now. For this case we have a look at the sidebar definitions, which are in `_data/sidebars`:
```
_data/sidebars
├── edgefarm.yml
├── edge-solutions.yml
├── main-sidebar.yml
├── quick-start-guide.yml
├── user-manual.yml
└── video-section.yml
```
Sidebars can include other sidebars, so the different submenu can be separated from each other.

For example the `main-sidebar` includes the `quick-start-guide` sidebar, the `user-manual` sidebar and the `video-section` sidebar. Further includes the `user-manual` sidebar the `edgefarm` sidebar and the `edge-solutions` sidebar. For better imagination:
```
main-sidebar.yml
├── quick-start-guide.yml
├── user-manual.yml
│   ├── edgefarm.yml
│   └── edge-solutions.yml
└── video-section.yml
```
So for this adjustment - remember: we want to add something in the user manual in edge solutions part - we need the `edge-solutions.yml` file to be modified:

<pre><code>sidebar:
  title: Edge Solutions
  url: /user-manual/edge-solutions/
  navitems:
    - title: ModuCop
      url: /user-manual/edge-solutions/moducop/
      navitems:
        - title: Introduction
          url: /user-manual/edge-solutions/moducop/introduction/
          navitems:
            - ...
        - title: Use ModuCop
          url: /user-manual/edge-solutions/moducop/use/
          navitems:
            - title: Mounting Options
              url: /user-manual/edge-solutions/moducop/use/mounting-options/
            - title: Installing Accessories
              url: /user-manual/edge-solutions/moducop/use/installing-accessories/
            <strong style="color:red">- title: Demo Page
              url: /user-manual/edge-solutions/moducop/use/demo-page/</strong>
        - ...
    - ...
</code></pre>

> Note: The `url` needs to be the exact copy of `permalink` from front matter of the file to ensure the page is correctly highlighted in the sidebar when visited.

### How to add a new menu to the sidebar

Assume that the website has the following sidebar and you want to add another menu after the page highlighted in orange on the same level:

<img src=".readme/sidebar.png" alt="Sidebar" height="300px">

TODO

### How to add a video
TODO

### How to add a video section
TODO

## General descriptions
### Sidebar
img src=".readme/sidebar.png" alt="Sidebar" height="300px">

The page currently visited is highlighted in orange. Expanded menus are highlighted in brown (yes, this color is brown). Items in menus are simbolized a indentation.

So if you follow the hierarchy to the item you get:
```
User Manual > Edge Solutions > ModuCop > Use ModuCop > Installing Accessories
```

### Documentation Folder Structure

The folder structure in the documentation folders is designed to match the url of the corresponding file, but with slightly changes.


An example url:
<pre><code>http://localhost:4000/<strong style="color:red">user-manual/edge-solutions/moducop/use/installing-accessories</strong>/
</code></pre>

At the front there is the base path, here `http://localhost:4000/`. This can be ingnored.

This is the fitting part of the folderstructure:
```
_user-manual
├── 01-user-manual.md
├── 02-edgefarm
│   └── ...
├── 03-edge-solutions
│   ├── 01-edge-solutions.md
│   ├── 02-moducop
│   │   ├── 01-moducop.md
│   │   ├── 02-introduction
│   │   │   ├── 01-introduction.md
│   │   │   ├── 02-specification.md
│   │   │   └── 03-mechanical-outline.md
│   │   ├── 03-use
│   │   │   ├── 01-use.md
│   │   │   ├── 02-mounting-options.md
│   │   │   └── 03-installing-accessories.md
│   │   └── 04-detailed
│   │       ├── 01-detailed.md
│   │       ├── 02-lmp.md
│   │       └── 03-moducop-hw.md
│   └── 03-sensor-converter
│       ├── 01-sensor-converter.md
│       ├── 02-SES01.md
│       └── 03-SUS02.md
└── 05-troubleshooting
    └── ...
```

The files are numbered to ensure the order of the navigation with the `Previous` and `Next` buttons on the bottom ist the desired one: Logically step through the contents from top to down in the sidebar.

In each folder you see a file which is (almost) named after the folder in which it is located. This is the landing page of the menu in the sidebar. A menu doesn't necessarily have to have a landing page. It may only group related stuff together.

A menu in the sidebar is represented by a folder in the repository only in case the menu itsel is considered to have a landing page. Else the files are just included in the directory of the menu above.

So the resulting path to the url at the beginning is:
<pre><code>_<strong style="color:red">user-manual/</strong>03-<strong style="color:red">edge-solutions/</strong>02-<strong style="color:red">moducop/</strong>03-<strong style="color:red">use/</strong>03-<strong style="color:red">installing-accessories</strong>.md
</code></pre>



### Breadcrumps
Breadcrumps are displayed at the top of each page above the headline, e.g.:

<img src=".readme/breadcrumps.png" alt="Sidebar" width=60%>

Breadcrumps are generated from url, e.g.:
```
http://localhost:4000/user-manual/edge-solutions/moducop/use/installing-assessories/
```




######## Notes
add docker container
$ docker run --rm --name=jekyll-dev --volume="$PWD:/srv/jekyll"  -it -p 4000:4000 jekyll/jekyll:4 sh

$ bundle update
$ bundle exec jekyll serve --host=0.0.0.0



# move editable stuff in subfolder

# move all jekyll content one folder deeper to separate readme etc. from jekyll stuff

# license
im root lincense file von uns
im jekyll ordner orginal license und uns oben hinzufügen

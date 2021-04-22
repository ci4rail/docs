---
title: "Example File"
excerpt: "See how to use this documentation."
last_modified_at: 2021-04-20

feature_row:
  - image_path: /user-docs/images/edgefarm/orange-cloud.jpg
    alt: "EdgeFarm"
    title: "EdgeFarm"
    excerpt: "Use EdgeFarm to manage get an overview of devices, develop own edge or cloud modules and deploy them to your devices. Analayse the data provided from the devices."
    url: /user-manual/edgefarm/
    btn_label: "Learn More"
    btn_class: "btn--primary"
  - image_path: /user-docs/images/moducop/photo.png
    alt: "Moducop"
    title: "Moducop"
    excerpt: "Put Moducop into operation and connect it properly and consider the installation conditions."
    url: /user-manual/edge-solutions/moducop/
    btn_label: "Learn More"
    btn_class: "btn--primary"
  - image_path: /user-docs/images/sensors-converters/ses01-3d-model.png
    title: "Sensors & Converters"
    alt: "Sensors & Converters"
    excerpt: "Use Ci4Rail sensors to get more information from your Edge Device."
    url: /user-manual/edge-solutions/sensors-converters/
    btn_label: "Some other button text"
    btn_class: "btn--primary"

gallery:
  - url: /user-docs/images/sensors-converters/ses01-3d-model.png
    image_path: /user-docs/images/sensors-converters/ses01-3d-model.png
    alt: "alternative description 1 if image not found"
    title: "Image 1 title caption"
  - url: /user-manual/edge-solutions/moducop/
    image_path: /user-docs/images/moducop/photo.png
    alt: "alternative description 2 if image not found"
    title: "Image 2 title caption"
  - url: /user-manual/edgefarm/
    image_path: /user-docs/images/edgefarm/orange-cloud.jpg
    alt: "alternative description 3 if image not found"
    title: "Image 3 title caption"
---

This example documentation file shows how different formatting can be established in this template. Some formatting is usual [markdown syntax](#general-markdown-usage), but some [template specific formatting](#jekyll-template-specific) is possible. In addition, some topics can be realized in [both ways](#markdown-vs-template-specific).

# General Markdown Usage

## Text Formatting

This is the normal text for user documentation displayed as entered.

Create a new paragraph, a coherent section of a longer text, by leaving a blank line between two texts.

For all characters that cause formatting, the effect can be canceled with a backslash: \* \' \_ 2\. – The backslash itself is inserted by \\.

*Italics*, **bold** and ***bold italic*** or
_Italic_, __Bold__ and ___Bold italic___

> This quote is packed into an HTML block quote element.

Horizontal line, leave one blank line before, else it is interpreted as healine level one.

---
Futher context can start just the next line.

## Unordered List

* Item in an unordered list can be indicated by `*`
* Another item of the list
    * A sub-item, indented by four spaces
- Also `-` and
+ and `+` can be used

## Numbered List

1. Item in an ordered list
2. Another item of the list
1. Another item showing the actuall number is not important
100. Just need to be any decimal number followed by a dot
101 This is not identified as a list item

## Code Formatting

Create `inline source code`.

A normal paragraph

     A block of code
     by indentation
     with four spaces

Block of code can also be done with:
```
source code
```
or if you want language specific syntax highlighting:
```bash
echo "This is my bash code"
```
```python
print("This is python code")
```
Also `yaml` and `json` supported:
```yaml
application: influxdb
modules:
  - name: influxdb
    image: influxdb:latest
    createOptions: '{\"HostConfig\":{\"PortBindings\":{\"8086/tcp\":[{\"HostPort\":\"8086\"}]}}}'
```
```json
{
  question: "???",
  answer: 42
}
```

* Show source code in an list item:
   ```bash
   est Lorem ipsum dolor
   ```


# Jekyll Template Specific
## Info Blocks

**Info** This is a info block. **Markdown** `syntax` can be used within all of these blocks.
{: .notice--info}

**Warning** This is a warning text block.
{: .notice--warning}

**Danger** This is a red block.
{: .notice--danger}

**Success** This is a green block. Use \\ \
to \
\
let the block run over several lines.
{: .notice--success}

**Primary** This is a grey block.
{: .notice--primary}

**Notice** This is a light <br>grey block.
{: .notice}

{% capture notice-text %}
You can also do some more content freely into the notices
* Bullet point 1
* Bullet point 2

Some further content.
{% endcapture %}
<div class="notice--info">
  {{ notice-text | markdownify }}
</div>

## Picture Rows

There are some features included in the theme to easily add pictures with special adjustment. Both methods need to be defined in the frontmatter at the top of the page. Both enable to have three picutures placed next to each other. When more than three images are listed, the next one is placed below.

### Feature Row
This is the definition of the feature row in the front matter:
```yaml
feature_row:
  - image_path: assets/images/edgefarm/orange-cloud.jpg
    alt: "EdgeFarm"
    title: "EdgeFarm"
    excerpt: "Use EdgeFarm to manage get an overview of devices, develop own edge or cloud modules and deploy them to your devices. Analayse the data provided from the devices."
    url: /user-manual/edgefarm/
    btn_label: "Learn More"
    btn_class: "btn--primary"
  - image_path: /user-docs/images/site/moducop/photo.png
    alt: "Moducop"
    title: "Moducop"
    excerpt: "Put Moducop into operation and connect it properly and consider the installation conditions."
    url: /user-manual/edge-solutions/moducop/
    btn_label: "Learn More"
    btn_class: "btn--primary"
  - image_path: /user-docs/images/sensors-converters/ses01-3d-model.png
    title: "Sensors & Converters"
    alt: "Sensors & Converters"
    excerpt: "Use Ci4Rail sensors to get more information from your Edge Device."
    url: /user-manual/edge-solutions/sensors-converters/
    btn_label: "Some other button text"
    btn_class: "btn--primary"
```

This results in the following output:
{% include feature_row %}

### Image Gallery
This is the definition of the image gallery in the front matter:
```yaml
gallery:
  - url: /user-docs/images/sensors-converters/ses01-3d-model.png
    image_path: /user-docs/images/sensors-converters/ses01-3d-model.png
    alt: "alternative description 1 if image not found"
    title: "Image 1 title caption"
  - url: /user-manual/edge-solutions/moducop/
    image_path: /user-docs/images/moducop/photo.png
    alt: "alternative description 2 if image not found"
    title: "Image 2 title caption"
  - url: /user-manual/edgefarm/
    image_path: /user-docs/images/edgefarm/orange-cloud.jpg
    alt: "alternative description 3 if image not found"
    title: "Image 3 title caption"
```

This results in the following output:
{% include gallery caption="This is a sample gallery with **Markdown support**." %}

# Markdown and Template Specific
## Include Figure
Include figure using markdown (Hover to see the Title Text):

![alternative description if image not found]({{ '/user-docs/images/moducop/photo.png' | relative_url }} "Logo Title Text")

Change size of markdown figure (mix of markdown and jekyll specific):

![alternative description if image not found]({{ '/user-docs/images/moducop/photo.png' | relative_url }} "Logo Title Text"){: style="width: 100%"}

![alternative description if image not found]({{ '/user-docs/images/moducop/photo.png' | relative_url }} "Logo Title Text"){: style="width: 50%"}

Include figure using template syntax (does not support title but caption):

 {% include figure image_path="/user-docs/images/moducop/photo.png" alt="alternative description if image not found" caption="This is a figure caption." %}

## Add Links

A link to an external page can be done completely without template syntax:
[Link to external page](https://www.google.de "Title that is displayed when hovering over the mouse")

A link to an internal page requires some template syntax `{% raw %}{ 'URL' | relative_url }}{% endraw %}` to ensure the link is correctly generated:
[Link to internal page]({{ '/quick-start-guide' | relative_url }} "Title that is displayed when hovering over the mouse")

# Heading Level 1
## Heading Level 2
### Heading Level 3
#### Heading Level 4
##### Heading Level 5

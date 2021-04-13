# docs
Documentation for Ci4Rail products

## base template
As entrypoint the template minimal-mistakes was selected:
Version 3d3cb58a2efa2c8b1ed4d9f93f48419e9e0aedec from 03.03.2021.


## Run theme locally
TODO: Add preconditions here.


Execute the following:
```
bundle update
bundle exec jekyll serve
```

Visit `http://localhost:4000/` to see webside.

## View latest version
Latest version (main brauch) is published on:
https://docs.ci4rail.com/

## Modify sidebar
Example of a sibebar:
```yaml
sidebar:
  title: sidebar title
  navitems:
    - title: Section 1
      navitems:
        - title: Page 1
          url: /page1
        - title: Page 2
          external_url: https://google.com
        - title: Subsection 1
          navitems:
            - title: Page 3
              url: /longer/url/page3
            - title: Page 4
              url: /page4
        - title: Page 5
          url: /page5
        - title: Page 6
          url: /page6
        - sidebar: subsidebar
    - title: Section 2
      navitems:
        - title: Page 7
          url: page7
```
Example of a sub-sidebar:
```yaml
sidebar:
  title: subsidebar title
  navitems:
    - title: Page 8
      url: page8
    - title: Another Section
      navitems:
        - title: Page 9
          url: /page9
        - title: Page 10
          external_url: https://google.com
        - title: Another Subsection
          navitems:
            - title: Page 11
              url: page11
```


only use max 5 headline levels!!!!

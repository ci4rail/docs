# docs

Documentation for Ci4Rail products.

## Base Template

As entrypoint the template minimal-mistakes was selected:
Version 3d3cb58a2efa2c8b1ed4d9f93f48419e9e0aedec from 03.03.2021.

## View Latest Version

Latest version (main branch) is published on: [docs.ci4rail.com](https://docs.ci4rail.com/)

## Run theme

### With Gitpod

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/ci4rail/docs)

### On Windows

Preconditions:
* Install Jekyll: See [install instructions](https://jekyllrb.com/docs/installation/windows/).

Start server locally:
```
cd docs
bundle update
bundle exec jekyll serve --host=0.0.0.0 --drafts
```

Visit `http://localhost:4000/` to see webside.

> Note: View the [example page](docs/user-docs/_drafts/example.md) on `http://localhost:4000/example/` for impression how to design a side and how it will look like.

> Note: On github pages, the website is build without `--drafts` option. This ensures, that files placed in `docs/user-docs/_drafts/` are not generated into the public website, as these are intendet to only be drafts and not published.

> If you get an error starting the server locally check [next section](#fixing-could-not-open-library-libcurl-error) for instructions how to fix it.


#### Fixing errors

**Fixing `Could not open library 'libcurl'` error**
1. Download [curl](https://curl.se/windows/) (curl for 64 bit)
2. Unpack zip file
3. Go to bin folder and rename `libcurl-x64.dll` to `libcurl.dll`
4. Copy the file `libcurl.dll` to the directory `C:\Ruby27-x64` while `27` has to be replaced by actual Ruby version


**Fixing `cannot load such file webrick` error**
This fix is included in latest `Gemfile`.

Run `bundle update` in `docs` folder before starting jekyll page.


### On Linux or WSL

Preconditions:
* Install docker: See [install instructions](https://docs.docker.com/engine/install/).

Start server locally:
```bash
./dobi.sh run-jekyll-page
```

or run jekyll environment interactive:
```bash
./dobi.sh run-jekyll-interactive
bundle update &&
bundle exec jekyll serve --host=0.0.0.0 --drafts
```

Visit `http://localhost:4000/` to see webside.

> Note: View the [example page](docs/user-docs/_drafts/example.md) on `http://localhost:4000/example/` for impression how to design a side and how it will look like.

> Note: On github pages, the website is build without `--drafts` option. This ensures, that files placed in `docs/user-docs/_drafts/` are not generated into the public website, as these are intendet to only be drafts and not published.


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

## How to Write Documentation
See markdown file [How to Write Documentation](docs/user-docs/_drafts/how-to-write-documentation.md) or [run the theme locally](#run-theme-locally) and
view it in the browser on [http://localhost:4000/how-to-write-documentation/](http://localhost:4000/how-to-write-documentation/).

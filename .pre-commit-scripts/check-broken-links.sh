#!/usr/bin/env bash

cd docs && \
    bundle exec jekyll build && \
    bundle exec htmlproofer --assume_extension --only-4xx --allow-has-href ./_site

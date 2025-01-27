FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Install jekyll
RUN sudo apt-get update && sudo apt-get install ruby-full build-essential zlib1g-dev pre-commit -y

RUN echo 'export GEM_HOME="$HOME/gems"' >> ~/.zshrc
RUN echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.zshrc

RUN sudo gem install jekyll:4.2.0 bundler:2.2.24

FROM gitpod/workspace-full

# Install jekyll
RUN sudo apt-get install ruby-full build-essential zlib1g-dev -y

RUN echo 'export GEM_HOME="$HOME/gems"' >> ~/.zshrc
RUN echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.zshrc

RUN pip install pre-commit
RUN if ! grep -q "export PIP_USER=no" "$HOME/.bashrc"; then printf '%s\n' "export PIP_USER=no" >> "$HOME/.bashrc"; fi

RUN sudo gem install jekyll:4.2.0 bundler:2.2.24

FROM jekyll/jekyll:pages

ENV LANG=en_IE.UTF-8 \
    LANGUAGE=en_IE:en \
    TZ=Europe/Madrid \
    LC_ALL=en_IE.UTF-8 \
    LANG=en_IE.UTF-8 \
    LANGUAGE=en_IE
EXPOSE 4000

# Set up user so that we can share ssh credentials.
ENV USERNAME=jekyll
# RUN echo "$USERNAME ALL=\(root\) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
#     && chmod 0440 /etc/sudoers.d/$USERNAME

# Install development packages
RUN apk update && apk add \
    # development packages
    ruby-dev \
    gcc \
    make \
    curl \
    build-base \
    libc-dev \
    libffi-dev \
    zlib-dev \
    libxml2-dev \
    libgcrypt-dev \
    libxslt-dev \
    python \
    # pushing to git via ssh
    openssh \
    # permissions to install packages
    sudo \
    # tab completion inside the container
    git-bash-completion

# Set up git completion.
RUN echo "source /usr/share/bash-completion/completions/git" >> /home/$USERNAME/.bashrc

COPY Gemfile /srv/jekyll/
RUN bundle install && bundle update

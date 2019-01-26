FROM debian:stretch

ADD Recipe.deps /Recipe.deps
ADD Recipe.appimage /Recipe.appimage
ADD Recipe /Recipe
ADD cbp2make /usr/bin/cbp2make
RUN bash -ex Recipe.deps

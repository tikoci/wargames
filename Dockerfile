FROM alpine

COPY . /app

# Install dependencies
RUN apk update \
 && apk add --no-cache alpine-sdk busybox-extras ncurses-dev lynx 

# No X11, so not needed? 
# apk add cool-retro-term

# Install Vidtex Viewdata Terminal
RUN cd /app \
  && wget "https://github.com/simonlaszcz/vidtex/blob/master/releases/vidtex-1.3.0.tar.gz?raw=true" -O "vidtex-1.3.0.tar.gz" \
  && tar xvf vidtex-1.3.0.tar.gz \
  && cd vidtex-1.3.0 \
  && mkdir -p /usr/include/ncursesw \
  && cp /usr/include/curses.h /usr/include/ncursesw \ 
  && ./configure \
  && make \
  && make install \
  && cd ..

# Install Viewdata Fonts
RUN cd /app \
  && wget https://bjh21.me.uk/bedstead/bedstead.otf \
  && wget https://galax.xyz/TELETEXT/MODE7GX3.TTF \
  && mkdir -p /usr/share/fonts/truetype/ \
  && cp bedstead.otf /usr/share/fonts/truetype/ \
  && cp MODE7GX3.TTF /usr/share/fonts/truetype/


# Install shell-gpt & WOPR role (needs to be enabled in wopr.c)
# echo you are running Python Version
# python --version
# apk add espeak
# apk add py3-pip
# pip install shell-gpt
# cp C/src/WOPR.json ~/.config/shell_gpt/roles

# Compile and install C code
RUN cd /app \
  && gcc C/src/imsai8080.c -o ./imsai8080 \
  && gcc C/src/school.c -o ./school \
  && gcc C/src/dialer.c -o ./dialer \
  && gcc C/src/pan-am.c -o ./pan-am \
  && gcc C/src/bank.c -o ./bank \
  && gcc C/src/wopr.c -o ./wopr \
  && gcc C/src/tic-tac-toe.c -o ./tic-tac-toe \
  && cp C/src/*.txt ./ \
  && cp C/src/imsai8080.json ./ \
  && chmod +x *.sh

FROM php:7.1-cli

RUN apt-get update && apt-get install -y re2c git build-essential software-properties-common wget g++

RUN wget http://www.cmake.org/files/v3.1/cmake-3.1.0.tar.gz && \
    tar xzf cmake-3.1.0.tar.gz && cd cmake-3.1.0 && ./configure --prefix=/opt/cmake && \
    make && make install

RUN apt-get install -y gtk+-3.0

RUN  git clone https://github.com/andlabs/libui.git && \
    cd libui && \
    mkdir build && cd build && \
    /opt/cmake/bin/cmake ..

RUN pecl install channel://pecl.php.net/ui-2.0.0
RUN echo 'extension=ui.so' > /etc/php/7.1/mods-available/ui.ini && \
    ln -s /etc/php/7.1/mods-available/ui.ini 20-ui.ini

ADD ./snake.php



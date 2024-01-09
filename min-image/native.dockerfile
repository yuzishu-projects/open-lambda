FROM debian

RUN apt-get -y  update
RUN apt-get -y install wget apt-transport-https curl
# RUN apt-get -y install python3 python3-dev python3-pip python-is-python3
RUN apt-get -y install build-essential libseccomp-dev
# https://devguide.python.org/getting-started/setup-building/#install-dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install gdb lcov pkg-config \
      libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
      libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
      lzma lzma-dev tk-dev uuid-dev zlib1g-dev
RUN mkdir /cpython && cd /cpython && wget -O cpython.tar.gz https://github.com/python/cpython/archive/refs/tags/v3.8.13.tar.gz && tar xzf cpython.tar.gz
# https://docs.python.org/3.8/using/unix.html
RUN cd /cpython/cpython-3.8.13/ && ./configure --prefix=/usr/local && make -s -j && make install && make clean
RUN rm -rf /cpython
# RUN pip3 install --upgrade pip
RUN pip3 install virtualenv requests tornado==6.1.0 sqlalchemy simplejson

RUN mkdir /runtimes

# Build the python module also in the Container
RUN mkdir /runtimes/python
COPY runtimes/python /tmp/py-runtime
RUN cd /tmp/py-runtime && python3 setup.py build_ext --inplace
RUN mv /tmp/py-runtime/ol.*.so /runtimes/python/ol.so
RUN mv /tmp/py-runtime/server.py /runtimes/python/server.py
RUN mv /tmp/py-runtime/server_legacy.py /runtimes/python/server_legacy.py
RUN rm -rf /tmp/py-runtime

# for the Docker container engine
COPY spin /
RUN apt-get install -y libgl1 libglib2.0-0
COPY test.jpeg /data/test.jpeg
RUN ln -s /usr/local/bin/python3 /usr/bin/python3
RUN ln -s /usr/local/bin/pip3 /usr/bin/pip3


CMD ["/spin"]

# FROM ubuntu:22.04
FROM lass

# RUN apt-get -y --fix-missing update
# RUN apt-get -y install wget apt-transport-https curl
# RUN apt-get -y install python3 python3-dev python3-pip python-is-python3
# RUN apt-get -y install build-essential libseccomp-dev
# RUN pip3 install --upgrade pip
# RUN pip3 install virtualenv requests tornado==6.1.0

RUN mkdir /runtimes

# Build the python module also in the Container
RUN mkdir /runtimes/python
COPY runtimes/python /tmp/py-runtime
# RUN cd /tmp/py-runtime && python3 setup.py build_ext --inplace
COPY build_ol.sh /tmp/py-runtime/
RUN cd /tmp/py-runtime && bash build_ol.sh
RUN mv /tmp/py-runtime/ol.*.so /runtimes/python/ol.so
RUN mv /tmp/py-runtime/server.py /runtimes/python/server.py
RUN mv /tmp/py-runtime/server_legacy.py /runtimes/python/server_legacy.py
RUN mv /tmp/py-runtime/controller_client.py /runtimes/python/controller_client.py
RUN mv /tmp/py-runtime/ipdos_client_sdk.py /runtimes/python/ipdos_client_sdk.py
RUN mv /tmp/py-runtime/ipdos.cpython-38-x86_64-linux-gnu.so /runtimes/python/ipdos.cpython-38-x86_64-linux-gnu.so
RUN rm -rf /tmp/py-runtime

COPY start.sh /home/yuzishu/Desktop/share_exp/ShareSoftState/cpython-3.8.13/multiple_version_test/

# cv2
RUN apt-get update && apt-get -y install libgl1 libglib2.0-0
COPY test.jpeg /data/test.jpeg

# for the Docker container engine
COPY spin /

CMD ["/spin"]

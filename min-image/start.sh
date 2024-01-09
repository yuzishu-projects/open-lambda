#!/bin/bash

cd /home/yuzishu/Desktop/share_exp/ShareSoftState/cpython-3.8.13/multiple_version_test

export PYTHONMALLOC=default
export PYTHONHASHSEED=0
export PYTHONLOADFROMSHARED=True
export GLIBC_COPY_FROM_SHARE=1
export LD_LIBRARY_PATH=/home/yuzishu/python3_overwrite_malloc/lib/:/home/yuzishu/Desktop/share_exp/ShareSoftState/glibc-2.35/build:/usr/local/lib/:/usr/local/lib/x86_64-linux-gnu/:/lib/x86_64-linux-gnu/:/usr/lib/x86_64-linux-gnu/:/usr/lib/x86_64-linux-gnu/libfakeroot/:$LD_LIBRARY_PATH
source venv_ol/bin/activate
ulimit -c 0
export PYTHONLOGENV=print
export OPENBLAS_NUM_THREADS=1
export MKL_NUM_THREADS=1

LD_PRELOAD=libipdos.so python3 -u /runtimes/python/server.py /host/bootstrap.py 1 true 

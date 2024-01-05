#!/bin/bash

export LD_LIBRARY_PATH=/home/yuzishu/python3_overwrite_malloc/lib/:/home/yuzishu/Desktop/share_exp/ShareSoftState/glibc-2.35/build:/usr/local/lib/:/usr/local/lib/x86_64-linux-gnu/:/lib/x86_64-linux-gnu/:/usr/lib/x86_64-linux-gnu/:/usr/lib/x86_64-linux-gnu/libfakeroot/:$LD_LIBRARY_PATH
LD_PRELOAD=libipdos.so /home/yuzishu/python3_overwrite_malloc/bin/python3 setup.py build_ext --inplace

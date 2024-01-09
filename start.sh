# make ol imgs/ol-min
# umount mryao-worker2/lambda/dev/null
cd /root/open-lambda
rm -rf mryao-worker2
./ol worker init -p mryao-worker2 -i ol-min
rm -rf /root/open-lambda/mryao-worker2/registry
cp -r /root/registry /root/open-lambda/mryao-worker2/
./ol worker up -p mryao-worker2 -i ol-min &

sleep 3

echo 'haha'

curl -d '{}' http://localhost:5000/run/toGrey
rm -rf /root/open-lambda/mryao-worker2/lambda/dev/null

cd /root/lass_benchmark/exp_motivation
bash /root/lass_benchmark/exp_motivation/motivation.sh

# rm  mryao-worker2/lambda/dev/null
# touch mryao-worker2/lambda/dev/null
# mknod -m 0666 mryao-worker2/lambda/dev/null c 1 3
# touch mryao-worker2/lambda/dev/null

# mount --bind /dev/null mryao-worker2/lambda/dev/null
# mount -o remount,rw /dev/null mryao-worker2/lambda/dev/null
# umount mryao-worker2/lambda/dev/null
# mount --bind /dev /root/open-lambda/mryao-worker2/lambda/dev
# mount --bind /dev/pts /root/open-lambda/mryao-worker2/lambda/dev/pts
# mount --bind /proc /root/open-lambda/mryao-worker2/lambda/proc
# mount --bind /sys /root/open-lambda/mryao-worker2/lambda/sys
# mount -o remount,rw /dev mryao-worker2/lambda/dev
# rm 
# umount mryao-worker2/lambda/dev/pts
# umount mryao-worker2/lambda/dev
# umount mryao-worker2/lambda/proc
# umount mryao-worker2/lambda/sys

# mknod -m 666 /root/open-lambda/mryao-worker2/lambda/dev/null c 1 3
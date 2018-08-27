wget https://github.com/Aitical/fix_import__bz2_error/blob/master/_bz2.cpython-36m-x86_64-linux-gnu.so
echo " " | sudo -S mv _bz2.cpython-36m-x86_64-linux-gnu.so /usr/local/python3/lib/python3.6/lib-dynload
echo " "| sudo -S ln -s /lib64/libbz2.so.1 /usr/lib64/libbz2.so.1.0
echo "\n测试语句..."
python3 -c "import bz2; print(bz2.__doc__)"

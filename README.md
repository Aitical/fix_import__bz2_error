这几天看到一个python的分布式计算库Dask,了解了一下,觉得蛮有意思的就想试试,在部署启动时报错

![find_error](https://s1.ax1x.com/2018/08/27/PqBGbF.png)

接着就开始google和看别人的博客,最终把问题解决了,不过这里参考了几个不同的回答才最终解决在这里整理下最终的解决方案

环境说明:

- Centos7
- Python3.6.6

看了一些教程和问题,可以定位到这个问题是python3.6缺少了一个_bz2.cpython-36m-x86_64-linux-gnu.so的组件

StackOverFlow和部分博主推荐在自己编译安装bz2然后重新编译python3.6即可,过程大致如下

1. yum install  bzip2-devel
2. wget http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz
3. tar -zxvf bzip2-1.0.6.tar.gz
4. cd bzip2-1.0.6
5. make && make install
6. configure and re compile python

不过我不想重新搞一遍,所以采用下面的方法:

目标: 把这个组件放到对应python路径下的`lib/python3.6/lib-dynload/`中即可

于是我下载了so文件,放进去后执行,又有了另外一个问题

![another_error](https://s1.ax1x.com/2018/08/27/PqBM3q.png)

添加个链接就可以了

```shell
ln -s /lib64/libbz2.so.1 /usr/lib64/libbz2.so.1.0
```

测试一下

```shell
python3 -c "import bz2; print(bz2.__doc__)"
```

![result](https://s1.ax1x.com/2018/08/27/PqB8DU.png)

到这问题就已经解决了

整个操作的过程很简单,由于要在集群的环境中更改一遍,我把过程整理在sh脚本中,脚本和so文件都在[github](https://github.com/Aitical/fix_import__bz2_error) 上,注意设置脚本中的用户密码和python路径就可以一键修复这个问题了



参考链接:

https://blog.csdn.net/heros_never_die/article/details/79942124

https://www.cnblogs.com/emanlee/p/7325171.html

https://stackoverflow.com/questions/12806122/missing-python-bz2-module




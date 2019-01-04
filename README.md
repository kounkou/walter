# walter

### Introduction

Walter is a tool that enables deploying any application conforming to\
ELF x-bit LSB shared object, and dynamically linked\
This tool will be useful for those who have a binary and have no idea\
how to grab all the dependencies and export them elsewhere.

### example

Imagine you just built an application with Qt\
Usually, the scenario is the following. Let's start with a\
very simple example.

```bash
kaloudis@kaloudis:$ cat test.cpp 
#include <bits/stdc++.h>
#include <QObject>

using namespace std;

int main() {
    return 0;
}
```

Then we can just compile and see the different dependencies of the application

```bash
kaloudis@kaloudis:$ qmake -project && qmake && make && ldd QtWalker
	linux-vdso.so.1 (0x00007ffe7c15a000)
	libQt5Core.so.5 => /usr/lib/x86_64-linux-gnu/libQt5Core.so.5 (0x00007f5019ddf000)
	libstdc++.so.6 => /usr/lib/x86_64-linux-gnu/libstdc++.so.6 (0x00007f5019a56000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f5019665000)
	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f5019446000)
	libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x00007f5019229000)
	libicui18n.so.60 => /usr/lib/x86_64-linux-gnu/libicui18n.so.60 (0x00007f5018d88000)
	libicuuc.so.60 => /usr/lib/x86_64-linux-gnu/libicuuc.so.60 (0x00007f50189d1000)
	libdouble-conversion.so.1 => /usr/lib/x86_64-linux-gnu/libdouble-conversion.so.1 (0x00007f50187c0000)
	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f50185bc000)
	libglib-2.0.so.0 => /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0 (0x00007f50182a6000)
	libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f5017f08000)
	libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007f5017cf0000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f501a72c000)
	libicudata.so.60 => /usr/lib/x86_64-linux-gnu/libicudata.so.60 (0x00007f5016147000)
	libpcre.so.3 => /lib/x86_64-linux-gnu/libpcre.so.3 (0x00007f5015ed5000)
```

From there, it's easy to launch [Walter](https://github.com/kounkou/walter/edit/master/walter.sh)

```bash
kaloudis@kaloudis:$ bash walter.sh QtWalker
```

The result is generated in the current directory 

```bash
kaloudis@kaloudis:$ ls packages
total 43528
drwxr-xr-x 2 godbod godbod     4096 Jan  4 00:58 ./
drwxr-xr-x 3 godbod godbod     4096 Jan  4 00:59 ../
-rwxr-xr-x 1 godbod godbod   170960 Jan  4 00:58 ld-linux-x86-64.so.2*
-rwxr-xr-x 1 godbod godbod  2030544 Jan  4 00:58 libc.so.6*
-rw-r--r-- 1 godbod godbod    14560 Jan  4 00:58 libdl.so.2
-rw-r--r-- 1 godbod godbod    67648 Jan  4 00:58 libdouble-conversion.so.1
-rw-r--r-- 1 godbod godbod    96616 Jan  4 00:58 libgcc_s.so.1
-rw-r--r-- 1 godbod godbod  1133872 Jan  4 00:58 libglib-2.0.so.0
-rw-r--r-- 1 godbod godbod 26904264 Jan  4 00:58 libicudata.so.60
-rw-r--r-- 1 godbod godbod  2754872 Jan  4 00:58 libicui18n.so.60
-rw-r--r-- 1 godbod godbod  1792008 Jan  4 00:58 libicuuc.so.60
-rw-r--r-- 1 godbod godbod  1700792 Jan  4 00:58 libm.so.6
-rw-r--r-- 1 godbod godbod   464824 Jan  4 00:58 libpcre.so.3
-rwxr-xr-x 1 godbod godbod   144976 Jan  4 00:58 libpthread.so.0*
-rw-r--r-- 1 godbod godbod  5536104 Jan  4 00:58 libQt5Core.so.5
-rw-r--r-- 1 godbod godbod  1594832 Jan  4 00:58 libstdc++.so.6
-rw-r--r-- 1 godbod godbod   116960 Jan  4 00:58 libz.so.1
-rwxr-xr-x 1 godbod godbod     8656 Jan  4 00:58 QtWalker*

```

Enjoy !

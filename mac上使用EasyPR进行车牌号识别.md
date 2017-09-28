---
title: "macOS上使用EasyPR进行车牌号识别"
layout: page
date: 2017-09-22 10:57:15
--- 

EasyPR github项目地址:[https://github.com/liuruoze/EasyPR](https://github.com/liuruoze/EasyPR)

[TOC]

## 升级到新版本


尝试执行cmake,提示我们需要安装3.2版本openCV

``` bash
➜  EsayPR git:(master) cmake .
-- The C compiler identification is AppleClang 9.0.0.9000037
-- The CXX compiler identification is AppleClang 9.0.0.9000037
-- Check for working C compiler: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc
-- Check for working C compiler: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc -- works
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Detecting C compile features
-- Detecting C compile features - done
-- Check for working CXX compiler: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++
-- Check for working CXX compiler: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ -- works
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Detecting CXX compile features
-- Detecting CXX compile features - done
CMake Error at CMakeLists.txt:13 (find_package):
  Could not find a configuration file for package "OpenCV" that is compatible
  with requested version "3.2.0".

  The following configuration files were considered but not accepted:

    /usr/local/share/OpenCV/OpenCVConfig.cmake, version: 2.4.13.2



-- Configuring incomplete, errors occurred!
See also "/Users/tyrad/Desktop/EsayPR/CMakeFiles/CMakeOutput.log".
```



尝试安装opencv3

``` bash
brew install opencv3

#发现报错
Error: opencv 2.4.13.2 is already installed
To upgrade to 3.3.0_3, run `brew upgrade opencv`
```

继续按提示安装:

``` bash
brew upgrade opencv
```

查看当前的版本:

``` bash
pkg-config --modversion opencv
```


## 安装

<hr>

版本信息:

openCV: 3.3.0
EasyPR:  

```
~ git log 
commit 598cbb63f1c65a8ee228e9a4163cdca7d4e19545 (HEAD -> master, origin/master, origin/HEAD)
Author: liuruoze <liuruoze@163.com>
Date:   Mon Jun 19 21:24:52 2017 +0800
...
```

cmake

```
~ cmake -version
cmake version 3.9.0
```

<hr>




1). 修改 `include/esaypr/config.h` 文件
> Opencv3.2版本的支持，编译前仅需要将config.h中将#define CV_VERSION_THREE_ZERO改为#define CV_VERSION_THREE_TWO即可。

config.h文件的位置：`include/esaypr/config.h`

2). 为了避免系统中安装的老版本opencv对编译的影响，需要在 CMakeLists.txt 中修改：

```
    set(CMAKE_PREFIX_PATH ${CMAKE_PREFIX_PATH} "/usr/local/opt/opencv@3")
```

3). 项目提供了一键编译shell， 

```
./build.sh
```


最后在目录生成了demo文件,尝试下运行:

``` bash
./demo recognize -p resources/image/plate_recognize.jpg --svm resources/model/svm.xml --ann resources/model/ann.xml
```

![2017092266238c2.png](http://oi6f4bkw5.bkt.clouddn.com/2017092266238c2.png)



具体使用: [https://github.com/liuruoze/EasyPR/blob/master/Usage.md](https://github.com/liuruoze/EasyPR/blob/master/Usage.md)


## 使用 command line tool

1). 集成openCV[具体看这里](http://wiki.tyrad.cc/openCV/macOS上使用openCV.html)

2). 将`libeasypr.a`、`libthirdparty.a`、`include`目录导入工程
![201709275187cxx.png](http://oi6f4bkw5.bkt.clouddn.com/201709275187cxx.png)

3). `header search path`添加: `$(SRCROOT)/EasyPRDemo/include`

4). `product` -> `scheme` ->`Edit Scheme`中,将`Work Directory`改成当前工程的路径(见最后一章图片)

5). 将`EasyPR`原文件中的`models`目录放到当前当前工程目录下(目的是为了和`include/easypr/config.h`中的路径对应起来)

![2017092792418mm.png](http://oi6f4bkw5.bkt.clouddn.com/2017092792418mm.png)

<!--header search path /usr/local/Cellar/eigen/3.3.4/include/eigen3-->
6). 测试效果

```
#include <iostream>
#include <opencv2/opencv.hpp>
#include "easypr.h"
using namespace easypr;
using namespace cv;

void showImage2();

int main(int argc, const char * argv[]) {
    // insert code here...
    std::cout << "Hello, World!\n";
        
    CPlateRecognize pr;
    pr.setResultShow(false);
    pr.setDetectType(PR_DETECT_CMSER);
    
    vector<CPlate> plateVec;
    Mat src = imread("test.jpg");
    int result = pr.plateRecognize(src, plateVec);
    if(plateVec.size() > 0){
        string name=plateVec[0].getPlateStr();
        cout<<endl<<"resunt = "<<name <<endl;
    }
    return 0;
}
```

![2017092759375c.png](http://oi6f4bkw5.bkt.clouddn.com/2017092759375c.png)

## 使用 Xcode cmake

> 测试环境 Xcode9.0

1). 进入下载好的`EasyPR`目录下
2). 创建新目录`Xcode`: `mkdir Xcode`
3). `cd Xcode`
4). `cmake -G "Xcode" ..`

![2017092618892c.png](http://oi6f4bkw5.bkt.clouddn.com/2017092618892c.png)


5).需要配置的地方:

`Edit Scheme`中,将`Work Directory`改成`EasyPR`所在路径。

![201709267206wdt.png](http://oi6f4bkw5.bkt.clouddn.com/201709267206wdt.png)

6). 运行`Demo` target 即可





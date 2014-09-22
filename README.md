zxing
=====

ZXing ("Zebra Crossing") with workaround for Xcode 6

The current version linked from CocoaPods trunk doesn't seem to want to compile in Xcode 6, so here's workaround.

This is a fork off the [last officially-released version of ZXing](https://github.com/zxing/zxing/tree/00f634024ceeee591f54e6984ea7dd666fab22ae/iphone) that still contained a C++ port and iOS client.

To use this, change the ZXing line in your Podfile to this:

`pod 'ZXing', :git => 'git@github.com:Tinkertanker/zxing.git', :tag => 'xcode6-workaround'`

New projects should probably check out [ZXingObjC](https://github.com/TheLevelUp/ZXingObjC) instead. Existing projects should probably migrate when feasible.


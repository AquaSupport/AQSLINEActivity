AQSLINEActivity
===============

![](http://img.shields.io/cocoapods/v/AQSLINEActivity.svg?style=flat) [![Build Status](https://travis-ci.org/AquaSupport/AQSLINEActivity.svg)](https://travis-ci.org/AquaSupport/AQSLINEActivity)

[iOS] UIActivity for LINE

<img src=https://dl.dropboxusercontent.com/u/7817937/_github/aquamarine/AQSLINEActivity.png width=320px>

Usage
---

```objc
UIActivity *lineActivity = [[AQSLINEActivity alloc] init];
NSArray *items = @[[UIImage imageNamed:@"someimage.png"]];

UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:items withApplicationActivities:@[lineActivity]];

[self presentViewController:activityViewControoler animated:YES completion:NULL];
```

Installation
---

```
pod "AQSLINEActivity"
```

Related Projects
---

- [AQSShareService](https://github.com/AquaSupport/AQSShareService) - UX-improved share feature in few line

LICENSE
---

```
The MIT License (MIT)

Copyright (c) 2014 AquaSupport

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

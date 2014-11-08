AQSLINEActivity
===============

![](http://img.shields.io/cocoapods/v/AQSLINEActivity.svg?style=flat) [![Build Status](https://travis-ci.org/AquaSupport/AQSLINEActivity.svg)](https://travis-ci.org/AquaSupport/AQSLINEActivity)

[iOS] UIActivity for LINE

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

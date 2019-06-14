# iOS传感器

## 目前已经通过 SensorManager 整合

### 支持获取以下数据:

* 距离传感器
* 气压计
* 陀螺仪
* 磁力计
* 加速计
* 运动传感器
* 计步器
* 光感
* touchID
* NFC

**使用计步器需要 Info.plist 添加 Privacy - Motion Usage Description**

**使用光感需要 Info.plist 添加 Privacy - Camera Usage Description**

**使用NFC需要 Info.plist 添加 Privacy - NFC Scan Usage Description，Target->Capabilities-> Near Field Communication Tag Reading->ON**

### 使用方法：

1. 遵循需要使用的传感器代理
2. 开启传感器
3. 获取数据
4. 结束获取 

### 距离传感器示例代码：

```
#import "DistanceSensorViewController.h"

@interface DistanceSensorViewController () <DistanceSensorDelegate>

@end

@implementation DistanceSensorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tipLabel.text = @"距离传感器\n靠近听筒黑屏，离开听筒亮屏";
    
    [[SensorManager sharedManager] startDistanceSensor];
    [SensorManager sharedManager].distanceSensorDelegate = self;
}

- (void)proximityStateDidChange:(BOOL)proximityState {
    if (proximityState) {
        NSLog(@"靠近");
    }
    else {
        NSLog(@"远离");
    }
}

- (void)dealloc {
    [[SensorManager sharedManager] endDistanceSensor];
}

@end

```
demo:[http://git.ipo.com/zhushuai/SensorManager](http://git.ipo.com/zhushuai/SensorManager)
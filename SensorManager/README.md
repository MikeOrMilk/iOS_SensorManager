# iOS传感器

## SensorManager （传感器管理工具）

SensorManager 采用的是单例模式

目的是:

1. 统一管理各项处理器，开启以及关闭和数据的获取（任何一个传感器在不同的地方所返回的数据都是一致的）；

2. 由于在整个程序中只会实例化一次，所以在程序如果出了问题，可以快速的定位问题所在；

3. 由于在整个程序中只存在一个对象，节省了系统内存资源，提高了程序的运行效率；

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

**TocuhID 和 NFC 传感器开启之后没有结束的方法，因为它们的使用都是一次性的**

### 使用方法：

1. 遵循 SensorManagerDelegate 代理
2. 开启需要使用到的传感器
3. 通过传感器代理方法获取数据 （所有的数据返回均不在主线程，如需要刷新UI，需切回主线程）
4. 结束获取数据

### 开启气压计传感器示例代码：

```
// 遵循代理
    [SensorManager sharedManager].sensorDelegate = self;
```

```
// 开启气压计传感器
    [[SensorManager sharedManager] startCMAltimeter];

```
```
// 代理方法中获取数据
- (void)getCMAltitudeData:(CMAltitudeData *)altitudeData error:(NSError *)error {
    NSLog(@"%@", [NSString stringWithFormat:@"相对高度:%@ m \n 气压:%@ kPa", altitudeData.relativeAltitude, altitudeData.pressure]);
}
```

```
// 结束获取
    [[SensorManager sharedManager] endCMAltimeter];
```

### 关于系统版本和机型
**1.开启传感器会先验证当前系统版本和机型是否支持，如不支持则会打印无法使用当前传感器，代理方法也无法获得任何回调**

**2.NFC最低支持硬件iPhone 7或者iPhone 7 Plus，最低支持系统为iOS 11**

### 关于数据的异常处理
**SensorManger获得的是最原始的传感器数据，如果出现任何异常情况，则会返回error**

demo:[http://git.ipo.com/ex-zhushuai002/SensorManager](http://git.ipo.com/ex-zhushuai002/SensorManager)
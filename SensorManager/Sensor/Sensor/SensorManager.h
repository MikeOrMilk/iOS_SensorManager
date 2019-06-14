//
//  SensorManager.h
//  Sensor
//
//  Created by 朱帅(EX-ZHUSHUAI002) on 2019/6/13.
//  Copyright © 2019 朱帅(EX-ZHUSHUAI002). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import <CoreMotion/CMAltimeter.h>

NS_ASSUME_NONNULL_BEGIN

/**
 @protocol
 @abstract 使用传感器的代理方法
 */
@protocol SensorManagerDelegate <NSObject>

@optional
/*!
 @method
 @abstract      距离传感器代理方法
 */
- (void)proximityStateDidChange:(BOOL)proximityState;
/*!
 @method
 @abstract      气压计代理方法
 */
- (void)getCMAltitudeData:(CMAltitudeData * _Nullable)altitudeData error:(NSError * _Nullable)error;



@end

// 距离传感器
@protocol DistanceSensorDelegate <NSObject>

- (void)proximityStateDidChange:(BOOL)proximityState;

@end

// 气压计
@protocol CMAltimeterDelegate <NSObject>

- (void)getCMAltitudeData:(CMAltitudeData * _Nullable)altitudeData error:(NSError * _Nullable)error;

@end

// 陀螺仪
@protocol GyroscopeDelegate <NSObject>

- (void)getCMGyroData:(CMGyroData * _Nullable)gyroData error:(NSError * _Nullable)error;

@end

// 磁力计
@protocol MagnetometerDelegate <NSObject>

- (void)getCMMagnetometerData:(CMMagnetometerData * _Nullable)magnetometerData error:(NSError * _Nullable)error;

@end

// 加速计
@protocol AccelerometerDelegate <NSObject>

- (void)getCMAccelerometerData:(CMAccelerometerData * _Nullable)accelerometerData error:(NSError * _Nullable)error;

@end

// 运动传感器
@protocol DeviceMotionDelegate <NSObject>

- (void)getCMDeviceMotion:(CMDeviceMotion * _Nullable)motion error:(NSError * _Nullable)error;

@end

// 计步器
@protocol CMPedometerDelegate <NSObject>

- (void)getCMPedometerData:(CMPedometerData * _Nullable)pedometerData error:(NSError * _Nullable)error;

@end

// 光感
@protocol AmbientLightDelegate <NSObject>

- (void)getBrightnessValue:(float)brightnessValue;

@end

@interface SensorManager : NSObject

+ (instancetype)sharedManager;

// 距离传感器
- (void)startDistanceSensor;
- (void)endDistanceSensor;
@property (nonatomic, weak) id<DistanceSensorDelegate> distanceSensorDelegate;

// 气压计
- (void)startCMAltimeter;
- (void)endCMAltimeter;
@property (nonatomic, weak) id<CMAltimeterDelegate> CMAltimeterDelegate;

// 陀螺仪
- (void)startGyroscope;
- (void)endGyroscope;
@property (nonatomic, weak) id<GyroscopeDelegate> GyroscopeDelegate;

// 磁力计
- (void)startMagnetometer;
- (void)endMagnetometer;
@property (nonatomic, weak) id<MagnetometerDelegate> MagnetometerDelegate;

// 加速计
- (void)startAccelerometer;
- (void)endAccelerometer;
@property (nonatomic, weak) id<AccelerometerDelegate> AccelerometerDelegate;

// 运动传感器
- (void)startDeviceMotion;
- (void)endDeviceMotion;
@property (nonatomic, weak) id<DeviceMotionDelegate> DeviceMotionDelegate;

// 计步器
- (void)startCMPedometer;
- (void)endCMPedometer;
@property (nonatomic, weak) id<CMPedometerDelegate> CMPedometerDelegate;

// 光感
- (void)startAmbientLight;
- (void)endAmbientLight;
@property (nonatomic, weak) id<AmbientLightDelegate> AmbientLightDelegate;

@end

NS_ASSUME_NONNULL_END

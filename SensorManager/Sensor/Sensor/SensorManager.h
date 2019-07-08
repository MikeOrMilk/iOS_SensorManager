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
#import <CoreNFC/CoreNFC.h>

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

/*!
 @method
 @abstract      陀螺仪代理方法
 */
- (void)getCMGyroData:(CMGyroData * _Nullable)gyroData error:(NSError * _Nullable)error;

/*!
 @method
 @abstract      磁力计理方法
 */
- (void)getCMMagnetometerData:(CMMagnetometerData * _Nullable)magnetometerData error:(NSError * _Nullable)error;

/*!
 @method
 @abstract      加速计代理方法
 */
- (void)getCMAccelerometerData:(CMAccelerometerData * _Nullable)accelerometerData error:(NSError * _Nullable)error;

/*!
 @method
 @abstract      运动传感器代理方法
 */
- (void)getCMDeviceMotion:(CMDeviceMotion * _Nullable)motion error:(NSError * _Nullable)error;

/*!
 @method
 @abstract      计步器代理方法
 */
- (void)getCMPedometerData:(CMPedometerData * _Nullable)pedometerData error:(NSError * _Nullable)error;

/*!
 @method
 @abstract      光感代理方法
 */
- (void)getBrightnessValue:(float)brightnessValue;

/*!
 @method
 @abstract      touchID
 */
- (void)getTouchIDResultSuccess:(BOOL)success error:(NSError * _Nullable)error;

/*!
 @method
 @abstract      NFC
 */
- (void)readerSession:(NFCNDEFReaderSession *)session didInvalidateWithError:(NSError *)error;
- (void)readerSession:(NFCNDEFReaderSession *)session didDetectNDEFs:(NSArray*)messages;

@end

@interface SensorManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, weak) id <SensorManagerDelegate> sensorDelegate;

// 距离传感器
- (void)startDistanceSensor;
- (void)endDistanceSensor;

// 气压计
- (void)startCMAltimeter;
- (void)endCMAltimeter;

// 陀螺仪
- (void)startGyroscope;
- (void)endGyroscope;

// 磁力计
- (void)startMagnetometer;
- (void)endMagnetometer;

// 加速计
- (void)startAccelerometer;
- (void)endAccelerometer;

// 运动传感器
- (void)startDeviceMotion;
- (void)endDeviceMotion;

// 计步器
- (void)startCMPedometer;
- (void)endCMPedometer;

// 光感
- (void)startAmbientLight;
- (void)endAmbientLight;

// touchID
- (void)startTouchID;

// NFC
- (void)startNFC;

@end

NS_ASSUME_NONNULL_END

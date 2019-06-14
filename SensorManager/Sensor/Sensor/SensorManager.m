//
//  SensorManager.m
//  Sensor
//
//  Created by 朱帅(EX-ZHUSHUAI002) on 2019/6/13.
//  Copyright © 2019 朱帅(EX-ZHUSHUAI002). All rights reserved.
//

#import "SensorManager.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>

@interface SensorManager () <AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) CMAltimeter *altimeter;
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, strong) CMPedometer *pedometer;
@property (nonatomic, strong) AVCaptureSession *session;

@end

@implementation SensorManager

static NSTimeInterval UpdateInterval = 0.1;
#define WeakSelf(type) autoreleasepool{} __weak __typeof__(type) weakSelf = type;

+ (instancetype)sharedManager {
    static SensorManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
     });
    return _manager;
}

#pragma mark - 距离传感器

- (void)startDistanceSensor {
    [UIDevice currentDevice].proximityMonitoringEnabled = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proximityStateDidChange:) name:UIDeviceProximityStateDidChangeNotification object:nil];
}

- (void)endDistanceSensor {
    [UIDevice currentDevice].proximityMonitoringEnabled = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceProximityStateDidChangeNotification object:nil];
}

- (void)proximityStateDidChange:(NSNotification *)note
{
    if ([self.distanceSensorDelegate respondsToSelector:@selector(proximityStateDidChange:)]) {
        [self.distanceSensorDelegate proximityStateDidChange:[UIDevice currentDevice].proximityState];
    }
}

#pragma mark - 气压计

- (CMAltimeter *)altimeter {
    if (!_altimeter) {
        _altimeter = [[CMAltimeter alloc] init];
    }
    return _altimeter;
}

- (void)startCMAltimeter {
    if (![CMAltimeter isRelativeAltitudeAvailable]) {
        NSLog(@"无法使用气压计");
        return;
    }
    
    @WeakSelf(self);
    [self.altimeter startRelativeAltitudeUpdatesToQueue:[NSOperationQueue new] withHandler:^(CMAltitudeData * _Nullable altitudeData, NSError * _Nullable error) {
        if ([weakSelf.CMAltimeterDelegate respondsToSelector:@selector(getCMAltitudeData:error:)]) {
            [weakSelf.CMAltimeterDelegate getCMAltitudeData:altitudeData error:error];
        }
    }];
}

- (void)endCMAltimeter {
    [self.altimeter stopRelativeAltitudeUpdates];
}


#pragma mark - 陀螺仪

- (CMMotionManager *)motionManager {
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
    }
    return _motionManager;
}

- (void)startGyroscope {
    if (![self.motionManager isGyroAvailable]) {
        NSLog(@"陀螺仪不可用");
        return;
    }
    self.motionManager.gyroUpdateInterval = UpdateInterval;
    @WeakSelf(self);
    [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue new] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
        if ([weakSelf.GyroscopeDelegate respondsToSelector:@selector(getCMGyroData:error:)]) {
            [weakSelf.GyroscopeDelegate getCMGyroData:gyroData error:error];
        }
    }];
}

- (void)endGyroscope {
    [self.motionManager stopGyroUpdates];
}

#pragma mark - 磁力计

- (void)startMagnetometer {
    if (![self.motionManager isMagnetometerAvailable]) {
        NSLog(@"磁力计不可用");
        return;
    }
    self.motionManager.magnetometerUpdateInterval = UpdateInterval;
    @WeakSelf(self);
    [self.motionManager startMagnetometerUpdatesToQueue:[NSOperationQueue new] withHandler:^(CMMagnetometerData * _Nullable magnetometerData, NSError * _Nullable error) {
        if ([weakSelf.MagnetometerDelegate respondsToSelector:@selector(getCMMagnetometerData:error:)]) {
            [weakSelf.MagnetometerDelegate getCMMagnetometerData:magnetometerData error:error];
        }
    }];
}

- (void)endMagnetometer {
    [self.motionManager stopMagnetometerUpdates];
}

#pragma mark - 加速计

- (void)startAccelerometer {
    if (!self.motionManager.accelerometerAvailable) {
        NSLog(@"加速计不可用");
        return;
    }
    
    self.motionManager.accelerometerUpdateInterval = UpdateInterval;
    @WeakSelf(self);
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        if ([weakSelf.AccelerometerDelegate respondsToSelector:@selector(getCMAccelerometerData:error:)]) {
            [weakSelf.AccelerometerDelegate getCMAccelerometerData:accelerometerData error:error];
        }
    }];
}

- (void)endAccelerometer {
    [self.motionManager stopAccelerometerUpdates];
}

#pragma mark - 运动传感器

- (void)startDeviceMotion {
    if (![self.motionManager isDeviceMotionAvailable]) {
        NSLog(@"运动传感器不可用");
        return;
    }
    
    [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue new]
                                            withHandler:^(CMDeviceMotion * _Nullable motion,
                                                          NSError * _Nullable error) {
                                                if ([self.DeviceMotionDelegate respondsToSelector:@selector(getCMDeviceMotion:error:)]) {
                                                    [self.DeviceMotionDelegate getCMDeviceMotion:motion error:error
                                                     ];
                                                }
                                            }];
}

- (void)endDeviceMotion {
    [self.motionManager stopDeviceMotionUpdates];
}

#pragma mark - 计步器

- (CMPedometer *)pedometer {
    if (!_pedometer) {
        _pedometer = [[CMPedometer alloc] init];
    }
    return _pedometer;
}

- (void)startCMPedometer {
    if (![CMPedometer isStepCountingAvailable]) {
        NSLog(@"计步器无效");
        return;
    }
    
    [self.pedometer startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        if ([self.CMPedometerDelegate respondsToSelector:@selector(getCMPedometerData:error:)]) {
            [self.CMPedometerDelegate getCMPedometerData:pedometerData error:error];
        }
    }];
}

- (void)endCMPedometer {
    [self.pedometer stopPedometerUpdates];
}

#pragma mark - 光感

- (AVCaptureSession *)session {
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
    }
    return _session;
}
- (void)startAmbientLight {
    
    // 1.获取硬件设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device == nil) {
        NSLog(@"不支持");
        return;
    }
    // 2.创建输入流
    AVCaptureDeviceInput *input = [[AVCaptureDeviceInput alloc]initWithDevice:device error:nil];
    // 3.创建设备输出流
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
    [output setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    
    // AVCaptureSession属性
    // 设置为高质量采集率
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    // 添加会话输入和输出
    if ([self.session canAddInput:input]) {
        [self.session addInput:input];
    }
    if ([self.session canAddOutput:output]) {
        [self.session addOutput:output];
    }
    // 9.启动会话
    [self.session startRunning];
}

// AVCaptureVideoDataOutputSampleBufferDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    CFDictionaryRef metadataDict = CMCopyDictionaryOfAttachments(NULL,sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    NSDictionary *metadata = [[NSMutableDictionary alloc] initWithDictionary:(__bridge NSDictionary*)metadataDict];
    CFRelease(metadataDict);
    NSDictionary *exifMetadata = [[metadata objectForKey:(NSString *)kCGImagePropertyExifDictionary] mutableCopy];
    float brightnessValue = [[exifMetadata objectForKey:(NSString *)kCGImagePropertyExifBrightnessValue] floatValue];
    if ([self.AmbientLightDelegate respondsToSelector:@selector(getBrightnessValue:)]) {
        [self.AmbientLightDelegate getBrightnessValue:brightnessValue];
    }
}

- (void)endAmbientLight {
    [self.session stopRunning];
    self.session = nil;
}


@end

//
//  DeviceMotionViewController.m
//  Sensor
//
//  Created by 朱帅(EX-ZHUSHUAI002) on 2019/6/13.
//  Copyright © 2019 朱帅(EX-ZHUSHUAI002). All rights reserved.
//

#import "DeviceMotionViewController.h"

@interface DeviceMotionViewController () <DeviceMotionDelegate>

@end

@implementation DeviceMotionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[SensorManager sharedManager] startDeviceMotion];
    [SensorManager sharedManager].DeviceMotionDelegate = self;
}

- (void)getCMDeviceMotion:(CMDeviceMotion *)motion error:(NSError *)error {
    double gravityX = motion.gravity.x;
    double gravityY = motion.gravity.y;
    double gravityZ = motion.gravity.z;
    double zTheta = atan2(gravityZ,sqrtf(gravityX*gravityX+gravityY*gravityY))/M_PI*180.0;
    double xyTheta = atan2(gravityX,gravityY)/M_PI*180.0;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.tipLabel.text = [NSString stringWithFormat:@"\n重力:\nX：%f\nY：%f\nZ：%f \n与水平夹角: %f\n自身旋转角度：%f", gravityX, gravityY, gravityZ, zTheta, xyTheta];

    });
}

- (void)dealloc {
    [[SensorManager sharedManager] endDeviceMotion];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

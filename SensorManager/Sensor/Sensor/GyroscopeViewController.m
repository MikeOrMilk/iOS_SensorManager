//
//  GyroscopeViewController.m
//  Sensor
//
//  Created by 朱帅(EX-ZHUSHUAI002) on 2019/6/13.
//  Copyright © 2019 朱帅(EX-ZHUSHUAI002). All rights reserved.
//

#import "GyroscopeViewController.h"

@interface GyroscopeViewController () <GyroscopeDelegate>

@end

@implementation GyroscopeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[SensorManager sharedManager] startGyroscope];
    [SensorManager sharedManager].GyroscopeDelegate = self;
}

- (void)getCMGyroData:(CMGyroData *)gyroData error:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
    self.tipLabel.text = [NSString stringWithFormat:@"旋转速度 x = %f, y = %f, z = %f", gyroData.rotationRate.x, gyroData.rotationRate.y, gyroData.rotationRate.z];
    });
}

- (void)dealloc {
    [[SensorManager sharedManager] endGyroscope];
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

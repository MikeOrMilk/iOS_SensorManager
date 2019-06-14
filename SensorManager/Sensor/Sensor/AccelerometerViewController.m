//
//  AccelerometerViewController.m
//  Sensor
//
//  Created by 朱帅(EX-ZHUSHUAI002) on 2019/6/13.
//  Copyright © 2019 朱帅(EX-ZHUSHUAI002). All rights reserved.
//

#import "AccelerometerViewController.h"

@interface AccelerometerViewController () <AccelerometerDelegate>

@end

@implementation AccelerometerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[SensorManager sharedManager] startAccelerometer];
    [SensorManager sharedManager].AccelerometerDelegate = self;
}

- (void)getCMAccelerometerData:(CMAccelerometerData *)accelerometerData error:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.tipLabel.text = [NSString stringWithFormat:@"加速度：x : %f, y : %f, z : %f", accelerometerData.acceleration.x, accelerometerData.acceleration.y, accelerometerData.acceleration.z];
    });
}

- (void)dealloc {
    [[SensorManager sharedManager] endAccelerometer];
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

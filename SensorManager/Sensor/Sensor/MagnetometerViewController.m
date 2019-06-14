//
//  MagnetometerViewController.m
//  Sensor
//
//  Created by 朱帅(EX-ZHUSHUAI002) on 2019/6/13.
//  Copyright © 2019 朱帅(EX-ZHUSHUAI002). All rights reserved.
//

#import "MagnetometerViewController.h"

@interface MagnetometerViewController () <MagnetometerDelegate>

@end

@implementation MagnetometerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[SensorManager sharedManager] startMagnetometer];
    [SensorManager sharedManager].MagnetometerDelegate = self;
}

- (void)getCMMagnetometerData:(CMMagnetometerData *)magnetometerData error:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
       self.tipLabel.text = [NSString stringWithFormat:@"x : %f, y : %f, z : %f", magnetometerData.magneticField.x, magnetometerData.magneticField.y, magnetometerData.magneticField.z];
    });
}

- (void)dealloc {
    [[SensorManager sharedManager] endMagnetometer];
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

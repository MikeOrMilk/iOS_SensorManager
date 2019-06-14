
//
//  CMPedometerViewController.m
//  Sensor
//
//  Created by 朱帅(EX-ZHUSHUAI002) on 2019/6/13.
//  Copyright © 2019 朱帅(EX-ZHUSHUAI002). All rights reserved.
//

#import "CMPedometerViewController.h"

@interface CMPedometerViewController () <CMPedometerDelegate>

@end

@implementation CMPedometerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[SensorManager sharedManager] startCMPedometer];
    [SensorManager sharedManager].CMPedometerDelegate = self;
    self.tipLabel.text = @"步数0 距离0米\n请走动试试";
}

- (void)getCMPedometerData:(CMPedometerData *)pedometerData error:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.tipLabel.text = [NSString stringWithFormat:@"步数 %@, 距离 %@ 米",pedometerData.numberOfSteps,pedometerData.distance];
    });
}

- (void)dealloc {
    [[SensorManager sharedManager] endCMPedometer];
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

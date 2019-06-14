//
//  CMAltimeterViewController.m
//  Sensor
//
//  Created by 朱帅(EX-ZHUSHUAI002) on 2019/6/13.
//  Copyright © 2019 朱帅(EX-ZHUSHUAI002). All rights reserved.
//

#import "CMAltimeterViewController.h"

@interface CMAltimeterViewController () <CMAltimeterDelegate>

@end

@implementation CMAltimeterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tipLabel.text = @"气压计（数据会延迟获取）";
    [[SensorManager sharedManager] startCMAltimeter];
    [SensorManager sharedManager].CMAltimeterDelegate = self;
}

- (void)getCMAltitudeData:(CMAltitudeData *)altitudeData error:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.tipLabel.text = [NSString stringWithFormat:@"相对高度:%@ m \n 气压:%@ kPa", altitudeData.relativeAltitude, altitudeData.pressure];
    });
}

- (void)dealloc {
    [[SensorManager sharedManager] endCMAltimeter];
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

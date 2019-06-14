
//
//  AmbientLightViewController.m
//  Sensor
//
//  Created by 朱帅(EX-ZHUSHUAI002) on 2019/6/13.
//  Copyright © 2019 朱帅(EX-ZHUSHUAI002). All rights reserved.
//

#import "AmbientLightViewController.h"

@interface AmbientLightViewController () <AmbientLightDelegate>

@end

@implementation AmbientLightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[SensorManager sharedManager] startAmbientLight];
    [SensorManager sharedManager].AmbientLightDelegate = self;
    self.tipLabel.text = @"根据当前环境光感提示是否打开闪光灯\n环境光感<0:提示是否打开闪光灯\n环境光感>0:提示是否关闭闪光灯";
}

- (void)getBrightnessValue:(float)brightnessValue {
    self.tipLabel.text = [NSString stringWithFormat:@"当前感光系数:%f", brightnessValue];
}

- (void)dealloc {
    [[SensorManager sharedManager] endAmbientLight];
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

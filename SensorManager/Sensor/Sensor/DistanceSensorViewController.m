//
//  DistanceSensorViewController.m
//  Sensor
//
//  Created by 朱帅(EX-ZHUSHUAI002) on 2019/6/13.
//  Copyright © 2019 朱帅(EX-ZHUSHUAI002). All rights reserved.
//

#import "DistanceSensorViewController.h"

@interface DistanceSensorViewController () <DistanceSensorDelegate>

@end

@implementation DistanceSensorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tipLabel.text = @"距离传感器\n靠近听筒黑屏，离开听筒亮屏";
    
    [[SensorManager sharedManager] startDistanceSensor];
    [SensorManager sharedManager].distanceSensorDelegate = self;
}

- (void)proximityStateDidChange:(BOOL)proximityState {
    if (proximityState) {
        NSLog(@"靠近");
    }
    else {
        NSLog(@"远离");
    }
}

- (void)dealloc {
    [[SensorManager sharedManager] endDistanceSensor];
}

@end

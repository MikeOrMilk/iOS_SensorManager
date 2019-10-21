//
//  TouchIDViewController.m
//  Sensor
//
//  Created by 朱帅(EX-ZHUSHUAI002) on 2019/6/13.
//  Copyright © 2019 朱帅(EX-ZHUSHUAI002). All rights reserved.
//

#import "TouchIDViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "SensorManager.h"

@interface TouchIDViewController () <SensorManagerDelegate>

@end

@implementation TouchIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [SensorManager sharedManager].sensorDelegate = self;
    [[SensorManager sharedManager] startTouchID];
}

- (void)getTouchIDResultSuccess:(BOOL)success error:(NSError *)error {
    if (success) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"验证成功");
        });
    }
    else {
        switch (error.code) {
            case LAErrorSystemCancel:
            {
                NSLog(@"系统取消授权，如其他APP切入");
                break;
            }
            case LAErrorUserCancel:
            {
                NSLog(@"用户取消验证Touch ID");
                break;
            }
            case LAErrorAuthenticationFailed:
            {
                NSLog(@"授权失败");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"系统未设置密码");
                break;
            }
            case LAErrorBiometryNotAvailable:
            {
                NSLog(@"设备Touch ID不可用，例如未打开");
                break;
            }
            case LAErrorBiometryNotEnrolled:
            {
                NSLog(@"设备Touch ID不可用，用户未录入");
                break;
            }
            case LAErrorUserFallback:
            {
                NSLog(@"用户选择输入密码");
                break;
            }
            default:
            {
                NSLog(@"其他情况，切换主线程处理");
                break;
            }
        }
    }
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

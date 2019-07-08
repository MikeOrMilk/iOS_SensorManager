
//
//  NFCViewController.m
//  Sensor
//
//  Created by 朱帅(EX-ZHUSHUAI002) on 2019/6/13.
//  Copyright © 2019 朱帅(EX-ZHUSHUAI002). All rights reserved.
//

#import "NFCViewController.h"
#import "SensorManager.h"

@interface NFCViewController () <SensorManagerDelegate>

@end

@implementation NFCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [SensorManager sharedManager].sensorDelegate = self;
    [[SensorManager sharedManager] startNFC];
}

- (void)readerSession:(NFCNDEFReaderSession *)session didDetectNDEFs:(NSArray *)messages {
    // 读取成功
    for (NFCNDEFMessage *msg in messages) {
        NSArray *ary = msg.records;
        for (NFCNDEFPayload *rec in ary) {
            
            NFCTypeNameFormat typeName = rec.typeNameFormat;
            NSData *payload = rec.payload;
            NSData *type = rec.type;
            NSData *identifier = rec.identifier;
            
            NSLog(@"TypeName : %d",typeName);
            NSLog(@"Payload : %@",payload);
            NSLog(@"Type : %@",type);
            NSLog(@"Identifier : %@",identifier);
        }
    }
}

- (void)readerSession:(NFCNDEFReaderSession *)session didInvalidateWithError:(NSError *)error {
    NSLog(@"%ld", (long)error.code);
    // error.code == 201 扫描超时
    // error.code == 200 取消扫描
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

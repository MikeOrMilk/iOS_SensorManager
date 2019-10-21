//
//  BaseViewController.m
//  Sensor
//
//  Created by 朱帅(EX-ZHUSHUAI002) on 2019/6/13.
//  Copyright © 2019 朱帅(EX-ZHUSHUAI002). All rights reserved.
//

#import "BaseViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface BaseViewController () <UITableViewDelegate, UITableViewDataSource, SensorManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <NSString *>*dataArray;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setData];
    [self setUI];
}

- (void)setUI {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)setData {
    [SensorManager sharedManager].sensorDelegate = self;
    [[SensorManager sharedManager] startDistanceSensor];
    [[SensorManager sharedManager] startCMAltimeter];
    [[SensorManager sharedManager] startGyroscope];
    [[SensorManager sharedManager] startMagnetometer];
    [[SensorManager sharedManager] startAccelerometer];
    [[SensorManager sharedManager] startDeviceMotion];
    [[SensorManager sharedManager] startCMPedometer];
    [[SensorManager sharedManager] startAmbientLight];
    self.dataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 8; i++) {
        [self.dataArray addObject:@""];
        if (i == 0) {
            self.dataArray[0] = @"距离传感器（靠近听筒前方测试)";
        }
        if (i == 6) {
            self.dataArray[6] = @"计步器(会有延迟)\n走两步试试";
        }
    }
}


#pragma mark - SensorManagerDelegate

- (void)proximityStateDidChange:(BOOL)proximityState {
    self.dataArray[0] = proximityState ? @"距离传感器：靠近" : @"距离传感器：远离";
    [self updateUI];
    if (proximityState) {
        NSLog(@"靠近");
    }
    else {
        NSLog(@"远离");
    }
    
}

- (void)getCMAltitudeData:(CMAltitudeData *)altitudeData error:(NSError *)error {
    NSLog(@"%@", [NSString stringWithFormat:@"相对高度:%@ m \n 气压:%@ kPa", altitudeData.relativeAltitude, altitudeData.pressure]);
    self.dataArray[1] = [NSString stringWithFormat:@"气压计（会有延迟）\n相对高度:%@ m \n 气压:%@ kPa", altitudeData.relativeAltitude, altitudeData.pressure];
    [self updateUI];
}

- (void)getCMGyroData:(CMGyroData *)gyroData error:(NSError *)error {
    NSLog(@"%@", [NSString stringWithFormat:@"旋转速度 x = %f, y = %f, z = %f", gyroData.rotationRate.x, gyroData.rotationRate.y, gyroData.rotationRate.z]);
    self.dataArray[2] = [NSString stringWithFormat:@"陀螺仪\n旋转速度 x = %f, y = %f, z = %f", gyroData.rotationRate.x, gyroData.rotationRate.y, gyroData.rotationRate.z];
    [self updateUI];
}

- (void)getCMMagnetometerData:(CMMagnetometerData *)magnetometerData error:(NSError *)error {
    NSLog(@"%@", [NSString stringWithFormat:@"x : %f, y : %f, z : %f", magnetometerData.magneticField.x, magnetometerData.magneticField.y, magnetometerData.magneticField.z]);
    self.dataArray[3] = [NSString stringWithFormat:@"磁力计\nx : %f, y : %f, z : %f", magnetometerData.magneticField.x, magnetometerData.magneticField.y, magnetometerData.magneticField.z];
    [self updateUI];
}

- (void)getCMAccelerometerData:(CMAccelerometerData *)accelerometerData error:(NSError *)error {
    NSLog(@"%@", [NSString stringWithFormat:@"加速度：x : %f, y : %f, z : %f", accelerometerData.acceleration.x, accelerometerData.acceleration.y, accelerometerData.acceleration.z]);
    self.dataArray[4] = [NSString stringWithFormat:@"加速计\n加速度：x : %f, y : %f, z : %f", accelerometerData.acceleration.x, accelerometerData.acceleration.y, accelerometerData.acceleration.z];
    [self updateUI];
}

- (void)getCMDeviceMotion:(CMDeviceMotion *)motion error:(NSError *)error {
    double gravityX = motion.gravity.x;
    double gravityY = motion.gravity.y;
    double gravityZ = motion.gravity.z;
    double zTheta = atan2(gravityZ,sqrtf(gravityX*gravityX+gravityY*gravityY))/M_PI*180.0;
    double xyTheta = atan2(gravityX,gravityY)/M_PI*180.0;
    NSLog(@"%@", [NSString stringWithFormat:@"重力:\nX：%f\nY：%f\nZ：%f \n与水平夹角: %f\n自身旋转角度：%f", gravityX, gravityY, gravityZ, zTheta, xyTheta]);
    self.dataArray[5] = [NSString stringWithFormat:@"运动传感器\n重力:\nX：%f\nY：%f\nZ：%f \n与水平夹角: %f\n自身旋转角度：%f", gravityX, gravityY, gravityZ, zTheta, xyTheta];
    [self updateUI];
}

- (void)getCMPedometerData:(CMPedometerData *)pedometerData error:(NSError *)error {
    NSLog(@"%@", [NSString stringWithFormat:@"步数 %@, 距离 %@ 米",pedometerData.numberOfSteps,pedometerData.distance]);
    self.dataArray[6] =  [NSString stringWithFormat:@"计步器（会有延迟）\n步数 %@, 距离 %@ 米",pedometerData.numberOfSteps,pedometerData.distance];
    [self updateUI];
}

- (void)getBrightnessValue:(float)brightnessValue {
    NSLog(@"%@", [NSString stringWithFormat:@"当前感光系数:%f", brightnessValue]);
    self.dataArray[7] = [NSString stringWithFormat:@"光感（后置摄像头测量）\n当前感光系数:%f", brightnessValue];
    [self updateUI];
}

- (void)updateUI {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (void)dealloc {
    NSLog(@"%@", self.class);
}

@end

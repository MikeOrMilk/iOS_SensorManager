//
//  ViewController.m
//  Sensor
//
//  Created by 朱帅(EX-ZHUSHUAI002) on 2019/6/13.
//  Copyright © 2019 朱帅(EX-ZHUSHUAI002). All rights reserved.
//

#import "ViewController.h"
#import "SensorManager.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setData];
    [self setUI];
}

- (void)setData {
    self.dataArray = @[@"距离传感器、气压计、陀螺仪、磁力计、加速计、运动传感器、计步器、光感",
                       @"touchID",
                       @"NFC"];
}

- (void)setUI {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 0 ? 88 : 44;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    NSArray *vcs = @[@"BaseViewController",
                     @"TouchIDViewController",
                     @"NFCViewController",];
    [self.navigationController pushViewController:[[NSClassFromString(vcs[row]) alloc] init] animated:YES];
}

@end

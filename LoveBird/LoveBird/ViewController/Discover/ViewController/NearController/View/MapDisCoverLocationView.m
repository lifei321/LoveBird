//
//  MapDisCoverLocationView.m
//  LoveBird
//
//  Created by cheli shan on 2018/8/7.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MapDisCoverLocationView.h"


@interface MapDisCoverLocationView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end


@implementation MapDisCoverLocationView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundColor = [UIColor whiteColor];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [self addSubview:self.tableView];
        
    }
    return self;
}

- (void)closeBUttonClick {
    [self removeFromSuperview];
}


- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = [dataArray mutableCopy];
    [self.tableView reloadData];
}


#pragma mark-- tabelView 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    NSString *info = self.dataArray[indexPath.row];
    cell.textLabel.text = info;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return AutoSize6(130);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *info = self.dataArray[indexPath.row];

    if (self.locationBlock) {
        self.locationBlock(info, indexPath.row);
    }
}


@end

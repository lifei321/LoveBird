//
//  MapDisCoverView.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/19.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MapDisCoverView.h"
#import "FindResultCell.h"
#import "MapDiscoverModel.h"
#import "BirdDetailController.h"


@interface MapDisCoverView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, strong) MapDiscoverInfoModel *selectBirdModel;

@end

@implementation MapDisCoverView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 5;
        self.backgroundColor = [UIColor whiteColor];
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(25), 0, AutoSize6(300), AutoSize6(100))];
        _textLabel.font = kFontPF6(32);
        _textLabel.textColor = [UIColor blackColor];
        [self addSubview:_textLabel];
        
        UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - AutoSize6(70), AutoSize6(30), AutoSize6(40), AutoSize6(40))];
        [closeButton setImage:[UIImage imageNamed:@"map_close"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeBUttonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeButton];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(AutoSize6(25), _textLabel.bottom, frame.size.width - AutoSize6(50), 0.5)];
        line.backgroundColor = kLineColoreDefaultd4d7dd;
        [self addSubview:line];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, line.bottom, frame.size.width, frame.size.height - line.bottom - AutoSize6(30)) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundColor = [UIColor whiteColor];
        [self.tableView registerClass:[FindResultCell class] forCellReuseIdentifier:NSStringFromClass([FindResultCell class])];
        [self addSubview:self.tableView];
        
    }
    return self;
}

- (void)closeBUttonClick {
    [self.backView removeFromSuperview];
    [self removeFromSuperview];
}


- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = [dataArray mutableCopy];
    self.textLabel.text = [NSString stringWithFormat:@"全部鸟种(%ld)", dataArray.count];
    [self.tableView reloadData];
}


#pragma mark-- tabelView 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FindResultCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FindResultCell class]) forIndexPath:indexPath];
    cell.infoModel = self.dataArray[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return AutoSize6(130);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MapDiscoverInfoModel *bridModel = self.dataArray[indexPath.row];
    if (self.selectBirdModel == bridModel) {
        return;
    }
    
    for (MapDiscoverInfoModel *cellmodel in self.dataArray) {
        if (cellmodel.isSelect) {
            cellmodel.isSelect = NO;
            break;
        }
    }
    self.selectBirdModel = bridModel;
    bridModel.isSelect = YES;
    [self.tableView reloadData];
    
    BirdDetailController *detailvc = [[BirdDetailController alloc] init];
    detailvc.cspCode = bridModel.csp_code;
    [[UIViewController currentViewController].navigationController pushViewController:detailvc animated:YES];
}

@end

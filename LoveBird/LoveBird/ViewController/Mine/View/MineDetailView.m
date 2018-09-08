//
//  MineDetailView.m
//  LoveBird
//
//  Created by cheli shan on 2018/9/8.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MineDetailView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MineSetModel.h"

@interface  MineDetailView() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIImageView *headView;

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UILabel *gradeLabel;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MineDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 5;
        self.backgroundColor = [UIColor whiteColor];
        
        _headView = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(15), AutoSize6(70), AutoSize6(70))];
        _headView.clipsToBounds = YES;
        _headView.layer.cornerRadius = _headView.width / 2;
        [self addSubview:_headView];

        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(_headView.right + AutoSize6(10), 0, AutoSize6(300), AutoSize6(100))];
        _textLabel.font = kFontPF6(28);
        _textLabel.textColor = [UIColor blackColor];
        [self addSubview:_textLabel];
        
        self.gradeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_textLabel.right, _textLabel.top, AutoSize6(54), AutoSize6(30))];
        self.gradeLabel.centerY = _textLabel.centerY;
        self.gradeLabel.textColor = [UIColor whiteColor];
        self.gradeLabel.backgroundColor = kColorDefaultColor;
        self.gradeLabel.font = kFont6(18);
        self.gradeLabel.textAlignment = NSTextAlignmentCenter;
        self.gradeLabel.layer.masksToBounds = YES;
        self.gradeLabel.layer.cornerRadius = 3;
        [self addSubview:self.gradeLabel];
        
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
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.tableFooterView = [UIView new];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [self addSubview:self.tableView];
        
    }
    return self;
}

- (void)closeBUttonClick {
    [self.backView removeFromSuperview];
    [self removeFromSuperview];
}

- (void)setName:(NSString *)name {
    self.textLabel.text = name;
}

- (void)setHead:(NSString *)head {
    [_headView sd_setImageWithURL:[NSURL URLWithString:head] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
}

- (void)setGrade:(NSString *)grade {
    
    CGFloat width = [_textLabel.text getTextWightWithFont:self.textLabel.font];
    self.textLabel.width = width + AutoSize6(10);
    
    if (grade.length == 0) {
        grade = @"0";
    }
    self.gradeLabel.text = [NSString stringWithFormat:@"Lv.%@", grade];
    
    CGFloat gradewidth = [self.gradeLabel.text getTextWightWithFont:self.gradeLabel.font];
    self.gradeLabel.width = gradewidth + AutoSize6(20);
    
    self.gradeLabel.left = self.textLabel.right;
}

- (void)setUserModel:(UserModel *)userModel {
    _userModel = userModel;
    
    [self makeData];
    [self.tableView reloadData];
}

#pragma mark-- tabelView 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(AutoSize6(25), AutoSize6(94) - 0.5, self.tableView.width - AutoSize6(50), 0.5)];
    line.backgroundColor = kLineColoreDefaultd4d7dd;
    [cell.contentView addSubview:line];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MineSetModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.title;
    cell.textLabel.textColor = kColorTextColor7f7f7f;
    
    cell.detailTextLabel.text = model.detailText;
    cell.detailTextLabel.textColor = kColorTextColor333333;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return AutoSize6(94);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (void)makeData {
    
    _dataArray = [NSMutableArray new];
    
    MineSetModel *model1 = [[MineSetModel alloc] init];
    model1.title = @"签名";
    model1.detailText = _userModel.sign;
    [self.dataArray addObject:model1];
    
    MineSetModel *model2 = [[MineSetModel alloc] init];
    model2.title = @"所在地";
    model2.detailText = [NSString stringWithFormat:@"%@%@", _userModel.province, _userModel.city];
    [self.dataArray addObject:model2];
    
    MineSetModel *model3 = [[MineSetModel alloc] init];
    model3.title = @"微信";
    model3.detailText = _userModel.wechat;
    [self.dataArray addObject:model3];
    
    MineSetModel *model4 = [[MineSetModel alloc] init];
    model4.title = @"微博";
    model4.detailText = _userModel.weibo;
    [self.dataArray addObject:model4];
}
@end

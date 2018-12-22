//
//  LogDetailHeadCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/30.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "LogDetailHeadCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LogDetailUpModel.h"
#import "UserInfoViewController.h"
#import "LogDetailHeadImageView.h"

@interface LogDetailHeadCell()

@property (nonatomic, strong) UILabel *birdLabel;

@property (nonatomic, strong) UIView *lineView;
@end

@implementation LogDetailHeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        self.birdLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(20), SCREEN_WIDTH / 2, AutoSize6(25))];
        self.birdLabel.textColor = kColorTextColorLightGraya2a2a2;
        self.birdLabel.font = kFont6(24);
        [self.contentView addSubview:self.birdLabel];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(AutoSize6(0), AutoSize6(136), SCREEN_WIDTH, 1)];
        self.lineView.backgroundColor = kLineColoreDefaultd4d7dd;
        [self.contentView addSubview:self.lineView];
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = [dataArray copy];
    
    NSMutableArray *array = [NSMutableArray new];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];

    _dataArray = [NSArray arrayWithArray:array];
    self.birdLabel.text = [NSString stringWithFormat:@"已有%ld人赞过", self.dataArray.count];

    CGFloat top = self.birdLabel.bottom + AutoSize6(20);
    int count = 1;
    CGFloat width = AutoSize6(66);
    CGFloat left = AutoSize6(30);
    int j = 0;
    for (int i = 0; i < self.dataArray.count; i ++) {
        LogDetailUpModel *model = self.dataArray[i];
        left = AutoSize6(30) + (i - j) * width * 2 / 3;
        
        if ((left + width) > (SCREEN_WIDTH - AutoSize6(30))) {
            left = AutoSize6(30);
            top = self.birdLabel.bottom + AutoSize6(20) + AutoSize6(20) + width;
            count ++;
            j = i;
        }
        
        if (count > 2) {
            break;
        }
        
        LogDetailHeadImageView *image = [self makeViewWithLeft:left top:top];
        image.contentMode = UIViewContentModeScaleToFill;
        [image sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
        image.userInteractionEnabled = YES;
        image.uid = model.uid;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headDidClick:)];
        [image addGestureRecognizer:tap];
    }
    
    self.lineView.top = top + width + AutoSize6(18);
}

- (LogDetailHeadImageView *)makeViewWithLeft:(CGFloat)left top:(CGFloat)top {
    LogDetailHeadImageView *view  = [[LogDetailHeadImageView alloc] initWithFrame:CGRectMake(left, top, AutoSize6(66), AutoSize6(66))];
    view.contentMode = UIViewContentModeScaleAspectFit;
    view.layer.cornerRadius = view.height / 2;
    view.clipsToBounds = YES;
    [self.contentView addSubview:view];
    
    return view;
}

- (void)headDidClick:(UITapGestureRecognizer *)tap {
    
    LogDetailHeadImageView *headView = (LogDetailHeadImageView *)tap.view;
    UserInfoViewController *infovc = [[UserInfoViewController alloc] init];
    infovc.uid = headView.uid;
    [[UIViewController currentViewController].navigationController pushViewController:infovc animated:YES];
}

+ (CGFloat)getHeight:(NSArray *)dataArray {
    NSMutableArray *array = [NSMutableArray new];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];
    [array addObjectsFromArray:dataArray];

    dataArray = [NSArray arrayWithArray:array];
    
    CGFloat top = 0.0;
    int count = 0;
    CGFloat width = AutoSize6(66);

    for (int i = 0; i < dataArray.count; i ++) {
        
        CGFloat left;
        if (i == 0) {
            left = AutoSize6(30);
            top = AutoSize6(20) + AutoSize6(25) + AutoSize6(20);
            count = 1;
        } else {
            left = AutoSize6(30) + i * width * 2 / 3;
        }
        
        if ((left + width) > (SCREEN_WIDTH - AutoSize6(30))) {
            left = AutoSize6(30);
            top = AutoSize6(20) + AutoSize6(25) + AutoSize6(20) + width + AutoSize6(20) ;
            count ++;
        }
        if (count > 2) {
            break;
        }
    }
    
    return  top + width + AutoSize6(20);
}

@end

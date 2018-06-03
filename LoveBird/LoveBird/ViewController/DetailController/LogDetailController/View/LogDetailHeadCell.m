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
        
        self.birdLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(210), 0, AutoSize6(180), AutoSize6(138))];
        self.birdLabel.textAlignment = NSTextAlignmentRight;
        self.birdLabel.textColor = kColorTextColorLightGraya2a2a2;
        self.birdLabel.font = kFont6(24);
        [self.contentView addSubview:self.birdLabel];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(AutoSize6(0), AutoSize6(137), SCREEN_WIDTH, 0.5)];
        self.lineView.backgroundColor = kLineColoreDefaultd4d7dd;
        [self.contentView addSubview:self.lineView];
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = [dataArray copy];
    
    self.birdLabel.text = [NSString stringWithFormat:@"已有%ld人赞过", dataArray.count];

    for (int i = 0; i < dataArray.count; i ++) {
        LogDetailUpModel *model = self.dataArray[i];
        CGFloat left;
        if (i == 0) {
            left = AutoSize6(30);
        } else {
            left = AutoSize6(30) + i * AutoSize6(66) * 2 / 3;
        }
        UIImageView *image = [self makeViewWithLeft:left];
        [image sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@""]];
        
        if (i > 7) {
            break;
        }
    }
}

- (UIImageView *)makeViewWithLeft:(CGFloat)left {
    UIImageView *view  = [[UIImageView alloc] initWithFrame:CGRectMake(left, AutoSize6(36), AutoSize6(66), AutoSize6(66))];
    view.contentMode = UIViewContentModeCenter;
    view.layer.cornerRadius = view.height / 2;
    view.clipsToBounds = YES;
    [self.contentView addSubview:view];
    
    return view;
}

@end

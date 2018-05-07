//
//  PublishSelectCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/6.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "PublishSelectCell.h"
#import "PublishSelectView.h"

@interface PublishSelectCell()

@property (nonatomic, strong) UILabel *titleLabe;

@property (nonatomic, strong) UIButton *lessButton;

@end

@implementation PublishSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.titleLabe = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(30), 0, AutoSize6(150), AutoSize6(112))];
        self.titleLabe.textColor = [UIColor blackColor];
        self.titleLabe.textAlignment = NSTextAlignmentLeft;
        self.titleLabe.font = kFont6(30);
        [self.contentView addSubview:self.titleLabe];
        
        
        PublishSelectView *pview = [[PublishSelectView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(310), AutoSize6(30), AutoSize6(220), AutoSize6(112))];
        [self.contentView addSubview:pview];
        
        self.lessButton = [[UIButton alloc] initWithFrame:CGRectMake(pview.right, AutoSize6(30), AutoSize6(52), AutoSize6(52))];
        [self.lessButton addTarget:self action:@selector(lessButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.lessButton setImage:[UIImage imageNamed:@"pub_less_no"] forState:UIControlStateNormal];
        [self.lessButton setImage:[UIImage imageNamed:@"pub_less_yes"] forState:UIControlStateSelected];
        [self.contentView addSubview:self.lessButton];
        
        
    }
    return self;
}

- (void)setTitleText:(NSString *)titleText {
    self.accessoryType = UITableViewCellStyleDefault;
    if ([titleText isEqualToString:@"选择鸟种"]) {
        self.titleLabe.textColor = kColorTextColorLightGraya2a2a2;
        self.lessButton.selected = YES;
    }
    self.titleLabe.text = titleText;
}

- (void)lessButtonClick:(UIButton *)button {
    if (button.selected) {
        return;
    }
}

@end

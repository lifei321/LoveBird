//
//  LogContentSubjectCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/3.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "LogContentSubjectCell.h"

@interface LogContentSubjectCell()

@property (nonatomic, strong) UILabel *birdLabel;

@property (nonatomic, strong) UILabel *tagLabel;


@end


@implementation LogContentSubjectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        self.birdLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(20), SCREEN_WIDTH / 2, AutoSize6(60))];
        self.birdLabel.textAlignment = NSTextAlignmentLeft;
        self.birdLabel.textColor = kColorTextColorLightGraya2a2a2;
        self.birdLabel.font = kFont6(22);
        [self.contentView addSubview:self.birdLabel];
        
        self.tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - SCREEN_WIDTH / 2 - AutoSize6(30), AutoSize6(20), SCREEN_WIDTH / 2 - AutoSize6(30), AutoSize6(60))];
        self.tagLabel.textAlignment = NSTextAlignmentRight;
        self.tagLabel.textColor = kColorTextColorLightGraya2a2a2;
        self.tagLabel.font = kFont6(22);
        [self.contentView addSubview:self.tagLabel];
        
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    self.birdLabel.text = title;
}

- (void)setDetail:(NSString *)detail {
    self.tagLabel.text = detail;
}

@end

//
//  PublishSelectBirdCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/13.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "PublishSelectBirdCell.h"
#import "FindSelectBirdModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PublishSelectBirdCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation PublishSelectBirdCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.iconImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize6(30), 0, AutoSize6(200), AutoSize6(130))];
        self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.iconImageView.image = [UIImage imageNamed:@"pub_select_place"];
        [self.contentView addSubview:self.iconImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.iconImageView.right + AutoSize6(20), AutoSize6(30), SCREEN_WIDTH - AutoSize6(50) - self.iconImageView.right, AutoSize6(30))];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = kFont6(30);
        [self.contentView addSubview:self.titleLabel];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom + AutoSize6(15), self.titleLabel.width, AutoSize6(30))];
        self.contentLabel.textColor = [UIColor blackColor];
        self.contentLabel.textAlignment = NSTextAlignmentLeft;
        self.contentLabel.font = kFont6(28);
        [self.contentView addSubview:self.contentLabel];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, AutoSize6(129.5), SCREEN_WIDTH - AutoSize6(30), 0.5)];
        self.lineView.backgroundColor = kLineColoreDefaultd4d7dd;
        [self.contentView addSubview:self.lineView];
        
    }
    return self;
}

- (void)setModel:(AppBaseCellModel *)model {
//    [super setModel:model];
    self.accessoryType = UITableViewCellAccessoryNone;
    FindSelectBirdModel *bridModel = (FindSelectBirdModel *)model.userInfo;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:bridModel.bird_img] placeholderImage:[UIImage imageNamed:@"pub_select_place"]];
    self.titleLabel.text = bridModel.name;
    self.contentLabel.text = bridModel.name_la;
    
    self.titleLabel.textColor = (model.isSelect) ? kColorDefaultColor : [UIColor blackColor];
    self.contentLabel.textColor = (model.isSelect) ? kColorDefaultColor : [UIColor blackColor];
    self.lineView.backgroundColor = (model.isSelect) ? kColorDefaultColor : kLineColoreDefaultd4d7dd;


}


@end

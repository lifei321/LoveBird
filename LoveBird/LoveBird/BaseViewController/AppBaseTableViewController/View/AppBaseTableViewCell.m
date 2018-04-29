//
//  AppBaseTableViewCell.m
//  LoveBird
//
//  Created by ShanCheli on 2017/7/7.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppBaseTableViewCell.h"

@implementation AppBaseTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.textLabel.textColor = UIColorFromRGB(0x252525);
        self.detailTextLabel.textColor = UIColorFromRGB(0xbcbcbc);
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    // 复原初始状态
    if (self.model.rightView.superview == self.contentView) {
        [self.model.rightView removeFromSuperview];
    }
    
    if (self.model.leftView.superview == self.contentView) {
        [self.model.leftView removeFromSuperview];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    if (self.imageView.image != nil) {
        
        self.imageView.top = (self.height - self.imageView.image.size.height) / 2;
    }
    
    // 重置_titleTipsIcon位置
    if (self.model.titleIcon != nil) {
        self.model.titleIcon.left = CGRectGetMaxX(self.textLabel.frame) + AutoSize(2);
        self.model.titleIcon.top = self.height / 2 - self.model.titleIcon.size.height / 2;
    }
    
    if (self.model.rightView != nil) {
        
        if (self.model.rightView.width == 0) {
            self.model.rightView.width = self.width - self.model.rightView.left - AutoSize(15);
        }
        
        if (self.model.rightView.height == 0) {
            self.model.rightView.height = self.height - AutoSize(15);
        }
        
        self.model.rightView.top = self.height / 2 - self.model.rightView.height / 2;
        
        if (self.accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
            self.model.rightView.width = self.width - self.model.rightView.left - AutoSize(15) - AutoSize(10);
        }
    }
    
    if (self.model.detail != nil) {
        
        self.detailTextLabel.top = self.height / 2 - self.detailTextLabel.height / 2;
    }
}

- (void)setModel:(AppBaseCellModel *)model {
    
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xe1e1e1);
    
    self.textLabel.text = model.title;
    
    if ([model.detail isKindOfClass:[NSString class]]) {
        
        self.detailTextLabel.text = (NSString *)model.detail;
        
    } else if ([model.detail isKindOfClass:[UIImage class]]) {
        
        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - AutoSize(40) - AutoSize(10), (self.frame.size.height - AutoSize(40) ) / 2, AutoSize(40), AutoSize(40))];
        view.image = (UIImage *)model.detail;
        [self.contentView addSubview:view];
        
    } else {
        
        self.detailTextLabel.text = nil;
    }
    
    if (model.pushViewController == nil) {
        
        self.accessoryType = model.accessoryType;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    if (model.leftView != nil) {
        
        CGRect frame = model.leftView.frame;
        frame.origin.y = AutoSize(10) + (self.frame.size.height - AutoSize(15) - model.leftView.frame.size.height) / 2;
        model.leftView.frame = frame;
        
        if (![[self.contentView subviews] containsObject:model.leftView]) {
            [self.contentView addSubview:model.leftView];
        }
    } else {
        
        [self.model.leftView removeFromSuperview];
    }
    
    if (model.rightView != nil) {
        
        [self.contentView addSubview:model.rightView];
        
    } else {
        
        [self.model.rightView removeFromSuperview];
    }
    
    if (model.image != nil) {
        
        self.imageView.image = model.image;
    }
    
    if (model.detailColor != nil) {
        
        self.detailTextLabel.textColor = model.detailColor;
    }
    
    if (model.titleColor != nil) {
        
        self.textLabel.textColor = model.titleColor;
    }
    
    // cell title 提示图标
    if (model.titleIcon != nil) {
        
        [self.contentView addSubview:model.titleIcon];
        
    } else {
        
        [self.model.titleIcon removeFromSuperview];
    }
    
    self.hidden = model.hidden;
    
    _model = model;
}

@end

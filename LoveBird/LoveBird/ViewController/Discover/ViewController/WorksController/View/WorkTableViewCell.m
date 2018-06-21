//
//  WorkTableViewCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/27.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "WorkTableViewCell.h"
#import "WorksImageView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface WorkTableViewCell()

@property (nonatomic, strong) WorksImageView *leftImageview;

@property (nonatomic, strong) WorksImageView *rightImageview;

@end

@implementation WorkTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        

        self.leftImageview = [[WorksImageView alloc] init];
        self.leftImageview.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.leftImageview];
        
        self.rightImageview = [[WorksImageView alloc] init];
        self.rightImageview.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.rightImageview];
        
    }
    return self;
}

- (void)setListArray:(NSArray *)listArray {
    _listArray = [listArray copy];
    
    self.rightImageview.hidden = (listArray.count > 1) ? NO : YES;
    
    if (listArray.count == 1) {
        WorksModel *model = listArray.firstObject;
        [self.leftImageview sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
        
        CGFloat imageHeight = (model.imgHeight) * (SCREEN_WIDTH / model.imgWidth);
        self.leftImageview.frame = CGRectMake(0, 0, SCREEN_WIDTH, imageHeight);
        self.leftImageview.name = @"张三";
        
    } else if (listArray.count == 2) {
        
        WorksModel *model1 = listArray.firstObject;
        WorksModel *model2 = listArray.lastObject;
        
        CGFloat width1 = SCREEN_WIDTH * (model1.imgWidth / (model1.imgWidth + model2.imgWidth));
        CGFloat width2 = SCREEN_WIDTH * (model2.imgWidth / (model1.imgWidth + model2.imgWidth));
        
        CGFloat imageHeight = (model1.imgHeight) * (width1 / model1.imgWidth);
        
        self.leftImageview.frame = CGRectMake(0, 0, width1 - 1, imageHeight);
        self.rightImageview.frame = CGRectMake(width1 + 1, 0, width2 - 1, imageHeight);
        [self.leftImageview sd_setImageWithURL:[NSURL URLWithString:model1.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
        [self.rightImageview sd_setImageWithURL:[NSURL URLWithString:model2.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
        
        self.leftImageview.name = model1.tags;
        self.rightImageview.name = model2.tags;
    }
    
}

@end

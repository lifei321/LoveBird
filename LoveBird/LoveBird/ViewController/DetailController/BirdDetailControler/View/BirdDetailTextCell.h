//
//  BirdDetailTextCell.h
//  LoveBird
//
//  Created by cheli shan on 2018/6/2.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BirdDetailTextCell;
@protocol BirdDetailTextCellDelegate<NSObject>

- (void)BirdDetailTextCell:(BirdDetailTextCell *)cell button:(UIButton *)button;
@end

@interface BirdDetailTextCell : UITableViewCell

@property (nonatomic, weak) id<BirdDetailTextCellDelegate>delegate;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL hasImage;

@property (nonatomic, copy) NSString *detail;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *playButton;

@property (nonatomic, strong) UIImageView *iconImageView;

@end

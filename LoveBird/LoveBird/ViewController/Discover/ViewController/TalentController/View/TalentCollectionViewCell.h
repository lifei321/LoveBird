//
//  TalentCollectionViewCell.h
//  LoveBird
//
//  Created by cheli shan on 2018/3/4.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TalentModel.h"

@protocol FollowButtonDidClickDelegate <NSObject>

- (void)followButtonClickDelegate:(UIButton *)button;

@end

@interface TalentCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) TalentModel *talentModel;

@property (nonatomic, weak) id<FollowButtonDidClickDelegate>followDelegate;


@end

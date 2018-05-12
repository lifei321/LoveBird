//
//  PublishFooterView.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/7.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublishEditModel.h"


@protocol PublishFooterViewDelegate<NSObject>

- (void)textViewClickDelegate:(PublishEditModel *)model;

- (void)imageViewClickDelegate:(PublishEditModel *)model;


@end

@interface PublishFooterView : UIView

@property (nonatomic, weak) id<PublishFooterViewDelegate>delegate;

@end

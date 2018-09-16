//
//  ShequFrameModel.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/15.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "ShequFrameModel.h"

#define kWidthForBackView (SCREEN_WIDTH - AutoSize6(30) - AutoSize6(95))

@implementation ShequFrameModel


- (void)setShequModel:(ShequModel *)shequModel {
    _shequModel = shequModel;
    

    CGFloat height = 0;
    self.headViewFrame = CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(65));
    height = CGRectGetMaxY(self.headViewFrame);
    
    
    CGFloat backViewHeight = 0;
    if (shequModel.subject.length) {
        
        CGFloat titleHeight = [shequModel.subject getTextHeightWithFont:kFontDiscoverTitle withWidth:(kWidthForBackView - AutoSize6(40))];
        titleHeight += AutoSize6(20);
        self.titleLabelFrame = CGRectMake(AutoSize6(20), AutoSize6(25), kWidthForBackView - AutoSize6(40), titleHeight);
        backViewHeight = CGRectGetMaxY(self.titleLabelFrame);
    }
    
    if (shequModel.imgUrl.length) {
        
        if (shequModel.imgWidth < 1) {
            return ;
        }

        CGFloat imageHeight = (shequModel.imgHeight) * (AutoSize6(585) / shequModel.imgWidth);
        self.contentImageViewFrame  = CGRectMake(AutoSize6(20), backViewHeight + AutoSize6(20), AutoSize6(585), imageHeight);
        backViewHeight = CGRectGetMaxY(self.contentImageViewFrame);
    } else {
        self.lineViewFrame = CGRectMake(AutoSize6(20), backViewHeight + AutoSize6(10), kWidthForBackView - AutoSize6(40), 1);
        backViewHeight = CGRectGetMaxY(self.lineViewFrame);
    }
    
    if (backViewHeight == 0) {
        self.height = 0;
        return;
    }
    
    self.bottomViewFrame = CGRectMake(0, backViewHeight + AutoSize6(5), AutoSize6(400), AutoSize6(80));
    self.timeLabelFrame = CGRectMake(kWidthForBackView - AutoSize6(20) - AutoSize6(200), self.bottomViewFrame.origin.y, AutoSize6(200), self.bottomViewFrame.size.height);
    backViewHeight = CGRectGetMaxY(self.bottomViewFrame);
    
    self.backViewFrame = CGRectMake(AutoSize6(95), height + AutoSize6(10), kWidthForBackView, backViewHeight);
    self.height = CGRectGetMaxY(self.backViewFrame) + AutoSize6(30);

    self.leftlineViewFrame = CGRectMake(AutoSize6(62.5), AutoSize6(65), 1, self.height - AutoSize6(65));

}

@end

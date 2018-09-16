//
//  MineLogFrameModel.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/26.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MineLogFrameModel.h"

#define kWidthForBackView (SCREEN_WIDTH - AutoSize6(30) - AutoSize6(95))


@implementation MineLogFrameModel
- (void)setShequModel:(ShequModel *)shequModel {
    _shequModel = shequModel;
    
    CGFloat height = 0;
    
    CGFloat backViewHeight = 0;
    if (shequModel.subject.length) {
        
        CGFloat titleHeight = [shequModel.subject getTextHeightWithFont:kFontDiscoverTitle withWidth:(kWidthForBackView - AutoSize6(40))];
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
    }
    
    if (shequModel.summary.length) {
        self.subjectLabelFrame  = CGRectMake(AutoSize6(20), backViewHeight, AutoSize6(585), AutoSize6(78));
        self.moreButtonFrame = CGRectMake(kWidthForBackView - AutoSize6(100), backViewHeight, AutoSize6(80), AutoSize6(78));
        
        backViewHeight = CGRectGetMaxY(self.subjectLabelFrame);
    }
    
    
//    self.timeLabelFrame = CGRectMake(kWidthForBackView - AutoSize6(20) - AutoSize6(200), self.bottomViewFrame.origin.y, AutoSize6(200), self.backViewFrame.size.height);
//    backViewHeight = CGRectGetMaxY(self.bottomViewFrame);
    
    self.backViewFrame = CGRectMake(AutoSize6(95), height + AutoSize6(30), kWidthForBackView, backViewHeight);
    self.height = CGRectGetMaxY(self.backViewFrame);
    
    self.lineViewFrame = CGRectMake(AutoSize6(69), 0, AutoSize6(10), self.height);

//    if (!self.isFirst) {
//        self.lineViewFrame = CGRectMake(AutoSize6(69), self.backViewFrame.origin.y, AutoSize6(10), self.height - self.backViewFrame.origin.y);
//    } else {
//        self.lineViewFrame = CGRectMake(AutoSize6(69), 0, AutoSize6(10), self.height);
//    }
    
    self.dayLabelFrame = CGRectMake(AutoSize6(20), AutoSize6(15), AutoSize6(40), AutoSize6(20));
    self.monthLabelFrame = CGRectMake(self.dayLabelFrame.origin.x, CGRectGetMaxY(self.dayLabelFrame), self.dayLabelFrame.size.width, self.dayLabelFrame.size.height);
}




- (void)setLogModel:(BirdDetailLogModel *)logModel {
    _logModel = logModel;
    
    CGFloat height = 0;
    
    CGFloat backViewHeight = 0;

    
    if (logModel.imgUrl.length) {
        if (logModel.imgWidth < 1) {
            return ;
        }

        
        self.titleLabelFrame = CGRectMake(AutoSize6(20), AutoSize6(25), kWidthForBackView - AutoSize6(40), AutoSize6(40));
        backViewHeight = CGRectGetMaxY(self.titleLabelFrame);

        CGFloat imageHeight = (logModel.imgHeight) * (AutoSize6(585) / logModel.imgWidth);
        self.contentImageViewFrame  = CGRectMake(AutoSize6(20), backViewHeight + AutoSize6(20), AutoSize6(585), imageHeight);
        backViewHeight = CGRectGetMaxY(self.contentImageViewFrame);

    } else if (logModel.title.length) {
        
        CGFloat titleHeight = [logModel.title getTextHeightWithFont:kFontDiscoverTitle withWidth:(kWidthForBackView - AutoSize6(40))];
        self.titleLabelFrame = CGRectMake(AutoSize6(20), AutoSize6(25), kWidthForBackView - AutoSize6(40), titleHeight);
        backViewHeight = CGRectGetMaxY(self.titleLabelFrame);
    }
    
    if (logModel.authorName.length) {
        self.subjectLabelFrame  = CGRectMake(AutoSize6(20), backViewHeight, AutoSize6(585), AutoSize6(78));
        
        self.countLabelFrame = CGRectMake(kWidthForBackView - AutoSize6(100), backViewHeight, AutoSize6(80), AutoSize6(78));
        
        backViewHeight = CGRectGetMaxY(self.countLabelFrame);
    } else {
        self.countLabelFrame = CGRectMake(kWidthForBackView - AutoSize6(100), backViewHeight, AutoSize6(80), AutoSize6(78));
        
        backViewHeight = CGRectGetMaxY(self.countLabelFrame);
    }
    
    
    //    self.timeLabelFrame = CGRectMake(kWidthForBackView - AutoSize6(20) - AutoSize6(200), self.bottomViewFrame.origin.y, AutoSize6(200), self.backViewFrame.size.height);
    //    backViewHeight = CGRectGetMaxY(self.bottomViewFrame);
    
    self.backViewFrame = CGRectMake(AutoSize6(95), height + AutoSize6(30), kWidthForBackView, backViewHeight);
    self.height = CGRectGetMaxY(self.backViewFrame);
    
    if (self.isFirst) {
        self.lineViewFrame = CGRectMake(AutoSize6(69), self.backViewFrame.origin.y, AutoSize6(10), self.height - self.backViewFrame.origin.y);
    } else {
        self.lineViewFrame = CGRectMake(AutoSize6(69), 0, AutoSize6(10), self.height);
    }
    
    self.dayLabelFrame = CGRectMake(AutoSize6(20), AutoSize6(15), AutoSize6(40), AutoSize6(20));
    
    self.monthLabelFrame = CGRectMake(self.dayLabelFrame.origin.x, CGRectGetMaxY(self.dayLabelFrame), self.dayLabelFrame.size.width, self.dayLabelFrame.size.height);

}
@end

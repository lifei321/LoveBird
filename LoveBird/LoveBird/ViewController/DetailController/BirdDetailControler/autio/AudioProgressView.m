//
//  AudioProgressView.m
//  LoveBird
//
//  Created by cheli shan on 2018/8/5.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AudioProgressView.h"

@interface AudioProgressView ()

@property (nonatomic, strong) UIView *totalView;

@property (nonatomic, strong) UIView *progressView;

@end

@implementation AudioProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.totalView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height / 2 - 2, frame.size.width, 4)];
        self.totalView.backgroundColor = kColorDefaultBackgroudColorE5E5E5;
        [self addSubview:self.totalView];
        
        self.progressView = [[UIView alloc] initWithFrame:CGRectMake(0, self.totalView.top, 0, self.totalView.height)];
        self.progressView.backgroundColor = kColorDefaultColor;
        [self addSubview:self.progressView];
    }
    return self;
}

- (void)setProgressValue:(CGFloat)progressValue {
    _progressValue = progressValue;
    
    self.progressView.width = self.totalView.width * progressValue / 100;
}

@end

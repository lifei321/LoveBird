//
//  MineLogLineView.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/26.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MineLogLineView.h"

@interface MineLogLineView()

@property (nonatomic, strong) UIView *topview;

@property (nonatomic, strong) UIView *lineview;

@property (nonatomic, strong) UIView *toplineview;


@end

@implementation MineLogLineView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.toplineview = [[UIView alloc] init];
        self.toplineview.backgroundColor = kLineColoreDefaultd4d7dd;
        [self addSubview:self.toplineview];
        
        self.topview = [[UIView alloc] init];
        self.topview.backgroundColor = kLineColoreDefaultd4d7dd;
        [self addSubview:self.topview];
        
        self.lineview = [[UIView alloc] init];
        self.lineview.backgroundColor = kLineColoreDefaultd4d7dd;
        [self addSubview:self.lineview];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.isFirst) {
        self.toplineview.frame = CGRectZero;
        self.topview.frame = CGRectMake(0, 0, AutoSize6(10), AutoSize6(10));
        self.lineview.frame = CGRectMake(self.width / 2 - 0.5, AutoSize6(11), 1, self.height - AutoSize6(12));
        
    } else {
        self.toplineview.frame = CGRectMake(self.width / 2 - 0.5, 0, 1, AutoSize6(30));
        self.topview.frame = CGRectMake(0, AutoSize6(30), AutoSize6(10), AutoSize6(10));
        
        self.lineview.frame = CGRectMake(self.width / 2 - 0.5, self.topview.bottom + 1, 1, self.height - AutoSize6(12) - AutoSize6(30));
    }
    
    self.topview.layer.cornerRadius = self.topview.width / 2;

}

@end
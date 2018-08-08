//
//  WorksImageView.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/27.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "WorksImageView.h"

@interface WorksImageView()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView *backLabel;

@end

@implementation WorksImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = kFont6(20);
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.layer.masksToBounds = YES;
        self.nameLabel.backgroundColor = [UIColor clearColor];
        
        self.backLabel = [[UIView alloc] init];
        self.backLabel.layer.masksToBounds = YES;
        self.backLabel.alpha = 0.4;
        self.backLabel.backgroundColor = [UIColor blackColor];

        [self addSubview:self.backLabel];
        [self addSubview:self.nameLabel];

    }
    return self;
}

- (void)setName:(NSString *)name {
    _name = [name copy];
    
    if (name.length) {
        self.nameLabel.text = name;

        self.nameLabel.frame = CGRectMake(AutoSize6(10), self.height - AutoSize6(48), 0, AutoSize6(36));
        CGFloat width = [name getTextWightWithFont:self.nameLabel.font];
        self.nameLabel.width = width + AutoSize6(40);
        self.nameLabel.layer.cornerRadius = self.nameLabel.height / 2;

    } else {
        self.nameLabel.frame = CGRectZero;
    }
    
    self.backLabel.frame = self.nameLabel.frame;
    self.backLabel.layer.cornerRadius = self.backLabel.height / 2;

}

@end

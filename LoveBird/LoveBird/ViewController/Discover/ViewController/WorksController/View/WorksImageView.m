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

@end

@implementation WorksImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = kFont6(20);
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.backgroundColor = [UIColor blackColor];
        self.nameLabel.alpha = 0.8;
        self.nameLabel.layer.masksToBounds = YES;
        [self addSubview:self.nameLabel];
        
    }
    return self;
}

- (void)setName:(NSString *)name {
    _name = [name copy];
    self.nameLabel.text = name;
    
    self.nameLabel.frame = CGRectMake(AutoSize6(10), self.height - AutoSize6(48), 0, AutoSize6(36));
    CGFloat width = [name getTextWightWithFont:self.nameLabel.font];
    self.nameLabel.width = width + AutoSize6(40);
    self.nameLabel.layer.cornerRadius = self.nameLabel.height / 2;
}

@end

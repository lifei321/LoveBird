//
//  PublishCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/7.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "PublishCell.h"

@interface PublishCell ()

@property (nonatomic, strong) UILabel *titleLabe;

@end

@implementation PublishCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.titleLabe = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(30), 0, AutoSize6(150), AutoSize6(112))];
        self.titleLabe.textColor = [UIColor blackColor];
        self.titleLabe.textAlignment = NSTextAlignmentLeft;
        self.titleLabe.font = kFont6(30);
        [self.contentView addSubview:self.titleLabe];

        
    }
    return self;
}

@end

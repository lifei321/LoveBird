//
//  RegInfoTableViewCell.m
//  LoveBird
//
//  Created by ShanCheli on 2017/7/12.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "RegInfoTableViewCell.h"

@implementation RegInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


@end

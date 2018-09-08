//
//  ShequZuzhiCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/19.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "ShequZuzhiCell.h"
#import "ShequZuzhiModel.h"


@interface ShequZuzhiCell();
@property (nonatomic, strong) AppTagsView *tagsView;
@end

@implementation ShequZuzhiCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        self.tagsView = [[AppTagsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        [self.contentView addSubview:self.tagsView];
        
        @weakify(self);
        self.tagsView.tagblock = ^(NSInteger selectIndex) {
            @strongify(self);
            if (self.tagBlock) {
                self.tagBlock(selectIndex);
            }
        };
    }
    return self;
}

- (void)setIsShow:(BOOL)isShow {
    if (isShow) {
        self.tagsView.selectIndex = -1;
    } else {
        self.tagsView.selectIndex = -1;
    }
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = [dataArray copy];
    
    NSMutableArray *array = [NSMutableArray new];
    
    for (ShequZuzhiModel *model in dataArray) {
        [array addObject:model.name];
    }
    
    
    self.tagsView.tagArray = array;
    

    self.tagsView.height = [AppTagsView getHeight:array width:SCREEN_WIDTH];
}
@end

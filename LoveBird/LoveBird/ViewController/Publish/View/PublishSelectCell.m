//
//  PublishSelectCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/6.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "PublishSelectCell.h"
#import "PublishSelectView.h"

@interface PublishSelectCell()

@property (nonatomic, strong) UILabel *titleLabe;

@property (nonatomic, strong) UIButton *lessButton;

@property (nonatomic, strong) PublishSelectView *selectView;


@end

@implementation PublishSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.titleLabe = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(30), 0, AutoSize6(150), AutoSize6(112))];
        self.titleLabe.textColor = [UIColor blackColor];
        self.titleLabe.textAlignment = NSTextAlignmentLeft;
        self.titleLabe.font = kFont6(30);
        [self.contentView addSubview:self.titleLabe];
        
        
        _selectView = [[PublishSelectView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(310), AutoSize6(30), AutoSize6(220), AutoSize6(112))];
        [self.contentView addSubview:_selectView];
        
        self.lessButton = [[UIButton alloc] initWithFrame:CGRectMake(_selectView.right, AutoSize6(30), AutoSize6(52), AutoSize6(52))];
        [self.lessButton addTarget:self action:@selector(lessButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.lessButton setImage:[UIImage imageNamed:@"pub_less_no"] forState:UIControlStateNormal];
        [self.lessButton setImage:[UIImage imageNamed:@"pub_less_yes"] forState:UIControlStateSelected];
        [self.contentView addSubview:self.lessButton];
        
        @weakify(self);
        _selectView.lessblock = ^{
            @strongify(self);
            if (self.delegate && [self.delegate respondsToSelector:@selector(publishSelectCellLessDelegate:)]) {
                [self.delegate publishSelectCellLessDelegate:self];
            }
        };
        
        _selectView.addblock = ^{
            @strongify(self);
            if (self.delegate && [self.delegate respondsToSelector:@selector(publishSelectCellAddDelegate:)]) {
                [self.delegate publishSelectCellAddDelegate:self];
            }
        };
    }
    return self;
}

- (void)setSelectModel:(PublishSelectModel *)selectModel {
    _selectModel = selectModel;
    self.accessoryType = UITableViewCellStyleDefault;
    _selectView.isSelect = selectModel.isSelect;
    _selectView.countLable.text = [NSString stringWithFormat:@"%ld", selectModel.count];

    if (selectModel.isSelect) {
        self.titleLabe.textColor = kColorTextColorLightGraya2a2a2;
        self.lessButton.selected = YES;
    } else {
        self.lessButton.selected = NO;
    }
    self.titleLabe.text = selectModel.title;
}


- (void)lessButtonClick:(UIButton *)button {
    if (button.selected) {
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(publishSelectCellDeleteDelegate:)]) {
        [self.delegate publishSelectCellDeleteDelegate:self];
    }
}

@end

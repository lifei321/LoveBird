//
//  AppTagsView.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/13.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppTagsView.h"

@interface AppTagsView()

@property (nonatomic, strong) UIButton *selectButton;

@end

@implementation AppTagsView


/**
 *  初始化
 *
 *  @param frame    frame
 *
 */
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

// 初始化
- (void)setUp{
    
    // 默认颜色
    self.textColorSelected = [UIColor whiteColor];
    self.textColorNormal = kColorTextColorLightGraya2a2a2;
    self.backgroundColorSelected = kColorTarBarTitleHighlightColor;
    self.backgroundColorNormal = kLineColoreLightGrayECECEC;
    self.backgroundColor = [UIColor whiteColor];
}

// 重写set属性
- (void)setTagArray:(NSMutableArray *)tagArray{
    
    _tagArray = tagArray;
    
    // 重新创建标签
    [self resetTagButton];
}

- (void)setTextColorSelected:(UIColor *)textColorSelected{
    
    _textColorSelected = textColorSelected;
    // 重新创建标签
    [self resetTagButton];
}

- (void)setTextColorNormal:(UIColor *)textColorNormal{
    
    _textColorNormal = textColorNormal;
    // 重新创建标签
    [self resetTagButton];
}

- (void)setBackgroundColorSelected:(UIColor *)backgroundColorSelected{
    
    _backgroundColorSelected = backgroundColorSelected;
    // 重新创建标签
    [self resetTagButton];
}

- (void)setBackgroundColorNormal:(UIColor *)backgroundColorNormal{
    
    _backgroundColorNormal = backgroundColorNormal;
    // 重新创建标签
    [self resetTagButton];
}

#pragma mark - Private

// 重新创建标签
- (void)resetTagButton{
    
    // 移除之前的标签
    for (UIButton* btn  in self.subviews) {
        [btn removeFromSuperview];
    }
    // 重新创建标签
    [self createTagButton];
}

// 创建标签按钮
- (void)createTagButton{
    
    // 按钮高度
    CGFloat btnH = AutoSize6(54);
    // 距离左边距
    CGFloat leftX = AutoSize6(30);
    // 距离上边距
    CGFloat topY = AutoSize6(40);
    // 按钮左右间隙
    CGFloat marginX = AutoSize6(20);
    // 按钮上下间隙
    CGFloat marginY = AutoSize6(20);
    // 文字左右间隙
    CGFloat fontMargin = AutoSize6(20);
    
    for (int i = 0; i < _tagArray.count; i++) {
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(leftX, topY, 100, btnH);
        btn.tag = 100+i;
        
        PublishEVModel *evModel = _tagArray[i];

        // 默认选中第一个
        if (self.selectModel) {
            if ([self.selectModel.evId isEqualToString:evModel.evId]) {
                btn.selected = YES;
                self.selectButton = btn;
            }
        }
        
        // 按钮文字
        [btn setTitle:evModel.name forState:UIControlStateNormal];
        btn.titleLabel.font = kFont6(26);
        [btn setTitleColor:self.textColorNormal forState:UIControlStateNormal];
        [btn setTitleColor:self.textColorSelected forState:UIControlStateSelected];
        [btn setBackgroundImage:[self imageWithColor:self.backgroundColorNormal] forState:UIControlStateNormal];
        [btn setBackgroundImage:[self imageWithColor:self.backgroundColorSelected] forState:UIControlStateSelected];
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        
        [btn sizeToFit];
        CGRect frame = btn.frame;
        frame.size.width += fontMargin * 2;
        frame.size.height = btnH;
        btn.frame = frame;
        
        // 处理换行
        if (btn.left + btn.width + marginX > self.width) {
            
            leftX = AutoSize6(30);
            
            // 换行
            topY += btnH + marginY;
            btn.left = leftX;
            btn.top = topY;
        }
        
        [btn addTarget:self action:@selector(selectdButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        leftX += btn.width + marginX;
    }
}


// 根据颜色生成UIImage
- (UIImage*)imageWithColor:(UIColor*)color{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开始画图的上下文
    UIGraphicsBeginImageContext(rect.size);
    
    // 设置背景颜色
    [color set];
    // 设置填充区域
    UIRectFill(CGRectMake(0, 0, rect.size.width, rect.size.height));
    
    // 返回UIImage
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - Event

// 标签按钮点击事件
- (void)selectdButton:(UIButton*)btn{
    
    if (self.selectButton.tag == btn.tag) {
        self.selectButton.selected = NO;
        self.selectButton = nil;
        self.selectModel = nil;
    } else {
        self.selectButton.selected = NO;
        self.selectButton = btn;
        self.selectButton.selected = YES;
        PublishEVModel *model = _tagArray[btn.tag - 100];
        self.selectModel = model;
        
        if (self.tagblock) {
            self.tagblock(model);
        }
    }
}


@end

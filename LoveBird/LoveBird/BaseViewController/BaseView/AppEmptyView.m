//
//  AppEmptyView.m
//  LoveBird
//
//  Created by ShanCheli on 2017/6/21.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppEmptyView.h"
#import "TTTAttributedLabel.h"
#import "AppButton.h"

@interface AppEmptyView ()

/**
 *  重新刷新
 */
@property (copy, nonatomic) dispatch_block_t retryBlock;

@end

@implementation AppEmptyView

+ (AppEmptyView *)createEmptyViewWithText:(NSString *)text
                                     image:(UIImage *)img
                                 retryText:(NSString *)retryTitle
                                retryBlock:(dispatch_block_t)retryBlock {
    return [[self alloc] initWithText:text attributedText:nil image:img retryText:retryTitle retryBlock:retryBlock target:nil action:nil];
}


+ (AppEmptyView *)createEmptyViewWithText:(NSString *)text
                            attributedText:(NSString *)attributedText
                                     image:(UIImage *)img
                                    target:(id)target
                                    action:(SEL)action {
    return [[self alloc] initWithText:text attributedText:attributedText image:img retryText:nil retryBlock:nil target:target action:action];
}

+ (AppEmptyView *)createEmptyViewWithText:(NSString *)text
                                 textColor:(UIColor *)textColor
                                     image:(UIImage *)img
                                     space:(CGFloat)space
                                 retryText:(NSString *)retryTitle
                                retryBlock:(dispatch_block_t)retryBlock {
    return [[self alloc] initWithText:text textColor:textColor attributedText:nil image:img space:space retryText:retryTitle retryBlock:retryBlock target:nil action:nil];
}

- (instancetype)initWithText:(NSString *)text
              attributedText:(NSString *)attributedText
                       image:(UIImage *)img
                   retryText:(NSString *)retryTitle
                  retryBlock:(dispatch_block_t)retryBlock
                      target:(id)target
                      action:(SEL)action {
    return [self initWithText:text textColor:kColorTextColorAFAFAF attributedText:attributedText image:img space:AutoSize(10) retryText:retryTitle retryBlock:retryBlock target:target action:action];
}


- (instancetype)initWithText:(NSString *)text
                   textColor:(UIColor *)textColor
              attributedText:(NSString *)attributedText
                       image:(UIImage *)img
                       space:(CGFloat)space
                   retryText:(NSString *)retryTitle
                  retryBlock:(dispatch_block_t)retryBlock
                      target:(id)target
                      action:(SEL)action {
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)]) {
        CGFloat viewHeight = 0;
        NSMutableArray *subViewArray = [NSMutableArray new];
        
        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, space)];
        spaceView.backgroundColor = [UIColor clearColor];
        
        if (img) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
            imageView.image = img;
            
            if (subViewArray.count > 0) {
                [subViewArray addObject:spaceView];
            }
            
            [subViewArray addObject:imageView];
            viewHeight += imageView.height;
        }
        
        if (text.length > 0) {
            
            TTTAttributedLabel *detailLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(AutoSize(15), 0, SCREEN_WIDTH - AutoSize(30), AutoSize(30))];
            detailLabel.font = kFont(14);
            detailLabel.textColor = textColor;
            detailLabel.adjustsFontSizeToFitWidth = NO;
            detailLabel.numberOfLines = 0;
            detailLabel.textAlignment = NSTextAlignmentCenter;
            detailLabel.delegate = target;
            
            //不显示下划线
            detailLabel.linkAttributes = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:(NSString *)kCTUnderlineStyleAttributeName];
            
            if (attributedText.length > 0) {
                
                //设置可点击的字体颜色 和大小
                [detailLabel setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
                    
                    NSRange range = [[mutableAttributedString string] rangeOfString:attributedText  options:NSCaseInsensitiveSearch];
                    
                    [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:kColorTextColorOrangeED7338 range:range];
                    
                    return mutableAttributedString;
                }];
                
                //显示超级链接
                NSRange range = [text rangeOfString:attributedText];
                [detailLabel addLinkToURL:nil withRange:range];
                
            } else {
                detailLabel.text = text;
                [detailLabel sizeToFit];
            }
            
            if (subViewArray.count > 0) {
                [subViewArray addObject:spaceView];
            }
            
            [subViewArray addObject:detailLabel];
            viewHeight += detailLabel.height;
        }
        
        if (retryBlock) {
            self.retryBlock = [retryBlock copy];
            UIButton *actionBt = [[AppButton alloc] initWithFrame:CGRectMake(0, AutoSize(10), AutoSize(300), AutoSize(39)) style:AppButtonStyleGray];
            [actionBt setTitle:retryTitle forState:UIControlStateNormal];
            [actionBt addTarget:self action:@selector(refreshButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            if (subViewArray.count > 0) {
                [subViewArray addObject:spaceView];
            }
            
            [subViewArray addObject:actionBt];
            viewHeight += actionBt.height;
        }
        
        CGFloat lastViewBottom = 0;
        
        for (UIView *subview in subViewArray) {
            subview.top = lastViewBottom;
            subview.center = CGPointMake(self.width / 2, subview.center.y);
            [self addSubview:subview];
            
            lastViewBottom += subview.height;
        }
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, lastViewBottom);
        
        //暂时没用到viewHeight（去除warning）
        NSLog(@"viewHeight:%f",viewHeight);
    }
    
    return self;
}

- (void)refreshButtonPressed:(id)sender {
    if (self.retryBlock) {
        self.retryBlock();
    }
}

@end

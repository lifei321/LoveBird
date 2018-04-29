//
//  AppPlaceHolderTextView.m
//  LoveBird
//
//  Created by ShanCheli on 2017/7/7.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppPlaceHolderTextView.h"


@interface AppPlaceHolderTextView ()

@property (assign, nonatomic) BOOL shouldDrawPlaceholder;

@end

@implementation AppPlaceHolderTextView

#pragma mark - Life Cycle

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        
        [self configView];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (self.backgroundImage) {
        [self.backgroundImage drawInRect:self.bounds];
    }
    
    if (self.shouldDrawPlaceholder) {
        [self.placeholderColor set];
        [self.placeholder drawInRect:CGRectMake(8.0f, 8.0f, self.frame.size.width - 16.0f, 16.0f) withAttributes:@{ NSFontAttributeName:self.font, NSForegroundColorAttributeName:self.placeholderColor }];
    }
}

#pragma mark - Public API

- (void)setText:(NSString *)string {
    [super setText:string];
    [self updatePlaceholder];
}

- (void)setPlaceholder:(NSString *)string {
    _placeholder = string;
    [self updatePlaceholder];
}

#pragma mark - Private

- (void)configView {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:self];
    
    self.placeholderColor = [UIColor lightGrayColor];
    self.shouldDrawPlaceholder = NO;
    
    self.backgroundColor = [UIColor whiteColor];
    self.contentInset = UIEdgeInsetsMake(0, 0, AutoSize(10), 0);
    self.bounces = NO;
    self.font = [UIFont systemFontOfSize:AutoSize(12)];
    self.placeholder = @"请写下您的宝贵意见和建议";
    
    
    self.wordCoutLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width - AutoSize(70), self.height - AutoSize(30), AutoSize(60), AutoSize(20))];
    self.wordCoutLabel.textColor = [UIColor blueColor];
    self.wordCoutLabel.font = kFont(12);
    self.wordCoutLabel.textAlignment = NSTextAlignmentCenter;
    self.wordCoutLabel.text = [NSString stringWithFormat:@"0/%ld", self.limitCount];
    [self addSubview:self.wordCoutLabel];
    
    _wordMoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize(10), self.bottom, self.width, AutoSize(15))];
    _wordMoreLabel.font = kFont(10);
    _wordMoreLabel.textColor = [UIColor redColor];
    _wordMoreLabel.textAlignment = NSTextAlignmentLeft;
    _wordMoreLabel.text = @"您输入的字数已经超出范围";
    self.wordMoreLabel.hidden = YES;
    [self addSubview:_wordMoreLabel];

}

- (void)updatePlaceholder {
    BOOL prev = self.shouldDrawPlaceholder;
    
    self.shouldDrawPlaceholder = self.placeholder && self.placeholderColor && self.text.length == 0;
    
    if (prev != self.shouldDrawPlaceholder) {
        [self setNeedsDisplay];
    }
}

#pragma mark - NSNotification
- (void)textChanged:(NSNotification *)notificaiton {
    [self updatePlaceholder];
    
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.backgroundColor = [UIColor whiteColor];
    self.wordMoreLabel.hidden = YES;
    
    if (self.text.length > self.limitCount) {
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.backgroundColor = [UIColor yellowColor];
        self.wordMoreLabel.hidden = NO;
    }
    
    self.wordCoutLabel.text = [NSString stringWithFormat:@"%ld/%ld",(unsigned long)self.text.length, self.limitCount];

}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}
@end

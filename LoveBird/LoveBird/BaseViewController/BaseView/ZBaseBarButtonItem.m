//
//  BaseBarButtonItem.m
//  Pods
//
//  Created by zhuayi on 8/21/15.
//
//

#import "ZBaseBarButtonItem.h"

@implementation ZBaseBarButtonItem


- (void)setSelected:(BOOL)selected {
    _selected = selected;
}

- (UIButton *)button {
    if (_button == nil) {
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button addTarget:self.target action:self.action forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)setImage:(UIImage *)image {
    
    CGRect frame = self.button.frame;
    frame.size = image.size;
    self.button.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width + AutoSize6(20), frame.size.height + AutoSize6(20));
    [self.button setImage:image forState:UIControlStateNormal];
    self.customView = self.button;
}
@end

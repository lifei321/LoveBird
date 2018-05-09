//
//  ApplyTimePickerDetailView.h
//
//  Created by ShanCheli on 2017/9/18.
//

#import <UIKit/UIKit.h>

@class ApplyTimePickerView;
typedef void(^PickerViewDidSelectHandler)(ApplyTimePickerView *timePickerView, NSString *date);

@interface ApplyTimePickerView : UIView

@property (nonatomic, copy) PickerViewDidSelectHandler handler;

@end

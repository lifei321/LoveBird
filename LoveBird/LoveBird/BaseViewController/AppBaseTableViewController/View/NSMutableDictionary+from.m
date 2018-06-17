//
//  NSMutableDictionary+from.m
//  cardloan
//
//  Created by zhuayi on 16/5/19.
//  Copyright © 2016年 renxin. All rights reserved.
//

#import "NSMutableDictionary+from.h"
#import "AppTextField.h"

@implementation NSMutableDictionary (from)


- (NSString *)getTextFieldValueForKey:(NSString *)key {
    
    if (![self objectForKey:key]) {
        
        return nil;
    }
    
    if ([self[key] isKindOfClass:[AppTextField class]]) {
        
        return ((AppTextField *)self[key]).text;
    }
    
    return self[key];
}
@end

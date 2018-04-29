//
//  NSMutableDictionary+from.m
//  cardloan
//
//  Created by zhuayi on 16/5/19.
//  Copyright © 2016年 renxin. All rights reserved.
//

#import "NSMutableDictionary+from.h"
#import "AppBaseTextField.h"

@implementation NSMutableDictionary (from)


- (NSString *)getTextFieldValueForKey:(NSString *)key {
    
    if (![self objectForKey:key]) {
        
        return nil;
    }
    
    if ([self[key] isKindOfClass:[AppBaseTextField class]]) {
        
        return ((AppBaseTextField *)self[key]).text;
    }
    
    return self[key];
}
@end

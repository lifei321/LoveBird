//
//  AppBaseModel.m
//  LoveBird
//
//  Created by ShanCheli on 2017/7/3.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@implementation AppBaseModel

- (instancetype)initWithCode:(NSInteger)errcode errstr:(NSString *)errstr {
    self = [super init];
    if (self) {
        
        self.errcode = errcode;
        self.errstr = errstr;
    }
    return self;
}

+ (BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}

- (NSError *)error {
    self.errstr = self.errstr ? : @"";
    NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:self.errcode userInfo:@{NSLocalizedDescriptionKey : self.errstr}];
    return error;
}

+(JSONKeyMapper*)keyMapper {
    
    NSDictionary *dict = @{
                           @"msg": @"errcode",
                           @"code": @"errstr"
                           };
    
    return [[JSONKeyMapper alloc] initWithDictionary:dict];
}

@end

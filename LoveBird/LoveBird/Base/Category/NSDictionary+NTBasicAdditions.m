//
//  NSDictionary+NTBasicAdditions.m
//  BasicLibrary
//
//  Created by LiuLiming on 14-2-19.
//  Copyright (c) 2014年 netease. All rights reserved.
//

#import "NSDictionary+NTBasicAdditions.h"

@implementation NSDictionary (NTBasicAdditions)

- (NSString *)stringForKey:(NSString *)key {
    NSObject *object = [self objectForKey:key];

    if (object == nil || object == [NSNull null]) {
        return @"";
    }

    if ([object isKindOfClass:[NSString class]]) {
        return (NSString *)object;
    }

    return [NSString stringWithFormat:@"%@", object];
}

- (id)validObjectForKey:(NSString *)key {
    NSObject *object = [self objectForKey:key];

    if (object == [NSNull null]) {
        return nil;
    }

    return object;
}

- (NSArray *)arrayForKey:(NSString *)key {
    NSObject *object = [self objectForKey:key];

    if ([object isKindOfClass:[NSArray class]]) {
        return (NSArray *)object;
    } else if ([object isKindOfClass:[NSDictionary class]]) {
        return [(NSDictionary *)object allValues];
    }

    return nil;
}

- (NSDate *)dateForKey:(NSString *)key {
    NSString *object = [self objectForKey:key];

    if ([object isKindOfClass:[NSString class]]) {
        static NSDateFormatter *formater = nil;

        if (!formater) {
            formater = [[NSDateFormatter alloc] init];
            [formater setLocale:[NSLocale currentLocale]];
        }

        if (object.length == @"yyyy-MM-dd HH:mm".length) {
            [formater setDateFormat:@"yyyy-MM-dd HH:mm"];
        } else if (object.length == @"yyyy-MM-dd HH:mm:ss".length) {
            [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        }

        return [formater dateFromString:object];
    }

    if ([object isKindOfClass:[NSNumber class]]) {
        return [NSDate dateWithTimeIntervalSince1970:[object integerValue]];
    }

    return nil;
}

@end

@implementation NSMutableDictionary (NTBasicAdditions)

- (void)setValidObject:(id)anObject forKey:(id)aKey {
    if (anObject) {
        [self setObject:anObject forKey:aKey];
    }
}

- (void)setInteger:(NSInteger)value forKey:(id)key {
    [self setValue:[NSNumber numberWithInteger:value]
            forKey:key];
}

- (void)setDouble:(double)value forKey:(id)key {
    [self setValue:[NSNumber numberWithDouble:value] forKey:key];
}

/**
 *  按 key 升序排列字典
 *
 *  @return 返回排序后数组key
 */
- (NSArray *)sortDictWithAscendingKey {
    
    NSMutableArray *numArray = [NSMutableArray arrayWithArray:self.allKeys];
    [numArray sortUsingComparator: ^NSComparisonResult (NSString *str1, NSString *str2) {
        return [str1 compare:str2];
    }];
    NSMutableDictionary *newDict = [NSMutableDictionary new];
    for (NSString *key in numArray) {
        [newDict setObject:self[key] forKey:key];
    }
    [self removeAllObjects];
    for (NSString *key in numArray) {
        [self setObject:newDict[key] forKey:key];
    }
    return numArray;
}

/**
 *  序列化成oauth格式的签名串
 */
- (void)serializeDictToOauth1:(NSString *)signKey appendDict:(NSDictionary *)appendDict {
    
    if (appendDict) {
        [self addEntriesFromDictionary:appendDict];
    }
    NSArray *allKeys = [self sortDictWithAscendingKey];
    NSMutableArray *urlStrings = [NSMutableArray new];
    for (int i = 0; i < allKeys.count; i++) {
        NSString *key = allKeys[i];
        [urlStrings addObject:[NSString stringWithFormat:@"%@=%@", key, self[key]]];
    }
    NSString *strings = [urlStrings componentsJoinedByString:@"&"];
    NSString *sign = [NSString stringWithFormat:@"%@%@%@", signKey,strings, signKey];
    NSLog(@"sign is %@", sign);
    [self setObject:[sign md5HexDigest] forKey:@"appsign"];
//    strings = [NSString stringWithFormat:@"%@&sign=%@", strings, [sign md5HexDigest]];
}
@end

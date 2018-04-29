//
//  AppCache.m
//  LFBaseProject
//
//  Created by ShanCheli on 2018/1/30.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppCache.h"
#import <YYKit/YYCache.h>

static NSString * const AppCacheSharedName = @"AppCacheShared";

@implementation AppCache

+ (YYCache *)sharedCache
{
    static YYCache *cache;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        cache = [[YYCache alloc] initWithName:AppCacheSharedName];
    });
    
    return cache;
}


+ (void)setObject:(id<NSCoding>)object forKey:(NSString *)key expireTime:(NSInteger)expire {
    [[self sharedCache] setObject:object forKey:key];
}


+ (void)setObject:(id<NSCoding>)object forKey:(NSString *)key {
    [[self sharedCache] setObject:object forKey:key];
}

+ (id)objectForKey:(NSString *)key {
   return [[self sharedCache] objectForKey:key];
}


+ (void)removeObjectForKey:(NSString *)key {
    [[self sharedCache] removeObjectForKey:key];
}

+ (BOOL)containsObjectForKey:(NSString *)key {
    return [[self sharedCache] containsObjectForKey:key];
}

@end

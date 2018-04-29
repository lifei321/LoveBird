//
//  AppCache.h
//  LFBaseProject
//
//  Created by ShanCheli on 2018/1/30.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppCache : NSObject


/**
 *  设置缓存并且加上过期时间
 *
 *  @param object 缓存的对象
 *  @param key    对应的key
 *  @param expire 过期时间
 */
+ (void)setObject:(id<NSCoding>)object forKey:(NSString *)key expireTime:(NSInteger)expire;

/**
 *  设置缓存
 *
 *  @param object 缓存的对象
 *  @param key    对应的key
 */
+ (void)setObject:(id<NSCoding>)object forKey:(NSString *)key;

/**
 *  获取缓存
 *
 *  @param key 缓存对象对应的key
 *
 *  @return    缓存的对象
 */
+ (id)objectForKey:(NSString *)key;

/**
 *  删除缓存
 *
 *  @param key   缓存对象对应的key
 */
+ (void)removeObjectForKey:(NSString *)key;

/**
 判断是否缓存中`key`是否存在
 */
+ (BOOL)containsObjectForKey:(NSString *)key;

@end

//
//  NSDictionary+NTBasicAdditions.h
//  BasicLibrary
//
//  Created by LiuLiming on 14-2-19.
//  Copyright (c) 2014年 netease. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  NSDictionary NTBasicAdditions
 */
@interface NSDictionary (NTBasicAdditions)

/**
 *  @return 返回key对应值的字符串形式, 若值为nil或NSNull, 返回空字符串.
 */
- (NSString *)stringForKey:(NSString *)key;

/**
 *  @return 返回key的对应值, 若值为nil或NSNull, 返回nil.
 */
- (id)validObjectForKey:(NSString *)key;

/**
 *  @return 若key对应值是NSArray, 返回该array; 若key对应值是NSDictionary, 返回该dictionary中所有key的值组成的array, 若该dictionary值为空, 返回空array; 其余情况返回nil.
 */
- (NSArray *)arrayForKey:(NSString *)key;

/**
 *  @return 若key对应值为NString, 根据string长度返回形式为"yyyy-MM-dd HH:mm"或"yyyy-MM-dd HH:mm:ss"的NSDate, 若string无法解析则返回nil; 若key对应值为数字, 则返回以该数字为时间戳对应的NSDate; 其余情况返回nil.
 */
- (NSDate *)dateForKey:(NSString *)key;

@end

@interface NSMutableDictionary (NTBasicAdditions)

/**
 *  若anObject不是nil, 则将它设为aKey的对应值.
 */
- (void)setValidObject:(id)anObject forKey:(id)aKey;

- (void)setInteger:(NSInteger)value forKey:(id)key;

- (void)setDouble:(double)value forKey:(id)key;

/**
 *  按 key 升序排列字典
 *
 *  @return 返回排序后数组key
 */
- (NSArray *)sortDictWithAscendingKey;

/**
 *  序列化成oauth格式的签名串
 */
- (void)serializeDictToOauth1:(NSString *)signKey appendDict:(NSDictionary *)appendDict;
@end

//
//  AppCache.m
//  LFBaseProject
//
//  Created by ShanCheli on 2018/1/30.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppCache.h"
#import <YYKit/YYCache.h>
#import <SDWebImage/SDImageCache.h>

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
    
    if (!object) {
        [[self sharedCache] removeObjectForKey:key];
        return;
    }
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

/**
 *  计算单个文件大小
 */
+(long long)fileSizeAtPath:(NSString *)filePath{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath :filePath]){
        
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize];
    }
    return 0 ;
    
}

/**
 *  计算整个目录大小
 */
+ (float)folderSizeAtPath {
    NSString *folderPath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) {
        return 0 ;
    }
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    
    return folderSize/( 1024.0 * 1024.0 );
}



+ (void)clearCache:(NSString *)path {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}

+ (CGFloat)getSdCacheSize {
    CGFloat size = [[SDImageCache sharedImageCache] getSize];
    return size / 1024 / 1024;
}

+ (void)clearSdCacheCompletion:(AppCacheCompletionBlock)block {
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        if (block) {
            block();
        }
    }];
}

@end

//
//  AppApi.h
//  LoveBird
//
//  Created by ShanCheli on 2017/6/21.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#ifndef AppApi_h
#define AppApi_h


#define kAPI_USER_SERVER_VERSION(PATH) [NSString stringWithFormat:@"%@/%@", kAPI_USER_SERVER, PATH]

#define kAPI_CUSTOM_SERVER_VERSION(PATH, VERSION) [NSString stringWithFormat:@"%@/%@%@", kAPI_USER_SERVER, VERSION, PATH]




/**
 *  首页banner
 */
#define kAPI_Discover_Banner kAPI_USER_SERVER_VERSION(@"home/index.php")

/**
 *  首页数据
 */
#define kAPI_Discover_Content kAPI_USER_SERVER_VERSION(@"home/index.php?cmd=homeList")

/**
 *  收藏 评论 点赞
 */
#define kAPI_Discover_Collect kAPI_USER_SERVER_VERSION(@"article/index.php")

/**
 *  达人
 */
#define kAPI_Discover_Talent kAPI_USER_SERVER_VERSION(@"master/index.php")

/**
 *  查鸟首页
 */
#define kAPI_Find_Bird kAPI_USER_SERVER_VERSION(@"bird/index.php")

/**
 *  查鸟 类别
 */
#define kAPI_Find_Bird_family kAPI_USER_SERVER_VERSION(@"bird/index.php?cmd=searchFamily")




#endif /* AppApi_h */

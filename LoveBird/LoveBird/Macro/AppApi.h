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

#pragma mark-- 用户相关

/**
 *  添加关注
 */
#define kAPI_User_Follow kAPI_USER_SERVER_VERSION(@"user/index.php?cmd=follow")

/**
 *  关注列表
 */
#define kAPI_User_FollowList kAPI_USER_SERVER_VERSION(@"user/index.php?cmd=followList")

/**
 *  用户基本信息
 */
#define kAPI_User_PersonInfo kAPI_USER_SERVER_VERSION(@"user/index.php?cmd=personalInfo")

/**
 *  我的朋友圈列表（文章）
 */
#define kAPI_User_FollowContentList kAPI_USER_SERVER_VERSION(@"user/index.php?cmd=followArticleList")

/**
 *  收藏列表
 */
#define kAPI_User_CollectionList kAPI_USER_SERVER_VERSION(@"user/index.php?cmd=collectionList")

/**
 *  我的日志列表
 */
#define kAPI_User_LogList kAPI_USER_SERVER_VERSION(@"user/index.php?cmd=articleList")

/**
 *  我的鸟种列表
 */
#define kAPI_User_BirdList kAPI_USER_SERVER_VERSION(@"user/index.php?cmd=obBirdList")

/**
 *  我的相册
 */
#define kAPI_User_Photos kAPI_USER_SERVER_VERSION(@"user/index.php?cmd=album")

/**
 *  我的粉丝列表
 */
#define kAPI_User_FansList kAPI_USER_SERVER_VERSION(@"user/index.php?cmd=fansList")


/**
 *  用户基本信息
 */
#define kAPI_User_MyInfo kAPI_USER_SERVER_VERSION(@"user/index.php?cmd=myInfo")

/**
 *  获取通知列表
 */
#define kAPI_User_MessageNotify kAPI_USER_SERVER_VERSION(@"user/message.php")


#pragma mark-- 首页

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
 *  社区
 */
#define kAPI_Discover_ShequList kAPI_USER_SERVER_VERSION(@"community/index.php?cmd=articleList")

/**
 *  社区模块
 */
#define kAPI_Discover_ShequSection kAPI_USER_SERVER_VERSION(@"community/index.php?cmd=section")

/**
 *  大赛列表
 */
#define kAPI_Discover_MatchList kAPI_USER_SERVER_VERSION(@"match/index.php?cmd=matchList")

/**
 *  大赛详情 基本信息
 */
#define kAPI_Discover_MatchDetail kAPI_USER_SERVER_VERSION(@"match/index.php?cmd=matchDetail")

/**
 * 装备 咨询
 */
#define kAPI_Discover_articleList kAPI_USER_SERVER_VERSION(@"article/index.php?cmd=articleList")

#pragma mark-- 查鸟

/**
 *  查鸟首页
 */
#define kAPI_Find_Bird kAPI_USER_SERVER_VERSION(@"bird/index.php")

/**
 *  查鸟 类别
 */
#define kAPI_Find_Bird_family kAPI_USER_SERVER_VERSION(@"bird/index.php?cmd=searchFamily")

/**
 *  查鸟 关键字
 */
#define kAPI_Find_Bird_SearchBird kAPI_USER_SERVER_VERSION(@"bird/index.php?cmd=searchBird")



#pragma mark-- 发布

/**
 *  上传图片
 */
#define kAPI_Publish_UpLoad kAPI_USER_SERVER_VERSION(@"article/index.php?cmd=upload")


/**
 *  发布
 */
#define kAPI_Publish_Publish kAPI_USER_SERVER_VERSION(@"article/index.php?cmd=saveBirdArticle")

/**
 *  获取升天环境
 */
#define kAPI_Publish_GetEV kAPI_USER_SERVER_VERSION(@"bird/index.php?cmd=environmentList")





#pragma mark-- 文章

/**
 *  作品
 */
#define kAPI_Article_zuopinList kAPI_USER_SERVER_VERSION(@"article/index.php?cmd=photographyList")

/**
 *  排行
 */
#define kAPI_Article_rankingList kAPI_USER_SERVER_VERSION(@"birdapi/ranking/index.php?cmd=ranking")


#endif /* AppApi_h */

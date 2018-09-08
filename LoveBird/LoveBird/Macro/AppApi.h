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
 *  点赞
 */
#define kAPI_User_up kAPI_USER_SERVER_VERSION(@"article/index.php?cmd=upArticle")

/**
 *  发评论
 */
#define kAPI_User_comment kAPI_USER_SERVER_VERSION(@"article/index.php?cmd=commentArticle")

/**
 *  收藏文章
 */
#define kAPI_User_collect kAPI_USER_SERVER_VERSION(@"article/index.php?cmd=collectArticle")

/**
 *  点赞
 */
#define kAPI_User_up kAPI_USER_SERVER_VERSION(@"article/index.php?cmd=upArticle")

/**
 *  点赞
 */
#define kAPI_User_up kAPI_USER_SERVER_VERSION(@"article/index.php?cmd=upArticle")


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

//检查第三方是否注册
#define kAPI_User_CheckUser kAPI_USER_SERVER_VERSION(@"user/index.php?cmd=checkUser")


// 发送验证码
#define kAPI_User_sendSmd kAPI_USER_SERVER_VERSION(@"user/index.php?cmd=sendSms")

/**
 *  注册
 */
#define kAPI_User_register kAPI_USER_SERVER_VERSION(@"user/index.php?cmd=register")


/**
 *  登录
 */
#define kAPI_User_login kAPI_USER_SERVER_VERSION(@"user/index.php?cmd=login")


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
#define kAPI_Discover_Talent kAPI_USER_SERVER_VERSION(@"master/index.php?cmd=masterList")

/**
 *  社区
 */
#define kAPI_Discover_ShequList kAPI_USER_SERVER_VERSION(@"community/index.php?cmd=articleList")

/**
 *  社区模块
 */
#define kAPI_Discover_ShequSection kAPI_USER_SERVER_VERSION(@"community/index.php?cmd=section2")

/**
 *  大赛列表
 */
#define kAPI_Discover_MatchList kAPI_USER_SERVER_VERSION(@"match/index.php?cmd=matchList")

/**
 *  大赛详情
 */
#define kAPI_Discover_MatchDetail kAPI_USER_SERVER_VERSION(@"match/index.php?cmd=matchDetail")

/**
 *  大赛记录
 */
#define kAPI_Discover_MatchArticleList kAPI_USER_SERVER_VERSION(@"/match/index.php?cmd=matchArticleList")


/**
 *  大赛详情 基本信息
 */
#define kAPI_Discover_MatchDetail kAPI_USER_SERVER_VERSION(@"match/index.php?cmd=matchDetail")

/**
 * 装备 咨询
 */
#define kAPI_Discover_articleList kAPI_USER_SERVER_VERSION(@"article/index.php?cmd=articleList")

/**
 * 全局搜索 装备 咨询
 */
#define kAPI_Discover_Search_article kAPI_USER_SERVER_VERSION(@"home/index.php?cmd=searchArticle")

/**
 * 全局搜索 话题
 */
#define kAPI_Discover_Search_birdarticle kAPI_USER_SERVER_VERSION(@"home/index.php?cmd=searchBirdArticle")


#pragma mark-- 查鸟

/**
 *  查鸟首页
 */
#define kAPI_Find_Bird kAPI_USER_SERVER_VERSION(@"bird/index.php")


/**
 *  查鸟 关键字
 */
#define kAPI_Find_Bird_SearchBird kAPI_USER_SERVER_VERSION(@"bird/index.php?cmd=searchBird")

/**
 *  查鸟 体型
 */
#define kAPI_Find_Bird_shape kAPI_USER_SERVER_VERSION(@"bird/index.php?cmd=searchBirdByShape")

/**
 *  查鸟 体型可选项
 */
#define kAPI_Find_Bird_displayshape kAPI_USER_SERVER_VERSION(@"bird/index.php?cmd=displayShape")

/**
 *  查鸟 颜色
 */
#define kAPI_Find_Bird_displaycolor kAPI_USER_SERVER_VERSION(@"bird/index.php?cmd=displayColor")

/**
 *  查鸟 鸟头
 */
#define kAPI_Find_Bird_displayhead kAPI_USER_SERVER_VERSION(@"bird/index.php?cmd=displayBill")

/**
 *  类目
 */
#define kAPI_Find_Bird_subject kAPI_USER_SERVER_VERSION(@"bird/index.php?cmd=searchSubject")

/**
 *  属类
 */
#define kAPI_Find_Bird_genus kAPI_USER_SERVER_VERSION(@"bird/index.php?cmd=searchGenus")

/**
 *  查鸟 科类
 */
#define kAPI_Find_Bird_family kAPI_USER_SERVER_VERSION(@"bird/index.php?cmd=searchFamily")

/**
 *  查鸟 科类
 */
#define kAPI_Find_Bird_travelList kAPI_USER_SERVER_VERSION(@"travel/index.php?cmd=travelList")

/**
 *  全局搜索鸟种
 */
#define kAPI_Find_Search_bird kAPI_USER_SERVER_VERSION(@"home/index.php?cmd=searchBird")

/**
 *  图片鸟种
 */
#define kAPI_Find_Search_image_bird kAPI_USER_SERVER_VERSION(@"bird/index.php?cmd=aiSearchBirdByimg")

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
#define kAPI_Article_rankingList kAPI_USER_SERVER_VERSION(@"ranking/index.php?cmd=ranking")

/**
 *  地图 鸟数量
 */
#define kAPI_Discover_map kAPI_USER_SERVER_VERSION(@"bird/index.php?cmd=getBirdPoint")

/**
 *  鸟信息
 */
#define kAPI_Discover_mapMessage kAPI_USER_SERVER_VERSION(@"bird/index.php?cmd=getBirdListByGps")

#pragma mark-- 详情

/**
 *  日志详情
 */
#define kAPI_Detail_birdArticle kAPI_USER_SERVER_VERSION(@"article/index.php?cmd=birdArticleDetail")


/**
 *  文章详情
 */
#define kAPI_Detail_contentDetail kAPI_USER_SERVER_VERSION(@"article/index.php?cmd=articleDetail")


/**
 *  日志评论列表
 */
#define kAPI_Detail_talkList kAPI_USER_SERVER_VERSION(@"article/index.php?cmd=birdArticleCommentList")


/**
 *  文章评论列表
 */
#define kAPI_Detail_talkList_word kAPI_USER_SERVER_VERSION(@"article/index.php?cmd=articleCommentList")

/**
 *  日志点赞列表
 */
#define kAPI_Detail_uplist kAPI_USER_SERVER_VERSION(@"article/index.php?cmd=birdArticleUpList")

/**
 *  文章点赞列表
 */
#define kAPI_Detail_uplist_word kAPI_USER_SERVER_VERSION(@"article/index.php?cmd=articleUpList")


/**
 *  鸟种详情
 */
#define kAPI_Detail_BirdDetail kAPI_USER_SERVER_VERSION(@"bird/index.php?cmd=birdDetail")

/**
 *  删除日志详情
 */
#define kAPI_Detail_DeleteBirdDetail kAPI_USER_SERVER_VERSION(@"article/index.php?cmd=delBirdArticle")


/**
 *  草稿箱
 */
#define kAPI_Detail_caogaoxiang kAPI_USER_SERVER_VERSION(@"article/index.php?cmd=draftList")

/**
 *  草稿箱
 */
#define kAPI_Detail_caogaopublish kAPI_USER_SERVER_VERSION(@"article/index.php?cmd=saveBirdArticle")

/**
 *  草稿获取详情
 */
#define kAPI_Detail_caogaoDetail kAPI_USER_SERVER_VERSION(@"article/index.php?cmd=birdArticleDetailForEdit")


/**
 *  观鸟记录
 */
#define kAPI_Detail_guanniaojilu kAPI_USER_SERVER_VERSION(@"bird/index.php?cmd=birdLogList")

/**
 *  举报
 */
#define kAPI_Detail_report kAPI_USER_SERVER_VERSION(@"birdapi/home/index.php?cmd=report")




#pragma mark-- 设置

/**
 *  获取设置
 */
#define kAPI_Set_message kAPI_USER_SERVER_VERSION(@"user/message.php")

/**
 *  获取位置
 */
#define kAPI_Set_location kAPI_USER_SERVER_VERSION(@"user/index.php?cmd=getDistrictList")

/**
 *  完善信息
 */
#define kAPI_Set_finish kAPI_USER_SERVER_VERSION(@"user/index.php?cmd=modifyUserinfo")


#define kAPI_Set_finishHeadiCON kAPI_USER_SERVER_VERSION(@"user/index.php?cmd=modifyhead")



#pragma mark-- 搜索

/**
 *  用户
 */
#define kAPI_Search_userlist kAPI_USER_SERVER_VERSION(@"home/index.php?cmd=searchUser")

/**
 *  话题
 */
#define kAPI_Search_articleList kAPI_USER_SERVER_VERSION(@"home/index.php?cmd=searchBirdArticle")

/**
 *  鸟种
 */
#define kAPI_Search_birdlist kAPI_USER_SERVER_VERSION(@"home/index.php?cmd=searchBird")

/**
 *  zicun
 */
#define kAPI_Search_zixun kAPI_USER_SERVER_VERSION(@"home/index.php?cmd=searchArticle")


#endif /* AppApi_h */

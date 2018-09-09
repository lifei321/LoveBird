//
//  UserDao.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/2.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "UserDao.h"
#import "AppApi.h"
#import "AppBaseModel.h"
#import "UserFollowModel.h"
#import "UserInfoModel.h"
#import "UserFriendModel.h"
#import "UserBirdModel.h"
#import "UserModel.h"
#import "ShequModel.h"
#import "RegisterModel.h"

@implementation UserDao

+ (void)checkUserType:(NSInteger)type unionid:(NSString *)unionid openid:(NSString *)openid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(unionid) forKey:@"unionid"];
    [dic setObject:EMPTY_STRING_IF_NIL(openid) forKey:@"openid"];
    [dic setObject:[NSString stringWithFormat:@"%ld", type] forKey:@"type"];
    
    [AppHttpManager POST:kAPI_User_CheckUser parameters:dic jsonModelName:[RegisterDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

+ (void)getCode:(NSString *)mobile isRegister:(BOOL)isRegister successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(mobile) forKey:@"mobile"];
    [dic setObject:@(isRegister) forKey:@"isRegister"];
    
    [AppHttpManager POST:kAPI_User_sendSmd parameters:dic jsonModelName:[AppBaseModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 获取推送消息
+ (void)userMessageType:(UserMessageType)type successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    
    [dic setObject:[NSString stringWithFormat:@"%ld", type] forKey:@"type"];
    
    [AppHttpManager POST:kAPI_User_MessageNotify parameters:dic jsonModelName:[AppBaseModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 关注
+ (void)userFollow:(NSString *)taid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(taid) forKey:@"fuid"];

    [AppHttpManager POST:kAPI_User_Follow parameters:dic jsonModelName:[AppBaseModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 关注列表
+ (void)userFollowList:(NSString *)taid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(taid) forKey:@"taid"];

    [AppHttpManager POST:kAPI_User_FollowList parameters:dic jsonModelName:[UserFollowListModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 我的朋友圈 文章列表
+ (void)userContenPage:(NSInteger)pageNum SuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    [dic setObject:[NSString stringWithFormat:@"%ld", pageNum] forKey:@"page"];

    [AppHttpManager POST:kAPI_User_FollowContentList parameters:dic jsonModelName:[ShequDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 我的收藏列表
+ (void)userCollectList:(NSInteger)pageNum successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    [dic setObject:[NSString stringWithFormat:@"%ld", pageNum] forKey:@"page"];

    [AppHttpManager POST:kAPI_User_CollectionList parameters:dic jsonModelName:[ShequDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 我的日志列表
+ (void)userLogList:(NSInteger)pageNum
            matchId:(NSString *)matchId
                fid:(NSString *)taid
       successBlock:(LFRequestSuccess)successBlock
       failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:[NSString stringWithFormat:@"%ld", pageNum] forKey:@"page"];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(matchId) forKey:@"matchid"];
    [dic setObject:EMPTY_STRING_IF_NIL(taid) forKey:@"taid"];

    [AppHttpManager POST:kAPI_User_LogList parameters:dic jsonModelName:[ShequLogModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 我的鸟种列表
+ (void)userBirdList:(NSInteger)pageNum
                 fid:(NSString *)taid
             matchid:(NSString *)matchid
        successBlock:(LFRequestSuccess)successBlock
        failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    [dic setObject:[NSString stringWithFormat:@"%ld", pageNum] forKey:@"page"];
    [dic setObject:EMPTY_STRING_IF_NIL(taid) forKey:@"taid"];
    [dic setObject:EMPTY_STRING_IF_NIL(matchid) forKey:@"matchid"];

    [AppHttpManager POST:kAPI_User_BirdList parameters:dic jsonModelName:[UserBirdDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 相册列表
+ (void)userPhotoList:(NSString *)taid pageNum:(NSInteger)pageNum successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(taid) forKey:@"taid"];
    [dic setObject:[NSString stringWithFormat:@"%ld", pageNum] forKey:@"page"];

    [AppHttpManager POST:kAPI_User_Photos parameters:dic jsonModelName:[AppBaseModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 粉丝列表
+ (void)userFansList:(NSString *)taid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(taid) forKey:@"taid"];

    [AppHttpManager POST:kAPI_User_FansList parameters:dic jsonModelName:[UserFollowListModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 搜索用户列表
+ (void)userGetList:(NSString *)word successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(word) forKey:@"keywords"];
    
    [AppHttpManager POST:kAPI_Search_userlist parameters:dic jsonModelName:[UserFollowListModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 我的个人信息
+ (void)userMyInfo:(NSString *)taid SuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];

    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(taid) forKey:@"taid"];


    [AppHttpManager POST:kAPI_User_PersonInfo parameters:dic jsonModelName:[UserModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (!taid.length) {
            [UserPage sharedInstance].userModel = (UserModel *)responseObject;
        }
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 注册
+ (void)userRegister:(NSString *)mobile
            password:(NSString *)password
                name:(NSString *)name
                code:(NSString *)code
                type:(NSInteger)type
              openID:(NSString *)openid
             unionid:(NSString *)unionid
           headImage:(NSString *)headImage
        SuccessBlock:(LFRequestSuccess)successBlock
        failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(mobile) forKey:@"mobile"];
    [dic setObject:EMPTY_STRING_IF_NIL(password) forKey:@"password"];
    [dic setObject:EMPTY_STRING_IF_NIL(name) forKey:@"userName"];
    [dic setObject:EMPTY_STRING_IF_NIL(code) forKey:@"vCode"];
    
    if (type > 0) {
        [dic setObject:[NSString stringWithFormat:@"%ld", type] forKey:@"type"];
        [dic setObject:EMPTY_STRING_IF_NIL(openid) forKey:@"openid"];
        [dic setObject:EMPTY_STRING_IF_NIL(headImage) forKey:@"tpHead"];
        [dic setObject:EMPTY_STRING_IF_NIL(unionid) forKey:@"unionid"];
    }
    
    [AppHttpManager POST:kAPI_User_register parameters:dic jsonModelName:[RegisterDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        
        RegisterDataModel *dataModel = (RegisterDataModel *)responseObject;
        [UserPage setUid:dataModel.userInfo.uid];
        [UserPage setToken:dataModel.userInfo.token];
        
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 登录
+ (void)userLogin:(NSString *)mobile
         password:(NSString *)password
     SuccessBlock:(LFRequestSuccess)successBlock
     failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(mobile) forKey:@"userName"];
    [dic setObject:EMPTY_STRING_IF_NIL(password) forKey:@"password"];
    
    [AppHttpManager POST:kAPI_User_login parameters:dic jsonModelName:[RegisterDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        
        RegisterDataModel *dataModel = (RegisterDataModel *)responseObject;
        [UserPage setUid:dataModel.userInfo.uid];
        [UserPage setToken:dataModel.userInfo.token];
        
        
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 收藏
+ (void)userCollect:(NSString *)taid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(taid) forKey:@"tid"];
    
    [AppHttpManager POST:kAPI_User_collect parameters:dic jsonModelName:[AppBaseModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 点赞
+ (void)userUp:(NSString *)taid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(taid) forKey:@"tid"];
    
    [AppHttpManager POST:kAPI_User_up parameters:dic jsonModelName:[AppBaseModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

@end

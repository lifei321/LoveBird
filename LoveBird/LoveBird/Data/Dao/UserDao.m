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

// 获取推送消息
+ (void)userMessageType:(UserMessageType)type successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].userModel.uid) forKey:@"uid"];
    
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
+ (void)userFollow:(NSString *)fid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].userModel.uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(fid) forKey:@"fuid"];
    
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
+ (void)userFollowList:(NSString *)uid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@"483887" forKey:@"iuid"];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].userModel.uid) forKey:@"uid"];
    
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

// 用户个人信息
+ (void)userPersonInfo:(NSString *)uid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@"483887" forKey:@"iuid"];
    [dic setObject:EMPTY_STRING_IF_NIL(uid) forKey:@"uid"];
    
    [AppHttpManager POST:kAPI_User_PersonInfo parameters:dic jsonModelName:[UserInfoModel class] success:^(__kindof AppBaseModel *responseObject) {
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
+ (void)userContenSuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].userModel.uid) forKey:@"uid"];
    
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
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].userModel.uid) forKey:@"uid"];
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
                fid:(NSString *)fid
       successBlock:(LFRequestSuccess)successBlock
       failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@"483887" forKey:@"iuid"];
    [dic setObject:[NSString stringWithFormat:@"%ld", pageNum] forKey:@"page"];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].userModel.uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(matchId) forKey:@"matchid"];

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
                 fid:(NSString *)fid
        successBlock:(LFRequestSuccess)successBlock
        failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].userModel.uid) forKey:@"uid"];
    [dic setObject:[NSString stringWithFormat:@"%ld", pageNum] forKey:@"page"];
    [dic setObject:EMPTY_STRING_IF_NIL(fid) forKey:@"iuid"];
    
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
+ (void)userPhotoList:(NSString *)uid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@"483887" forKey:@"iuid"];
    [dic setObject:EMPTY_STRING_IF_NIL(uid) forKey:@"uid"];
    
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
+ (void)userFansList:(NSString *)uid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@"483887" forKey:@"iuid"];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].userModel.uid) forKey:@"uid"];
    
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

// 我的个人信息
+ (void)userMyInfoSuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].userModel.uid) forKey:@"uid"];

    [AppHttpManager POST:kAPI_User_PersonInfo parameters:dic jsonModelName:[UserModel class] success:^(__kindof AppBaseModel *responseObject) {
        [UserPage sharedInstance].userModel = (UserModel *)responseObject;
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
        SuccessBlock:(LFRequestSuccess)successBlock
        failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(mobile) forKey:@"mobile"];
    [dic setObject:EMPTY_STRING_IF_NIL(password) forKey:@"password"];
    [dic setObject:EMPTY_STRING_IF_NIL(name) forKey:@"userName"];
    [dic setObject:EMPTY_STRING_IF_NIL(code) forKey:@"vCode"];

    [AppHttpManager POST:kAPI_User_register parameters:dic jsonModelName:[RegisterDataModel class] success:^(__kindof AppBaseModel *responseObject) {
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
    [dic setObject:EMPTY_STRING_IF_NIL(mobile) forKey:@"username"];
    [dic setObject:EMPTY_STRING_IF_NIL(password) forKey:@"password"];
    
    [AppHttpManager POST:kAPI_User_login parameters:dic jsonModelName:[RegisterDataModel class] success:^(__kindof AppBaseModel *responseObject) {
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

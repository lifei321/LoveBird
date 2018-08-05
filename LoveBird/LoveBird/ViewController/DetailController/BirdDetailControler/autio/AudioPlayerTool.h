//
//  AudioPlayerTool.h
//  VideoWindow
//
//  Created by fangliguo on 2017/4/19.
//  Copyright © 2017年 cudatec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BirdDetailModel.h"

typedef void(^AudioPlayerFinishBlock)(void);

typedef void(^AudioPlayerProgressBlock)(CGFloat progress);

typedef NS_ENUM(NSUInteger, VedioStatus) {
    VedioStatusFailed,        // 播放失败
    VedioStatusBuffering,     // 缓冲中
    VedioStatusPlaying,       // 播放中
    VedioStatusFinished,       //停止播放
    VedioStatusPause       // 暂停播放
};


@interface AudioPlayerTool : NSObject

@property (nonatomic, strong) BirdDetailSongModel *songModel;

//播放状态
@property (nonatomic, assign) VedioStatus playerStatus;


@property (nonatomic, strong) AudioPlayerFinishBlock finishBlock;

@property (nonatomic, strong) AudioPlayerProgressBlock progressBlock;

+ (AudioPlayerTool *)sharePlayerTool;

// 开始 暂停
- (void)playButtonAction;

// 销毁
- (void)destroyPlayer;



@end

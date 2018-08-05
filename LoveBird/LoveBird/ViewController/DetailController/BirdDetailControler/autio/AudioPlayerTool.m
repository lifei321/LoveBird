//
//  AudioPlayerTool.m
//  VideoWindow
//
//  Created by fangliguo on 2017/4/19.
//  Copyright © 2017年 cudatec. All rights reserved.
//

#import "AudioPlayerTool.h"
#import <AVFoundation/AVFoundation.h>

@interface AudioPlayerTool()

@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) AVPlayerItem *playerItem;


@property (nonatomic, strong) id timeObserver;

@property (nonatomic, assign) CGFloat totalTime;



@end

@implementation AudioPlayerTool
+(AudioPlayerTool *)sharePlayerTool{
    static AudioPlayerTool *single;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        single = [[AudioPlayerTool alloc] init];
        
    });
    return single;
}

- (void)setSongModel:(BirdDetailSongModel *)songModel {
    _songModel = songModel;
    
    if (self.finishBlock) {
        self.finishBlock();
    }
    if (_player) {
        [self destroyPlayer];
    }
    
    self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:songModel.song_url]];
    [self.player replaceCurrentItemWithPlayerItem:self.playerItem];

    [self addPlayerListener];
    [self playButtonAction];
}

- (AVPlayer *)player {
    if (!_player) {
        _player = [[AVPlayer alloc] init];
        [_player setVolume:1];
        _player.rate = 1;
    }
    return _player;
}

//添加监听文件,所有的监听
- (void)addPlayerListener {
    
    if (self.player) {
        //播放速度监听
        [self.player addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    if (self.playerItem) {
        //播放状态监听
        [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        //缓冲进度监听
        [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
        
        //播放中监听，更新播放进度
        __weak typeof(self) weakSelf = self;
        self.timeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 30) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
            float currentPlayTime = (double)weakSelf.playerItem.currentTime.value/weakSelf.playerItem.currentTime.timescale;
            if (weakSelf.playerItem.currentTime.value<0) {
                currentPlayTime = 0.1; //防止出现时间计算越界问题
            }
            
            if (self.totalTime > 0) {
                CGFloat progress = currentPlayTime * 100 / self.totalTime;
                if (weakSelf.progressBlock) {
                    weakSelf.progressBlock(progress);
                }
            }
        }];
    }
    
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    //监听应用后台切换
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appEnteredBackground)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    //播放中被打断
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleInterruption:) name:AVAudioSessionInterruptionNotification object:[AVAudioSession sharedInstance]];
    //拔掉耳机监听？？
}


#pragma mark 播放，暂停
- (void)play{
    [self.player play];
    self.playerStatus = VedioStatusPlaying;
}

- (void)pause{
    [self.player pause];
    self.playerStatus = VedioStatusPause;

}

#pragma mark 监听播放完成事件
-(void)playerFinished:(NSNotification *)notification{
    [self.playerItem seekToTime:kCMTimeZero];
    [self pause];
    if (self.finishBlock) {
        self.finishBlock();
    }
}


#pragma mark 播放被打断
- (void)handleInterruption:(NSNotification *)notification {
    [self pause];
}

#pragma mark 进入后台，暂停音频
- (void)appEnteredBackground {
    [self pause];
}

#pragma mark 监听捕获
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItem *item = (AVPlayerItem *)object;
        if ([self.playerItem status] == AVPlayerStatusReadyToPlay) {
            //获取音频总长度
            CMTime duration = item.duration;
            self.totalTime =  CMTimeGetSeconds(duration);
            NSLog(@"AVPlayerStatusReadyToPlay -- 音频时长%f",CMTimeGetSeconds(duration));
            
        }else if([self.playerItem status] == AVPlayerStatusFailed) {
            
//            [self playerFailed];
            NSLog(@"AVPlayerStatusFailed -- 播放异常");
            
        }else if([self.playerItem status] == AVPlayerStatusUnknown) {
            
            [self pause];
            NSLog(@"AVPlayerStatusUnknown -- 未知原因停止");
        }
    } else if([keyPath isEqualToString:@"loadedTimeRanges"]) {
        AVPlayerItem *item = (AVPlayerItem *)object;
        NSArray * array = item.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue]; //本次缓冲的时间范围
        NSTimeInterval totalBuffer = CMTimeGetSeconds(timeRange.start) + CMTimeGetSeconds(timeRange.duration); //缓冲总长度
//        self.timeSlider.trackValue = totalBuffer;
        //当缓存到位后开启播放，取消loading
        if (totalBuffer >0 && self.playerStatus != VedioStatusPause) {
            [self.player play];
        }
        NSLog(@"---共缓冲---%.2f",totalBuffer);
    } else if ([keyPath isEqualToString:@"rate"]){
        AVPlayer *item = (AVPlayer *)object;
        if (item.rate == 0) {
            if (self.playerStatus != VedioStatusPause) {
                self.playerStatus = VedioStatusBuffering;
            }
        } else {
            self.playerStatus = VedioStatusPlaying;
            
        }
        NSLog(@"---播放速度---%f",item.rate);
    } else if([keyPath isEqualToString:@"playerStatus"]){
        switch (self.playerStatus) {
//            case VedioStatusBuffering:
//                [self.timeSlider.sliderBtn showActivity:YES];
//                break;
//            case VedioStatusPause:
//                [self.playButton setImage:[UIImage imageNamed:@"ico_play"] forState:UIControlStateNormal];
//                [self.timeSlider.sliderBtn showActivity:NO];
//                break;
//            case VedioStatusPlaying:
//                [self.playButton setImage:[UIImage imageNamed:@"ico_stop"] forState:UIControlStateNormal];
//                [self.timeSlider.sliderBtn showActivity:NO];
//                break;
                
            default:
                break;
        }
    }
}

#pragma mark 设置时间轴最大时间
- (void)setMaxDuratuin:(float)duration{
//    _totalTime = duration;
//    self.timeSlider.maximumValue = duration;
//    self.timeTotalLabel.text = [VedioPlayerConfig convertTime:duration];
}

#pragma mark 播放按钮事件
- (void)playButtonAction {
    if (self.player) {
        if (self.playerStatus == VedioStatusPause) {
            [self play];
        } else {
            [self pause];
        }
    } else {
        [self play];
    }
}

//销毁player,无奈之举 因为avplayeritem的制空后依然缓存的问题。
- (void)destroyPlayer {
    
    if (_playerItem) {
        [self.playerItem removeObserver:self forKeyPath:@"status"];
        [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
        _playerItem = nil;
    }
    
    if (_player) {
        [self.player removeObserver:self forKeyPath:@"rate"];
        [self.player removeTimeObserver:self.timeObserver];
        _player = nil;
    }
    self.totalTime = 0;
    self.playerStatus = VedioStatusPause;
//    self.timeSlider.value = 0;
//    self.timeNowLabel.text = @"00:00";
    
//    [self removeObserver:self forKeyPath:@"playerStatus"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

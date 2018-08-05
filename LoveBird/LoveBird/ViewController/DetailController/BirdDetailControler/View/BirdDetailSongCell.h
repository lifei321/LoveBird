//
//  BirdDetailSongCell.h
//  LoveBird
//
//  Created by cheli shan on 2018/6/3.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BirdDetailModel.h"
#import "AudioProgressView.h"


@class BirdDetailSongCell;
@protocol BBirdDetailSongCellDelegate<NSObject>

- (void)BirdDetailSongCell:(BirdDetailSongCell *)cell button:(UIButton *)button;
@end




@interface BirdDetailSongCell : UITableViewCell

@property (nonatomic, weak) id<BBirdDetailSongCellDelegate>delegate;

@property (nonatomic, strong) BirdDetailSongModel *songModel;

@property (nonatomic, strong) AudioProgressView *progressView;

@end

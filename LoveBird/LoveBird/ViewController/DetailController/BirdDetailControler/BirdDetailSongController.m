//
//  BirdDetailSongController.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/3.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "BirdDetailSongController.h"
#import "BirdDetailSongCell.h"
#import "AudioPlayerTool.h"

@interface BirdDetailSongController ()<UITableViewDelegate, UITableViewDataSource, BBirdDetailSongCellDelegate>

@end

@implementation BirdDetailSongController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigation];
    [self setTableView];
    
}

- (void)BirdDetailSongCell:(BirdDetailSongCell *)cell button:(UIButton *)button {
    
    if ([AudioPlayerTool sharePlayerTool].playerStatus == VedioStatusPlaying) {
        [[AudioPlayerTool sharePlayerTool] playButtonAction];
        return;
    }
    
    [AudioPlayerTool sharePlayerTool].songModel = cell.songModel;
    [AudioPlayerTool sharePlayerTool].finishBlock = ^{
        button.selected  = NO;
        cell.progressView.progressValue = 0;
    };
    
    [AudioPlayerTool sharePlayerTool].progressBlock = ^(CGFloat progress) {
        cell.progressView.progressValue = progress;
    };
}

#pragma mark-- tabelView 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BirdDetailSongCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BirdDetailSongCell class]) forIndexPath:indexPath];
    cell.songModel = self.dataArray[indexPath.row];
    cell.delegate = self;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AutoSize6(106);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

}


#pragma mark--- UI

- (void)setNavigation {
    
    self.title = @"声音";
//    self.rightButton.title = @"操作";
//    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateNormal];
//    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateHighlighted];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setTableView {
    
    self.tableView.top = total_topView_height;
    self.tableView.height = SCREEN_HEIGHT - total_topView_height;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[BirdDetailSongCell class] forCellReuseIdentifier:NSStringFromClass([BirdDetailSongCell class])];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(100))];
    footerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = footerView;
    
    //默认【上拉加载】
    //    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netForTalkList)];
}

@end

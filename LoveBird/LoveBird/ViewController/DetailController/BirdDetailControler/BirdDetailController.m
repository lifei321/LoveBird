//
//  BirdDetailController.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/2.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "BirdDetailController.h"
#import <MJRefresh/MJRefresh.h>
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "DetailDao.h"
#import "BirdDetailModel.h"
#import "BirdDetailTextCell.h"
#import "BirdDetailClassCell.h"
#import "BirdDetailGradeCell.h"
#import "BirdDetailCell.h"
#import "BirdDetailSongController.h"
#import "YLTableViewVC.h"
#import <SDWebImage/UIImageView+WebCache.h>


#import "AudioPlayerTool.h"

@interface BirdDetailController ()<SDCycleScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, BirdDetailTextCellDelegate>

@property (nonatomic, strong) BirdDetailModel *detailModel;

// 轮播图
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@end

@implementation BirdDetailController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setTableView];
    [self netForBirdDetail];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[AudioPlayerTool sharePlayerTool] destroyPlayer];
}

- (void)BirdDetailTextCell:(BirdDetailTextCell *)cell button:(UIButton *)button {
    
    if ([AudioPlayerTool sharePlayerTool].playerStatus == VedioStatusPlaying) {
        [[AudioPlayerTool sharePlayerTool] playButtonAction];
        return;
    }
    BirdDetailSongModel *songmodel = self.detailModel.song.firstObject;
    [[AudioPlayerTool sharePlayerTool] setSongModel:songmodel];
    [AudioPlayerTool sharePlayerTool].finishBlock = ^{
        button.selected  = NO;
    };
    
    [AudioPlayerTool sharePlayerTool].progressBlock = ^(CGFloat progress) {
        
    };
}


#pragma mark-- tabelView 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 3;
    }
    if (section == 1) {
        return 4;
    }
    
    if (section == 2) {
        return 13;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    UITableViewCell *cell;

    if (section == 0) {
        BirdDetailTextCell *textcell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BirdDetailTextCell class]) forIndexPath:indexPath];
        textcell.delegate = self;

        if (row == 0) {
            textcell.title = self.detailModel.name;
            textcell.titleLabel.font = kFont6(32);
            textcell.hasImage = YES;
        } else if (row == 1) {
            textcell.title = self.detailModel.pinyin;
            textcell.titleLabel.font = kFont6(32);
        } else if (row == 2) {
            textcell.title = self.detailModel.name_latin;
            textcell.titleLabel.font = [UIFont italicSystemFontOfSize:AutoSize6(32)];//设置字体为斜体
        }
        cell = textcell;
    } else if (section == 1) {
        BirdDetailTextCell *textcell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BirdDetailTextCell class]) forIndexPath:indexPath];
        if (row == 0) {
            textcell.title = @"叫声";
            textcell.detail = [NSString stringWithFormat:@"%ld种", self.detailModel.song.count];
        } else if (row == 1) {
            textcell.title = @"视频";
            textcell.detail = [NSString stringWithFormat:@"%ld条", self.detailModel.video.count];
        } else if (row == 2) {
            textcell.title = @"观察记录";
            textcell.detail = [NSString stringWithFormat:@"%@条", self.detailModel.obs_times];
        } else if (row == 3) {
            textcell.title = @"地域分布";
            textcell.detail = @"  ";
        }
        cell = textcell;
    } else if (section == 2) {
        if (row == 0) {
            BirdDetailClassCell *classCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BirdDetailClassCell class]) forIndexPath:indexPath];
            classCell.title = @"物种分类:";
            classCell.detail = self.detailModel.bird_class;
            cell = classCell;

        } else if (row == 1) {
            BirdDetailClassCell *classCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BirdDetailClassCell class]) forIndexPath:indexPath];
            classCell.title = @"别名:";
            classCell.detail = self.detailModel.alias;
            cell = classCell;

        } else if (row == 2) {
            BirdDetailGradeCell *classCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BirdDetailGradeCell class]) forIndexPath:indexPath];
            classCell.title = @"保护等级:";
            classCell.world = self.detailModel.protect_iucn;
            classCell.wallx = self.detailModel.protect_cites;
            classCell.china = self.detailModel.protect_china;
            cell = classCell;
        } else if (row == 3) {
            BirdDetailClassCell *classCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BirdDetailClassCell class]) forIndexPath:indexPath];
            classCell.title = @"特征:";
            classCell.detail = @"";
            cell = classCell;
        } else {
            BirdDetailCell *classCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BirdDetailCell class]) forIndexPath:indexPath];
            classCell.detailModel = self.detailModel;
            if (row == 4) {
                classCell.title = @"描述";
                classCell.detail = self.detailModel.describe;
                if (self.detailModel.region_img.length) {
                    classCell.hasImage = YES;
                }
            } else if (row == 5) {
                classCell.title = @"颜色";
                classCell.detail = self.detailModel.color;
            } else if (row == 6) {
                classCell.title = @"叫声";
                classCell.detail = self.detailModel.song_describe;
            } else if (row == 7) {
                classCell.title = @"习性";
                classCell.detail = self.detailModel.habit;
            } else if (row == 8) {
                classCell.title = @"生物学特征";
                classCell.detail = self.detailModel.bi_property;
            } else if (row == 9) {
                classCell.title = @"种群变化趋势";
                classCell.detail = self.detailModel.po_ch_property;
            } else if (row == 10) {
                classCell.title = @"分布范围";
                classCell.detail = self.detailModel.dis_range;
            } else if (row == 11) {
                classCell.title = @"分布情况";
                classCell.detail = self.detailModel.dis_status;
            } else if (row == 12) {
                classCell.title = @"中国分布情况";
                classCell.detail = self.detailModel.dis_status_china;
            }
            cell = classCell;
        }
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (!self.detailModel) {
        return AutoSize(0);
    }
    
    if (section == 0) {
        if (row == 0) {
            if (self.detailModel.alias.length) {
                return AutoSize6(92);
            }
        }
        if (row == 1) {
            if (self.detailModel.name.length) {
                return AutoSize6(92);
            }
        }
        if (row == 2) {
            if (self.detailModel.name_latin.length) {
                return AutoSize6(92);
            }
        }
    }
    
    if (section == 1) {
        if (row == 0) {
            if (self.detailModel.song.count) {
                return AutoSize6(92);
            }
        }
        if (row == 1) {
            if (self.detailModel.video.count) {
                return AutoSize6(92);
            }
        }
        if (row == 2) {
            if (self.detailModel.obs_times.length) {
                return AutoSize6(92);
            }
        }
        if (row == 3) {
            return AutoSize6(92);
        }       
    }
    
    if (section == 2) {
        if (row == 0) {
            if (self.detailModel.bird_class.length) {
                return AutoSize6(140);
            }
        } else if (row == 1) {
            if (self.detailModel.alias.length) {
                return AutoSize6(140);
            }
        }
        if (row == 2) {
            if (self.detailModel.protect_iucn.length || self.detailModel.protect_china.length || self.detailModel.protect_cites.length) {
                return AutoSize6(218);
            }
        }
        if (row == 3) {
            return AutoSize6(70);
        }
        
        if (row == 4) {
            if (self.detailModel.describe.length) {
                return [BirdDetailCell getHeightWithModel:self.detailModel text:self.detailModel.describe img:YES];
            }
        }
        if (row == 5) {
            if (self.detailModel.color.length) {
                return [BirdDetailCell getHeightWithModel:self.detailModel text:self.detailModel.color img:NO];
            }
        }
        if (row == 6) {
            if (self.detailModel.song_describe.length) {
                return [BirdDetailCell getHeightWithModel:self.detailModel text:self.detailModel.song_describe img:NO];
            }
        }
        if (row == 7) {
            if (self.detailModel.habit.length) {
                return [BirdDetailCell getHeightWithModel:self.detailModel text:self.detailModel.habit img:NO];
            }
        }
        if (row == 8) {
            if (self.detailModel.bi_property.length) {
                return [BirdDetailCell getHeightWithModel:self.detailModel text:self.detailModel.bi_property img:NO];
            }
        }
        if (row == 9) {
            if (self.detailModel.po_ch_property.length) {
                return [BirdDetailCell getHeightWithModel:self.detailModel text:self.detailModel.po_ch_property img:NO];
            }
        }
        if (row == 10) {
            if (self.detailModel.dis_range.length) {
                return [BirdDetailCell getHeightWithModel:self.detailModel text:self.detailModel.dis_range img:NO];
            }
        }
        if (row == 11) {
            if (self.detailModel.dis_status.length) {
                return [BirdDetailCell getHeightWithModel:self.detailModel text:self.detailModel.dis_status img:NO];
            }
        }
        if (row == 12) {
            if (self.detailModel.dis_status_china.length) {
                return [BirdDetailCell getHeightWithModel:self.detailModel text:self.detailModel.dis_status_china img:NO];
            }
        }
    }
    
    return AutoSize6(0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (!self.detailModel) {
        return 0.01f;
    }
    
    if (section == 0) {
        return 0.01f;
    }
    
    if (section == 1) {
        return AutoSize6(10);
    }
    
    if (section == 2) {
        return AutoSize6(92);
    }
    return AutoSize6(0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (!self.detailModel) {
        return 0.01f;
    }
    
    if (section == 0) {
        return 0.01f;
    }
    
    if (section == 1) {
        return AutoSize6(10);
    }
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (!self.detailModel) {
        return [[UIView alloc] init];
    }
    
    if (section == 2) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(92))];
        backView.backgroundColor = [UIColor whiteColor];
        backView.clipsToBounds = YES;
        
        // 详细内容文字
        UILabel *detailTextLable = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(0), AutoSize6(18), AutoSize6(200), AutoSize6(56))];
        detailTextLable.textAlignment = NSTextAlignmentCenter;
        detailTextLable.textColor = [UIColor whiteColor];
        detailTextLable.font = kFont6(30);
        detailTextLable.backgroundColor = kColorDefaultColor;
        detailTextLable.clipsToBounds = YES;
        detailTextLable.text = @"详细内容";
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:detailTextLable.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(AutoSize6(84), AutoSize6(84))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = detailTextLable.bounds;
        maskLayer.path = maskPath.CGPath;
        detailTextLable.layer.mask = maskLayer;
        [backView addSubview:detailTextLable];
        
        // 小白点
        UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(AutoSize6(170), AutoSize6(26), 4, 4)];
        whiteView.layer.cornerRadius = 2;
        whiteView.backgroundColor = [UIColor whiteColor];
        [detailTextLable addSubview:whiteView];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, backView.height - 0.5, SCREEN_WIDTH, 0.5)];
        lineView.backgroundColor = kLineColoreDefaultd4d7dd;
        [backView addSubview:lineView];
        return backView;
    }
    
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 1) {
        if (row == 0) { // 叫声
            BirdDetailSongController *songvc = [[BirdDetailSongController alloc] init];
            songvc.dataArray = [NSArray arrayWithArray: self.detailModel.song];
            [self.navigationController pushViewController:songvc animated:YES];
            
        } else if (row == 1) { // 视频
            YLTableViewVC *vediovc = [[YLTableViewVC alloc] init];
            vediovc.arrayDS = [NSMutableArray arrayWithArray:self.detailModel.video];
            [self.navigationController pushViewController:vediovc animated:YES];
        } else if (row == 3) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
            imageView.backgroundColor = [UIColor blackColor];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [self.view addSubview:imageView];
            imageView.userInteractionEnabled = YES;
            
            [imageView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidClick:)]];
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.detailModel.region_img] placeholderImage:nil];
        }
    }
}

- (void)imageViewDidClick:(UITapGestureRecognizer *)tap {
    UIImageView *imageView = (UIImageView *)tap.view;
    [imageView removeFromSuperview];
}

- (void)netForBirdDetail {
    @weakify(self);
    [DetailDao getBirdDetail:self.cspCode successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        self.detailModel = (BirdDetailModel *)responseObject;
        
        NSMutableArray *temp = [NSMutableArray new];
        for (BirdDetailImageModel *model in self.detailModel.img) {
            [temp addObject:model.img_url];
        }
        self.cycleScrollView.imageURLStringsGroup = temp;
        [self.tableView reloadData];

    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}

#pragma mark--- UI

- (void)setNavigation {
    
    self.title = @"鸟种详情";
//    self.rightButton.title = @"操作";
//    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateNormal];
//    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateHighlighted];
    
}

- (void)setTableView {
    
    self.tableView.top = total_topView_height;
    self.tableView.height = SCREEN_HEIGHT - total_topView_height;
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.cycleScrollView;
    [self.tableView registerClass:[BirdDetailTextCell class] forCellReuseIdentifier:NSStringFromClass([BirdDetailTextCell class])];
    [self.tableView registerClass:[BirdDetailClassCell class] forCellReuseIdentifier:NSStringFromClass([BirdDetailClassCell class])];
    [self.tableView registerClass:[BirdDetailGradeCell class] forCellReuseIdentifier:NSStringFromClass([BirdDetailGradeCell class])];
    [self.tableView registerClass:[BirdDetailCell class] forCellReuseIdentifier:NSStringFromClass([BirdDetailCell class])];

    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(100))];
    footerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = footerView;

    //默认【上拉加载】
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netForTalkList)];
}

- (SDCycleScrollView *)cycleScrollView {
    
    if (_cycleScrollView == nil) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(400)) delegate:nil placeholderImage:[UIImage imageNamed:@""]];
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _cycleScrollView.delegate = self;
    }
    return _cycleScrollView;
}

@end

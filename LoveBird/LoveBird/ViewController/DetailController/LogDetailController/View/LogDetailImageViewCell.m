//
//  LogDetailImageViewCell.m
//  LoveBird
//
//  Created by 十八子飞 on 2018/12/25.
//  Copyright © 2018 shancheli. All rights reserved.
//

#import "LogDetailImageViewCell.h"
#import "LogDetailHeadImageView.h"

#import "LogDetailController.h"
#import "MatchDetailController.h"


@interface LogDetailImageViewCell ()

@property (nonatomic, strong) LogDetailHeadImageView *iconImageView;

@end

@implementation LogDetailImageViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        self.contentView.backgroundColor = kColorViewBackground;
        
        _iconImageView  = [[LogDetailHeadImageView alloc] initWithFrame:CGRectMake(0, AutoSize6(20), SCREEN_WIDTH, AutoSize6(140))];
        _iconImageView.contentMode = UIViewContentModeScaleToFill;
        _iconImageView.image = [UIImage imageNamed:@"placeHolder"];
        [self.contentView addSubview:_iconImageView];
        
        _iconImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImageViewClick:)];
        [_iconImageView addGestureRecognizer:tap];

    }
    return self;
}

- (void)setArticleModel:(LogAdArticleModel *)articleModel {
    _articleModel = articleModel;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:articleModel.imgUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
}


- (void)iconImageViewClick:(UITapGestureRecognizer *)tap {
    if (self.articleModel.view_status.integerValue == 100) {
        // 日志详情
        LogDetailController *logDetailVC = [[LogDetailController alloc] init];
        logDetailVC.tid = self.articleModel.tid;
        [[UIViewController currentViewController].navigationController pushViewController:logDetailVC animated:YES];
        
    } else if (self.articleModel.view_status.integerValue == 200) {
        // 文章详情
        LogDetailController *logDetailVC = [[LogDetailController alloc] init];
        logDetailVC.aid = self.articleModel.aid;
        [[UIViewController currentViewController].navigationController pushViewController:logDetailVC animated:YES];
        
    } else if (self.articleModel.view_status.integerValue == 300) {
        // 大赛详情
        MatchDetailController *logDetailVC = [[MatchDetailController alloc] init];
        logDetailVC.matchid = self.articleModel.aid;
        [[UIViewController currentViewController].navigationController pushViewController:logDetailVC animated:YES];
        
    } else if (self.articleModel.view_status.integerValue == 400) {
        // webview
        AppWebViewController *webvc = [[AppWebViewController alloc] init];
        webvc.startupUrlString = self.articleModel.url;
        [[UIViewController currentViewController].navigationController pushViewController:webvc animated:YES];
    }
}

@end

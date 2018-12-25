//
//  LogDetailBananerCell.m
//  LoveBird
//
//  Created by 十八子飞 on 2018/12/24.
//  Copyright © 2018 shancheli. All rights reserved.
//

#import "LogDetailBananerCell.h"
#import "LogDetailHeadImageView.h"

#import "LogDetailController.h"
#import "MatchDetailController.h"
#import "LogArticleCell.h"

@interface LogDetailBananerCell ()

@property (nonatomic, strong) UILabel *titleLabel;




@end

@implementation LogDetailBananerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabl = [[UILabel alloc] initWithFrame:CGRectMake(0, AutoSize6(30), SCREEN_WIDTH, AutoSize6(36))];
        titleLabl.textColor = [UIColor blackColor];
        titleLabl.font = kFontBold6(36);
        titleLabl.textAlignment = NSTextAlignmentCenter;
        titleLabl.text = @"精彩推荐";
        _titleLabel = titleLabl;
    }
    return _titleLabel;
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = [dataArray copy];
    
    if (dataArray.count) {
        for (UIView *subview in self.subviews) {
            if ([subview isKindOfClass:[LogArticleCell class]]) {
                [subview removeFromSuperview];
            }
        }
        
        [self.contentView addSubview:self.titleLabel];
        
        CGFloat width = (SCREEN_WIDTH - AutoSize6(30) * 4) / 3;
        CGFloat height = AutoSize6(144) + AutoSize6(40) + AutoSize6(20);
        CGFloat left = AutoSize6(30);
        CGFloat top = self.titleLabel.bottom + AutoSize6(30);
        int index = 0;
        for (int i = 0; i < dataArray.count; i++) {
            if (i > 2) {
                top = self.titleLabel.bottom + AutoSize6(30) + height;
                index = i - 3;
            } else {
                index = i;
            }
            LogArticleCell *view = [[LogArticleCell alloc] initWithFrame:CGRectMake(left * (index + 1) + width * index, top, width, height)];
            view.model = dataArray[i];
            
            view.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewImageViewClick:)];
            [view addGestureRecognizer:tap2];
            [self.contentView addSubview:view];
        }
    }
}



- (void)viewImageViewClick:(UITapGestureRecognizer *)tap {
    LogArticleCell *cell = (LogArticleCell *)tap.view;
    
    if (cell.model.article_status.integerValue == 100) {
        // 日志详情
        LogDetailController *logDetailVC = [[LogDetailController alloc] init];
        logDetailVC.tid = cell.model.tid;
        [[UIViewController currentViewController].navigationController pushViewController:logDetailVC animated:YES];
        
    } else if (cell.model.article_status.integerValue == 200) {
        // 文章详情
        LogDetailController *logDetailVC = [[LogDetailController alloc] init];
        logDetailVC.aid = cell.model.tid;
        [[UIViewController currentViewController].navigationController pushViewController:logDetailVC animated:YES];
        
    } else if (cell.model.article_status.integerValue == 300) {
        // 大赛详情
        MatchDetailController *logDetailVC = [[MatchDetailController alloc] init];
        logDetailVC.matchid = cell.model.tid;
        [[UIViewController currentViewController].navigationController pushViewController:logDetailVC animated:YES];
        
    } else if (cell.model.article_status.integerValue == 400) {
        // webview
        AppWebViewController *webvc = [[AppWebViewController alloc] init];
        webvc.startupUrlString = cell.model.tid;
        [[UIViewController currentViewController].navigationController pushViewController:webvc animated:YES];
    }
}


+ (CGFloat)getHeightWithArray:(NSArray *)array {
    
    if (array.count) {
        CGFloat height = AutoSize6(96);
        
        if (array.count < 4) {
            height += (AutoSize6(144) + AutoSize6(60) + AutoSize6(30)) ;
        } else {
            height += ((AutoSize6(144) + AutoSize6(60)) * 2 + AutoSize6(30));
        }
        return height;
    }
    
    return 0;
}


@end

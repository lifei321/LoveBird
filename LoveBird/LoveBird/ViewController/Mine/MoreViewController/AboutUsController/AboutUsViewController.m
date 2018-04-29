//
//  AboutUsViewController.m
//  LoveBird
//
//  Created by ShanCheli on 2017/7/7.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AboutUsViewController.h"
#import "AppBaseCellModel.h"
#import "NSString+APP.h"


@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关于我们";
    
    self.dataSourceArray = @[[NSMutableArray new]];
    
    
    AppBaseCellModel *knownModel = [[AppBaseCellModel alloc] init];
    knownModel.title = @"了解小赢普惠";
    knownModel.pushViewController = @"KnowUsViewController";
    [self.dataSourceArray[0] addObject:knownModel];
    
    AppBaseCellModel *customModel = [[AppBaseCellModel alloc] init];
    customModel.title = @"客服电话";
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize(100) - AutoSize(10), 0, AutoSize(100), AutoSize(30))];
    // 客服电话
    UILabel  *telephoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, AutoSize(3), AutoSize(100), AutoSize(12))];
    telephoneLabel.font = kFont(12);
    telephoneLabel.text = @"400-010-0788";
    telephoneLabel.textColor = kLineColoreDefaultd4d7dd;
    telephoneLabel.textAlignment = NSTextAlignmentRight;
    [rightView addSubview:telephoneLabel];
    
    // 工作日
    UILabel  *workDayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, AutoSize(17), AutoSize(100), AutoSize(9))];
    workDayLabel.font = kFont(8);
    workDayLabel.text = @"工作日：9:00-18:00";
    workDayLabel.textColor = kLineColoreDefaultd4d7dd;
    workDayLabel.textAlignment = NSTextAlignmentRight;
    [rightView addSubview:workDayLabel];
    
    customModel.rightView = rightView;
    customModel.selector = @"gotoTelephone";
    [self.dataSourceArray[0] addObject:customModel];
    
    [self loadTableViewHeader];
    
    [self loadTableViewFooter];
}


/**
 *  tableView header
 */
- (void)loadTableViewHeader {
    
    // 316
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize(158))];
    
    // 160x198
    UIImageView *header = [[UIImageView alloc] initWithFrame:CGRectMake(0, AutoSize(30), AutoSize(80.5), AutoSize(80.5))];
    header.image = [UIImage imageNamed:@"headerIcon"];
    header.centerX = self.view.centerX;
    [backView addSubview:header];
    self.tableView.tableHeaderView = backView;
    
    // 大标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(header.frame) + AutoSize(7), AutoSize(90), AutoSize(15))];
    titleLabel.centerX = header.centerX;
    titleLabel.font = kFontBold(12);
    titleLabel.text = @"小赢普惠";
    titleLabel.textColor = kTextColorDefault494949;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:titleLabel];
    
    // 小标题
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + AutoSize(5), AutoSize(90), AutoSize(15))];
    subTitleLabel.centerX = header.centerX;
    subTitleLabel.font = kFont(11);
    subTitleLabel.text = @"智能轻松贷";
    subTitleLabel.textColor = kColorTextLightGrayColorbcbcbc;
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:subTitleLabel];
}

/**
 *  tablview footer
 */
- (void)loadTableViewFooter {
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - AutoSize(156) - 64 - AutoSize(88))];
    
    // 关于我们 版本号label
    CGFloat vesionLabelWidth = [APP_VERSION getTextWightWithFont:kFont(13)];
    UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, backView.height - AutoSize(24) - AutoSize(28) - AutoSize(18) - AutoSize(10), vesionLabelWidth + AutoSize(12), AutoSize(18))];
    versionLabel.backgroundColor = kVersionLabelBackgoundColord0d0d0;
    versionLabel.layer.cornerRadius = versionLabel.height * .5;
    versionLabel.layer.masksToBounds = YES;
    versionLabel.text = APP_VERSION;
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.font = kFont(13);
    versionLabel.textColor = [UIColor whiteColor];
    versionLabel.centerX = backView.centerX;
    [backView addSubview:versionLabel];
    
    // 236 26
    UIImageView *footerView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - AutoSize(118)) / 2, versionLabel.bottom + AutoSize(10), AutoSize(118), AutoSize(13))];
    footerView.image = [UIImage imageNamed:@"All_Rights"];
    [backView addSubview:footerView];
    self.tableView.tableFooterView = backView;
    
}

/**
 *  客服电话
 */
- (void)gotoTelephone {
    
//    [CardLoanBaseRoutes openUrl:kCustomTel routesType:CardLoanBaseRoutesTypeToTel];
}


@end

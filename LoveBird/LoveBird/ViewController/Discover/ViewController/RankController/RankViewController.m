//
//  RankViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/27.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "RankViewController.h"
#import "DiscoverDao.h"
#import "MJRefresh.h"
#import "UIImage+Addition.h"
#import "RankModel.h"
#import "RankTableViewCell.h"
#import "WZSwitch.h"


@interface RankViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIButton *selectButton;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIScrollView *scrollView;


@property (nonatomic, strong) UILabel *firstLabel;

@property (nonatomic, strong) UILabel *secondLabel;

@property(nonatomic,strong) WZSwitch *mySwitch;

@property (nonatomic , copy) NSString *isYear;

@property (nonatomic, strong) NSMutableArray *labelArray;

@property (nonatomic , copy) NSString *currentYear;

@end

@implementation RankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [NSMutableArray new];
    _labelArray = [NSMutableArray new];

    [self setNavigation];
    
    // 设置UI
    [self setTableView];
    
    [self netForContent];
}


- (void)netForContent {
    
    [AppBaseHud showHudWithLoding:self.view];
    @weakify(self);
    [DiscoverDao getRankList:self.matchId type:self.type isYear:self.isYear year:self.currentYear successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        
        [AppBaseHud hideHud:self.view];
        RankDataModel *dataModel = (RankDataModel *)responseObject;
        for (int i = 0; i < dataModel.user.count; i++) {
            RankModel *model = dataModel.user[i];
            model.second = i + 1;
        }
        [self.dataArray removeAllObjects];
        self.tableView.tableHeaderView = self.headerView;
        self.firstLabel.text = dataModel.title_first;
        self.secondLabel.text = dataModel.title_second;
        
        [self.dataArray addObjectsFromArray:dataModel.user];
        [self.tableView reloadData];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}

#pragma mark-- tabelView 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RankTableViewCell class]) forIndexPath:indexPath];
    cell.cellType = self.type;
    cell.rankModel = self.dataArray[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return AutoSize6(120);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (void)buttonDidClick:(UIButton *)button {
    if (button == self.selectButton) {
        return;
    }
    
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
    self.type = [NSString stringWithFormat:@"%ld", (long)button.tag];
    [self netForContent];
    [self.dataArray removeAllObjects];
    [self.tableView reloadData];
}

- (void)setNavigation {
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AutoSize6(400), AutoSize6(68))];
    titleView.layer.borderColor = kColorDefaultColor.CGColor;
    titleView.layer.borderWidth = 1;
    titleView.layer.cornerRadius = 5;
    titleView.clipsToBounds = YES;
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, titleView.width / 3 - 1, titleView.height)];
    [leftButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:kColorDefaultColor withSize:leftButton.size] forState:UIControlStateSelected];
    [leftButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:[UIColor whiteColor] withSize:leftButton.size] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTitle:@"鸟种" forState:UIControlStateNormal];
    [leftButton setTitle:@"鸟种" forState:UIControlStateSelected];
    leftButton.titleLabel.font = kFont6(24);
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftButton.selected = YES;
    self.selectButton = leftButton;
    leftButton.tag = 100;
    [titleView addSubview:leftButton];
    self.type = @"100";
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(leftButton.right, 0, 1, titleView.height)];
    line1.backgroundColor = kColorDefaultColor;
    [titleView addSubview:line1];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(leftButton.right + 1, 0, titleView.width / 3 - 1, titleView.height)];
    [rightButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:kColorDefaultColor withSize:leftButton.size] forState:UIControlStateSelected];
    [rightButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:[UIColor whiteColor] withSize:leftButton.size] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"日志" forState:UIControlStateNormal];
    [rightButton setTitle:@"日志" forState:UIControlStateSelected];
    rightButton.titleLabel.font = kFont6(24);
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightButton.tag = 200;

    [titleView addSubview:rightButton];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(rightButton.right, 0, 1, titleView.height)];
    line2.backgroundColor = kColorDefaultColor;
    [titleView addSubview:line2];
    
    UIButton *scolreButton = [[UIButton alloc] initWithFrame:CGRectMake(rightButton.right + 1, 0, titleView.width / 3 - 1, titleView.height)];
    [scolreButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:kColorDefaultColor withSize:leftButton.size] forState:UIControlStateSelected];
    [scolreButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:[UIColor whiteColor] withSize:leftButton.size] forState:UIControlStateNormal];
    [scolreButton addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [scolreButton setTitle:@"积分" forState:UIControlStateNormal];
    [scolreButton setTitle:@"积分" forState:UIControlStateSelected];
    scolreButton.titleLabel.font = kFont6(24);
    [scolreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [scolreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    scolreButton.tag = 300;

    [titleView addSubview:scolreButton];
    
    self.navigationItem.titleView = titleView;
    
    self.mySwitch = [[WZSwitch alloc]initWithFrame:CGRectMake(0, 0, AutoSize6(70), AutoSize6(40))];
    [self.mySwitch setSwitchState:NO animation:NO];
    [self.mySwitch setTextFont:[UIFont fontWithName:@"Helvetica-Bold" size:AutoSize6(24)]];
    
    // 0 总       1 年
    self.isYear = @"1";

    @weakify(self);
    self.mySwitch.block = ^(BOOL state) {
        @strongify(self);
        
        //yes 音频  no 视频
        self.isYear = [NSString stringWithFormat:@"%d", !state];
        [self netForContent];
    };
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:self.mySwitch];
    
    // 大赛过来的不显示年总
    if (self.matchId.length) {
        return;
    }
    self.rightButton = (ZBaseBarButtonItem *)barItem;
}

- (void)setTableView {
    
    self.tableView.top = total_topView_height;
    self.tableView.height = SCREEN_HEIGHT - total_topView_height;
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[RankTableViewCell class] forCellReuseIdentifier:NSStringFromClass([RankTableViewCell class])];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(50))];

}

- (UIView *)headerView {
    if (!_headerView) {
//        _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(375))];
//        _headerView.image = [UIImage imageNamed:@"mine_header_back"];
//        _headerView.contentMode = UIViewContentModeScaleToFill;
//
//        self.firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(140), AutoSize6(100), SCREEN_WIDTH - AutoSize6(280), AutoSize6(54))];
//        self.firstLabel.textAlignment = NSTextAlignmentCenter;
//        self.firstLabel.textColor = [UIColor whiteColor];
//        self.firstLabel.backgroundColor = [UIColor blackColor];
//        self.firstLabel.alpha = 0.6;
//        self.firstLabel.font = kFont6(26);
//        [_headerView addSubview:self.firstLabel];
//
//        self.secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(95), self.firstLabel.bottom + AutoSize6(26),SCREEN_WIDTH - AutoSize6(190), AutoSize6(65))];
//        self.secondLabel.textAlignment = NSTextAlignmentCenter;
//        self.secondLabel.textColor = [UIColor whiteColor];
//        self.secondLabel.font = kFont6(40);
//        self.secondLabel.backgroundColor = [UIColor blackColor];
//        self.secondLabel.alpha = 0.6;
//        [_headerView addSubview:self.secondLabel];
        
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(100))];
        _headerView.backgroundColor = UIColorFromRGB(0xececec);
        
        UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:_headerView.bounds];
        scrollview.backgroundColor = UIColorFromRGB(0xececec);

        [_headerView addSubview:scrollview];
        scrollview.delegate = self;
        
        NSMutableArray *array = [NSMutableArray new];
        NSString *currentYear = [[AppDateManager shareManager] getCurrentYear];
        self.currentYear = currentYear;
        for (int i = 2018; i< (currentYear.integerValue + 5); i++) {
            NSString *string = [NSString stringWithFormat:@"%d", i];
            [array addObject:string];
        }
        
        CGFloat left = 0;
        CGFloat width = AutoSize6(100);
        for (int i = 0; i < array.count; i++) {
            left = i * width;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(left, 0, width, _headerView.height)];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = UIColorFromRGB(0x777777);
            label.font = kFont6(30);
            label.text = array[i];
            [scrollview addSubview:label];
            [_labelArray addObject:label];
            label.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelDidClick:)];
            [label addGestureRecognizer:tap];
        }
        scrollview.contentSize = CGSizeMake(array.count * width, 0);
        self.scrollView = scrollview;
        
        int currentIndex = 0;
        for (int i = 0; i< array.count; i++) {
            NSString *string = array[i];
            if ([string isEqualToString:currentYear]) {
                currentIndex = i;
                break;
            }
        }
        
        UILabel *label = _labelArray[currentIndex];
        label.textColor = UIColorFromRGB(0xffad29);
        label.font = kFontBold6(30);
        
        scrollview.contentOffset = CGPointMake(- (SCREEN_WIDTH / 2 - (currentIndex * width + width / 2)), 0);
    }
    return _headerView;
}

- (void)labelDidClick:(UITapGestureRecognizer *)tap {
    UILabel *label = (UILabel *)tap.view;
    for (UILabel *olabel in _labelArray) {
        olabel.font = kFont6(30);
        olabel.textColor = UIColorFromRGB(0x777777);
    }
    label.textColor = UIColorFromRGB(0xffad29);
    label.font = kFontBold6(30);
    self.currentYear = label.text;
    
    NSInteger currentIndex = [self.labelArray indexOfObject:label];
    self.scrollView.contentOffset = CGPointMake(- (SCREEN_WIDTH / 2 - (currentIndex * label.width + label.width / 2)), 0);
    
    [self netForContent];
}
@end

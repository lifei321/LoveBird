//
//  FindViewController.m
//  LoveBird
//
//  Created by ShanCheli on 2018/1/27.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "FindViewController.h"
#import "FindSelectCell.h"
#import "AppHttpManager.h"
#import "ClassifyBirdViewController.h"
#import "MJRefresh.h"
#import "FindSizeViewController.h"
#import "BirdDetailController.h"
#import "FindDao.h"
#import "ClassifyModel.h"
#import "FindBodyResultController.h"

#define kStringForFind @"kStringForFind"


@interface FindViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (nonatomic, strong) UITextField *searchField;
@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查鸟";
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self setNavigationBarColor:[UIColor whiteColor]];
    [self.rightButton setImage:[UIImage imageNamed:@"find_right"]];
    
    self.tableView.top = total_topView_height;
    [self setHeaderView];
    self.tableView.tableFooterView = self.collectionView;
    
    //默认【下拉刷新】
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netForFind)];

    [self netForData];
}
- (void)netForData {
    if ([AppCache objectForKey:kStringForFind]) {
        FindSelectDataModel *dataModel = (FindSelectDataModel *)[AppCache objectForKey:kStringForFind];
        [self.dataArray addObjectsFromArray:dataModel.data];
        [self reloadFooterHeight];
    }
    [self.tableView.mj_header beginRefreshing];
}

- (void)netForFind {
    NSDictionary *dic = @{
                          @"cmd" : @"commonBirds",
                          @"page": @"1",
                          };
    @weakify(self);
    [AppHttpManager GET:kAPI_Find_Bird parameters:dic jsonModelName:[FindSelectDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        
        [self.tableView.mj_header endRefreshing];
        [self.dataArray removeAllObjects];
        
        FindSelectDataModel *dataModel = (FindSelectDataModel *)responseObject;
        [self.dataArray addObjectsFromArray:dataModel.data];
        [self reloadFooterHeight];

        [AppCache setObject:dataModel forKey:kStringForFind];
        
    } failure:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    [AppBaseHud showHudWithLoding:self.view];
    
    @weakify(self)
    [FindDao getBird:textField.text genus:@"" successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        FindSelectBirdDataModel *dataModel = (FindSelectBirdDataModel *)responseObject;
        FindBodyResultController *bodyvc = [[FindBodyResultController alloc] init];
        bodyvc.dataModel = dataModel;
        [self.navigationController pushViewController:bodyvc animated:YES];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}

#pragma mark-- 点击
- (void)selectViewTap:(UITapGestureRecognizer *)tap {
    UIView *tapView = tap.view;
    if (tapView.tag == 100) {
        
    } else if (tapView.tag == 200) {
        // 体型查鸟
        FindSizeViewController *bodyvc = [[FindSizeViewController alloc] init];
        [self.navigationController pushViewController:bodyvc animated:YES];
        
    } else if (tapView.tag == 300) {
        
        //分类查鸟
        ClassifyBirdViewController *vc = [[ClassifyBirdViewController alloc] init];
        vc.type = FindClassTypeMu;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)reloadFooterHeight {
    CGFloat count;
    if (_dataArray.count % 2) {
        count = (_dataArray.count / 2) + 1;
    } else {
        count = (_dataArray.count / 2);
    }
    self.collectionView.height = count * AutoSize(145) + AutoSize(20);
    [self.collectionView reloadData];
}

#pragma mark- collectionView代理

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FindSelectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FindSelectCell class]) forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FindSelectModel *model = self.dataArray[indexPath.row];
    
    BirdDetailController *detailvc = [[BirdDetailController alloc] init];
    detailvc.cspCode = model.csp_code;
    [self.navigationController pushViewController:detailvc animated:YES];
}


#pragma mark-- 选择view
- (void)setHeaderView {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize(264))];
    headerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:headerView];
    
    // 搜索
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, AutoSize(5), SCREEN_WIDTH, AutoSize(128))];
    UIImageView *imgeView = [[UIImageView alloc] initWithFrame:lineView.bounds];
    imgeView.backgroundColor = [UIColor orangeColor];
    [lineView addSubview:imgeView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize(30), AutoSize(30), SCREEN_WIDTH - AutoSize(30), AutoSize(15))];
    label.text = @"让我们一起来认识鸟儿吧";
    label.font = kFont(12);
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentLeft;
    [lineView addSubview:label];
    
    _searchField = [[UITextField alloc] initWithFrame:CGRectMake(((SCREEN_WIDTH - AutoSize(255)) / 2), label.bottom + AutoSize(20), AutoSize(255), AutoSize(29))];
    _searchField.placeholder = @"输入鸟名";
    _searchField.layer.cornerRadius = _searchField.height / 2;
    _searchField.backgroundColor = [UIColor whiteColor];
    _searchField.delegate = self;
    
    CGRect frame = _searchField.frame;
    frame.size.width = AutoSize(15);// 距离左侧的距离
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    _searchField.leftViewMode = UITextFieldViewModeAlways;
    _searchField.leftView = leftview;
    
    CGRect rightframe = _searchField.frame;
    rightframe.size.width = AutoSize(35);// 距离左侧的距离
    UIImageView *rightview = [[UIImageView alloc] initWithFrame:rightframe];
    rightview.image = [UIImage imageNamed:@"blue_search"];
    rightview.contentMode = UIViewContentModeCenter;
    _searchField.rightViewMode = UITextFieldViewModeAlways;
    _searchField.rightView = rightview;
    [lineView addSubview:_searchField];
    
    rightview.userInteractionEnabled = YES;
    
    
    [headerView addSubview:lineView];
    
    // 选择
    UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, lineView.bottom + AutoSize(5), SCREEN_WIDTH, AutoSize(81))];
    selectView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:selectView];
    
    CGFloat left = AutoSize(33);
    CGFloat width = AutoSize(50);
    CGFloat space = (SCREEN_WIDTH - width *3 - left * 2) / 2;
    
    UIView *view1 = [self makeImageViewWithFrame:CGRectMake(left, 0, width, selectView.height) image:@"pic_checkbird" text:@"图片查鸟" sel:@selector(selectViewTap:)];
    UIView *view2 = [self makeImageViewWithFrame:CGRectMake(view1.right + space, 0, width, selectView.height) image:@"shap_checkbird" text:@"体型查鸟" sel:@selector(selectViewTap:)];
    UIView *view3 = [self makeImageViewWithFrame:CGRectMake(view2.right + space, 0, width, selectView.height) image:@"classify_checkbird" text:@"分类查鸟" sel:@selector(selectViewTap:)];
    view1.tag = 100;
    view2.tag = 200;
    view3.tag = 300;
    [selectView addSubview:view1];
    [selectView addSubview:view2];
    [selectView addSubview:view3];
    
    // 常见鸟种
    UIView *textView = [self makeTextViewWithFrame:CGRectMake(0, selectView.bottom, SCREEN_WIDTH, AutoSize(45))];
    [headerView addSubview:textView];
    
    self.tableView.tableHeaderView = headerView;
}

- (UIView *)makeImageViewWithFrame:(CGRect)frame image:(NSString *)image text:(NSString *)text sel:(SEL)action {
    UIView *backView = [[UIView alloc] initWithFrame:frame];
    backView.userInteractionEnabled = YES;
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, AutoSize(13), backView.width, AutoSize(36))];
    view.image = [UIImage imageNamed:image];
    view.contentMode = UIViewContentModeCenter;
    view.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, view.bottom, backView.width, AutoSize(27))];
    label.text = text;
    label.font = kFont(11);
    label.textColor = kColorTextColor7f7f7f;
    label.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:label];
    
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:action];
    [backView addGestureRecognizer:tap];
    [backView addSubview:view];
    
    return backView;
}

- (UIView *)makeTextViewWithFrame:(CGRect)frame {
    UIView *textView = [[UIView alloc] initWithFrame:frame];
    textView.backgroundColor = [UIColor clearColor];
    
    CGFloat width = (SCREEN_WIDTH - AutoSize(78) - AutoSize(20)) / 2;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width + AutoSize(10), 0, AutoSize(78), textView.height)];
    label.text = @"常见鸟种";
    label.textColor = kColorTextColor333333;
    label.font = kFont(14);
    label.textAlignment = NSTextAlignmentCenter;
    [textView addSubview:label];
    
    UIView *lineleft = [[UIView alloc] init];
    lineleft.left = AutoSize(10);
    lineleft.centerY = label.centerY;
    lineleft.width = (SCREEN_WIDTH - AutoSize(78) - AutoSize(20)) / 2;
    lineleft.height = 1;
    lineleft.backgroundColor = UIColorFromRGB(0xd2d2d2);
    [textView addSubview:lineleft];
    
    UIView *lineRight = [[UIView alloc] init];
    lineRight.left = label.right;
    lineRight.centerY = lineleft.centerY;
    lineRight.width = (SCREEN_WIDTH - AutoSize(78) - AutoSize(20)) / 2;
    lineRight.height = 1;
    lineRight.backgroundColor = UIColorFromRGB(0xd2d2d2);
    [textView addSubview:lineRight];
    return textView;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.itemSize = CGSizeMake(AutoSize(148), AutoSize(135));
        flowLayout.minimumInteritemSpacing = AutoSize(0);
        flowLayout.minimumLineSpacing = AutoSize(10);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, AutoSize(10), 0, AutoSize(10));

        ///header 和footer 的高度
        flowLayout.headerReferenceSize = CGSizeZero;
        flowLayout.footerReferenceSize = CGSizeZero;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, AutoSize(0)) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);//上移64

        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[FindSelectCell class] forCellWithReuseIdentifier:NSStringFromClass([FindSelectCell class])];
    }
    return _collectionView;
}



- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}



@end

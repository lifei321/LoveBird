//
//  PublishSelectBirdController.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/13.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "PublishSelectBirdController.h"
#import "PublishSelectBirdCell.h"
#import "FindSelectBirdModel.h"
#import "FindDao.h"


@interface PublishSelectBirdController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *searchField;

@property (nonatomic, strong) AppBaseTableDataSource *viewSource;

@property (nonatomic, strong) FindSelectBirdModel *selectBirdModel;

@end

@implementation PublishSelectBirdController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setSearchView];
    [self setTableView];
    
    if (self.selectArray.count) {
        [self.selectArray removeLastObject];
        NSMutableArray *tempArray = [NSMutableArray new];
        for (FindSelectBirdModel *model in self.selectArray) {
            AppBaseCellModel *cellModel = [[AppBaseCellModel alloc] init];
            cellModel.userInfo = model;
            [tempArray addObject:cellModel];
        }
        [self.viewSource.tableListArray addObject:tempArray];
        [self.tableView reloadData];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    [AppBaseHud showHudWithLoding:self.view];
    @weakify(self)
    [FindDao getBird:textField.text genus:@"" successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        FindSelectBirdDataModel *dataModel = (FindSelectBirdDataModel *)responseObject;
        [self.viewSource.tableListArray removeAllObjects];
        
        NSMutableArray *tempArray = [NSMutableArray new];
        for (FindSelectBirdModel *model in dataModel.data) {
            AppBaseCellModel *cellModel = [[AppBaseCellModel alloc] init];
            cellModel.userInfo = model;
            [tempArray addObject:cellModel];
        }
        [self.viewSource.tableListArray removeAllObjects];
        [self.viewSource.tableListArray addObject:tempArray];
        [self.tableView reloadData];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AutoSize6(130);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AppBaseCellModel *cellModel = self.viewSource.tableListArray[0][indexPath.row];
    FindSelectBirdModel *bridModel = (FindSelectBirdModel *)cellModel.userInfo;
//    if (self.selectBirdModel == bridModel) {
//        return;
//    }
//
//    for (AppBaseCellModel *cellmodel in self.viewSource.tableListArray[0]) {
//        if (cellmodel.isSelect) {
//            cellmodel.isSelect = NO;
//            break;
//        }
//    }
//    self.selectBirdModel = bridModel;
//    cellModel.isSelect = YES;
//    [self.tableView reloadData];
    
    if (bridModel) {
        if (self.viewControllerActionBlock) {
            self.viewControllerActionBlock(self, bridModel);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-- UI
- (void)setNavigation {
    self.navigationItem.title = @"选择鸟种";
//    self.rightButton.title = @"完成";
//    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateNormal];
//    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateHighlighted];
    
}

- (void)rightButtonAction {
    if (self.selectBirdModel) {
        if (self.viewControllerActionBlock) {
            self.viewControllerActionBlock(self, self.selectBirdModel);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setTableView {
    
    self.tableView.top = total_topView_height + AutoSize6(96);
    self.tableView.height = SCREEN_HEIGHT - total_topView_height - AutoSize6(96);
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.viewSource = [[AppBaseTableDataSource alloc] init];
    [self registerClass:[PublishSelectBirdCell class] forCellReuseIdentifier:NSStringFromClass([PublishSelectBirdCell class]) dataSource:self.viewSource];
}

- (void)setSearchView {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, total_topView_height, SCREEN_WIDTH, AutoSize6(96))];
    backView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:backView];
    
    _searchField = [[UITextField alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(15), SCREEN_WIDTH - AutoSize6(60), AutoSize6(66))];
    _searchField.placeholder = @"搜索";
    _searchField.delegate = self;
    _searchField.layer.cornerRadius = 5;
    _searchField.backgroundColor = [UIColor whiteColor];
    
    CGRect leftframe = _searchField.frame;
    leftframe.size.width = AutoSize6(70);// 距离左侧的距离
    UIImageView *leftview = [[UIImageView alloc] initWithFrame:leftframe];
    leftview.image = [UIImage imageNamed:@"pub_search"];
    leftview.contentMode = UIViewContentModeCenter;
    _searchField.leftViewMode = UITextFieldViewModeAlways;
    _searchField.leftView = leftview;
    [backView addSubview:_searchField];
}

@end

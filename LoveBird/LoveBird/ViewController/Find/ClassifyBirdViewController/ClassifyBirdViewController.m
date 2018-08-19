//
//  ClassifyBirdViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/3/18.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "ClassifyBirdViewController.h"
#import "ClassifyModel.h"
#import "FindDao.h"
#import "FindClassCell.h"
#import "FindBodyResultController.h"

@interface ClassifyBirdViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) UITextField *searchField;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation ClassifyBirdViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        _dataArray = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setSearchView];
    [self setTabelview];
    [self netForClassBird];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FindClassCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FindClassCell class]) forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AutoSize6(104);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ClassifyModel *model = self.dataArray[indexPath.row];
    
    if (self.type == FindClassTypeMu) {
        ClassifyBirdViewController *classvc = [[ClassifyBirdViewController alloc] init];
        classvc.type = FindClassTypeKe;
        classvc.subject = model.subject;
        [self.navigationController pushViewController:classvc animated:YES];
    } else if (self.type == FindClassTypeKe) {
        ClassifyBirdViewController *classvc = [[ClassifyBirdViewController alloc] init];
        classvc.type = FindClassTypeShu;
        classvc.family = model.family;
        [self.navigationController pushViewController:classvc animated:YES];
    } else if (self.type == FindClassTypeShu) {
        
        [AppBaseHud showHudWithLoding:self.view];
        @weakify(self)
        [FindDao getBird:@"" genus:model.genus successBlock:^(__kindof AppBaseModel *responseObject) {
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

- (void)netForClassBird {
    
    [AppBaseHud showHudWithLoding:self.view];
    @weakify(self);
    [FindDao getBirdClass:self.type
                   family:self.family
                  subject:self.subject
             successBlock:^(__kindof AppBaseModel *responseObject) {
                @strongify(self);
                [AppBaseHud hideHud:self.view];
                ClassifyDataModel *dataModel = (ClassifyDataModel *)responseObject;
                [self.dataArray addObjectsFromArray:dataModel.data];
                [self.tableView reloadData];
                
            } failureBlock:^(__kindof AppBaseModel *error) {
                @strongify(self);
                [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}


- (void)setSearchView {
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, total_topView_height, SCREEN_WIDTH, AutoSize(44))];
    searchView.backgroundColor = self.tableView.backgroundColor;
    [self.view addSubview:searchView];
    
    _searchField = [[UITextField alloc] initWithFrame:CGRectMake(AutoSize(14), ((searchView.height - AutoSize(27)) / 2), SCREEN_WIDTH - AutoSize(27), AutoSize(27))];
    _searchField.placeholder = @"";
    _searchField.backgroundColor = [UIColor whiteColor];
    _searchField.delegate = self;
    
    CGRect frame = _searchField.frame;
    frame.size.width = AutoSize(15);// 距离左侧的距离
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    _searchField.leftViewMode = UITextFieldViewModeAlways;
    _searchField.leftView = leftview;

    [searchView addSubview:_searchField];
}

- (void)setTabelview {
    self.tableView.top = AutoSize(44) + topView_height;
    [self.tableView registerClass:[FindClassCell class] forCellReuseIdentifier:NSStringFromClass([FindClassCell class])];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(100))];
}

- (void)setNavigation {
    
    if (self.type == FindClassTypeMu) {
        self.title = @"目";
    } else if (self.type == FindClassTypeKe) {
        self.title = @"科";
    } else if (self.type == FindClassTypeShu) {
        self.title = @"属";
    }
}



@end

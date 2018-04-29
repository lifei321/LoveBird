//
//  ClassifyBirdViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/3/18.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "ClassifyBirdViewController.h"
#import "ClassifyModel.h"
#import "AppHttpManager.h"

@interface ClassifyBirdViewController ()<UITableViewDelegate, UITableViewDataSource>

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
    
    self.title = @"目";
    [self setSearchView];
    [self setTabelview];
    [self netForClassBird];
}

- (void)netForClassBird {
    
    NSDictionary *dic = @{
                          
                          };
    @weakify(self);
    [AppHttpManager POST:kAPI_Find_Bird_family parameters:dic jsonModelName:[ClassifyDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        
        [self.dataArray removeAllObjects];
        
//        FindSelectDataModel *dataModel = (FindSelectDataModel *)responseObject;
//        [self.dataArray addObjectsFromArray:dataModel.data];
//        [self reloadFooterHeight];
//
//        [AppCache setObject:dataModel forKey:kStringForFind];
        
    } failure:^(__kindof AppBaseModel *error) {
        @strongify(self);
        
    }];
}


- (void)setSearchView {
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, total_topView_height, SCREEN_WIDTH, AutoSize(44))];
    searchView.backgroundColor = self.tableView.backgroundColor;
    [self.view addSubview:searchView];
    
    _searchField = [[UITextField alloc] initWithFrame:CGRectMake(AutoSize(14), ((searchView.height - AutoSize(27)) / 2), SCREEN_WIDTH - AutoSize(27), AutoSize(27))];
    _searchField.placeholder = @"搜索";
    _searchField.backgroundColor = [UIColor whiteColor];
    
    CGRect frame = _searchField.frame;
    frame.size.width = AutoSize(15);// 距离左侧的距离
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    _searchField.leftViewMode = UITextFieldViewModeAlways;
    _searchField.leftView = leftview;

    [searchView addSubview:_searchField];
}

- (void)setTabelview {
    self.tableView.top = AutoSize(44) + topView_height;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.layer.cornerRadius = 3;
    ClassifyModel *model = _dataArray[indexPath.row];
    cell.textLabel.text = model.family;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AutoSize(41);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}


@end

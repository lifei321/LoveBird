//
//  PublishViewController.m
//  LoveBird
//
//  Created by ShanCheli on 2018/1/27.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "PublishViewController.h"
#import "PublishHeaderView.h"
#import "PublishSelectCell.h"
#import "PublishDetailCell.h"
#import "PublishDetailModel.h"
#import "PublishFooterView.h"
#import "PublishDao.h"
#import "PublishCell.h"
#import "PublishEditModel.h"
#import "PublishContenController.h"
#import "ApplyTimePickerView.h"
#import "PublishBirdInfoModel.h"
#import "PublishEVController.h"
#import "PublishEVModel.h"
#import "PublishSelectBirdController.h"
#import "FindSelectBirdModel.h"
#import "AppDateManager.h"
#import "WPhotoViewController.h"

@interface PublishViewController ()<UITableViewDataSource, PublishFooterViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PublishCellDelegate, PublishSelectDelegate>

// tableview数据源
@property (nonatomic, strong) NSMutableArray *dataArray;

// 保存选择的图片或者文字
@property (nonatomic, strong) NSMutableArray *dataModelArray;

// 鸟种
@property (nonatomic, strong) NSMutableArray *birdInfoArray;

@property (nonatomic, strong) PublishHeaderView *headerView;

@property (nonatomic, strong) PublishFooterView *footerView;

// 显示添加 的model
@property (nonatomic, strong) PublishEditModel *selectEditModel;

// 生态环境
@property (nonatomic, strong) PublishEVModel *selectEVModel;

// 选择的时间
@property (nonatomic, copy) NSString *selectTime;

@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigation];
    [self setTableView];
    [self setModels];
}

#pragma mark-- 发布

- (void)rightButtonAction {
    [AppBaseHud showHudWithLoding:self.view];
    @weakify(self);
    [PublishDao publish:self.dataModelArray
               birdInfo:self.birdInfoArray
                   evId:self.selectEVModel.evId
               loaction:@""
                   time:self.selectTime
                 status:@""
                  title:self.headerView.textField.text
           successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud showHudWithSuccessful:@"发布成功" view:self.view];
        [self.dataArray removeAllObjects];
        self.dataArray = nil;
        [self.dataModelArray removeAllObjects];
        self.dataModelArray = nil;
        [self.birdInfoArray removeAllObjects];
        self.birdInfoArray = nil;
        
        [self reloadHeaderView];
        [self reloadFooterView:NO];
        [self setModels];
        [self.tableView reloadData];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}

#pragma mark-- tableview代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        PublishSelectCell *scell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PublishSelectCell class]) forIndexPath:indexPath];
        scell.selectModel = self.dataArray[indexPath.section][indexPath.row];
        scell.delegate = self;
        cell = scell;
    } else if (indexPath.section == 1) {
        PublishDetailCell *dcell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PublishDetailCell class]) forIndexPath:indexPath];
        dcell.detailModel = self.dataArray[indexPath.section][indexPath.row];
        cell = dcell;
    } else {
        PublishCell *dcell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PublishCell class]) forIndexPath:indexPath];
        PublishEditModel *model = self.dataArray[indexPath.section][indexPath.row];
        
        model.isLast = NO;
        model.isFirst = NO;
        
        // 判断首行 和 尾行
        if (self.dataModelArray.count == 3) {
            if (indexPath.row == 1) {
                model.isFirst = YES;
                model.isLast = YES;
            }
        } else if (self.dataModelArray.count == 5){
            if (indexPath.row == 1) {
                model.isFirst = YES;
                model.isLast = NO;
            } else if (indexPath.row == 3) {
                model.isLast = YES;
                model.isFirst = NO;
            }
        } else {
            if (indexPath.row == 1) {
                model.isFirst = YES;
                model.isLast = NO;
            } else if (indexPath.row == (self.dataModelArray.count - 2)) {
                model.isLast = YES;
                model.isFirst = NO;
            }
        }
        dcell.editModel = model;
        dcell.delegate = self;
        cell = dcell;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 选择鸟种
    if (indexPath.section == 0) {
        PublishSelectBirdController *selvc = [[PublishSelectBirdController alloc] init];

        if (indexPath.row == (self.birdInfoArray.count - 1)) { // 添加鸟种
            @weakify(self);
            selvc.viewControllerActionBlock = ^(UIViewController *viewController, NSObject *userInfo) {
                @strongify(self);
                FindSelectBirdModel *model = self.birdInfoArray.lastObject;
                model.count++;
                
                FindSelectBirdModel *birdModel = (FindSelectBirdModel *)userInfo;
                birdModel.isSelect = NO;
                birdModel.count = 1;
                [self.birdInfoArray insertObject:birdModel atIndex:0];
                [self.tableView reloadData];
            };
        }
//        else { // 选择鸟名
//            @weakify(self);
//            selvc.viewControllerActionBlock = ^(UIViewController *viewController, NSObject *userInfo) {
//                @strongify(self);
//                FindSelectBirdModel *birdSeleModel = (FindSelectBirdModel *)userInfo;
//
//                FindSelectBirdModel *birdModel = self.birdInfoArray[indexPath.row];
//                birdSeleModel.isSelect = birdModel.isSelect;
//                birdSeleModel.count = birdModel.count;
//                birdModel = birdSeleModel;
//                [self.tableView reloadData];
//            };
//        }
        [self.navigationController pushViewController:selvc animated:YES];
        return;
    }
    
    // 选择日期
    if ((indexPath.section == 1) && (indexPath.row == 0)) {
        ApplyTimePickerView *pickerView = [[ApplyTimePickerView alloc] initWithFrame:self.view.bounds];
        @weakify(self)
        pickerView.handler = ^(ApplyTimePickerView *timePickerView, NSString *date) {
            @strongify(self)
            [timePickerView removeFromSuperview];
            timePickerView = nil;
            if (date.length) {
                self.selectTime = date;
                PublishDetailModel *model = self.dataArray[indexPath.section][indexPath.row];
                model.detailString = date;
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
            }
        };
        [self.view addSubview:pickerView];
        return;
    }
    
    // 生态环境
    if ((indexPath.section == 1) && (indexPath.row == 2)) {
        PublishEVController *evvc = [[PublishEVController alloc] init];
        evvc.selectEVModel = self.selectEVModel;
        @weakify(self);
        evvc.viewControllerActionBlock = ^(UIViewController *viewController, NSObject *userInfo) {
            @strongify(self);
            self.selectEVModel = (PublishEVModel *)userInfo;
            
            PublishDetailModel *model = self.dataArray[indexPath.section][indexPath.row];
            model.detailString = self.selectEVModel.name;
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:evvc animated:YES];
        return;
    }
    
    if (indexPath.section == 2) {
        PublishEditModel *model = self.dataModelArray[indexPath.row];
        if (model.message.length) { // 如果是文字类型的可编辑
            PublishContenController *contentVC = [[PublishContenController alloc] init];
            contentVC.text = model.message;
            
            @weakify(self);
            @weakify(model);
            contentVC.contentblock = ^(NSString *contentString) {
                @strongify(self);
                @strongify(model);
                // 设置数据
                model.message = contentString;
                
                [self.tableView reloadData];
            };
            [self.navigationController pushViewController:contentVC animated:YES];
        }
        
        return;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return AutoSize6(112);
    }
    
    if (indexPath.section == 1) {
        if (self.birdInfoArray.count > 1) {
            return AutoSize6(95);
        } else {
            return 0;
        }
    }
    
    if (indexPath.section == 2) {
        PublishEditModel *model = self.dataArray[indexPath.section][indexPath.row];
        if (model.isAddShowTextAndImageView) {
            return AutoSize6(84);
        }
        
        if (model.isAddType) {
            return AutoSize6(74);
        }
        
        return AutoSize6(274);
    }
    
    return 0;
}

#pragma mark-- 选择鸟种cell的代理

// 减少鸟的数量
- (void)publishSelectCellLessDelegate:(PublishSelectCell *)cell {
    
    FindSelectBirdModel *model = cell.selectModel;
    model.count --;
}

// 添加鸟种 添加鸟的数量
- (void)publishSelectCellAddDelegate:(PublishSelectCell *)cell {
    
    if (cell.selectModel.isSelect) {
        FindSelectBirdModel *model = self.birdInfoArray.lastObject;
        model.count++;
        
        FindSelectBirdModel *modeladd = [[FindSelectBirdModel alloc] init];
        modeladd.name = @"选择鸟种";
        modeladd.isSelect = NO;
        modeladd.count = 1;
        [self.birdInfoArray insertObject:modeladd atIndex:0];
        [self.tableView reloadData];
    } else {
        FindSelectBirdModel *model = cell.selectModel;
        model.count ++;
    }
}

// 删除鸟种 这一行
- (void)publishSelectCellDeleteDelegate:(PublishSelectCell *)cell {
    
    FindSelectBirdModel *model = self.birdInfoArray.lastObject;
    model.count--;
    
    [self.birdInfoArray removeObject:cell.selectModel];
    [self.tableView reloadData];
    
}

#pragma mark-- PublishCell 顺序变化 和 删减

// 删除这一行
- (void)publishCellCloseDelegate:(PublishCell *)cell  {
    
    if (self.dataModelArray.count == 3) {
        [self.dataModelArray removeAllObjects];
        [self reloadFooterView:NO];
    } else {
        NSInteger index = 0;
        for (int i = 0; i < self.dataModelArray.count; i++ ) {
            if (cell.editModel == self.dataModelArray[i]) {
                index = i;
                break;
            }
        }
        [self.dataModelArray removeObjectAtIndex:(index - 1)];
        [self.dataModelArray removeObjectAtIndex:(index - 1)];
        [self.dataModelArray removeObjectAtIndex:(index - 1)];
        [self.dataModelArray insertObject:[self getAddTypeCellModel] atIndex:(index - 1)];
    }
    [self.tableView reloadData];
}

// 上移
- (void)publishCellUpDelegate:(PublishCell *)cell {
    
    if (self.dataModelArray.count == 3) return;
    NSInteger index = [self getIndexWithModel:cell.editModel];
    if (index == 1) {
        return;
    }
    
    [self.dataModelArray exchangeObjectAtIndex:index withObjectAtIndex:(index - 2)];
    [self.tableView reloadData];
}

// 下移
- (void)publishCellDownDelegate:(PublishCell *)cell {
    if (self.dataModelArray.count == 3) return;
    NSInteger index = [self getIndexWithModel:cell.editModel];
    if (index == (self.dataModelArray.count - 2)) {
        return;
    }
    
    [self.dataModelArray exchangeObjectAtIndex:index withObjectAtIndex:(index + 2)];
    [self.tableView reloadData];

}

// 获取index
- (NSInteger)getIndexWithModel:(PublishEditModel *)model {
    NSInteger index = 0;
    for (int i = 0; i < self.dataModelArray.count; i++ ) {
        if (model == self.dataModelArray[i]) {
            index = i;
            break;
        }
    }
    return index;
}

#pragma mark-- 添加 文字和图片cell 的代理

// 添加文字
- (void)publishCellTextDelegate:(PublishCell *)cell {
    [self textViewClickDelegate:cell.editModel];
}

// 添加图片
- (void)publishCellImageDelegate:(PublishCell *)cell {
    [self imageViewClickDelegate:cell.editModel];
}

// 加号点击  显示添加文字和图片的view
- (void)publishCellAddDelegate:(PublishCell *)cell {
    
    if (self.dataModelArray.count == 3) {
        for (PublishEditModel *editModel in self.dataModelArray) {
            if (editModel.isAddShowTextAndImageView) {
                editModel.isAddShowTextAndImageView = NO;
                editModel.isAddType = YES;
            }
        }
    }
    
    PublishEditModel *model = cell.editModel;
    model.isAddShowTextAndImageView = YES;
    model.isAddType = NO;

    [self.tableView reloadData];
}


#pragma mark-- footerview  添加 文字 代理
- (void)textViewClickDelegate:(PublishEditModel *)model {
    PublishContenController *contentvc = [[PublishContenController alloc] init];
    @weakify(self);
    @weakify(model);
    contentvc.contentblock = ^(NSString *contentString) {
        @strongify(self);
        @strongify(model);
        // 设置数据
        
        // 内容cell
        PublishEditModel *modeladd = [[PublishEditModel alloc] init];
        modeladd.message = contentString;
        modeladd.isImg = NO;
        [self addCell:modeladd selectModel:model];
        
        [self reloadFooterView:YES];
        [self.tableView reloadData];
    };
    contentvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:contentvc animated:YES];
}

- (void)addCell:(PublishEditModel *)model selectModel:(PublishEditModel *)selectModel {
    if (!selectModel) {
        [self.dataModelArray addObject:[self getAddTypeCellModel]];
        [self.dataModelArray addObject:model];
        [self.dataModelArray addObject:[self getAddTypeCellModel]];
    } else {
        NSInteger index = 0;
        for (int i = 0; i < self.dataModelArray.count; i++ ) {
            if (selectModel == self.dataModelArray[i]) {
                index = i;
                break;
            }
        }
        [self.dataModelArray insertObject:[self getAddTypeCellModel] atIndex:(index + 1)];
        [self.dataModelArray insertObject:model atIndex:(index + 2)];
        [self.dataModelArray insertObject:[self getAddTypeCellModel] atIndex:(index + 3)];
        [self.dataModelArray removeObject:selectModel];
    }
}

// 获取一个加号model
- (PublishEditModel *)getAddTypeCellModel {
    PublishEditModel *modeladd = [[PublishEditModel alloc] init];
    modeladd.isAddShowTextAndImageView = NO;
    modeladd.isImg = NO;
    modeladd.isAddType = YES;
    return modeladd;
}

#pragma mark-- footerview 添加 图片 的代理
- (void)imageViewClickDelegate:(PublishEditModel *)model {
    self.selectEditModel = model;
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"选择照片"
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"拍照", @"相册", nil];
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {//相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self makePhoto];
        } else {
            [self showAlert];
        }
    } else if (buttonIndex == 1) {//相片
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            [self choosePicture];
        } else {
            [self showAlert];
        }
    }
}

- (void)showAlert {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请在设置-->隐私-->相机，中开启本应用的相机访问权限！！" delegate:self
                                         cancelButtonTitle:@"取消"
                                         otherButtonTitles:@"我知道了", nil];
    [alert show];
}

//跳转到imagePicker里
- (void)makePhoto {
    
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
}
        
//跳转到相册
- (void)choosePicture {
    WPhotoViewController *WphotoVC = [[WPhotoViewController alloc] init];
    //选择图片的最大数
    WphotoVC.selectPhotoOfMax = 8;
    @weakify(self);
    [WphotoVC setSelectPhotosBack:^(NSMutableArray *phostsArr) {
        @strongify(self);
        for (NSDictionary *dic in phostsArr) {
            [self upLoadImage:[dic objectForKey:@"image"]];
        }
    }];
    [self presentViewController:WphotoVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    UIImage *iamge = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self upLoadImage:iamge];
}

// 上传照片
- (void)upLoadImage:(UIImage *)image {
    [AppBaseHud showHudWithLoding:self.view];
    @weakify(self);
    [PublishDao upLoad:image successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        if (self.headerView.headerImageView.image == nil) {
            self.headerView.headerImageView.image = image;
        }
        
        self.selectEditModel.isAddShowTextAndImageView = NO;
        PublishUpModel *upModel = (PublishUpModel *)responseObject;
        
        
        // 设置数据
        PublishEditModel *model = [[PublishEditModel alloc] init];
        model.isAddShowTextAndImageView = NO;
        model.isImg = YES;
        model.imgUrl = upModel.imgUrl;
        model.aid = upModel.aid;
        model.isNewAid = YES;
        [self addCell:model selectModel:self.selectEditModel];

        [self reloadFooterView:YES];
        [self.tableView reloadData];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        
        [AppBaseHud showHud:error.errstr view:self.view];
    }];
}

#pragma mark-- 刷新footer
- (void)reloadFooterView:(BOOL)isHide {
    if (isHide) {
        self.footerView = nil;
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(50))];
    } else {
        self.footerView = [[PublishFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(200))];
        self.footerView.delegate = self;
        self.tableView.tableFooterView = self.footerView;
    }
}

- (void)reloadHeaderView {
    self.headerView = nil;
    self.headerView = [[PublishHeaderView alloc] init];
    self.tableView.tableHeaderView = nil;
    self.tableView.tableHeaderView = self.headerView;
}


#pragma mark-- UI
- (void)setNavigation {
    self.navigationItem.title = @"编辑";
    self.rightButton.title = @"完成";
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateNormal];
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateHighlighted];

    [self.leftButton setImage:[UIImage imageNamed:@"nav_close_black"]];
}

- (void)leftButtonAction {
    if (self.viewControllerActionBlock) {
        self.viewControllerActionBlock(self, nil);
    }
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
- (void)setTableView {
    
    self.tableView.top = total_topView_height;
    self.tableView.height = SCREEN_HEIGHT - total_topView_height;
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[PublishSelectCell class] forCellReuseIdentifier:NSStringFromClass([PublishSelectCell class])];
    [self.tableView registerClass:[PublishDetailCell class] forCellReuseIdentifier:NSStringFromClass([PublishDetailCell class])];
    [self.tableView registerClass:[PublishCell class] forCellReuseIdentifier:NSStringFromClass([PublishCell class])];
    
    [self reloadHeaderView];
    [self reloadFooterView:NO];
}

- (void)setModels {
    self.dataArray = [[NSMutableArray alloc] init];
    
    self.birdInfoArray = [[NSMutableArray alloc] init];
    FindSelectBirdModel *model01 = [[FindSelectBirdModel alloc] init];
    model01.name = @"选择鸟种";
    model01.isSelect = YES;
    model01.count = 0;
    [self.birdInfoArray addObject:model01];
    [self.dataArray addObject:self.birdInfoArray];
    
    //
    NSMutableArray *array2 = [[NSMutableArray alloc] init];
    PublishDetailModel *model1 = [[PublishDetailModel alloc] init];
    model1.title = @"时间";
    model1.detailString = @"选择";
    [array2 addObject:model1];
    
    PublishDetailModel *model2 = [[PublishDetailModel alloc] init];
    model2.title = @"位置";
    model2.detailString = @"选择";
    [array2 addObject:model2];
    
    PublishDetailModel *model3 = [[PublishDetailModel alloc] init];
    model3.title = @"生境";
    model3.detailString = @"选择";
    [array2 addObject:model3];
    [self.dataArray addObject:array2];
    
    self.dataModelArray = [[NSMutableArray alloc] init];
    [self.dataArray addObject:self.dataModelArray];
    
    self.selectTime = [[AppDateManager shareManager] getDateWithNSDate:[NSDate date] formatSytle:DateFormatYMD];

}

@end

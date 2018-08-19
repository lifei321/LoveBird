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
#import "UIImage+Addition.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "PublishMapViewController.h"

typedef void(^PublishUploadBlock)(NSInteger index, NSArray *selectImageArray);


@interface PublishViewController ()<UITableViewDataSource, PublishFooterViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PublishCellDelegate, PublishSelectDelegate>

// tableview数据源
@property (nonatomic, strong) NSMutableArray *dataArray;

// 保存选择的图片或者文字
@property (nonatomic, strong) NSMutableArray *dataModelArray;



@property (nonatomic, strong) PublishHeaderView *headerView;

@property (nonatomic, strong) PublishFooterView *footerView;

// 显示添加 的model
@property (nonatomic, strong) PublishEditModel *selectEditModel;


// 生态环境
@property (nonatomic, strong) PublishEVModel *selectEVModel;

// 选择的时间
@property (nonatomic, copy) NSString *selectTime;

// 上传图片用
@property (nonatomic, strong) NSMutableArray *uploadArray;

@property (nonatomic, copy) NSString *lng;

@property (nonatomic, copy) NSString *lat;

@property (nonatomic, copy) NSString *locale;


@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadView) name:kPublishReloadHeaderNotification object:nil];
    
    [self setNavigation];
    [self setTableView];
    [self setModels];
}

- (void)reloadView {
    [self.tableView reloadData];
}

#pragma mark-- 发布

- (void)publish {
    
    if (!self.headerView.textField.text.length) {
        [AppBaseHud showHudWithfail:@"请输入标题" view:self.view];
        return;
    }
    
    if (!self.dataModelArray.count && !self.birdInfoArray.count) {
        [AppBaseHud showHudWithfail:@"请选择鸟种或添加文字、图片" view:self.view];
        return;
    }
    
    [AppBaseHud showHudWithLoding:self.view];
    
    PublishEditModel *selectModel = [self.headerView getFengmian];
    
    @weakify(self);
    [PublishDao publish:self.dataModelArray
               birdInfo:self.birdInfoArray
                   evId:self.selectEVModel.evId
               loaction:self.locale
                    lat:self.lat
                    lng:self.lng
                   time:self.selectTime
                 status:self.status
                  title:self.headerView.textField.text
                  imgId:selectModel.aid
                 imgUrl:selectModel.imgUrl
                matchid:self.matchid
                    tid:self.tid
           successBlock:^(__kindof AppBaseModel *responseObject) {
               @strongify(self);
               
               if (self.status.length) {
                   [AppBaseHud showHudWithSuccessful:@"保存成功" view:self.view];
               } else {
                   [AppBaseHud showHudWithSuccessful:@"发布成功" view:self.view];
               }
               //               [self.dataArray removeAllObjects];
               //               self.dataArray = nil;
               //               [self.dataModelArray removeAllObjects];
               //               self.dataModelArray = nil;
               //               [self.birdInfoArray removeAllObjects];
               //               self.birdInfoArray = nil;
               //
               //               [self reloadHeaderView];
               //               [self reloadFooterView:NO];
               //               [self setModels];
               //               [self.tableView reloadData];
               [super leftButtonAction];
               
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

        if (indexPath.row == (self.birdInfoArray.count - 1)) { // 添加鸟种
            [self addBird];
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
    
    if ((indexPath.section == 1) && (indexPath.row == 1)) {
        
        PublishMapViewController *mapvc = [[PublishMapViewController alloc] init];
        
        @weakify(self);
        mapvc.viewControllerActionBlock = ^(UIViewController *viewController, NSObject *userInfo) {
            
            @strongify(self);
            
            NSDictionary *dic = (NSDictionary *)userInfo;
            self.lng = [dic objectForKey:@"lng"];
            self.lat = [dic objectForKey:@"lat"];
            self.locale = [dic objectForKey:@"locale"];
            PublishDetailModel *model = self.dataArray[indexPath.section][indexPath.row];
            model.detailString = self.locale;
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:mapvc animated:YES];
        
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
            return AutoSize6(84);
        }
        
        return AutoSize6(274);
    }
    
    return 0;
}

- (void)addBird {
    PublishSelectBirdController *selvc = [[PublishSelectBirdController alloc] init];
    selvc.selectArray = [NSMutableArray arrayWithArray:self.birdInfoArray];
    @weakify(self);
    selvc.viewControllerActionBlock = ^(UIViewController *viewController, NSObject *userInfo) {
        @strongify(self);
        FindSelectBirdModel *model = self.birdInfoArray.lastObject;
        model.num++;
        
        FindSelectBirdModel *birdModel = (FindSelectBirdModel *)userInfo;
        birdModel.isSelect = NO;
        birdModel.num = 1;
        [self.birdInfoArray insertObject:birdModel atIndex:0];
        [self setDateAndAddress];
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:selvc animated:YES];
}

- (void)setDateAndAddress {
    // 时间 地址
    NSString *date = [[AppDateManager shareManager] getCurrentDateWithFormatStyle:DateFormatYMD];
    PublishDetailModel *dateModel = self.dataArray[1][0];
    if ([dateModel.detailString isEqualToString:@"选择"]) {
        self.selectTime = date;
        dateModel.detailString = date;
    }
}

#pragma mark-- 选择鸟种cell的代理

// 减少鸟的数量
- (void)publishSelectCellLessDelegate:(PublishSelectCell *)cell {
    
    FindSelectBirdModel *model = cell.selectModel;
    model.num --;
}

// 添加鸟种 添加鸟的数量
- (void)publishSelectCellAddDelegate:(PublishSelectCell *)cell {
    
    if (cell.selectModel.isSelect) {
        FindSelectBirdModel *model = self.birdInfoArray.lastObject;
        model.num++;
        
        FindSelectBirdModel *modeladd = [[FindSelectBirdModel alloc] init];
        modeladd.name = @"点击选择鸟种";
        modeladd.isSelect = NO;
        modeladd.num = 1;
        [self.birdInfoArray insertObject:modeladd atIndex:0];
        [self.tableView reloadData];
    } else {
        FindSelectBirdModel *model = cell.selectModel;
        model.num ++;
    }
}

// 删除鸟种 这一行
- (void)publishSelectCellDeleteDelegate:(PublishSelectCell *)cell {
    
    FindSelectBirdModel *model = self.birdInfoArray.lastObject;
    model.num--;
    
    [self.birdInfoArray removeObject:cell.selectModel];
    [self.tableView reloadData];
    
}

// 添加鸟种
- (void)publishCellAddBirdDelegate:(PublishCell *)cell selectModel:(FindSelectBirdModel *)selectModel {
    if (self.birdInfoArray.count) {
        for (FindSelectBirdModel *birdModel in self.birdInfoArray) {
            if ([birdModel.csp_code isEqualToString:selectModel.csp_code]) {
                return;
            }
        }
    }

    selectModel.num = 1;
    [self.birdInfoArray insertObject:selectModel atIndex:0];
    [self setDateAndAddress];
    [self.tableView reloadData];
    
    // cell 的model填充
    PublishEditModel *editModel = cell.editModel;
    for (PublishEditModel *dataModel in self.dataModelArray) {
        if ([dataModel.imgUrl isEqualToString:editModel.imgUrl]) {
            dataModel.imgTag = editModel.imgTag;
            dataModel.csp_code = editModel.csp_code;
            break;
        }
    }
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
    
    for (PublishEditModel *editModel in self.dataModelArray) {
        if (editModel.isAddShowTextAndImageView) {
            editModel.isAddShowTextAndImageView = NO;
            editModel.isAddType = YES;
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
    if (self.dataModelArray.count == 0) {
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
        
        if (selectModel.isAddShowTextAndImageView) {
            [self.dataModelArray insertObject:[self getAddTypeCellModel] atIndex:(index + 1)];
            [self.dataModelArray insertObject:model atIndex:(index + 2)];
            [self.dataModelArray insertObject:[self getAddTypeCellModel] atIndex:(index + 3)];
            [self.dataModelArray removeObject:selectModel];

        } else {
            [self.dataModelArray insertObject:model atIndex:(index + 2)];
            [self.dataModelArray insertObject:[self getAddTypeCellModel] atIndex:(index + 3)];
        }
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
    WphotoVC.selectPhotoOfMax = 9;
    @weakify(self);
    [WphotoVC setSelectPhotosBack:^(NSMutableArray *phostsArr) {
        @strongify(self);
        
        NSDictionary *dic = phostsArr.firstObject;
        self.uploadArray = [NSMutableArray arrayWithArray:phostsArr];
        [self.uploadArray removeObjectAtIndex:0];
        [self upLoadImage:[dic objectForKey:@"image"]];
        
        
//        NSOperationQueue *queue=[[NSOperationQueue alloc] init];
//        queue.maxConcurrentOperationCount = 1;
//
//        NSMutableArray *tempArray = [NSMutableArray new];
//
//        @strongify(self);
//        for (NSDictionary *dic in phostsArr) {
//
//            //创建操作
//            NSBlockOperation *operation1=[NSBlockOperation blockOperationWithBlock:^(){
//                [self upLoadImage:[dic objectForKey:@"image"]];
//            }];
//            if (tempArray.count == 0) {
//                [tempArray addObject:operation1];
//            } else {
//                NSOperation *lastOperation = tempArray.lastObject;
//                [operation1 addDependency:lastOperation];
//                [tempArray addObject:operation1];
//            }
//
//            //将操作添加到队列中去
//            [queue addOperation:operation1];
//        }
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
    dispatch_async(dispatch_get_main_queue(), ^{
        [AppBaseHud showHudWithLoding:self.view];
    });
    
    UIImage *selectImage = [image compressImage:image withMaxSize:CGSizeMake(1200, MAXFLOAT)];
    
    @weakify(self);
    [PublishDao upLoad:selectImage successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [self.headerView setImage:selectImage];
        
        PublishUpModel *upModel = (PublishUpModel *)responseObject;
        
        // 图片存本地
        NSString* strUrl = upModel.imgUrl;
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        NSString* key = [manager cacheKeyForURL:[NSURL URLWithString:strUrl]];
        SDImageCache* cache = [SDImageCache sharedImageCache];
        [cache storeImage:selectImage forKey:key completion:nil];
        
        
        // 设置数据
        PublishEditModel *model = [[PublishEditModel alloc] init];
        model.isImg = YES;
        model.imgUrl = upModel.imgUrl;
        model.aid = upModel.aid;
        model.isNewAid = YES;
        [self addCell:model selectModel:self.selectEditModel];
        self.selectEditModel = model;
        
        // 封面数组
        [self.headerView.choosePhotoArr addObject:model];
        
        if (self.uploadArray.count) {
            NSDictionary *dic = self.uploadArray.firstObject;
            [self.uploadArray removeObjectAtIndex:0];
            [self upLoadImage:[dic objectForKey:@"image"]];
            
        } else {
            [self reloadFooterView:YES];
            [self.tableView reloadData];
            [AppBaseHud hideHud:self.view];
        }

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

    if (self.isModal) {
        [self.leftButton setImage:[UIImage imageNamed:@"nav_close_black"]];
    } else {
        [self.leftButton setImage:[UIImage imageNamed:@"nav_back_black"]];
    }
}

- (void)rightButtonAction {
    self.status = nil;
    [self publish];
}

- (void)leftButtonAction {

    AppAlertView *alertView = [[AppAlertView alloc] initWithTitle:@"" message:@"请选择退出方式？" cancelButtonTitle:@"放弃" otherButtonTitles:@"存草稿", nil];
    alertView.onDismissBlock = ^(NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            [super leftButtonAction];
        } else if (buttonIndex == 1) {
            self.status = @"4";
            [self publish];
        }
    };
    [alertView show];
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
    model01.name = @"点击选择鸟种";
    model01.isSelect = YES;
    model01.num = 0;
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

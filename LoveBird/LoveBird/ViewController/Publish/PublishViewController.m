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

@interface PublishViewController ()<UITableViewDataSource, PublishFooterViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) PublishHeaderView *headerView;

@property (nonatomic, strong) PublishFooterView *footerView;

@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigation];
    [self setTableView];
    [self setModels];
}

- (void)setNavigation {
    self.title = @"编辑";
    self.rightButton.title = @"完成";
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(36)} forState:UIControlStateNormal];
}

- (void)setTableView {
    
    self.tableView.top = total_topView_height;
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[PublishSelectCell class] forCellReuseIdentifier:NSStringFromClass([PublishSelectCell class])];
    [self.tableView registerClass:[PublishDetailCell class] forCellReuseIdentifier:NSStringFromClass([PublishDetailCell class])];

    self.headerView = [[PublishHeaderView alloc] init];
    self.tableView.tableHeaderView = self.headerView;
    
    self.footerView = [[PublishFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(166))];
    self.footerView.delegate = self;
    self.tableView.tableFooterView = self.footerView;
}

- (void)setModels {
    self.dataArray = [[NSMutableArray alloc] init];
    
    NSArray *array1 = @[@"选择鸟种"];
    [self.dataArray addObject:array1];
    
    //
    NSMutableArray *array2 = [[NSMutableArray alloc] init];
    PublishDetailModel *model1 = [[PublishDetailModel alloc] init];
    model1.title = @"时间";
    model1.detailString = @"2017-09-13";
    [array2 addObject:model1];
    
    PublishDetailModel *model2 = [[PublishDetailModel alloc] init];
    model2.title = @"位置";
    model2.detailString = @"北京市海淀区";
    [array2 addObject:model2];
    
    PublishDetailModel *model3 = [[PublishDetailModel alloc] init];
    model3.title = @"生境";
    model3.detailString = @"选择";
    [array2 addObject:model3];
    [self.dataArray addObject:array2];
}

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
        scell.titleText = self.dataArray[indexPath.section][indexPath.row];
        cell = scell;
    } else if (indexPath.section == 1) {
        PublishDetailCell *dcell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PublishDetailCell class]) forIndexPath:indexPath];
        dcell.detailModel = self.dataArray[indexPath.section][indexPath.row];
        cell = dcell;
    }
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return AutoSize6(112);
    }
    
    if (indexPath.section == 1) {
        return AutoSize6(95);
    }
    
    return 0.01f;
}

#pragma mark-- footerview 代理
- (void)textViewClickDelegate {
    
}

- (void)imageViewClickDelegate {
    
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
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请在设置-->隐私-->相机，中开启本应用的相机访问权限！！" delegate:self
                                                 cancelButtonTitle:@"取消"
                                                 otherButtonTitles:@"我知道了", nil];
            [alert show];
        }
    } else if (buttonIndex == 1) {//相片
            
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                
            [self choosePicture];
        } else {
                
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请在设置-->隐私-->照片，中开启本应用的相机访问权限！！"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"我知道了", nil];
                [alert show];
        }
    }
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
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerController.delegate = self;
    pickerController.allowsEditing = YES;
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    UIImage *iamge = [info objectForKey:UIImagePickerControllerEditedImage];
    @weakify(self);
    [PublishDao upLoad:iamge successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        self.headerView.headerImageView.image = iamge;
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        
    }];
}

@end

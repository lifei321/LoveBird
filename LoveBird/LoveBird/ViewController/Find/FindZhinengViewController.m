//
//  FindZhinengViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/8/12.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "FindZhinengViewController.h"
#import "FindResultCell.h"
#import "BirdDetailController.h"
#import "FindDao.h"
#import "FindzhinengModel.h"
#import "WPhotoViewController.h"
#import "UIImage+Addition.h"

@interface FindZhinengViewController ()<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIView *tipView;

@property (nonatomic, strong) UIView *loadingView;


@end

@implementation FindZhinengViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"图片查鸟";
//    self.rightButton.title = @"完成";
//    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateNormal];
//    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateHighlighted];
    
    
    [self setTableView];
    
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(500))];
    headerView.image = [UIImage imageNamed:@"placeHolder"];
    self.tableView.tableHeaderView = headerView;
    
    
    self.tipView = [[UIView alloc] initWithFrame:CGRectMake(0, AutoSize6(520) + total_topView_height, SCREEN_WIDTH, self.view.height - AutoSize6(520) - total_topView_height)];
    self.tipView.backgroundColor = [UIColor whiteColor];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, AutoSize6(200), SCREEN_WIDTH, AutoSize6(50))];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    NSString *placeString = @"这里包含鸟类数据达";
    NSString *countString = @"1400";
    NSString *mailString = @"多种";
    NSString *textString = [NSString stringWithFormat:@"%@%@%@", placeString, countString, mailString];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:textString];
    [attrString addAttribute:NSForegroundColorAttributeName value:kColorTextColor7f7f7f range:NSMakeRange(0, placeString.length)];
    [attrString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xeb6877) range:NSMakeRange(placeString.length, countString.length)];
    [attrString addAttribute:NSForegroundColorAttributeName value:kColorTextColor7f7f7f range:NSMakeRange(placeString.length + countString.length, mailString.length)];
    [attrString addAttribute:NSFontAttributeName value:kFont6(40) range:NSMakeRange(0, textString.length)];
    tipLabel.attributedText = attrString;
    [self.tipView addSubview:tipLabel];
    
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, tipLabel.bottom + AutoSize6(20), SCREEN_WIDTH, tipLabel.height)];
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    bottomLabel.font = kFont6(40);
    bottomLabel.textColor = kColorTextColor7f7f7f;
    bottomLabel.text = @"快点来认识他们吧!";
    [self.tipView addSubview:bottomLabel];
    
    [self.view addSubview:self.tipView];
    [self.view bringSubviewToFront:self.tipView];
    
    
    self.loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, AutoSize6(520) + total_topView_height, SCREEN_WIDTH, self.view.height - AutoSize6(520) - total_topView_height)];
    self.loadingView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.loadingView];
    [self.view bringSubviewToFront:self.loadingView];
    
    UILabel *loadLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, tipLabel.bottom + AutoSize6(20), SCREEN_WIDTH, tipLabel.height)];
    loadLabel.textAlignment = NSTextAlignmentCenter;
    loadLabel.font = kFont6(40);
    loadLabel.textColor = kColorTextColor7f7f7f;
    loadLabel.text = @"正在识别，请稍等...";
    [self.loadingView addSubview:loadLabel];

    self.loadingView.hidden = YES;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.height - AutoSize6(146), AutoSize6(425), AutoSize6(88))];
    button.backgroundColor = kColorDefaultColor;
    button.layer.cornerRadius = button.height / 2;
    button.centerX = self.view.centerX;
    [button setTitle:@"上传图片" forState:UIControlStateNormal];
    button.titleLabel.font = kFont6(30);
    [button addTarget:self action:@selector(buttonDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [self.view bringSubviewToFront:button];
    
    
}

- (void)buttonDidClick {
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
    WphotoVC.selectPhotoOfMax = 1;
    @weakify(self);
    [WphotoVC setSelectPhotosBack:^(NSMutableArray *phostsArr) {
        @strongify(self);
        
        NSDictionary *dic = phostsArr.firstObject;

        [self netForData:[dic objectForKey:@"image"]];
        
    }];
    [self presentViewController:WphotoVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    UIImage *iamge = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self netForData:iamge];
}

- (void)netForData:(UIImage *)image {
    [AppBaseHud showHudWithLoding:self.view];
    self.loadingView.hidden = NO;
    self.tipView.hidden = YES;
    @weakify(self);
    [FindDao getBirdImage:image successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        
        FindzhinengDataModel *dataModel = (FindzhinengDataModel *)responseObject;
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:dataModel.data];
        if (self.dataArray.count) {
            [self.tableView reloadData];
            self.tipView.hidden = YES;
            self.loadingView.hidden = YES;
        } else {
            self.tipView.hidden = NO;
            self.loadingView.hidden = YES;
        }
        
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
        self.tipView.hidden = NO;
        self.loadingView.hidden = YES;

    }];
}


#pragma mark-- tabelView 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FindResultCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FindResultCell class]) forIndexPath:indexPath];
    cell.zhinengModel = self.dataArray[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return AutoSize6(130);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)setTableView {
    
    self.tableView.top = topView_height;
    self.tableView.height = SCREEN_HEIGHT - topView_height;
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01f)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[FindResultCell class] forCellReuseIdentifier:NSStringFromClass([FindResultCell class])];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(200))];
}




@end

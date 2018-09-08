//
//  MineQRViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/9/8.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MineQRViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MineQRViewController ()

@property (nonatomic, strong) UIImageView *codeImageView;

@end

@implementation MineQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的二维码";
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(AutoSize6(85), total_topView_height + AutoSize6(84), SCREEN_WIDTH - AutoSize6(170), AutoSize6(776))];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    UIImageView *headIcon = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize6(85), AutoSize6(50), AutoSize6(100), AutoSize6(100))];
    headIcon.clipsToBounds  = YES;
    headIcon.layer.cornerRadius = 5;
    [headIcon sd_setImageWithURL:[NSURL URLWithString:[UserPage sharedInstance].userModel.head] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    [backView addSubview:headIcon];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(headIcon.right + AutoSize6(30), headIcon.top, SCREEN_WIDTH / 2, headIcon.height / 2)];
    nameLabel.textColor = kColorTextColor333333;
    nameLabel.font = kFontPF6(30);
    [backView addSubview:nameLabel];
    nameLabel.text = [UserPage sharedInstance].userModel.username;
    
    UILabel *sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.left, nameLabel.bottom, SCREEN_WIDTH / 2, headIcon.height / 2)];
    sexLabel.textColor = kColorTextColor333333;
    sexLabel.font = kFontPF6(30);
    [backView addSubview:sexLabel];
    sexLabel.text = [UserPage sharedInstance].userModel.gender;

    _codeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(headIcon.left, headIcon.bottom + AutoSize6(50), AutoSize6(410), AutoSize6(410))];
    [self creatCode];
    [backView addSubview:_codeImageView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, AutoSize6(90), AutoSize6(90))];
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 3;
    imageView.image = [UIImage imageNamed:@"icon"];
    [_codeImageView addSubview:imageView];
    imageView.center = CGPointMake(_codeImageView.width / 2, _codeImageView.width / 2);
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _codeImageView.bottom + AutoSize6(46), backView.width, AutoSize6(50))];
    titleLabel.textColor = UIColorFromRGB(0x7f7f7f);
    titleLabel.font = kFontPF6(30);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:titleLabel];
    titleLabel.text = @"扫描上面二维码图案";
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.left, titleLabel.bottom, titleLabel.width, AutoSize6(50))];
    contentLabel.textColor = UIColorFromRGB(0x7f7f7f);
    contentLabel.font = kFontPF6(30);
    contentLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:contentLabel];
    contentLabel.text = @"关注爱鸟网";
    
    
    UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, backView.bottom + AutoSize6(100), SCREEN_WIDTH, AutoSize6(50))];
    shareLabel.textColor = UIColorFromRGB(0x7f7f7f);
    shareLabel.font = kFontPF6(30);
    shareLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:shareLabel];
    shareLabel.text = @"分享二维码到";

    // 第三方登录按钮
    UIView * thirdView = [self makeThirdViewWithFrame:CGRectMake(0, shareLabel.bottom + AutoSize6(40), self.view.width, AutoSize(48))];
    [self.view addSubview:thirdView];
}

- (UIView *)makeThirdViewWithFrame:(CGRect)frame {
    
    UIView *backView = [[UIView alloc] initWithFrame:frame];
    
    CGFloat space = AutoSize6(120);
    CGFloat width = frame.size.height;
    CGFloat x = (self.view.width - width * 2 - space * 1) / 2;
    
    UIButton *wechat = [self makeButton:@"weixin" frame:CGRectMake(x, 0, width, width) tag:1000];
//    UIButton *qq = [self makeButton:@"qq" frame:CGRectMake(wechat.right + space, 0, width, width) tag:1002];
    UIButton *weibo = [self makeButton:@"weibo" frame:CGRectMake(wechat.right + space, 0, width, width) tag:1001];
    
    [backView addSubview:wechat];
//    [backView addSubview:qq];
    [backView addSubview:weibo];
    return backView;
}

- (UIButton *)makeButton:(NSString *)image frame:(CGRect)frame tag:(NSInteger)tag {
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.tag = tag;
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(thirdLoginDidClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}


#pragma mark- 第三方登录
- (void)thirdLoginDidClick:(UIButton *)button {
    
    NSInteger tag = button.tag - 1000 ;
    
    [AppShareManager shareWithTitle:[UserPage sharedInstance].userModel.shareTitle
                            summary:[UserPage sharedInstance].userModel.shareSummary
                                url:[UserPage sharedInstance].userModel.shareUrl
                              image:[UserPage sharedInstance].userModel.shareImg
                          shareType:tag];
    
}


- (void)creatCode {
    // 1.创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认设置
    [filter setDefaults];
    
    // 3.设置数据
    NSString *info = [UserPage sharedInstance].userModel.QRcodeUrl;
    NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:infoData forKeyPath:@"inputMessage"];
    
    // 4.生成二维码
    CIImage *outputImage = [filter outputImage];
    _codeImageView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:_codeImageView.width];
}

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));

    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);

    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


@end

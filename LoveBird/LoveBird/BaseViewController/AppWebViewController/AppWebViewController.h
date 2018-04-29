//
//  AppWebViewController.h
//  LoveBird
//
//  Created by ShanCheli on 2017/6/27.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppBaseViewController.h"
#import "LFWKWebView.h"
#import "NJKWebViewProgressView.h"



/**
 *  带一个UIWebview的ViewController
 */
@interface AppWebViewController : AppBaseViewController<LFWebViewDelegate>


@property (strong, nonatomic) LFWKWebView *webView;

/**
 *  进度条（暴露出来方便自定义进度条的属性，如：颜色／高度等）
 */
@property (strong, nonatomic) NJKWebViewProgressView *progressView;

/**
 *  需要加载的WebView的String类型URL地址
 */
@property (copy, nonatomic) NSString *startupUrlString;

/**
 *  url
 */
@property (nonatomic, strong) NSURL *url;

/**
 *  固定 title,如果存在则不改变 title
 */
@property (nonatomic, strong) NSString *fixedTitle;

/**
 *  关闭按钮
 */
@property (strong, nonatomic) UIBarButtonItem *closeButton;

/**
 * 模态窗口关闭图标
 */
@property (strong, nonatomic) UIImage *closeImage;


/**
 * 返回图标
 */
@property (strong, nonatomic) UIImage *blackImage;

/**
 *  打开URL
 *
 */
- (void)loadURL:(NSURL *)url;

/**
 *  present该VC的时候带有UINavigationBar
 *
 */
- (UINavigationController *)parentNavigationController;

/**
 *  左侧按钮
 */
- (void)updateNaviLeftButtton;



@end

//
//  AppWebViewController.m
//  LoveBird
//
//  Created by ShanCheli on 2017/6/27.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppWebViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>


#define kDefaultProgress 0.11

@interface AppWebViewController ()<LFWebViewDelegate>

@property (assign, nonatomic) BOOL isFinish;

@end

@implementation AppWebViewController{
    
    // 记录是否第一次加载了
    BOOL _isFirstLoad;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.fixedTitle ? : @"正在加载";
    
    if (self.isModal) {
        self.leftButton.image = (self.closeImage)?self.closeImage:[UIImage imageNamed:@"nav_close_black"];
    } else {
        self.leftButton.image = (self.blackImage)?self.blackImage:[UIImage imageNamed:@"nav_back_black"];
    }
    
    @weakify(self);
    [RACObserve(self.webView, canGoBack) subscribeNext:^(id x) {
        @strongify(self);
        [self updateNaviLeftButtton];
    }];

    // 添加观察者，观察网页进度条
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    // 动态更改title
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 如果有导航栏则需要减去64高，如果有tabbar的高度需要减去，也必需在viewWillAppear方法中去实现
    if (self.navigationController.navigationBarHidden == NO ) {
        
        self.webView.height = SCREEN_HEIGHT - 64;
    }
    
    self.progressView.progressBarView.height = 2.f;
    self.progressView.progressBarView.backgroundColor = UIColorFromRGB(0x574ef2);

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (_url && _isFirstLoad == NO) {
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_url];
        [self.webView loadRequest:request];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.progressView removeFromSuperview];
    self.progressView = nil;
}

- (void)setBlackImage:(UIImage *)blackImage {
    _blackImage = blackImage;
}

- (void)setCloseImage:(UIImage *)closeImage {
    _closeImage = closeImage;
}

#pragma mark - URLs

- (void)loadURL:(NSURL *)url {
    self.url = url;
}

- (void)setStartupUrlString:(NSString *)startupUrlString {
    [self loadURL:[NSURL URLWithString:startupUrlString]];
}

#pragma mark - Getter

- (LFWKWebView *)webView {
    
    if (_webView == nil) {
        _webView = [[LFWKWebView alloc] initWithFrame:CGRectZero];
        _webView.controllerDelegate = self;
    }
    return _webView;
}

/**
 *  进度条
 */
- (NJKWebViewProgressView *)progressView {
    if (_progressView == nil) {
        CGFloat progressBarHeight = 1.f;
        CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
        CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
        _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
        _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _progressView.progressBarView.backgroundColor = UIColorFromRGB(0x3bee8a);
        _progressView.alpha = 0.0;
        [_progressView setProgress:kDefaultProgress];
        [self.navigationController.navigationBar addSubview:_progressView];
        
    }
    return _progressView;
}

#pragma mark - NAVI

- (UINavigationController *)parentNavigationController {
    UINavigationController *navController = self.navigationController;
    
    if (!navController) {
        navController = [[UINavigationController alloc]initWithRootViewController:self];
    }
    
    return navController;
}

/**
 *  左侧按钮
 */
- (void)updateNaviLeftButtton {
    NSMutableArray *itemsArray = [NSMutableArray array];
    
    if (self.navigationItem.leftBarButtonItem) {
        [itemsArray addObject:self.leftButton];
    }
    
    
    self.leftButton.image = (self.blackImage)?self.blackImage:[UIImage imageNamed:@"nav_back_black"];
    if ([self.webView canGoBack]) {
        [itemsArray addObject:self.closeButton];
    }
    
//    if (self.isModal) {
//        if ([self.webView.realWebView canGoBack]) {
//            [itemsArray addObject:self.closeButton];
//            self.leftButton.image = (self.blackImage)?self.blackImage:[UIImage imageNamed:@"nav_back_black"];
//        } else {
//            self.leftButton.image = (self.closeImage)?self.closeImage:[UIImage imageNamed:@"nav_close_black"];
//        }
//    } else {
//        self.leftButton.image = (self.blackImage)?self.blackImage:[UIImage imageNamed:@"nav_back_black"];
//    }
    
    // 使用animated设置的话，动画结束前，重新设置的话，会使点击失效
    [self.navigationItem setLeftBarButtonItems:itemsArray];
}

#pragma mark - Setters & Getters

/**
 *  跳转多层，添加类似微信的 关闭按钮
 */
- (UIBarButtonItem *)closeButton {
    if (!_closeButton) {
        _closeButton = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeButtonPressed:)];
    }
    
    return _closeButton;
}

#pragma mark - Actions

- (void)leftButtonAction {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        [self closeButtonPressed:nil];
    }
}


- (void)closeButtonPressed:(UIButton *)sender {
    if ([self isModal]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UIWebViewDelegate

- (BOOL)lftwebView:(LFWKWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"===%@", request.URL);
//    if ([BJXYRoutes canOpenURL:request.URL]) {
//        [BJXYRoutes openURL:request.URL target:self callback:nil];
//        return NO;
//    }
    
    return YES;
}

- (void)lftwebViewDidStartLoad:(LFWKWebView *)webView {
    
    //添加进度条
    self.progressView.alpha = 1.0;
    
    // 记录控制器已经加载了一次,下次进入页面时就不再加载页面了
    _isFirstLoad = YES;
    NSLog(@"webview开始加载 %@", webView.URL);
}

- (void)lftwebViewDidFinishLoad:(LFWKWebView *)webView {
    
    _url = webView.URL;
    _isFinish = YES;
    [self updateNaviLeftButtton];
}

- (void)lftwebView:(LFWKWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [self updateNaviLeftButtton];
    NSLog(@"webview加载失败－－－%@",error);
}


/**
 *  网页进度条观察者（WKWeb／UIWeb 共同监测estimatedProgress 设置进度条的变化）
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    // 处理title
    if ([keyPath isEqualToString:@"title"]) {
        if (_fixedTitle != nil) {
            self.navigationItem.title = _fixedTitle;
            return;
        }
        
        self.navigationItem.title = change[@"new"];
        return;
    }
    
    if ([keyPath isEqualToString:@"estimatedProgress"] && object == self.webView) {
        
        [self.progressView setAlpha:1.0f];
        
        CGFloat newValue = [change[@"new"] floatValue];
        if (kDefaultProgress < newValue) {
            [self.progressView setProgress:newValue animated:YES];
            NSLog(@"进度条－－－－－－%f", newValue);
        } else {
            [self.progressView setProgress:kDefaultProgress animated:YES];
        }
        if(self.webView.estimatedProgress >= 1.0f) {
            
            [UIView animateWithDuration:0.25 animations:^{
                
                [self.progressView setAlpha:0];
                
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0 animated:NO];
            }];
        }
    } else {
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    
    if (_webView != nil) {
        
        [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
        [self.webView removeObserver:self forKeyPath:@"title"];
    }
}




@end

//
//  LFWKWebView.h
//  LoveBird
//
//  Created by cheli shan on 2018/4/27.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Utils.h"
#import <WebKit/WebKit.h>


@class LFWKWebView;
@protocol LFWebViewDelegate <NSObject>

@optional

/**
 *  开始加载
 */
- (void)lfwebViewDidStartLoad:(WKWebView *)webView;

/**
 *  加载完成
 */
- (void)lfwebViewDidFinishLoad:(WKWebView *)webView;

/**
 *  加载失败
 */
- (void)lfwebView:(WKWebView *)webView didFailLoadWithError:(NSError *)error;

/**
 *  是否加载网络请求
 *
 *  @param webView        当前webView对象
 *  @param request        触发的网络请求
 *  @param navigationType 触发加载网络请求的原因类型
 *
 *  @return               返回Yes加载，否则不加载
 */
- (BOOL)lfwebView:(LFWKWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(WKNavigationType)navigationType;

/**
 * 获取连接NSHTTPURLResponse
 *
 * @param webView  当前webView对象
 * @param response 获取的NSHTTPURLResponse
 */
- (void)lfwebView:(LFWKWebView *)webView getResponse:(NSHTTPURLResponse *)response;

@end

@interface LFWKWebView : WKWebView<WKNavigationDelegate, WKUIDelegate>

/**
 *  代理方法
 */
@property (nonatomic, weak) id<LFWebViewDelegate> controllerDelegate;

/**
 *  是否根据视图大小来缩放页面
 */
@property (nonatomic, assign) BOOL scalesPageToFit;

- (void)loadRequest:(NSURLRequest *)request;

/**
 *  将文件copy到tmp目录（wk打开本地网页的解决方法 8.0）wkwebview8.0系统，不支持加载本地html页面，所以需要用以下方法修复！！
 *
 *  @param path   文件的原始路径
 *
 *  @return NSURL copy后代表文件的NSURL
 */
- (NSURL *)fileURLForBuggyWKWebView8:(NSString *)path;

/**
 * 获取 js cookie
 */
+ (NSString *)getJSCookieString;

@end

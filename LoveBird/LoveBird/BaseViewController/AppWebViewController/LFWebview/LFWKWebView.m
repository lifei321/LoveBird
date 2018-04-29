//
//  LFWKWebView.m
//  LoveBird
//
//  Created by cheli shan on 2018/4/27.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "LFWKWebView.h"

@implementation LFWKWebView

- (instancetype)initWithFrame:(CGRect)frame {
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.preferences = [WKPreferences new];
    configuration.userContentController = [WKUserContentController new];
    // 解决内存泄漏
    configuration.selectionGranularity = WKSelectionGranularityCharacter;
    
    self = [super initWithFrame:frame configuration:configuration];
    if (self) {
        
        self.UIDelegate = self;
        self.navigationDelegate = self;
        
        //        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
    }
    return self;
}

- (void)loadRequest:(NSURLRequest *)request {
    
    NSMutableURLRequest *requestNew = [NSMutableURLRequest requestWithURL:request.URL];
    [requestNew addValue:[LFWKWebView readCurrentCookie:request.URL] forHTTPHeaderField:@"Cookie"];
    [super loadRequest:requestNew];
}


/**
 *  判断当前加载的url是否是WKWebView不能打开的协议类型
 */
- (BOOL)isLoadingWKWebViewDisableScheme:(NSURL *)url {
    
    BOOL retValue = NO;
    
    //判断是否正在加载WKWebview不能识别的协议类型：phone numbers, email address, maps, etc.
    if(![url.scheme isEqualToString:@"http"] && ![url.scheme isEqualToString:@"https"]) {
        UIApplication *app = [UIApplication sharedApplication];
        if ([app canOpenURL:url]) {
            [app openURL:url];
            retValue = YES;
        }
    }
    
    return retValue;
}

/**
 *  是否根据视图大小来缩放页面  默认为YES set方法
 */
- (void)setScalesPageToFit:(BOOL)scalesPageToFit {
    
    if (scalesPageToFit == NO) {
        return ;
    }
    
    NSString *jScript = @"var meta = document.createElement('meta'); \
    meta.name = 'viewport'; \
    meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'; \
    var head = document.getElementsByTagName('head')[0];\
    head.appendChild(meta);";
    
    if(scalesPageToFit) {
        
        WKUserScript *wkUScript = [[NSClassFromString(@"WKUserScript") alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
        [self.configuration.userContentController addUserScript:wkUScript];
    } else {
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:self.configuration.userContentController.userScripts];
        for (WKUserScript *wkUScript in array) {
            
            if([wkUScript.source isEqual:jScript]) {
                
                [array removeObject:wkUScript];
                break;
            }
        }
        for (WKUserScript *wkUScript in array) {
            
            [self.configuration.userContentController addUserScript:wkUScript];
        }
    }
}

/**
 * 获取 js cookie
 */
+ (NSString *)getJSCookieString {
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    //js函数
    NSString *JSFuncString =
    @"function setCookie(name,value,expires)\
    {\
    var oDate=new Date();\
    oDate.setDate(oDate.getDate()+expires);\
    document.cookie=name+'='+value+';expires='+oDate+';path=/'\
    }\
    function getCookie(name)\
    {\
    var arr = document.cookie.match(new RegExp('(^| )'+name+'=([^;]*)(;|$)'));\
    if(arr != null) return unescape(arr[2]); return null;\
    }\
    function delCookie(name)\
    {\
    var exp = new Date();\
    exp.setTime(exp.getTime() - 1);\
    var cval=getCookie(name);\
    if(cval!=null) document.cookie= name + '='+cval+';expires='+exp.toGMTString();\
    }";
    
    //拼凑js字符串
    NSMutableString *JSCookieString = JSFuncString.mutableCopy;
    for (NSHTTPCookie *cookie in cookieStorage.cookies) {
        NSString *excuteJSString = [NSString stringWithFormat:@"setCookie('%@', '%@', 1);", cookie.name, cookie.value];
        [JSCookieString appendString:excuteJSString];
    }
    
    return JSCookieString;
}

/**
 *  打开本地网页
 */
- (void)loadLocalPath:(NSString *)path {
    
    if(path){
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
            
            NSURL *fileURL = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@",path]];
            [self loadRequest:[NSURLRequest requestWithURL:fileURL]];
            
        } else {
            
            NSURL *fileURL = [self fileURLForBuggyWKWebView8:path];
            NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
            [self loadRequest:request];
        }
    }
}


#pragma mark -- WKWebview  WKNavigationDelegate代理方法

/**
 *  发生请求前是否允许跳转
 *  @param webView          实现该代理的webview
 *  @param navigationAction 当前navigation(导航)
 *  @param decisionHandler  decisionHandler是一个block 决定是否跳转block 两个枚举类型，取消／允许
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    BOOL respondsToSelector = [_controllerDelegate respondsToSelector:@selector(lfwebView:shouldStartLoadWithRequest:navigationType:)];
    BOOL resultBOOL = YES;
    if (respondsToSelector) {
        resultBOOL = [_controllerDelegate lfwebView:webView shouldStartLoadWithRequest:navigationAction.request navigationType:navigationAction.navigationType];
    }
    
    BOOL isLoadingDisableScheme = [self isLoadingWKWebViewDisableScheme:navigationAction.request.URL];
    
    // 解决10.3.1 crash
    NSURL *url = navigationAction.request.URL;
    if([[url scheme] isEqualToString:@"wvjbscheme"]){
        return;
    }
    
    if(resultBOOL && !isLoadingDisableScheme) {
        
        //        self.currentRequest = navigationAction.request;
        if(navigationAction.targetFrame == nil) {
            [webView loadRequest:navigationAction.request];
        }
        decisionHandler(WKNavigationActionPolicyAllow);
    } else {
        
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    
}

/**
 *  开始加载页面
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    if ([_controllerDelegate respondsToSelector:@selector(lfwebViewDidStartLoad:)]) {
        [_controllerDelegate lfwebViewDidStartLoad:webView];
    }
}

/**
 *  wkwebview 加载完成
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    //    if ([_controllerDelegate respondsToSelector:@selector(lfwebViewDidFinishLoad:)]) {
    //        [_controllerDelegate lfwebViewDidFinishLoad:webView];
    //    }
    //    [webView evaluateJavaScript:[LFWebView getJSCookieString] completionHandler:nil];
}

/**
 *  wkwebview 加载失败
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError: (NSError *)error {
    
    if ([_controllerDelegate respondsToSelector:@selector(lfwebView:didFailLoadWithError:)]) {
        [_controllerDelegate lfwebView:webView didFailLoadWithError:error];
    }
}

/**
 *  wkwebview 加载失败
 */
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError: (NSError *)error {
    
    if ([_controllerDelegate respondsToSelector:@selector(lfwebView:didFailLoadWithError:)]) {
        [_controllerDelegate lfwebView:webView didFailLoadWithError:error];
    }
}

/**
 *  接收到服务器响应后决定是否允许跳转
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
    
    if ([_controllerDelegate respondsToSelector:@selector(lfwebView:getResponse:)]) {
        [_controllerDelegate lfwebView:webView getResponse:response];
    }
    NSArray *cookies =[NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:response.URL];
    
    for (NSHTTPCookie *cookie in cookies) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }
    
    // 不对200做特殊判断，通一允许请求
    decisionHandler(WKNavigationResponsePolicyAllow);
}


- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
    [webView evaluateJavaScript:[LFWKWebView getJSCookieString] completionHandler:nil];
    if ([_controllerDelegate respondsToSelector:@selector(lfwebViewDidFinishLoad:)]) {
        [_controllerDelegate lfwebViewDidFinishLoad:webView];
    }
}

#pragma mark other

/**
 *  获取 cookie
 */
+ (NSString *)readCurrentCookie:(NSURL *)url {
    
    NSMutableArray *cookieArray = [NSMutableArray new];
    NSString *domain = [NSString stringWithFormat:@"%@://%@",url.scheme, url.host];
    NSArray *cookieJar = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:domain]];
    
    for (NSHTTPCookie *cookie in cookieJar) {
        [cookieArray addObject:[NSString stringWithFormat:@"%@=%@", cookie.name, cookie.value]];
        
    }
    return [cookieArray componentsJoinedByString:@";"];
}

#pragma mark 解决 wxwebview alert 不弹出的问题 需要实现下边三个代理

/**
 *  解决 wxwebview alert 不弹出的问题
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    [AppAlertView simpleAlertWithTitle:@"提示" message:message onDismiss:^(NSInteger buttonIndex) {
        completionHandler();
    }];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    //    DLOG(@"msg = %@ frmae = %@",message,frame);
    
    [AppAlertView questionAlertWithTitle:@"提示" message:message onDismiss:^(NSInteger buttonIndex) {
        completionHandler(buttonIndex);
    }];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIViewController currentViewController] presentViewController:alertController animated:YES completion:nil];
        });
    });
    
}

#pragma mark --（wk打开本地网页的解决方法）

/**
 *  将文件copy到tmp目录（wk打开本地网页的解决方法 8.0）wkwebview8.0系统，不支持加载本地html页面，所以需要用以下方法修复！！
 *
 *  @return NSURL
 */
- (NSURL *)fileURLForBuggyWKWebView8:(NSString *)path {
    
    NSURL *fileURL = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@", path]];
    
    NSError *error = nil;
    if (!fileURL.fileURL || ![fileURL checkResourceIsReachableAndReturnError:&error]) {
        return nil;
    }
    // Create "/temp/www" directory
    NSFileManager *fileManager= [NSFileManager defaultManager];
    NSURL *temDirURL = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:@"www"];
    [fileManager createDirectoryAtURL:temDirURL withIntermediateDirectories:YES attributes:nil error:&error];
    
    // 取到本地html后的锚点
    NSString *lastPathComponent = [[fileURL.absoluteString componentsSeparatedByString:@"/"] lastObject];
    
    NSURL *dstURL = [NSURL URLWithString:[temDirURL.absoluteString stringByAppendingString:lastPathComponent]];
    // Now copy given file to the temp directory
    [fileManager removeItemAtURL:dstURL error:&error];
    [fileManager copyItemAtURL:fileURL toURL:dstURL error:&error];
    // Files in "/temp/www" load flawlesly :)
    return dstURL;
}

/**
 *  释放
 */
- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end

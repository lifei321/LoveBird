//
//  WKWebViewJavascriptBridge+LF.m
//  LoveBird
//
//  Created by cheli shan on 2018/4/27.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "WKWebViewJavascriptBridge+LF.h"

@implementation WKWebViewJavascriptBridge (LF)

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
    if ([self valueForKey:@"_webView"] != webView) {
        
        return;
    }
    
    id object = [self valueForKey:@"_webViewDelegate"];
    __strong typeof(object) strongDelegate = object;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:didCommitNavigation:)]) {
        [strongDelegate webView:webView didCommitNavigation:navigation];
    }
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    if ([self valueForKey:@"_webView"] != webView) {
        
        return;
    }
    
    id object = [self valueForKey:@"_webViewDelegate"];
    __strong typeof(object) strongDelegate = object;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:decidePolicyForNavigationResponse:decisionHandler:)]) {
        [strongDelegate webView:webView decidePolicyForNavigationResponse:navigationResponse decisionHandler:decisionHandler];
    }
}
@end

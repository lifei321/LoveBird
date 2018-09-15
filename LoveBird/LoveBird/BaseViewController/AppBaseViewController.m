//
//  AppBaseViewController.m
//  LoveBird
//
//  Created by ShanCheli on 2017/6/21.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppBaseViewController.h"
#import "AppEmptyView.h"
#import "AppMacro.h"
#import "MBProgressHUD+BWMExtension.h"
#import "UINavigationItem+CustomItem.h"

@interface AppBaseViewController ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic) AppEmptyView *emptyView;

@property (strong, nonatomic) UITapGestureRecognizer *viewTapGesture;

@property (assign, nonatomic) CGPoint emptyViewOffset;


@end

@implementation AppBaseViewController

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _operationArray = [NSMutableArray new];
    }
    
    /**
     *  设置 YES, 不监听网络状态
     */
    if (!self.isNotMontorNetWork)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkUnavailable) name:kNetWorkUnavailableNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkAvailable) name:kNetWorkAvailableNotification object:nil];
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kColorViewBackground;
    
    //IOS7 UI适配
    if (IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    if(IOS8) {
        
        // IOS8多了一个样式UIModalPresentationOverCurrentContext，
        // IOS8中presentViewController时请将控制器的modalPresentationStyle设置为UIModalPresentationOverCurrentContext
        // 否则会出现
        // Snapshotting a view that has not been rendered results in an empty snapshot. Ensure your view has been rendered at least once before snapshotting or snapshot after screen updates.
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeAll;
    }
    
    if (self.navigationController.viewControllers.count > 1) {
        if (!self.backImage) {
            self.backImage = [UIImage imageNamed:@"nav_back_black"];
        }
    }
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //右滑返回手势
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.navigationBar.translucent = true;

    if (_isCustomNavigation) {
        
        [self.view bringSubviewToFront:_navigationBar];
        
        self.navigationBarItem.leftBarButtonItem = self.leftButton;
        self.navigationBarItem.rightBarButtonItem = self.rightButton;
    } else {
        
        self.navigationItem.leftBarButtonItem = self.leftButton;
        self.navigationItem.rightBarButtonItem = self.rightButton;
    }
}

- (void)viewWillDisappear: (BOOL)animated {
    [super viewWillDisappear: animated];
    
    if (self.isCustomNavigation) {
        
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
}

- (void)setBackImage:(UIImage *)backImage {
    
    _backImage = backImage;
    self.leftButton.image = backImage;
    self.leftButton.title = @"";
}

// 设置导航栏颜色
- (void)setNavigationBarColor:(UIColor *)color {
    self.navigationController.navigationBar.barTintColor = color;
}

// 设置title颜色
- (void)setNavigationBarTitleColor:(UIColor *)color {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:color}];
}

// 设置title字体大小
- (void)setNavigationBarFont:(UIFont *)font {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:font}];
}



#pragma mark 自定义导航栏

- (void)setIsCustomNavigation:(BOOL)isCustomNavigation {
    _isCustomNavigation = isCustomNavigation;
    if (isCustomNavigation) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        [self.navigationBar pushNavigationItem:self.navigationBarItem animated:YES];
        [self.view addSubview:self.navigationBar];
    } else {
        [self.navigationController setNavigationBarHidden:NO animated:NO];

    }
}

- (void)setIsNavigationTransparent:(BOOL)isNavigationTransparent {
    _isNavigationTransparent = isNavigationTransparent;
    if (isNavigationTransparent) {
        
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_clear"] forBarMetrics:UIBarMetricsDefault];
        self.navigationBar.shadowImage = [UIImage imageNamed:@"nav_clear"];
    }
}

- (UINavigationBar *)navigationBar {
    
    if (_navigationBar == nil) {
        
        _navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, total_topView_height)];
        _navigationBar.titleTextAttributes = self.navigationController.navigationBar.titleTextAttributes;
        _navigationBar.items = @[self.navigationItem];
    }
    return _navigationBar;
}

- (UINavigationItem *)navigationBarItem {
    
    if (_navigationBarItem == nil) {
        _navigationBarItem = [[UINavigationItem alloc] initWithTitle:self.title];
    }
    return _navigationBarItem;
}


#pragma mark--- 按钮

//  左侧按钮
- (ZBaseBarButtonItem *)leftButton {
    if (_leftButton == nil) {
        ZBaseBarButtonItem *leftBarButton = [[ZBaseBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonAction)];
        _leftButton = leftBarButton;
    }
    return _leftButton;
}

// 右侧按钮
- (ZBaseBarButtonItem *)rightButton {
    if (_rightButton == nil) {
        ZBaseBarButtonItem *leftBarButton = [[ZBaseBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonAction)];
        _rightButton = leftBarButton;
    }
    return _rightButton;
}



/**
 *  判断是否presentingViewController 过来的
 *
 *  @return BOOL
 */
- (BOOL)isModal {
    NSArray *viewcontrollers = self.navigationController.viewControllers;
    if (viewcontrollers.count > 1) {
        
        if ([viewcontrollers objectAtIndex:viewcontrollers.count - 1] == self) {
            
            return NO;
        }
    } else {
        
        return YES;
    }
    return YES;
}

#pragma mark- buttonAction

- (void)leftButtonAction {
    [self hideKeyboard];
    
    if (self.isModal) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)rightButtonAction {
    [self hideKeyboard];
}

#pragma mark-- 网络状态改变 动作

- (void)netWorkUnavailable {
}

- (void) netWorkAvailable {
}

#pragma mark - EmptyView

- (void)showNetErrorView:(dispatch_block_t)retryBlock {
    [self createEmptyViewWith:@"网络无法连接" image:[UIImage imageNamed:@"empty_no_network"] offset:CGPointMake(0, 0 - total_topView_height) retryText:@"再试一次" retryBlock:retryBlock];
}

- (void)showNoDataView {
    [self createEmptyViewWith:@"暂无记录" image:[UIImage imageNamed:@"emptyview_nodata"] offset:CGPointMake(0,-80) retryText:nil retryBlock:nil];
}

- (void)showNoMessage {
    [self createEmptyViewWith:@"暂无消息" image:[UIImage imageNamed:@"emptyview_noMessage"] offset:CGPointMake(0,-80) retryText:nil retryBlock:nil];
}

- (void)showServerError {
    [self createEmptyViewWith:@"系统修复" image:[UIImage imageNamed:@"emptyview_serverError"] offset:CGPointMake(0,-80) retryText:nil retryBlock:nil];
}

- (void)createEmptyViewWith:(NSString*)text
                  textColor:(UIColor *)textColor
                      image:(UIImage *)image
                     offset:(CGPoint)offset
                     space :(CGFloat)space
                  retryText:(NSString *)retryTitle
                 retryBlock:(dispatch_block_t)retryBlock {
    if (!self.isViewLoaded) {
        return;
    }
    
    if (self.emptyView) {
        [self.emptyView removeFromSuperview];
        self.emptyView = nil;
    }
    
    self.emptyView = [AppEmptyView createEmptyViewWithText:text textColor:textColor image:image space:space retryText:retryTitle retryBlock:retryBlock];
    self.emptyView.backgroundColor = [UIColor clearColor];
    
    self.emptyView.centerX = CGRectGetWidth(self.view.bounds) / 2;
    self.emptyView.centerY = CGRectGetHeight(self.view.bounds) / 2 + offset.y;
    self.emptyViewOffset = offset;
    
    [self.view addSubview:self.emptyView];
    
    //MBProgressHUD View在最前面显示
    if ([MBProgressHUD allHUDsForView:self.view] > 0) {
        for (MBProgressHUD *hud in [MBProgressHUD allHUDsForView:self.view]) {
            [self.view bringSubviewToFront:hud];
        }
    }
}

- (void)createEmptyViewWith:(NSString *)text
                      image:(UIImage *)image
                     offset:(CGPoint)offset
                  retryText:(NSString *)retryTitle
                 retryBlock:(dispatch_block_t)retryBlock {
    if (!self.isViewLoaded) {
        return;
    }
    
    if (self.emptyView) {
        [self.emptyView removeFromSuperview];
        self.emptyView = nil;
    }
    
    self.emptyView = [AppEmptyView createEmptyViewWithText:text image:image retryText:retryTitle retryBlock:retryBlock];
    self.emptyView.backgroundColor = [UIColor clearColor];
    
    self.emptyView.centerX = CGRectGetWidth(self.view.bounds) / 2;
    self.emptyView.centerY = CGRectGetHeight(self.view.bounds) / 2 + offset.y;
    self.emptyViewOffset = offset;
    
    [self.view addSubview:self.emptyView];
    
    //MBProgressHUD View在最前面显示
    if ([MBProgressHUD allHUDsForView:self.view] > 0) {
        for (MBProgressHUD *hud in [MBProgressHUD allHUDsForView:self.view]) {
            [self.view bringSubviewToFront:hud];
        }
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.emptyView.centerX = CGRectGetWidth(self.view.bounds) / 2;
    self.emptyView.centerY = CGRectGetHeight(self.view.bounds) / 2 + self.emptyViewOffset.y;
}

- (void)removeEmptyView {
    if (self.emptyView) {
        [self.emptyView removeFromSuperview];
        self.emptyView = nil;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self hideKeyboard];
}

/**
 *  隐藏键盘
 */
- (void)hideKeyboard {
    [self.view endEditing:YES];
}

#pragma mark - View Tap Gesture

- (void)setBEnableTapToResignFirstResponder:(BOOL)bEnableTapToResignFirstResponder {
    _bEnableTapToResignFirstResponder = bEnableTapToResignFirstResponder;
    if (bEnableTapToResignFirstResponder) {
        if (!self.viewTapGesture) {
            self.viewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
            self.viewTapGesture.cancelsTouchesInView = NO;
            [self.view addGestureRecognizer:self.viewTapGesture];
        }
    } else {
        [self.view removeGestureRecognizer:self.viewTapGesture];
        self.viewTapGesture = nil;
    }
}


- (void)backgroundTapped:(UITapGestureRecognizer *)gesture {
    [self hideKeyboard];
}


// 是否是root控制器
- (BOOL)isRootViewController {
    return (self == self.navigationController.viewControllers.firstObject);
}

#pragma mark
#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self isRootViewController]) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

#pragma mark--- 系统设置
-(BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}



- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //    for (NSURLSessionDataTask *operation in _operationArray) {
    ////#warning 这里 crash 太严重,先关闭掉
    ////        NSLog(@"operation is %@", operation);
    ////        @try {
    ////            [operation cancel];
    ////        } @catch (NSException *exception) {
    ////        } @finally {
    ////        }
    //    }
    //    [_operationArray removeAllObjects];
}


@end

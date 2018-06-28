//
//  AppBaseTableViewController.m
//  LoveBird
//
//  Created by ShanCheli on 2017/7/7.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppBaseTableViewController.h"
#import "AppButton.h"


@interface AppBaseTableViewController ()

/**
 *  cell标示
 */
@property (nonatomic, strong) NSString *identifier;


@end

@implementation AppBaseTableViewController

/**
 默认初始化
 */
- (instancetype)init {
    self = [self initWithStyle:UITableViewStyleGrouped];
    if (self) {
    }
    return self;
}

/**
 自定义初始化TableView的方法
 
 @param style TableView的样式
 @return instancetype
 */
- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super init];
    if (self) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - total_topView_height - kTabBarHeight) style:style];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    _tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    _tableView.sectionIndexColor = _sectionIndexColor;
    
    [self.view addSubview:_tableView];
    [_tableView setSeparatorColor:_separatorColor];
    
    // 适配 iOS 11
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 11.0) {
        // 不主动设置此处为0的话，cell 和 SectionHeader、 SectionFooter 的高度 会不走代理方法
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedRowHeight = 0;
        
        // 等使用Xcode9 以后再打开
        // UIViewController 的 automaticallyAdjustsScrollViewInsets 属性已经不使用，换为下面属性
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
            self.automaticallyAdjustsScrollViewInsets = NO;

        }
    }

}

- (void)setDataSource:(AppBaseTableDataSource *)dataSource {
    
    _dataSource = dataSource;
    self.tableView.dataSource = _dataSource;
}

- (void)registerClass:(Class)cellClass
forCellReuseIdentifier:(NSString *)identifier
           dataSource:(AppBaseTableDataSource *)datSource {
    [self.tableView registerClass:cellClass forCellReuseIdentifier:identifier];
    
    self.dataSource = datSource;
    self.dataSource.cellClass = cellClass;
    self.dataSource.identifier = identifier;
}

/**
 *  刷新表单
 */
- (void)reloadData {
    
    [self.tableView reloadData];
}

/**
 *  设置tableHeaderView文案
 *
 */
- (void)setHeaderTipsString:(NSString *)headerTipsString textColor:(UIColor *)textColor textFont:(UIFont *)textFont {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    UILabel *tipsText = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize(10), AutoSize(10), AutoSize(300), AutoSize(30))];
    tipsText.text = headerTipsString;
    tipsText.font = textFont;
    tipsText.textColor = textColor;
    [headerView addSubview:tipsText];
    self.tableView.tableHeaderView = headerView;
}

/**
 *  设置tableFooterView文案
 *
 */
- (void)setFooterTipsString:(NSString *)footerTipsString textColor:(UIColor *)textColor textFont:(UIFont *)textFont {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    UILabel *tipsText = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize(10), AutoSize(5), AutoSize(300), AutoSize(30))];
    tipsText.text = footerTipsString;
    tipsText.font = textFont;
    tipsText.textColor = textColor;
    [headerView addSubview:tipsText];
    self.tableView.tableFooterView = headerView;
}

/**
 *  tablieView footView 设置一个 button
 */
- (void)addFootViewWithButton:(NSString *)buttonText addTarget:(id)target action:(SEL)action{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize(49))];
    self.tableView.tableFooterView = footerView;
    AppButton *logoutButton = [[AppButton alloc] initWithFrame:CGRectMake(0, AutoSize(10), AutoSize(300), AutoSize(39)) style:AppButtonStyleYellow];
    [logoutButton setTitle:buttonText forState:UIControlStateNormal];
    [logoutButton setAlignmentCenterWithSuperview:footerView];
    [footerView addSubview:logoutButton];
    
    if (action != nil) {
        [logoutButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
}


/**
 *  更新cell model
 */
- (void)updateDataSourceFormCellAtIndexPath:(NSArray *)indexPathsArray viewCellsBlock:(LFBaseTableViewCellCallBack)callBack {
    NSMutableArray *cellsArray = [NSMutableArray array];
    for (NSIndexPath *indexPath in indexPathsArray) {
        AppBaseCellModel *cellModel = self.dataSource.tableListArray[indexPath.section][indexPath.row];
        if (cellModel != nil) {
            [cellsArray addObject:cellModel];
        }
    }
    callBack(cellsArray);
    //#warning 单独更新一行有问题, 单独更新会创建一个新的 cell, 导致复用出错, 先临时改成 tableview reload
    [self.tableView reloadData];
    //    [self.tableView beginUpdates];
    //    [self.tableView reloadRowsAtIndexPaths:indexPathsArray withRowAnimation:UITableViewRowAnimationNone];
    //    [self.tableView endUpdates];
}


#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return AutoSize(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return AutoSize(37);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AppBaseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.5f];
    if (cell.model.pushViewController != nil ) {
        UIViewController *viewController = [[NSClassFromString(cell.model.pushViewController) alloc] init];
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
    if (cell.model.selector != nil ) {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:NSSelectorFromString(cell.model.selector) withObject:cell.model];
#pragma clang diagnostic pop
        
    }
}

- (void)deselect {
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

#pragma --mark UISearchDisplayDelegate
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
    
    self.searchDisplayController.searchBar.showsCancelButton = YES;
    
    ((AppBaseNavigationController *)self.navigationController).alphaView.top = 0 - ((AppBaseNavigationController *)self.navigationController).alphaView.height;
    
    for (id searchbutton in controller.searchBar.subviews) {
        UIView *view = (UIView *)searchbutton;
        UIButton *cancelButton = (UIButton *)[view.subviews objectAtIndex:2];
        cancelButton.enabled = YES;
        [cancelButton setTitle:@"取消"  forState:UIControlStateNormal];//文字
        break;
    }
}


- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller {
    
    ((AppBaseNavigationController *)self.navigationController).alphaView.top = 0;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    //去除 No Results 标签
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.001);
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        
        for (UIView *subview in controller.searchResultsTableView.subviews) {
            
            if ([subview isKindOfClass:[UILabel class]] && [[(UILabel *)subview text] isEqualToString:@"No Results"]) {
                
                UILabel *label = (UILabel *)subview;
                label.text = @"无结果";
                break;
            }
        }
    });
    return YES;
}
#pragma clang diagnostic pop

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
////    [self hideKeyboard];
//}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    //
    //    self.originalViewRect = self.view.frame;
    //    CGRect frame = [textField.superview convertRect:textField.frame toView:self.view];
    //    int offset = frame.origin.y + textField.height * 2 - (self.view.frame.size.height - AutoSize(216.0));//键盘高度216
    //
    //    NSTimeInterval animationDuration = 0.30f;
    //    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    //    [UIView setAnimationDuration:animationDuration];
    //
    //    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    //    if(offset > 0)
    //        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    //
    //    [UIView commitAnimations];
}


- (void)dealloc {
    NSLog(@"%s", __func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

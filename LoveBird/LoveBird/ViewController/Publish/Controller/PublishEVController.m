//
//  PublishEVController.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/13.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "PublishEVController.h"
#import "AppTagsView.h"
#import "PublishDao.h"

@interface PublishEVController ()

@end

@implementation PublishEVController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"生态环境";
    
    [self netForData];
    
}

- (void)netForData {
    [AppBaseHud showHudWithLoding:self.view];
    
    @weakify(self);
    [PublishDao getEVSuccessBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        PublishEVDataModel *dataModel = (PublishEVDataModel *)responseObject;
        
        AppTagsView *tagView = [[AppTagsView alloc] initWithFrame:CGRectMake(0, total_topView_height, SCREEN_WIDTH, SCREEN_HEIGHT - total_topView_height)];
        tagView.selectModel = self.selectEVModel;
        tagView.tagArray = dataModel.data;
        
        @weakify(self);
        tagView.tagblock = ^(PublishEVModel *selectModel) {
            @strongify(self);

            [self.navigationController popViewControllerAnimated:YES];
            if (self.viewControllerActionBlock) {
                self.viewControllerActionBlock(self, selectModel);
            }
        };
        
        [self.view addSubview:tagView];
        
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
        
    }];
    
}

@end

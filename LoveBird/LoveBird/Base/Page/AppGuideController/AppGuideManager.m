//
//  AppGuideManager.m
//  LoveBird
//
//  Created by ShanCheli on 2017/7/7.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppGuideManager.h"
#import "AppDelegate.h"

#import "OnboardingViewController.h"
#import "OnboardingContentViewController.h"

@implementation AppGuideManager

+(AppGuideManager *)shareManager{
    static AppGuideManager *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[AppGuideManager alloc] init];
    });
    return instance;
}



- (void)showGuideView {
    
    if ([self needShowUpdateGuide]) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        delegate.window.rootViewController = [self generateStandardOnboardingVC];
        //        self.window.rootViewController = [self generateMovieOnboardingVC];
        //        self.window.rootViewController = [self generateContentVideoOnboardingVC];
        
    } else {
        
        [self setupNormalRootViewController];
    }
}




- (BOOL)needShowUpdateGuide {
    return [[NSUserDefaults standardUserDefaults] objectForKey:[self updateGuideKey]] ? [[NSUserDefaults standardUserDefaults] boolForKey:[self updateGuideKey]] : YES;
}

- (void)setNeedShowUpdateGuide:(BOOL)needShowUpdateGuide {
    [[NSUserDefaults standardUserDefaults] setBool:needShowUpdateGuide forKey:[self updateGuideKey]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)updateGuideKey {
    NSString *key = [kUserHasOnboardedKey stringByAppendingString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    
    return key;
}


#pragma mark--------------- 引导页有关

- (void)setupNormalRootViewController {
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate setRootViewControllerForWindow];
}

//点击 体验、跳过 回调
- (void)handleOnboardingCompletion {
    
    [self setNeedShowUpdateGuide:NO];
    [self setupNormalRootViewController];
}

- (OnboardingViewController *)generateStandardOnboardingVC {
    OnboardingContentViewController *firstPage = [OnboardingContentViewController contentWithTitle:@"What A Beautiful Photo" body:@"This city background image is so beautiful." image:[UIImage imageNamed:@"blue"] buttonText:@"Enable Location Services" action:^{

    }];
    
    OnboardingContentViewController *secondPage = [OnboardingContentViewController contentWithTitle:@"I'm so sorry" body:@"I can't get over the nice blurry background photo." image:[UIImage imageNamed:@"red"] buttonText:@"Connect With Facebook" action:^{
 
    }];
    secondPage.movesToNextViewController = YES;
    secondPage.viewDidAppearBlock = ^{

    };
    
    OnboardingContentViewController *thirdPage = [OnboardingContentViewController contentWithTitle:@"Seriously Though" body:@"Kudos to the photographer." image:[UIImage imageNamed:@"yellow"] buttonText:@"Get Started" action:^{
        [self handleOnboardingCompletion];
    }];
    
    OnboardingViewController *onboardingVC = [OnboardingViewController onboardWithBackgroundImage:[UIImage imageNamed:@"street"] contents:@[firstPage, secondPage, thirdPage]];
    onboardingVC.shouldFadeTransitions = YES;
    onboardingVC.fadePageControlOnLastPage = YES;
    onboardingVC.fadeSkipButtonOnLastPage = YES;
    
    onboardingVC.allowSkipping = YES;
    onboardingVC.skipHandler = ^{
        [self handleOnboardingCompletion];
    };
    
    return onboardingVC;
}

- (OnboardingViewController *)generateMovieOnboardingVC {
    OnboardingContentViewController *firstPage = [[OnboardingContentViewController alloc] initWithTitle:@"Everything Under The Sun" body:@"The temperature of the photosphere is over 10,000°F." image:nil buttonText:nil action:nil];
    firstPage.topPadding = -15;
    firstPage.underTitlePadding = 160;
    firstPage.titleLabel.textColor = [UIColor colorWithRed:239/255.0 green:88/255.0 blue:35/255.0 alpha:1.0];
    firstPage.titleLabel.font = [UIFont fontWithName:@"SFOuterLimitsUpright" size:38.0];
    firstPage.bodyLabel.textColor = [UIColor colorWithRed:239/255.0 green:88/255.0 blue:35/255.0 alpha:1.0];
    firstPage.bodyLabel.font = [UIFont fontWithName:@"NasalizationRg-Regular" size:18.0];
    
    OnboardingContentViewController *secondPage = [[OnboardingContentViewController alloc] initWithTitle:@"Every Second" body:@"600 million tons of protons are converted into helium atoms." image:nil buttonText:nil action:nil];
    secondPage.titleLabel.font = [UIFont fontWithName:@"SFOuterLimitsUpright" size:38.0];
    secondPage.underTitlePadding = 170;
    secondPage.topPadding = 0;
    secondPage.titleLabel.textColor = [UIColor colorWithRed:251/255.0 green:176/255.0 blue:59/255.0 alpha:1.0];
    secondPage.bodyLabel.textColor = [UIColor colorWithRed:251/255.0 green:176/255.0 blue:59/255.0 alpha:1.0];
    secondPage.bodyLabel.font = [UIFont fontWithName:@"NasalizationRg-Regular" size:18.0];
    
    OnboardingContentViewController *thirdPage = [[OnboardingContentViewController alloc] initWithTitle:@"We're All Star Stuff" body:@"Our very bodies consist of the same chemical elements found in the most distant nebulae, and our activities are guided by the same universal rules." image:nil buttonText:@"Explore the universe" action:^{
        [self handleOnboardingCompletion];
    }];
    thirdPage.topPadding = 10;
    thirdPage.underTitlePadding = 160;
    thirdPage.bottomPadding = -10;
    thirdPage.titleLabel.font = [UIFont fontWithName:@"SFOuterLimitsUpright" size:38.0];
    thirdPage.titleLabel.textColor = [UIColor colorWithRed:58/255.0 green:105/255.0 blue:136/255.0 alpha:1.0];
    thirdPage.bodyLabel.textColor = [UIColor colorWithRed:58/255.0 green:105/255.0 blue:136/255.0 alpha:1.0];
    thirdPage.bodyLabel.font = [UIFont fontWithName:@"NasalizationRg-Regular" size:15.0];
    [thirdPage.actionButton setTitleColor:[UIColor colorWithRed:239/255.0 green:88/255.0 blue:35/255.0 alpha:1.0] forState:UIControlStateNormal];
    thirdPage.actionButton.titleLabel.font = [UIFont fontWithName:@"SpaceAge" size:17.0];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *moviePath = [bundle pathForResource:@"sun" ofType:@"mp4"];
    NSURL *movieURL = [NSURL fileURLWithPath:moviePath];
    
    OnboardingViewController *onboardingVC = [[OnboardingViewController alloc] initWithBackgroundVideoURL:movieURL contents:@[firstPage, secondPage, thirdPage]];
    onboardingVC.shouldFadeTransitions = YES;
    onboardingVC.shouldMaskBackground = NO;
    onboardingVC.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:239/255.0 green:88/255.0 blue:35/255.0 alpha:1.0];
    onboardingVC.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    return onboardingVC;
}

- (OnboardingViewController *)generateContentVideoOnboardingVC {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *moviePath = [bundle pathForResource:@"sun" ofType:@"mp4"];
    NSURL *movieURL = [NSURL fileURLWithPath:moviePath];
    
    OnboardingContentViewController *firstPage = [OnboardingContentViewController contentWithTitle:@"Everything Under The Sun" body:@"The temperature of the photosphere is over 10,000°F." videoURL:movieURL buttonText:nil action:nil];
    firstPage.topPadding = -15;
    firstPage.underTitlePadding = 160;
    firstPage.titleLabel.textColor = [UIColor colorWithRed:239/255.0 green:88/255.0 blue:35/255.0 alpha:1.0];
    firstPage.titleLabel.font = [UIFont fontWithName:@"SFOuterLimitsUpright" size:38.0];
    firstPage.bodyLabel.textColor = [UIColor colorWithRed:239/255.0 green:88/255.0 blue:35/255.0 alpha:1.0];
    firstPage.bodyLabel.font = [UIFont fontWithName:@"NasalizationRg-Regular" size:18.0];
    
    OnboardingContentViewController *secondPage = [OnboardingContentViewController contentWithTitle:@"Every Second" body:@"600 million tons of protons are converted into helium atoms." videoURL:movieURL buttonText:nil action:nil];
    secondPage.titleLabel.font = [UIFont fontWithName:@"SFOuterLimitsUpright" size:38.0];
    secondPage.underTitlePadding = 170;
    secondPage.topPadding = 0;
    secondPage.titleLabel.textColor = [UIColor colorWithRed:251/255.0 green:176/255.0 blue:59/255.0 alpha:1.0];
    secondPage.bodyLabel.textColor = [UIColor colorWithRed:251/255.0 green:176/255.0 blue:59/255.0 alpha:1.0];
    secondPage.bodyLabel.font = [UIFont fontWithName:@"NasalizationRg-Regular" size:18.0];
    
    OnboardingContentViewController *thirdPage = [OnboardingContentViewController contentWithTitle:@"We're All Star Stuff" body:@"Our very bodies consist of the same chemical elements found in the most distant nebulae, and our activities are guided by the same universal rules." videoURL:movieURL buttonText:nil action:^{
        [self handleOnboardingCompletion];
    }];
    thirdPage.topPadding = 10;
    thirdPage.underTitlePadding = 160;
    thirdPage.bottomPadding = -10;
    thirdPage.titleLabel.font = [UIFont fontWithName:@"SFOuterLimitsUpright" size:38.0];
    thirdPage.titleLabel.textColor = [UIColor colorWithRed:58/255.0 green:105/255.0 blue:136/255.0 alpha:1.0];
    thirdPage.bodyLabel.textColor = [UIColor colorWithRed:58/255.0 green:105/255.0 blue:136/255.0 alpha:1.0];
    thirdPage.bodyLabel.font = [UIFont fontWithName:@"NasalizationRg-Regular" size:15.0];
    [thirdPage.actionButton setTitleColor:[UIColor colorWithRed:239/255.0 green:88/255.0 blue:35/255.0 alpha:1.0] forState:UIControlStateNormal];
    thirdPage.actionButton.titleLabel.font = [UIFont fontWithName:@"SpaceAge" size:17.0];
    
    OnboardingViewController *onboardingVC = [[OnboardingViewController alloc] initWithBackgroundImage:nil contents:@[firstPage, secondPage, thirdPage]];
    onboardingVC.view.backgroundColor = [UIColor blackColor];
    onboardingVC.shouldFadeTransitions = YES;
    onboardingVC.shouldMaskBackground = NO;
    onboardingVC.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:239/255.0 green:88/255.0 blue:35/255.0 alpha:1.0];
    onboardingVC.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    return onboardingVC;
}



@end

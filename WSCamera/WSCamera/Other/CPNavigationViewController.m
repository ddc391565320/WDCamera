//
//  CPNavigationViewController.m
//  Learner Kit
//
//  Created by Wade on 14-8-6.
//  Copyright (c) 2014年 Collegepre.. All rights reserved.
//  导航栏控制器

#import "CPNavigationViewController.h"

#import "CPHeaders.h"

@interface CPNavigationViewController ()

@end

@implementation CPNavigationViewController

+ (void)initialize
{
    // 设置导航栏按钮主题
    [self setupItemTheme];
}

/**
 * 设置导航栏按钮主题
 */
+ (void)setupItemTheme
{
    // 1.获得appearance对象, 就能修改主题
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 2.设置背景
    if (iOS7) { // iOS7
        // 按钮文字
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        // 设置文字颜色
//        textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
        // 去掉阴影
//        textAttrs[NSShadowAttributeName] = [NSValue valueWithUIOffset:UIOffsetZero];
        // 设置文字字体
        textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
        [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    } else
    { // iOS6
        // 按钮背景
        [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
        
        // 按钮文字
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        // 设置文字颜色
//        textAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
        // 去掉阴影
//        textAttrs[NSShadowAttributeName] = [NSValue valueWithUIOffset:UIOffsetZero];
        // 设置文字字体
        textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
        [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
        [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
    }
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
      self.interactivePopGestureRecognizer.delegate = nil;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 如果push的不是根控制器(不是栈底控制器)
        viewController.hidesBottomBarWhenPushed = YES;
        // 左上角的返回
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}
@end

//
//  MBProgressHUD+MJ.h
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 . All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (MJ)
+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

#pragma mark - 显示不消失需要手动隐藏
+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

#pragma mark - 不带延迟时间
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view;
+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

#pragma mark - 带延迟时间
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view andDelay:(float)delay;
+ (void)showError:(NSString *)error toView:(UIView *)view andDelay:(float)delay;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view andDelay:(float)delay;
+ (void)showSuccess:(NSString *)success andDelay:(float)delay;
+ (void)showError:(NSString *)error andDelay:(float)delay;

@end

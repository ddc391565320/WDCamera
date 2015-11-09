//
//  CPCommon.h
//  Hermes
//
//  Created by Wade on 15/6/8.
//  Copyright (c) 2015年 Wade. All rights reserved.
//

#ifndef Hermes_CPCommon_h
#define Hermes_CPCommon_h

#define CPMicrosoftYaHei(a) [UIFont fontWithName:@"MicrosoftYaHei" size:a]

#define CPisNewToStudyVC @"isNewToStudyVC"
#define CPNotificationCreatTime @"notificationCreatTime"
#define CPUserAccount @"userAccount"
#define CPUserPassword @"userPassword"
#define CPUserMD5Password @"md5userPassword"
#define CPURLPrefix @"http://api.classserver.cn"
#define CPTestURLPrefix @"http://192.168.1.10"

#define CPGetAccount  [CPUserDefaultsTool getValueForKey:CPUserAccount]
#define CPGetMD5Password [CPUserDefaultsTool getValueForKey:CPUserMD5Password]
#define CPGetPassword [CPUserDefaultsTool getValueForKey:CPUserPassword]

#pragma mark 定义常量表达式
#define CPControllernum 4;

#import "CPLocalizableTools.h"
#define CPMainStoryBoard [UIStoryboard storyboardWithName:@"Main" bundle:nil]
#define CPapplicationIconBadge @"applicationIconBadge"
// --------------------------------------------------------------------------------------------------------------- //
// MicrosoftYaHei
#define CPMicrosoftYaHei(a) [UIFont fontWithName:@"MicrosoftYaHei" size:a]

// 6个6颜色
#define CPColor_6      [UIColor colorsWithHexString:0x666666]

// 6个3颜色
#define CPColor_3      [UIColor colorsWithHexString:0x333333]

// 定义打印方法和线程
#define CPLocation CPLog(@"函数:%s||线程:%@",__func__,[NSThread currentThread])

// 设置字体大小
#define CPFontSize  @"fontSize"

// 设置segment
#define CPSegValue  @"segValue"

#define CPMainStoryBoard [UIStoryboard storyboardWithName:@"Main" bundle:nil]

// 是否为iOS7
#define iOS7 ([UIDevice currentDevice].systemVersion.doubleValue >= 7.0)
// 是否为4inch
#define FourInch ([UIScreen mainScreen].bounds.size.height == 568.0)

// 随机色
#define CPRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

// 获得RGB颜色
#define CPRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define CPRGBAColor(r, g, b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0]

// 屏幕的高
#define CPScreenHeight [UIScreen mainScreen].bounds.size.height

// 屏幕的宽
#define CPScreenWidth [UIScreen mainScreen].bounds.size.width

// 屏幕的宽
#define CPScreenSize [UIScreen mainScreen].bounds.size

// 3.自定义Log
#ifdef DEBUG
#define CPLog(...) NSLog(__VA_ARGS__)
#else
#define CPLog(...)
#endif

#define CPLocalizedString(key) [[CPLocalizableTools bundle] localizedStringForKey:(key) value:@"" table:@"LocalLanguage"]

#endif

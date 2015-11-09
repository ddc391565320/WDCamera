//
//  InternationalControl.h
//  MyInternational
//
//  Created by catal on 14-12-28.
//  Copyright (c) 2014年 catal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InternationalControl : NSObject
//获取当前资源文件
+ (NSBundle *)bundle;
//初始话语言文件
+ (void)initUserLanguage;
//获取应用当前语言
+ (NSString *)userLanguage;
//设置当前语言
+ (void)setUserLanguage:(NSString *)language;

@end

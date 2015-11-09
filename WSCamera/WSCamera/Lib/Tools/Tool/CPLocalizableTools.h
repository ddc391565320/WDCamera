//
//  CPLocalizableTools.h
//  Tutor_Kit
//
//  Created by Wade on 15-1-13.
//  Copyright (c) 2015年 collegepre. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPLocalizableTools : NSObject
+(NSBundle *)bundle;//获取当前资源文件

+(void)initUserLanguage;//初始化语言文件

+(NSString *)userLanguage;//获取应用当前语言

+(void)setUserlanguage:(NSString *)language;//设置当前语言
@end

//
//  InternationalControl.m
//  MyInternational
//
//  Created by tarena6 on 14-12-28.
//  Copyright (c) 2014年 tarena6. All rights reserved.
//

#import "InternationalControl.h"

static NSBundle *bundle = nil;
@implementation InternationalControl
+ (NSBundle *)bundle
{
    return bundle;
}
+ (void)initUserLanguage
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *userLanguageString = [def valueForKeyPath:@"userLanguage"];
    //获取系统当前语言版本
    NSArray *languages = [def objectForKey:@"AppleLanguages"];
    NSString *current = [languages objectAtIndex:0];
    if (userLanguageString.length == 0)
    {
        //获取文件路径
        NSString *path = [[NSBundle mainBundle]pathForResource:current ofType:@"lproj"];
        //生成bundle
        bundle = [NSBundle bundleWithPath:path];
        [def setValue:current forKey:@"userLanguage"];
        [def synchronize];
    }
    else
    {
        //获取文件路径
        NSString *path = [[NSBundle mainBundle]pathForResource:userLanguageString ofType:@"lproj"];
        //生成bundle
        bundle = [NSBundle bundleWithPath:path];
    }
}
+ (NSString *)userLanguage
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *language = [def valueForKeyPath:@"userLanguage"];
    return language;
}
+ (void)setUserLanguage:(NSString *)language
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *path = [[NSBundle mainBundle]pathForResource:language ofType:@"lproj"];
    bundle = [NSBundle bundleWithPath:path];
    [def setValue:language forKeyPath:@"userLanguage"];
    [def synchronize];
    
}
@end

//
//  CPLocalizableTools.m
//  Tutor_Kit
//
//  Created by Wade on 15-1-13.
//  Copyright (c) 2015年 collegepre. All rights reserved.
//

#import "CPLocalizableTools.h"

#define MCuserLanguage  @"userLanguage"
#define MCAppleLanguages  @"AppleLanguages"

@implementation CPLocalizableTools

static NSBundle *bundle = nil;

+ ( NSBundle * )bundle{
    return bundle;
}

+(void)initUserLanguage{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *string = [def valueForKey:MCuserLanguage];
    if(string.length == 0){
        //获取系统当前语言版本
        NSArray* languages = [def objectForKey:MCAppleLanguages];
        NSString *current = [languages objectAtIndex:0];
        string = current;
        [def setValue:current forKey:MCuserLanguage];
        [def synchronize];//持久化，不加的话不会保存
    }
    
    //获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:string ofType:@"lproj"];
    bundle = [NSBundle bundleWithPath:path];//生成bundle
}

+(NSString *)userLanguage
{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *language = [def valueForKey:MCuserLanguage];
    return language;
}

+(void)setUserlanguage:(NSString *)language
{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    //1.第一步改变bundle的值
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    bundle = [NSBundle bundleWithPath:path];
    
    //2.持久化
    [def setValue:language forKey:MCuserLanguage];
    [def synchronize];
}


@end

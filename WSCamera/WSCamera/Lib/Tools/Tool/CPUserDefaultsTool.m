//
//  CPUserDefaultsTool.m
//  Learner Kit
//
//  Created by Wade on 14-8-6.
//  Copyright (c) 2014年 .. All rights reserved.
//

#import "CPUserDefaultsTool.h"
#import <UIKit/UIKit.h>



@implementation CPUserDefaultsTool

SingletonM(UserDefaultsTool)
+ (void)saveWithValue:(NSString *)value forKey:(NSString *)key
{
    NSUserDefaults *UserDef = [NSUserDefaults standardUserDefaults];
    [UserDef setObject:value forKey:key];
    [UserDef synchronize];
}

+ (NSString *)getValueForKey:(NSString *)key
{
    NSUserDefaults *UserDef = [NSUserDefaults standardUserDefaults];
   return [UserDef objectForKey:key];

}

+ (void)removeValueForKey:(NSString *)key
{
    NSUserDefaults *UserDef = [NSUserDefaults standardUserDefaults];
    [UserDef removeObjectForKey:key];
    [UserDef synchronize];
}

+ (NSInteger)getIntegerValueForKey:(NSString *)key
{
    NSUserDefaults *UserDef = [NSUserDefaults standardUserDefaults];
    return [UserDef integerForKey:key];
}

+ (void)saveWithIntegerValue:(NSInteger)value forKey:(NSString *)key
{
    NSUserDefaults *UserDef = [NSUserDefaults standardUserDefaults];
    [UserDef setInteger:value forKey:key];
    [UserDef synchronize];
}

+ (void)setAnimationDuration:(float)duration animation:(void (^)())animation
{
    [UIView beginAnimations:@"改变大小" context:NULL];
    [UIView setAnimationDuration:0.25];//设置动画的持续时间
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    if (animation) {
        animation();
    }

    [UIView commitAnimations];
}


+ (BOOL)fileexist:(NSString *)path
{
    NSFileManager *manger = [NSFileManager defaultManager];
    return [manger fileExistsAtPath:path];
}

/**
 *  对象转字符串
 */
+ (NSString *)stringWithObject:(id)object
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:0 error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return str;
}

+ (NSString *)md5:(NSString *)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];//
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++)
    {
        [ret appendFormat:@"%02x",result[i]];
    }
    
    return ret;
}

@end

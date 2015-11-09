//
//  CPUserDefaultsTool.h
//  Learner Kit
//
//  Created by Wade on 14-8-6.
//  Copyright (c) 2014年 .. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import <CommonCrypto/CommonDigest.h>

//typedef enum 
@interface CPUserDefaultsTool : NSObject
SingletonH(UserDefaultsTool)
/**
 *  对象转字符串
 */
+ (NSString *)stringWithObject:(id)object;
/**
 *  获取MD5值
 */
+ (NSString *)md5:(NSString *)input;
/**
 *  保存字符串
 */
+ (void)saveWithValue:(NSString *)value forKey:(NSString *)key;
/**
 *  获取字符串
 */
+ (NSString *)getValueForKey:(NSString *)key;
/**
 *  移除字符串
 */
+ (void)removeValueForKey:(NSString *)key;


/**
 *  获取整形
 */
+ (NSInteger)getIntegerValueForKey:(NSString *)key;
/**
 *  保存整形
 */
+ (void)saveWithIntegerValue:(NSInteger)value forKey:(NSString *)key;

/**
 *  基本动画
 */
+ (void)setAnimationDuration:(float)duration animation:(void(^)())animation;


/**
 *  判断文件是否存在
 */
+ (BOOL)fileexist:(NSString *)path;
@end

//
//  NSArray+Log.m
//  
//
//  Created by teacher on 14-5-29.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "NSArray+Log.h"

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    // 手动重新拼接数组的描述字符串
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    
    // 循环拼接内容
    for (id obj in self) {
        [strM appendFormat:@"\t%@,\n", obj];
    }
    
    [strM appendString:@")"];
    
    return strM;
}

@end

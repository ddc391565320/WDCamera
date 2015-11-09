//
//  CPSetting.m
//  Hermes
//
//  Created by Wade on 15/6/16.
//  Copyright (c) 2015年 Wade. All rights reserved.
//

#import "CPSetting.h"

@implementation CPSetting
+ (instancetype)settingWithHeader:(NSString *)header children:(NSArray *)children
{
    CPSetting *setting = [[CPSetting alloc] init];
    setting.header = header;
    setting.children = children;
    return setting;
}
@end

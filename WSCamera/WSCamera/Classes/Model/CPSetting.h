//
//  CPSetting.h
//  Hermes
//
//  Created by Wade on 15/6/16.
//  Copyright (c) 2015年 Wade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPSettingChild.h"



@interface CPSetting : NSObject

@property (nonatomic, copy) NSString *header;
@property (nonatomic, strong) NSArray *children;

+ (instancetype)settingWithHeader:(NSString *)header children:(NSArray *)children;
@end

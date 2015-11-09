//
//  CPSettingChild.m
//  Hermes
//
//  Created by Wade on 15/6/16.
//  Copyright (c) 2015年 Wade. All rights reserved.
//

#import "CPSettingChild.h"

@implementation CPSettingChild
+ (instancetype)childWithTitle:(NSString *)title subTitle:(NSString *)subTitle detailText:(NSString *)detailText isSwitch:(BOOL)isSwitch isArrow:(BOOL)isArrow DestVC:(Class)detstVC{
    {
        CPSettingChild *child = [[CPSettingChild alloc] init];
        child.title = title;
        child.subtitleText = subTitle;
        child.detailText = detailText;
        child.isSwitch = isSwitch;
        child.isArrow = isArrow;
        child.destVc = detstVC;
        return child;
    }
}
@end

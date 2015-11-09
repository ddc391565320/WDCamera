//
//  CPSettingChild.h
//  Hermes
//
//  Created by Wade on 15/6/16.
//  Copyright (c) 2015年 Wade. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CPSettingItemBlock)();

@interface CPSettingChild : NSObject

@property (nonatomic, copy) CPSettingItemBlock opration;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitleText;
@property (nonatomic, copy) NSString *detailText;
@property (nonatomic, assign) BOOL isSwitch;
@property (nonatomic, assign) BOOL isArrow;
/**
 *  目标控制器(要跳转到得控制器)
 */
@property (nonatomic, assign) Class destVc;


+ (instancetype)childWithTitle:(NSString *)title subTitle:(NSString *)subTitle detailText:(NSString *)detailText isSwitch:(BOOL)isSwitch isArrow:(BOOL)isArrow DestVC:(Class)detstVC;

@end

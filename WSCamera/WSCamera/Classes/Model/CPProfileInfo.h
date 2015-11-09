//
//  CPProfileInfo.h
//  Hermes
//
//  Created by Wade on 15/7/3.
//  Copyright (c) 2015年 Wade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPProfileInfo : NSObject
/*
 "username":"admin",
 "student_name":"张一正",
 "phonenumber":"18610010001",
 "photo_address":"http://sc.admin5.com/uploads/allimg/100210/1136291235-1.png",
 "school_info":"亦庄校区",
 "class_info":"幼教一班",
 */
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *student_name;
@property (nonatomic, strong) NSArray *classid;
@property (nonatomic, copy) NSString *phonenumber;
@property (nonatomic, copy) NSString *photo_address;
@property (nonatomic, copy) NSString *school;
@property (nonatomic, copy) NSArray *class_info;

@end

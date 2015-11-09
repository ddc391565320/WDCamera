//
//  UIColorFromHexString.h
//  Kid's English
//
//  Created by 裴 越 on 8/27/13.
//  Copyright (c) 2013 Hynear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor (HexString)

+ (UIColor *)colorWithHexString: (NSString *) hexString;

@end

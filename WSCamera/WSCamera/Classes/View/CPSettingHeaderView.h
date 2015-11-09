//
//  CPSettingHeaderView.h
//  Hermes
//
//  Created by Wade on 15/6/17.
//  Copyright (c) 2015年 Wade. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CPSetting;
@interface CPSettingHeaderView : UITableViewHeaderFooterView
@property (nonatomic, strong) CPSetting *set;

+ (instancetype)headerWithTableView:(UITableView *)tableView;
@end

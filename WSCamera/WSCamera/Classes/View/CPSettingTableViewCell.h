//
//  CPSettingTableViewCell.h
//  Hermes
//
//  Created by Wade on 15/6/16.
//  Copyright (c) 2015年 Wade. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CPSettingChild;

typedef void(^SwitchValueChange)(BOOL isON);

@interface CPSettingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UISwitch *pushSwitch;

@property (nonatomic, copy) SwitchValueChange switchValueChange;
@property (nonatomic, strong) CPSettingChild *child;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

//
//  CPSettingTableViewCell.m
//  Hermes
//
//  Created by Wade on 15/6/16.
//  Copyright (c) 2015年 Wade. All rights reserved.
//

#import "CPSettingTableViewCell.h"
#import "CPSettingChild.h"

@interface CPSettingTableViewCell()


@end

@implementation CPSettingTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    CPSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell"];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CPSettingTableViewCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return cell;
}

- (void)setChild:(CPSettingChild *)child
{
    _child = child;
    self.titleLabel.text = child.title;
    self.subTitleLabel.text = child.subtitleText;
    self.detailLabel.text = child.detailText;
    self.pushSwitch.hidden = !child.isSwitch;
    self.arrowImageView.hidden = !child.isArrow;
    
}

@end

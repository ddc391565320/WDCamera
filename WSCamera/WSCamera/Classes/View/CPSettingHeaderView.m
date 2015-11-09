//
//  CPSettingHeaderView.m
//  Hermes
//
//  Created by Wade on 15/6/17.
//  Copyright (c) 2015年 Wade. All rights reserved.
//

#import "CPSettingHeaderView.h"
#import "CPSetting.h"
#import "CPHeaders.h"

@interface CPSettingHeaderView()
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *lineLabel;
@end

@implementation CPSettingHeaderView
+ (instancetype)headerWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"SettingHeader";
    CPSettingHeaderView *header =  [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (header == nil) {
        // 创建一个头部视图
        header = [[CPSettingHeaderView alloc] initWithReuseIdentifier:identifier];
        // 给headerView中添加子控件
        //        header.frame = CGRectMake(0, 0, 320, 44);
        
    }
    return header;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        // 2.添加label
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.font = CPMicrosoftYaHei(17);
        nameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel *line = [[UILabel alloc] init];
        line.backgroundColor = [UIColor lightGrayColor];
         [self.contentView addSubview:line];
        self.lineLabel = line;
    }
    return self;
}

- (void)setSet:(CPSetting *)set
{
    _set = set;
    self.nameLabel.text = set.header;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.nameLabel.frame = self.bounds;
    self.nameLabel.x = 20;
    
    self.lineLabel.frame = self.bounds;
    self.lineLabel.height = 1;
    self.lineLabel.y = self.bounds.size.height - 1;
}


@end

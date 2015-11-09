//
//  WSSettingViewController.m
//  WSCamera
//
//  Created by Wade on 15/7/23.
//  Copyright (c) 2015年 Wade. All rights reserved.
//

#import "WSSettingViewController.h"
#import "CPHeaders.h"
#import "CPProfileInfo.h"
#import "CPSetting.h"
#import "CPSettingChild.h"
#import "CPSettingTableViewCell.h"
#import "CPSettingHeaderView.h"

@interface WSSettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataList;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@end

@implementation WSSettingViewController

- (NSArray *)dataList
{
    if (!_dataList)
    {
        _dataList = [NSArray array];
    }
    return _dataList;
}
- (IBAction)backBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    [self setupSubViews];
    [self settingSetItems];
    
}

- (void)setupSubViews
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = [UIColor whiteColor];

    [self setupTitleView];
}


- (void)setupTitleView
{
    self.titleView.backgroundColor = [UIColor colorWithHexString:@"#00b8ee"];
    self.titleLabel.font = [UIFont systemFontOfSize:22];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self.backBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    self.backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    self.backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
}

- (void)exitBtnClick:(UIButton *)btn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)settingSetItems
{
    CPSettingChild *nameItem = [CPSettingChild childWithTitle:@"学生姓名" subTitle:@"" detailText:@"" isSwitch:NO isArrow:NO DestVC:nil];
    
    CPSettingChild *phoneItem = [CPSettingChild childWithTitle:@"手机号码" subTitle:@"" detailText:@"" isSwitch:NO isArrow:NO DestVC:nil];
    
    CPSettingChild *schoolItem = [CPSettingChild childWithTitle:@"所在学校" subTitle:@"" detailText:@"" isSwitch:NO isArrow:NO DestVC:nil];
    
    
    CPSettingChild *classItemt = [CPSettingChild childWithTitle:@"班级信息" subTitle:@"" detailText:@"" isSwitch:NO isArrow:NO DestVC:nil];
    
    NSArray *arr1 = [NSArray arrayWithObjects:nameItem,phoneItem,schoolItem,classItemt, nil];
    CPSetting *header1 = [CPSetting settingWithHeader:@"学生信息" children:arr1];
    
    
    CPSettingChild *sw = [CPSettingChild childWithTitle:@"消息推送" subTitle:@"若关闭此功能将收不到上课提醒" detailText:@"" isSwitch:YES isArrow:NO DestVC:nil];
    
    //    NSString *version = [];
    CPSettingChild *checkVersion = [CPSettingChild childWithTitle:@"检查版本" subTitle:@"" detailText:@"0.1.0" isSwitch:NO isArrow:NO DestVC:nil];
    
    CPSettingChild *changePassword = [CPSettingChild childWithTitle:@"修改密码" subTitle:@"" detailText:@"" isSwitch:NO isArrow:YES DestVC:nil];
    
    NSArray *arr2 = [NSArray arrayWithObjects:sw,checkVersion,changePassword, nil];
    CPSetting *header2 = [CPSetting settingWithHeader:@"设置" children:arr2];
    
    
    CPSettingChild *schoolInfo = [CPSettingChild childWithTitle:@"学校信息" subTitle:@"" detailText:@"" isSwitch:NO isArrow:YES DestVC:nil];
    
    CPSettingChild *aboutSesamestreet = [CPSettingChild childWithTitle:@"关于芝麻街" subTitle:@"" detailText:@"" isSwitch:NO isArrow:YES DestVC:nil];
    
    NSArray *arr3 = [NSArray arrayWithObjects:schoolInfo,aboutSesamestreet,nil];
    
    CPSetting *header3 = [CPSetting settingWithHeader:@"其他" children:arr3];
    
    self.dataList = [NSArray arrayWithObjects:header1,header2,header3,nil];
    [self.tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CPSetting  *setting = self.dataList[section];
    return setting.children.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CPSetting  *setting = self.dataList[indexPath.section];
    CPSettingChild *child = setting.children[indexPath.row];
    CPSettingTableViewCell *cell  = [CPSettingTableViewCell cellWithTableView:tableView];
    cell.child = child;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2 &&indexPath.row == 1)
    {
  
    }
    if (indexPath.section == 1 &&indexPath.row == 1)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showMessage:@"正在检查..." toView:self.view];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view];
                
                [MBProgressHUD showSuccess:@"已是最新版本." andDelay:1.0];
            });
        });
    }
    if (indexPath.section == 1&&indexPath.row == 2)
    {
       
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CPSettingHeaderView *header = [CPSettingHeaderView headerWithTableView:tableView];
    CPSetting *set = self.dataList[section];
    header.set = set;
    return header;
}


@end

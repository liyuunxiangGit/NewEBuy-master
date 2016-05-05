//
//  AfterSaleViewController.m
//  SuningEBuy
//
//  Created by zl on 14-11-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "AfterSaleViewController.h"

@interface AfterSaleViewController ()

@end

@implementation AfterSaleViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"售后服务";
        self.pageTitle = @"售后服务";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    self.tpTableView = (id)self.groupTableView;
    self.tpTableView.frame = frame;
    self.tpTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tpTableView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tpTableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    v.backgroundColor = [UIColor clearColor];
    return v;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *cellIndentifier = @"ziXunIndentifier";
    
    MyEBuyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (nil == cell)
    {
        cell = [[MyEBuyViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.leftImage.frame = CGRectMake(12, 8, 25, 25);
    cell.leftImage.image = [UIImage imageNamed:@"ego-icon-zixun.png"];
    cell.labTip.text = @"咨询";
    
    return cell;
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self SNDataCollection:@"740607"];
    [self myConsultation];
}

//我的咨询
-(void)myConsultation
{

    ConsultationViewController *consult = [[ConsultationViewController alloc] init];
    consult.ismyconsult=YES;
    [self.navigationController pushViewController:consult animated:YES];
    
}

-(void)SNDataCollection:(NSString*)aStr
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:aStr, nil]];
}
@end

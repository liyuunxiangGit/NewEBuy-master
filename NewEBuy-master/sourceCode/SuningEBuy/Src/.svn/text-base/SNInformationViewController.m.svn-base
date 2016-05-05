//
//  SNInformationViewController.m
//  SuningEBuy
//
//  Created by xingxianping on 13-7-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SNInformationViewController.h"
#import "SNInformationDetailViewController.h"

@interface SNInformationViewController ()
{
    BOOL            isLoadOK;
}
@end

@implementation SNInformationViewController

@synthesize informationService=_informationService;

@synthesize listArr=_listArr;
@synthesize isFirstLoad=_isFirstLoad;

- (id)init
{
    self = [super init];
    
    if(self)
    {
        isLoadOK = NO;
        self.isFirstLoad=YES;
        self.hidesBottomBarWhenPushed =YES;
    }
    return self;
}

- (void)dealloc
{
    _informationService.delegate=nil;
    SERVICE_RELEASE_SAFELY(_informationService);
    
    TT_RELEASE_SAFELY(_listArr);
    
}

- (void)loadView
{
    [super loadView];
    
    self.title = L(@"Imformation_NewsCenter");
    self.pageTitle = L(@"PageTitleDisplayNewsCenter");
    
    self.tableView.frame =[self visibleBoundsShowNav:YES showTabBar:NO];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView addSubview:self.refreshHeaderView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!isLoadOK) {
        [self refreshData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(SNInformationService *)informationService
{
    if (!_informationService) {
        _informationService=[[SNInformationService alloc]init];
        _informationService.delegate=self;
    }
    return _informationService;
}

- (NSMutableArray *)listArr
{
    if (!_listArr) {
        _listArr=[[NSMutableArray alloc] init];
    }
    return _listArr;
}

#pragma mark TableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!IsArrEmpty(self.listArr)) {
        return 1;
    }
    else
        return 0;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if ([self hasMore])
    {
        return [self.listArr count]+1;
    }
    return [self.listArr count];
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasMore] && self.listArr.count ==indexPath.section) {
        return 30;
    }
    
    if ([[self.listArr objectAtIndex:indexPath.section] isKindOfClass:[BigImageTypeDTO class]]) {
        BigImageTypeDTO *item =[self.listArr objectAtIndex:indexPath.section];
        
        return  [SingelImageCell height:item];
    }
    else if ([[self.listArr objectAtIndex:indexPath.section] isKindOfClass:[NSArray class]])
    {
        return 440;
    }
    
    return 30;
        
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc]init];
    view.backgroundColor =[UIColor clearColor];
    
    return view;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasMore] && indexPath.section == [self.listArr count])
    {
        static NSString *MoreCellIdentifier = @"MoreCellIdentifier";
        UITableViewMoreCell * cell = (UITableViewMoreCell*)[tableView dequeueReusableCellWithIdentifier:MoreCellIdentifier];
        
        if (cell == nil) {
            UITableViewMoreCell *cell = [[UITableViewMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoreCellIdentifier];
            cell.title = L(@"Get More...");
            cell.animating = NO;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];  
            cell.backgroundColor = [UIColor clearColor];
            cell.textLabel.textColor= [UIColor light_Black_Color];
            return cell;
        }
        
        cell.animating = NO;
        return cell;
    }
    
    if ([[self.listArr objectAtIndex:indexPath.section] isKindOfClass:[BigImageTypeDTO class]]) {
        BigImageTypeDTO *item =[self.listArr objectAtIndex:indexPath.section];
        
        static NSString *tableViewCellIdentifier1=@"tableViewCellIdentifier1";
        
        SingelImageCell *cell1=[tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier1];
        
        if (cell1==nil) {
            cell1=[[SingelImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellIdentifier1];
            
            [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
            
//            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }

        [cell1 setItem:item];
        
        return cell1;
    }
    else
    {
        static NSString *tableViewCellIdentifier2=@"tableViewCellIdentifier2";
        
        MoreImageTextCell *cell2=[tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier2];
        
        if (cell2==nil) {
            cell2=[[MoreImageTextCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellIdentifier2];
            
            [cell2 setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            cell2.userInteractionEnabled = YES;

        }
        
        [cell2 setData:[self.listArr objectAtIndex:indexPath.section]];
        cell2.delegate =self;
        
        return cell2;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == [self.listArr count]&&[self hasMore]) {
        [self loadMoreData];
        return;
    }
    
    if ([[self.listArr objectAtIndex:indexPath.section] isKindOfClass:[BigImageTypeDTO class]]) {
        BigImageTypeDTO *item = [self.listArr objectAtIndex:indexPath.section];
        SNInformationDetailViewController *VC=[[SNInformationDetailViewController alloc]initWithInfoId:item.infoId andsize:@"big"];
        [self.navigationController pushViewController:VC animated:YES];
        TT_RELEASE_SAFELY(VC);

    }
}

- (void)buttonClicked:(NSString *)infoId andSize:(NSString *)size
{
    SNInformationDetailViewController *VC=[[SNInformationDetailViewController alloc]initWithInfoId:infoId andsize:size];
    [self.navigationController pushViewController:VC animated:YES];
    TT_RELEASE_SAFELY(VC);
}
#pragma mark-refresh and load more data
- (void)refreshTableView
{
    [self.tableView reloadData];
}

- (void)refreshData{
    
    [super refreshData];
    
    self.currentPage = 1;
    
    self.isLastPage = YES;
    
    [self displayOverFlowActivityView];
    
    [self.informationService beginInformationListHttpRequest:[NSString stringWithFormat:@"%i", self.currentPage]];
}


- (void)loadMoreData{
    
    [super loadMoreData];
    
    [self startMoreAnimation:YES];

    [self displayOverFlowActivityView];
    
    [self.informationService beginInformationListHttpRequest:[NSString stringWithFormat:@"%i",self.currentPage]];
}


#pragma mark-informationServiceDelegate
- (void)informationServiceComplete:(SNInformationService *)service isSuccess:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
   
    if (self.isFromHead) {
        [self refreshDataComplete];
    }else{
        [self loadMoreDataComplete];
    }
    
    if (isSuccess) {
        isLoadOK = YES;
        
        if (self.isFromHead) {
            [self.listArr removeAllObjects];
            [self.listArr addObjectsFromArray:service.informationListArray];
        }
        else
        {
            [self.listArr addObjectsFromArray:service.informationListArray];
        }
        DLog(@"%@",self.listArr);
        
        if (self.currentPage<service.totalPage) {
            self.isLastPage=NO;
            self.currentPage ++;
        }
        else
        {
            self.isLastPage=YES;
        }

        [self.tableView reloadData];
    }
    else
    {
        isLoadOK = NO;
        NSString *errorMsg = self.informationService.errorMsg.trim.length?self.informationService.errorMsg:L(@"Imformation_NetworlLinkFailed");
        [self presentSheet:errorMsg];
    }
}

@end

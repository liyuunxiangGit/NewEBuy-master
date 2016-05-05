//
//  BusinessTravelRootViewController.m
//  SuningEBuy
//
//  Created by robin wang on 7/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BusinessTravelRootViewController.h"
#import "SearchHotelViewController.h"
#import "QueryPlaneViewController.h"
#import "MyTicketListViewController.h"
#import "BusinessCell.h"
#import "HotelOrderListViewController.h"
@implementation BusinessTravelRootViewController

@synthesize itemList = _itemList;

@synthesize vpTableView = _vpTableView;

@synthesize webView = _webView;

-(id)init
{
	if((self = [super init]))
	{ 
		self.title = L(@"BusinessTravelChannel");
        
        self.pageTitle = L(@"virtual_business_businessHall");
        
        if (!_itemList)
        {
            _itemList = [[NSArray alloc] initWithObjects: L(@"PanelOrder"),L(@"HotelOrder"), nil];
        }
	}
	
    return self;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_vpTableView);
    
    TT_RELEASE_SAFELY(_itemList);
    
    TT_RELEASE_SAFELY(_webView);
    
}

- (void)loadView
{
    [super loadView];
    
    UIView *contentView = self.view;
    
    CGRect frame = contentView.frame;
    
    frame.origin.x = 0;
    frame.origin.y = 0;
//    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7) {
//        frame.origin.y = -15;
//    }
    frame.size.height = contentView.bounds.size.height - 44;
    
    self.groupTableView.frame = frame;
    
    [self.groupTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.groupTableView];
    
    self.hasSuspendButton=YES;
}

- (UITableView *)vpTableView
{
    if(!_vpTableView){
		
        _vpTableView = [[GradientBackgroundTable alloc] initWithFrame:CGRectZero
                                                                style:UITableViewStyleGrouped];    
		
		
		[_vpTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
		
		[_vpTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_vpTableView.scrollEnabled = YES;
		
		_vpTableView.userInteractionEnabled = YES;
		
		_vpTableView.delegate =self;
		
		_vpTableView.dataSource =self;
		
		_vpTableView.backgroundColor =[UIColor clearColor];
		
        _vpTableView.backgroundView =  nil;
	}
	
	return _vpTableView;
    
}

-(UIWebView*)webView
{
    if(_webView == nil)
    {
        _webView = [[UIWebView alloc]init];
    }
    
    return  _webView;
}

#pragma mark -
#pragma mark Table View Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {    
            return 1;
            break;
        }    
            
        case 1:
        {    
            return 1;
            break;
        } 
            
        case 2:
        {    
            return 3;//为兼容ios6,headsectionView展示我的酒店机票用cell代替
            break;
        }
        case 3:
        {
            return 1;
            break;
        }
        default:
            break;
    }
    
    return [self.itemList count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2&&indexPath.row==0) {
        return 25;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 15)];
    
    if(IOS7_OR_LATER)
    {
        view.backgroundColor = [UIColor uiviewBackGroundColor];
        
    }
    else
    {
        view.backgroundColor = [UIColor clearColor];
        
    }
    
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {    
            
            static NSString *PanelCellIdentifier = @"PanelCellIdentifier";

            BusinessCell* cell=[tableView dequeueReusableCellWithIdentifier:PanelCellIdentifier];

            if (cell==nil) {
                cell=[[BusinessCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PanelCellIdentifier];
                cell.titleLbl.text=L(@"Panel");
            }
            return cell;
            
            break;
        }   
            
        case 1:
        {    
            
            static NSString *VirtualProductCellIdentifier = @"VirtualProductCellIdentifier";
            

            BusinessCell* cell=[tableView dequeueReusableCellWithIdentifier:VirtualProductCellIdentifier];
            
            if (cell==nil) {
                cell=[[BusinessCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:VirtualProductCellIdentifier];
                cell.titleLbl.text=L(@"Hotel");
            }
            return cell;
            break;
        } 
            
        case 2:
        {
            //模拟headSectionView展示我的酒店机票
            if (indexPath.row==0) {
                static NSString *headSectionCell = @"headSectionCell";
                
                
                UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:headSectionCell];
                
                if (cell==nil) {
                    cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headSectionCell];
                    cell.backgroundView=nil;
                    cell.backgroundColor=[UIColor clearColor];
                    
                    UILabel* headSectionLbl=[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 18)];
                    headSectionLbl.textColor=[UIColor dark_Gray_Color];
                    headSectionLbl.backgroundColor=[UIColor clearColor];
                    headSectionLbl.font=[UIFont boldSystemFontOfSize:17.0];
                    headSectionLbl.text=L(@"MyHotelPanelTicket");
                    
                    [cell addSubview:headSectionLbl];
                }
                return cell;
            }
            
            //机票订单和酒店订单cell
            static NSString *BussinessInfoCellIdentifier = @"BussinessInfoCellIdentifier_root";
            

            BusinessCell* cell=[tableView dequeueReusableCellWithIdentifier:BussinessInfoCellIdentifier];
            
            if (cell==nil) {
                cell=[[BusinessCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BussinessInfoCellIdentifier];
                cell.titleLbl.text=[self.itemList objectAtIndex: indexPath.row-1];//减掉1
            }
            if (indexPath.row==1) {
                cell.bottomLineImgView.hidden=YES;//去掉重复的line
            }
            return cell;
            break;
        }
        case 3:
        {
            static NSString *callServiceNumIdentifier = @"callServiceNumIdentifier";
            
            BusinessCell* cell=[tableView dequeueReusableCellWithIdentifier:callServiceNumIdentifier];
            
            if (cell==nil) {
                cell=[[BusinessCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:callServiceNumIdentifier];
                cell.titleLbl.text=L(@"travelServiceNum");
            }
            return cell;
            break;
            
        }
        default:
            break;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch ([indexPath section]) {
        case 0:
        {
            self.hidesBottomBarWhenPushed = YES;
            QueryPlaneViewController *next = [[QueryPlaneViewController alloc] init];
            [self.navigationController pushViewController:next animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }  
        case 1:
        {
            SearchHotelViewController *next = [[SearchHotelViewController alloc] init];
            [self.navigationController pushViewController:next animated:YES];

            break;
        }
        case 2:
        {
            if (indexPath.row ==1) {
                MyTicketListViewController *TV = [[MyTicketListViewController alloc] init];
                TV.isFromAllOrderCenter = NO;
                [self.navigationController pushViewController:TV animated:YES];
                
                TT_RELEASE_SAFELY(TV);
                
            }else if (indexPath.row ==2){
                
                HotelOrderListViewController *nextController = [[HotelOrderListViewController alloc] init];
                nextController.isFromAllOrderCenter=0;
                [self.navigationController pushViewController:nextController animated:YES];
                
            
            }
            break;
        }
        case 3:
        {
            [self callHotLine];
            break;
        }
         default:
            break;
    }
}

- (BOOL)checkHardWareIsSupportCallHotLine
{
    
    BOOL isSupportTel = NO;
    
    NSURL *telURL = [NSURL URLWithString:@"tel://4006766766"];
    
    isSupportTel = [[UIApplication sharedApplication] canOpenURL:telURL];
    
    return isSupportTel;
    
}

- (void)callHotLine
{
    if ([self checkHardWareIsSupportCallHotLine]) {
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://4006766766"]]];
        
    }else{
        
        BBAlertView *alert = [[BBAlertView alloc]
                              initWithTitle:L(@"Tips")
                              message:L(@"Sorry, Unsupport call tel \n hotline:4006766766")
                              delegate:nil
                              cancelButtonTitle:L(@"Ok")
                              otherButtonTitles:nil];
        [alert show];
    }
}



@end

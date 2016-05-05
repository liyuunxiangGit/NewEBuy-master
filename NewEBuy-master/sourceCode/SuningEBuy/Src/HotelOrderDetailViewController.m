//
//  HotelOrderDetailViewController.m
//  SuningEBuy
//
//  Created by Qin on 14-2-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "HotelOrderDetailViewController.h"

@interface HotelOrderDetailViewController ()

@end

@implementation HotelOrderDetailViewController

@synthesize postDto = _postDto;

@synthesize parseDto = _parseDto;

//@synthesize vpTableView = _vpTableView;

@synthesize totle=_totle;
@synthesize totlePriceLbl=_totlePriceLbl;
- (id)init
{
    self = [super init];
    
    if (self) {
        
        self.title = L(@"hotelOrderDetail");
        
        self.pageTitle = L(@"virtual_business_hotelOrderDetail");
        
        isLoaderOK = NO;
        
        
        
    }
    
    return self;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_postDto);
    
    TT_RELEASE_SAFELY(_parseDto);
    
//    TT_RELEASE_SAFELY(_vpTableView);
    
}

- (void)HttpRelease
{
    DLog(@"Http Release \n");
    
    HTTP_RELEASE_SAFELY(sendCommendASIHTTPRequest);
}

#pragma mark -
#pragma mark View lifecycle
//- (UITableView *)vpTableView
//{
//    if(!_vpTableView){
//		
//        _vpTableView = [[GradientBackgroundTable alloc] initWithFrame:CGRectZero
//                                                                style:UITableViewStyleGrouped];
//		
//		
//		[_vpTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//		
//		[_vpTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
//		
//		_vpTableView.scrollEnabled = YES;
//		
//		_vpTableView.userInteractionEnabled = YES;
//		
//		_vpTableView.delegate =self;
//		
//		_vpTableView.dataSource =self;
//		
//		_vpTableView.backgroundColor =[UIColor clearColor];
//		
//        _vpTableView.backgroundView = nil;
//	}
//	
//	return _vpTableView;
//    
//}
-(void)bottomView
{
    [self useBottomNavBar];
    
    [self.bottomNavBar addSubview:self.totle];
    [self.bottomNavBar addSubview:self.totlePriceLbl];
    self.bottomNavBar.backButton.hidden=YES;
    self.bottomNavBar.hidden=YES;//数据加载完成再显示

}
-(UILabel*)totle
{
    if (_totle==nil) {
        _totle=[[UILabel alloc] initWithFrame:CGRectMake(60,15,80, 20)];
        _totle.backgroundColor=[UIColor clearColor];
        _totle.textColor=[UIColor light_Black_Color];
        _totle.font=[UIFont systemFontOfSize:17];
        _totle.textAlignment=UITextAlignmentRight;
        _totle.text=L(@"BTTotal");
    }
    return _totle;
}

-(UILabel*)totlePriceLbl
{
    if (_totlePriceLbl==nil) {
        _totlePriceLbl=[[UILabel alloc] initWithFrame:CGRectMake(145,15,140, 20)];
        _totlePriceLbl.backgroundColor=[UIColor clearColor];
        _totlePriceLbl.textColor=[UIColor orange_Red_Color];
        _totlePriceLbl.font=[UIFont systemFontOfSize:17];
        _totlePriceLbl.textAlignment=UITextAlignmentLeft;
    }
    return _totlePriceLbl;
}
- (void)loadView
{
    [super loadView];
    
    UIView *contentView = self.view;
    
    CGRect frame = contentView.frame;
    
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.height = contentView.bounds.size.height - 92;
    
    self.groupTableView.frame = frame;
    
    [self.view addSubview:self.groupTableView];
    [self.groupTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.groupTableView.hidden=YES;
    
    [self bottomView];
        // [self.tableView addSubview:(UIView*)self.refreshHeaderView];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (isLoaderOK== NO) {
        [self sendListHttpRequest];
    }
}
//-(UILabel*)totle
#pragma mark -
#pragma mark Http Request

- (void)sendListHttpRequest
{
    [self displayOverFlowActivityView];
    
    self.groupTableView.userInteractionEnabled = NO;
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    NSString *userId = [UserCenter defaultCenter].userInfoDTO.userId;
    
    [postDataDic setObject:(userId == nil ? @"" : userId)
                    forKey:@"memberId"];
    
    [postDataDic setObject:self.postDto.orderUid forKey:@"hotelOrderId"];
    
    HTTP_RELEASE_SAFELY(sendCommendASIHTTPRequest);
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostHotelOrderForHttp,KHotelOrderDetail];
    
    sendCommendASIHTTPRequest = [Http sendHttpRequest:@"get history recharge List"
                                                  URL:url
                                              isHttps:YES
                                           UrlParaDic:postDataDic
                                             Delegate:self
                                       SucessCallback:@selector(requestListOk:)
                                         FailCallback:@selector(requestListFail:)];
    
    
    TT_RELEASE_SAFELY(postDataDic);
    
    if (!sendCommendASIHTTPRequest) {
        
        [self removeOverFlowActivityView];
        
        self.groupTableView.userInteractionEnabled = YES;
        
        return;
    }
    
}

- (void)requestListOk:(ASIFormDataRequest *)request
{
    NSDictionary *items = request.jasonItems;
	
	DLog(@"requestMobilePayHistory from server  NSUrlString=%@\n",[items description]);
    
    [self removeOverFlowActivityView];
    
    self.groupTableView.userInteractionEnabled = YES;
    
    [self parseHttpRequestList:items];
    
}

- (void)requestListFail:(ASIFormDataRequest *)request
{
    [self removeOverFlowActivityView];
    
    self.groupTableView.userInteractionEnabled = YES;
    
    [self presentCustomDlg:L(@"Please check your network")];
    
}

- (void)showInfo:(NSString *)infomation
{
    if (infomation == nil || [infomation isEqualToString:@""])
    {
        [self presentSheet:@"error" posY:80];
        
        return;
    }
    
    [self presentSheet:infomation posY:80];
}

- (void)refreshTableView
{
    self.bottomNavBar.hidden=0;
    self.totlePriceLbl.text=[NSString stringWithFormat:@"￥%.2f",[self.parseDto.totalPrice doubleValue]];
    
    self.groupTableView.hidden=0;
    [self.groupTableView reloadData];
}

- (void)parseHttpRequestList:(NSDictionary *)items
{
    if (IsNilOrNull(items))
    {
        return;
    }
    
    HotelOrderDetailDTO *tempDto = [[HotelOrderDetailDTO alloc] init];
    
    [tempDto encodeFromDictionary:items];
    
    self.parseDto = tempDto;
    
    
    [self refreshTableView];
}

#pragma mark -
#pragma mark Table View Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15;
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            return [HotelInfoCell cellHeightWithDto:self.parseDto];
            break;
        }
            
        case 1:
        {
            return 75;
            break;
        }
            
        case 2:
        {
            return 140;
            break;
        }
           
        case 3:
        {
            return 120;
            break;
        }
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:
        {
            static NSString *hotelInfoCellIdentifier = @"HotelInfoCellIdentifier";
            
            HotelInfoCell *cell = (HotelInfoCell *)[tableView dequeueReusableCellWithIdentifier:hotelInfoCellIdentifier];
            
            if(cell == nil){
                
                cell = [[HotelInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hotelInfoCellIdentifier];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            
            [cell setHotelInfoCellWithDto:self.parseDto];
            
            return cell;
            
            break;
        }
            
        case 1:
        {
            static NSString *payInfoCellIdentifier = @"PayInfoCellIdentifier";
            
            PayInfoCell *cell = (PayInfoCell *)[tableView dequeueReusableCellWithIdentifier:payInfoCellIdentifier];
            
            if(cell == nil){
                
                cell = [[PayInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:payInfoCellIdentifier];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                
            }
            
            [cell setPayInfoCellWithDto:self.parseDto];
            
            return cell;
            
            break;
        }
            
        case 2:
        {
            static NSString *manInfoCellIdentifier = @"ManInfoCellIdentifier";
            
            ManInfoCell *cell = (ManInfoCell *)[tableView dequeueReusableCellWithIdentifier:manInfoCellIdentifier];
            
            if(cell == nil){
                
                cell = [[ManInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:manInfoCellIdentifier];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                
            }
            
            [cell setManInfoCellWithDto:self.parseDto];
            
            return cell;
            
            break;
        }
        case 3:
        {
            static NSString *hotelOrderInfoCellIdentifier = @"HotelOrderInfoCellIdentifier";
            
            HotelOrderInfoCell *cell = (HotelOrderInfoCell *)[tableView dequeueReusableCellWithIdentifier:hotelOrderInfoCellIdentifier];
            
            if(cell == nil){
                
                cell = [[HotelOrderInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hotelOrderInfoCellIdentifier];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                
            }
            
            [cell setHotelOrderInfoCellWithDto:self.parseDto];
            
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
	
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section ==1) {
        return L(@"liveingInfo");
    }
    
    if (section ==2) {
        return L(@"ContactInfo");
    }
    
    return nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end

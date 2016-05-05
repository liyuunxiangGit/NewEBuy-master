//
//  MoreViewController.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-28.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "MoreViewController.h"
#import "PlaySoundAndShacking.h"
#import "BrowsingHistoryViewController.h"
#import "CheckUpdateCommand.h"
#import "SuningFamilyViewController.h"

#import "LoginViewController.h"
#import "LogOutCommand.h"
#import "UITableViewCell+BgView.h"
#import "EbuyRuleViewController.h"
#import "UserFeedBackController.h"
#import "CollectDeviceTokenCommand.h"
#define kAppId @"424598114"


@interface MoreViewController()
{
    dispatch_queue_t  _queue;
    
    MessageFilterSelecter  selecteType;
}

@property (nonatomic,strong) NSMutableArray              *cellsArray;

@property (nonatomic,strong) UITableView                 *messageFilterTableview;

@property (nonatomic,strong) UIImage                     *messageSelectedImage;

@property (nonatomic,strong) UIImage                     *messageUnselectedImage;

@property (nonatomic,strong) NSMutableArray              *selectedCellArray;

- (void)callHotLine;

- (void)jump2FiveStarsMark;

- (void)checkUpdateVersion;

@end

/*********************************************************************/

@implementation MoreViewController


@synthesize footView = _footView;
@synthesize logoutBtn = _logoutBtn;

- (void)dealloc {
    TT_RELEASE_SAFELY(_moreView);
    TT_RELEASE_SAFELY(_footView);
    TT_RELEASE_SAFELY(_logoutBtn);
    TT_RELEASE_SAFELY(_selectMark);
    TT_RELEASE_SAFELY(_messageFilterTableview);
    TT_RELEASE_SAFELY(_selectedCellArray);
    TT_RELEASE_SAFELY(_cellsArray);
    
    _moreView.owner = nil;
    _moreView.groupTableView.delegate = nil;
    _moreView.groupTableView.dataSource = nil;
    
    _messageFilterTableview.delegate = nil;
    _messageFilterTableview.dataSource =nil;
    
    if (_queue) {
        dispatch_release(_queue);
        _queue = 0x00;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init {
    self = [super init];
    if (self) {
        self.title = L(@"Settings");
        
        self.hidesBottomBarWhenPushed = YES;
        
        self.pageTitle = L(@"member_myEbuy_setting");

        _queue = dispatch_queue_create([[NSString stringWithFormat:@"suning.%@", self] UTF8String], NULL);
        
        [self initialNotifications];
        quailtyType = [[Config currentConfig].imageQuailty intValue];
        
       // self.navigationController.navigationBar
    }
    return self;
}

- (void)initialNotifications{
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    
    [defaultCenter addObserver:self
                      selector:@selector(defaultCityDidChange:)
                          name:DEFAULT_CITY_CHANGE_NOTIFICATION
                        object:nil];
    
    [defaultCenter addObserver:self selector:@selector(lgoutOK:) name:LOGOUT_OK_NOTIFICATION object:nil];
}
#pragma mark -
#pragma mark view life cycle

- (void)loadView
{
    [super loadView];
    
    
    _moreView = [[MoreView alloc] initWithOwner:self];
    _moreView.owner = self;
    _moreView.backgroundColor = [UIColor uiviewBackGroundColor];
    self.view = _moreView;
    _moreView.groupTableView.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:!self.hidesBottomBarWhenPushed];


    _moreView.groupTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    _moreView.groupTableView.tag = 0;
    
    self.hasSuspendButton = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([UserCenter defaultCenter].isLogined)
    {
        _moreView.groupTableView.tableFooterView = self.footView;
    }
    
    [self.moreView.groupTableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (![_moreView.addressPickerView isLoadProvincesOk]) {
        [_moreView.addressPickerView reloadAddressData];
    }
}

- (SNShareKit *)shareKit
{
    if (!_shareKit) {
        _shareKit = [[SNShareKit alloc] initWithNavigationController:self.navigationController];
    }
    return _shareKit;
}

- (ChooseShareWayView *)chooseShareWayView
{
    if (!_chooseShareWayView) {
        _chooseShareWayView = [[ChooseShareWayView alloc] init];
        _chooseShareWayView.delegate = self;
    }
    return _chooseShareWayView;
}

#pragma mark -
#pragma mark address picker view method

- (void)addressPickerLoadDataOkWithSelectInfo:(AddressInfoDTO *)addressInfo
{
    _moreView.cityLabel.text = addressInfo.cityContent;
//    [_moreView.addressBtn setTitle:addressInfo.cityContent forState:UIControlStateNormal];
    
}


#pragma mark -
#pragma mark tool bar cell delegate
//doneClicked   //doneButtonClicked
- (void)doneClicked:(ToolBarCell *)sender
{
    AddressInfoDTO *selectInfo = _moreView.addressPickerView.selectAddressInfo;
    if (selectInfo.province == nil ||
        selectInfo.city == nil) {
        return;
    }
    [Config currentConfig].defaultProvince = _moreView.addressPickerView.selectAddressInfo.province;
    [Config currentConfig].defaultCity = _moreView.addressPickerView.selectAddressInfo.city;
    NSNotification *notification = 
    [NSNotification notificationWithName:DEFAULT_CITY_CHANGE_NOTIFICATION
                                  object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    _moreView.cityLabel.text = _moreView.addressPickerView.selectAddressInfo.cityContent;
    [_moreView.addressBtn setTitle:_moreView.addressPickerView.selectAddressInfo.cityContent forState:UIControlStateNormal];
    [_moreView.groupTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
    [sender resignFirstResponder];
}

- (void)cancelButtonClicked:(id)sender{
    
}

#pragma mark -
#pragma mark table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 0) {
        return 6;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 0)
    {
        switch (section) {
            case 0:
                return 1;
                break;
            case 1:
                return 3;
            case 2:
                return 1;
                break;
            case 3:
                return 1;
                break;
            case 4:
                return 4;
                break;
            case 5:
                return 1;
                break;
            default:
                break;
        }
    }else {
        return 3;
    }
    
    return 0;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    
//    if (2 == section) {
//        
//        NSString *headTitle = @"图片显示质量";
//        
//        
//        return headTitle;
//    }
//    
//    return nil;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 0) {
        if (1 == section) {
            return 30;
        }
        return 10;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 0) {
        if (section == 1) {
            UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
            headView.backgroundColor = self.view.backgroundColor;
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 160, 20)];
            titleLabel.text = L(@"Image quality");
            titleLabel.textColor = [UIColor dark_Gray_Color];
            titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            titleLabel.textAlignment = UITextAlignmentLeft;
            titleLabel.backgroundColor = [UIColor clearColor];
            
            [headView addSubview:titleLabel];
            
            return headView;
        }
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.0001)];
        v.backgroundColor = [UIColor clearColor];
        return v;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (tableView.tag == 0) {
        if (section == 5
            && [UserCenter defaultCenter].isLogined)
        {
            return self.footView;
        }
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.0001)];
        v.backgroundColor = [UIColor clearColor];
        return v;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 0) {
        static NSString *moreCellIdentifier = @"moreCellIdentifier";
        
        ToolBarCell *cell = [tableView dequeueReusableCellWithIdentifier:moreCellIdentifier];
        if (cell == nil) {
            cell = [[ToolBarCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:moreCellIdentifier];
            cell.toolBarDelegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.canBecomeFirstRes = NO;
            //cell.backgroundColor = [UIColor cellBackViewColor];
            cell.textLabel.textColor = [UIColor light_Black_Color];
            cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        }
        else
        {
            cell.textLabel.text = @"";
            cell.detailTextLabel.text = @"";
            cell.accessoryView = nil;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.canBecomeFirstRes = NO;
            cell.inputView = nil;
            
            [cell.contentView removeAllSubviews];
        }
        
        UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellDetail.png"]];
        //arrow.frame = CGRectMake(0, 0, 18/2, 29/2);
        
        
        switch (indexPath.section) {
            case 0:
            {
                if (indexPath.row == 0) {
                    
                    cell.textLabel.text = L(@"Delivery City");
                    //cell.accessoryView = _moreView.addressBtn;
                    // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.accessoryView = arrow;
                    cell.canBecomeFirstRes = YES;
                    cell.inputView = _moreView.addressPickerView;
                    [cell.contentView addSubview:_moreView.cityLabel];
                    // _moreView.addressBtn.inputView = _moreView.addressPickerView;
                }
                
                break;
            }
            case 1:{
                
                switch (indexPath.row) {
                    case 0:
                    {
                        cell.textLabel.text = L(@"Intelligent model");
                        if (AUTO_QUAILTY == quailtyType) {
                            
                            cell.accessoryView = self.selectMark;
                        }
                    }
                        break;
                    case 1:
                    {
                        cell.textLabel.text = L(@"High quality (for Wifi)");
                        if (HEIGHT_QUAILTY == quailtyType) {
                            
                            cell.accessoryView = self.selectMark;
                        }
                    }
                        break;
                    case 2:
                    {
                        cell.textLabel.text = L(@"Ordinary (for 3G or 2G environment)");
                        if (LOW_QUAILTY == quailtyType) {
                            
                            cell.accessoryView = self.selectMark;
                        }
                    }
                        break;
                    default:
                        break;
                }
                
            }
                break;
            case 2:
            {
                if (indexPath.row == 0) {
                    cell.textLabel.text=L(@"Image Cache");
                    //cell.accessoryView = _moreView.imageMemoryLabel;
                    
                    //chupeng 2014.3.31 不再提示缓存大小
                    //[cell.contentView addSubview:_moreView.imageMemoryLabel];
                    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.accessoryView = arrow;
                }
                
                break;
            }
            case 3:
            {
                if (indexPath.row == 0) {
                    
                    cell.textLabel.text= L(@"Message settings");
                    
                    cell.accessoryView = arrow;
                }
                
                break;
            }
            case 4:
            {
                switch (indexPath.row) {
                    case 2:
                    {
                        cell.textLabel.text=L(@"Share to friends");
                        cell.accessoryType = UITableViewCellAccessoryNone;
                    }
                        break;
                    case 0:
                    {
                        cell.textLabel.text = L(@"SuningFamily·SuningEBuy");
                        
                    }
                        break;
                    case 1:
                    {
                        cell.textLabel.text = L(@"CheckUpdate");
                        
                        [cell.contentView addSubview:_moreView.versionLabel];
                    }
                        break;
                        
                    case 3:
                    {
                        cell.textLabel.text = L(@"CommentEBuy");
                    }
                        break;
                        
                        
                    default:
                        break;
                }
                break;
            }
            case 5:
            {
                switch (indexPath.row) {
                        
                        //                case 0:
                        //                {
                        //                    cell.textLabel.text = @"法律声明";
                        //                }
                        //                    break;
                    case 0:
                    {
                        cell.textLabel.text = L(@"HotLine");
                        cell.customLabel.text = @"4008-365-365";
                        cell.customLabel.frame = CGRectMake(125, 9, 150, 26);
                        cell.customLabel.textAlignment = UITextAlignmentRight;
                        [cell.contentView addSubview:cell.customLabel];
                    }
                        break;
                        
                    default:
                        break;
                }
                break;
            }
            default:
                break;
        }
        return cell;
    }else{
        static NSString *messageFilterCellIdentifier = @"messageFilterCellIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:messageFilterCellIdentifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:messageFilterCellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.textLabel.textColor = [UIColor light_Black_Color];
            
            cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0f];
            
            UIImageView *MessageFilterSelectMark = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 14, 14)];
            
            MessageFilterSelectMark.image = self.messageUnselectedImage;
            
            cell.accessoryView = MessageFilterSelectMark;
        }
        
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = L(@"Push message screening");
                
                if (selecteType == MessageFilterSelectAll)
                {
                    UIImageView *imageView = (UIImageView*)cell.accessoryView;
                    
                    imageView.image = self.messageSelectedImage;
                    
                    [_selectedCellArray addObject:cell];
                }
                
                break;
            }
            case 1:
            {
                cell.textLabel.text = L(@"Promotional messages");
                
                if (selecteType == MessageFilterSelectAll||selecteType == MessageFilterSelectSalesPromotion||selecteType == MessageFilterSelectSalesPromotionAndLogistic||selecteType == MessageFilterSelectSalesPromotionAndPersonality)
                {
                    UIImageView *imageView = (UIImageView*)cell.accessoryView;
                    
                    imageView.image = self.messageSelectedImage;
                    
                    [_selectedCellArray addObject:cell];
                }
                
                break;
            }
            case 2:
            {
                cell.textLabel.text = L(@"Personalized recommendation");
                
                if (selecteType == MessageFilterSelectAll||selecteType == MessageFilterSelectPersonality||selecteType == MessageFilterSelectPersonalityAndLogistic||selecteType == MessageFilterSelectSalesPromotionAndPersonality)
                {
                    UIImageView *imageView = (UIImageView*)cell.accessoryView;
                    
                    imageView.image = self.messageSelectedImage;
                    
                    [_selectedCellArray addObject:cell];
                }
                
                break;
            }
            /*case 3:
            {
                cell.textLabel.text = @"物流消息";
                
                if (selecteType == MessageFilterSelectAll||selecteType == MessageFilterSelectLogistic||selecteType == MessageFilterSelectPersonalityAndLogistic||selecteType == MessageFilterSelectSalesPromotionAndLogistic)
                {
                    UIImageView *imageView = (UIImageView*)cell.accessoryView;
                    
                    imageView.image = [UIImage imageNamed:@"MessageFilterCheck"];
                    
                    [_selectedCellArray addObject:cell];
                }
                
                break;
            }*/
            default:
                break;
        }
        
        [_cellsArray addObject:cell];
        
        return cell;
    }
    return nil;
}

- (void)singleSelectCell:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [_moreView.groupTableView indexPathForCell:cell];
    
    switch (indexPath.section) {
        case 0:
            
            break;
        case 1:{
            
            quailtyType = indexPath.row;
            [Config currentConfig].imageQuailty = [NSNumber numberWithInt:quailtyType];
            [_moreView.groupTableView reloadData];
        }
            break;
        case 2:{
            
            [self clearImageMemory:nil];
        }
            break;
        case 3:{
            
            BBAlertView *messageFilterAlert = [[BBAlertView alloc]initWithStyle:BBAlertViewStyleMessageFilter Title:nil message:nil customView:self.messageFilterTableview delegate:self cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];
            
            
            [messageFilterAlert show];
            
            break;
        }
        case 4:
        {
            
            switch (indexPath.row) {
                case 2:
                {
                    [self share];
                }
                    break;
                case 0:
                {
                    SuningFamilyViewController *vc = [SuningFamilyViewController controller];
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 1:
                {
                    [self checkUpdateVersion];
                    break;
                }

                case 3:
                {
                 
                   // [self jump2FiveStarsMark];
                    
                    UserFeedBackController *userFeedBackViewController = [[UserFeedBackController alloc] init];
                    
                    [self.navigationController pushViewController:userFeedBackViewController animated:YES];
                }
                     break;
                default:
                    break;
            }
            break;
            
        
            
        }

        case 5:{
            switch (indexPath.row) {
//
//                case 0:
//                {
//
//                    [self gotoRuler];
//                    break;
//                }
                case 0:
                {
                    [self callHotLine];
                    break;
                }
                    
                default:
                    break;
            }
            break;
        }
            break;
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        UIImageView *imageView = (UIImageView*)cell.accessoryView;
        
        switch (indexPath.row) {
            case 0:
            {
                [_selectedCellArray removeAllObjects];
                
                if (imageView.image == self.messageSelectedImage)
                {
                    for (UITableViewCell *item in _cellsArray)
                    {
                        UIImageView *itemImageView = (UIImageView*)item.accessoryView;
                        
                        itemImageView.image = self.messageUnselectedImage;
                    }
                }else{
                    for (UITableViewCell *item in _cellsArray)
                    {
                        UIImageView *itemImageView = (UIImageView*)item.accessoryView;
                        
                        itemImageView.image = self.messageSelectedImage;
                        
                        [_selectedCellArray addObject:item];
                    }
                }
                
                break;
            }
            default:
            {
                if (imageView.image == self.messageSelectedImage)
                {
                    imageView.image = self.messageUnselectedImage;
                    
                    if ([_selectedCellArray containsObject:[_cellsArray objectAtIndex:0]])
                    {
                        [_selectedCellArray removeObject:[_cellsArray objectAtIndex:0]];
                        
                        UITableViewCell *firstCell = (UITableViewCell*)[_cellsArray objectAtIndex:0];
                        
                        UIImageView *itemImageView = (UIImageView*)firstCell.accessoryView;
                        
                        itemImageView.image = self.messageUnselectedImage;
                    }
                    
                    [_selectedCellArray removeObject:cell];
                    
                }else{
                    imageView.image = self.messageSelectedImage;
                    
                    [_selectedCellArray addObject:cell];
                }
                
                break;
            }
        }
        
        if ([_selectedCellArray count] == 2)
        {
            cell = [_cellsArray objectAtIndex:0];
            
            UIImageView *imageView = (UIImageView*)cell.accessoryView;
            
            imageView.image = self.messageSelectedImage;
            
            [_selectedCellArray addObject:cell];
        }
    }
}

#pragma mark -
#pragma mark actions
                                       
-(UITableView*)messageFilterTableview
{
    if (!_messageFilterTableview)
    {
        _cellsArray = [[NSMutableArray alloc] init];
        
        _selectedCellArray = [[NSMutableArray alloc]init];
        
        selecteType = [[Config currentConfig].messageFilter intValue];
        
        _messageFilterTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 280, 132) style:UITableViewStylePlain];
        
        _messageFilterTableview.scrollEnabled = NO;
        
        _messageFilterTableview.delegate = self;
        
        _messageFilterTableview.dataSource = self;
        
        _messageFilterTableview.tag = 1;
        
    }
    return _messageFilterTableview;
}

-(UIImage*)messageSelectedImage
{
    if (!_messageSelectedImage)
    {
        _messageSelectedImage = [UIImage imageNamed:@"MessageFilterCheck"];
    }
    
    return _messageSelectedImage;
}

-(UIImage*)messageUnselectedImage
{
    if (!_messageUnselectedImage)
    {
        _messageUnselectedImage = [UIImage imageNamed:@"TuisongFilterUnselected"];
    }
    
    return _messageUnselectedImage;
}

-(void)gotoRuler{
    
    EbuyRuleViewController *v = [[EbuyRuleViewController alloc] init];
    
    [self.navigationController pushViewController:v animated:YES];
}

- (void)share
{
    [self.shareKit shareWithContent:[self getShareContent]];
    [self.shareKit setShareTitle:L(@"More_Share_Title")];
    
    [self.chooseShareWayView showChooseShareWayView];
}

- (void)chooseShareWay:(SNShareType)shareWay
{
    [self.shareKit didChooseShareWay:shareWay];
}

- (NSString *)getShareContent
{
    
    NSString *content=[NSString stringWithFormat:@"%@",L(@"More_Share_Content")];
    return content;
}

- (void)soundControl:(id)sender
{
    UISwitch *musicSwitch = (UISwitch *)sender;
    
	[Config currentConfig].isSoundOn = [NSNumber numberWithBool:musicSwitch.on];
    
    if (musicSwitch.on)
    {
        [PlaySoundAndShacking playSound];
    }
}

- (void)reloadTableView
{
    [self.groupTableView reloadData];
}

//add by wangjiaxing 星级评分
- (void)jump2FiveStarsMark
{
    
    NSString *str = [NSString stringWithFormat:  
                     @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", kAppId];   
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:str]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]]; 
    }
    else
    {
        DLog(@"bu zhichi ");
    }
    
}


//add by wangjiaxing 清除缓存图片
- (void)clearImageMemory:(id)sender
{
    BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:nil message:L(@"If Clear Image Cache") delegate:self cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];
    [alertView setConfirmBlock:^{
        
        [self displayOverFlowActivityView:L(@"More_Clear_Mem_Loading")];
        
        SNImageCacheClearWithCompletion(^{
            
            [self clearMemoryDidOk];
        });
        
    }];
    [alertView show];
}

- (void)clearMemoryDidOk
{
    [self removeOverFlowActivityView];
    [self presentSheet:L(@"More_Clear_Mem_Success")];
}

- (void)checkUpdateVersion
{
    [self displayOverFlowActivityView:L(@"CheckingUpdate...")];
    CheckUpdateCommand *command = [[CheckUpdateCommand alloc] initWithCheckUpdateMode:ManualCleck];
    [CommandManage excuteCommand:command completeBlock:^(id<Command> cmd) {
        
        if (!command.needUpdate) {
            
            self.moreView.versionLabel.text = [NSString stringWithFormat:@"%@: %@",L(@"Latest version"),[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
        }
        
        [self removeOverFlowActivityView];
    }];
}

- (BOOL)checkHardWareIsSupportCallHotLine
{
    
    BOOL isSupportTel = NO;
    
    NSURL *telURL = [NSURL URLWithString:@"tel://4008365365"];
    
    isSupportTel = [[UIApplication sharedApplication] canOpenURL:telURL];
    
    return isSupportTel;
    
}

- (void)callHotLine
{
    if ([self checkHardWareIsSupportCallHotLine]) {
        [_moreView.callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://4008365365"]]];
    }else{
        [self presentCustomDlg:L(@"Sorry, Unsupport call tel \n hotline: 4008-365-365")];
    }
}

//- (void)showAddressPickView:(id)sender{
//    self.inputView = self.moreView.addressPickerView;
//}

- (void)defaultCityDidChange:(NSNotification *)notification
{
    NSNumber *isNeedRefresh = [notification object];
    if (isNeedRefresh && 
        [isNeedRefresh isKindOfClass:[NSNumber class]] &&
        ![isNeedRefresh boolValue]) {
        //do nothing
    }else{
        //刷新默认地址
        AddressInfoDTO *dto = [[AddressInfoDTO alloc] init];
        dto.province = [Config currentConfig].defaultProvince;
        dto.city = [Config currentConfig].defaultCity;
        _moreView.addressPickerView.baseAddressInfo = dto;
        TT_RELEASE_SAFELY(dto);
        //[_moreView.addressPickerView reloadAddressData];
    }
    
}

- (UIView *)footView{
    if (_footView == nil) {
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
        [_footView addSubview:self.logoutBtn];        
    }
    return  _footView;
}

- (UIImageView *)selectMark{
    if (_selectMark == nil) {
        _selectMark = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 12, 9)];
        
        _selectMark.image = [UIImage imageNamed:@"cellMark.png"];
    }
    return  _selectMark;
}

- (UIButton *)logoutBtn
{
    if (_logoutBtn == nil) {
        _logoutBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 300, 40)];
        _logoutBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [_logoutBtn setBackgroundImage:[UIImage streImageNamed:@"orange_button.png"] forState:UIControlStateNormal];
        [_logoutBtn setBackgroundImage:[UIImage streImageNamed:@"orange_button_clicked.png"] forState:UIControlStateHighlighted];
        [_logoutBtn setTitle:L(@"LogoutTitle") forState:UIControlStateNormal];
        [_logoutBtn addTarget:self action:@selector(loginLogoutAction) forControlEvents:UIControlEventTouchUpInside];
        _logoutBtn.backgroundColor = [UIColor clearColor];
    }
    return _logoutBtn;
}

- (void)loginLogoutAction{
    
    if ([UserCenter defaultCenter].isLogined) {
        
        BBAlertView *alertView = [[BBAlertView alloc] initWithStyle:BBAlertViewStyleDefault
                                                              Title:L(@"Logout System")
                                                            message:L(@"Logout Confirm")
                                                         customView:nil
                                                           delegate:nil
                                                  cancelButtonTitle:L(@"Cancel")
                                                  otherButtonTitles:L(@"Ok")];
        
        MoreViewController *__weak weakSelf = self;
        
        [alertView setConfirmBlock:^{
            
            [weakSelf displayOverFlowActivityView];
            
            LogOutCommand *logOutCmd = [LogOutCommand command];
            [CommandManage excuteCommand:logOutCmd completeBlock:^(id<Command> cmd){
                // xzoscar 2014-07-24 modify
                // Desc : 要求注销后 进入登录页面
                [weakSelf removeOverFlowActivityView];
                
                if (nil != weakSelf.delegate
                    && [weakSelf.delegate respondsToSelector:@selector(delegate_moreViewController_logout)]) {
                    [weakSelf.delegate delegate_moreViewController_logout];
                }
            }];
            
        }];
        
        [alertView show];
        
        TT_RELEASE_SAFELY(alertView);
        
        
    }else{
        
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        
        loginVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        
        AuthManagerNavViewController *authorController = [[AuthManagerNavViewController alloc] initWithRootViewController:loginVC];
        
        [self presentModalViewController:authorController animated:YES];
        
        TT_RELEASE_SAFELY(loginVC);
        
        TT_RELEASE_SAFELY(authorController);
        
    }
    
}

#pragma mark - Tapped Action Methods
#pragma mark   点击事件的相应处理

//注销操作结束的通知处理逻辑。
- (void)lgoutOK:(NSNotification *)notification{
    [self removeOverFlowActivityView];
    if (![UserCenter defaultCenter].isLogined) {
        //注销成功
        
        //去首页
        [self.navigationController popViewControllerAnimated:NO];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"lgoutOK" object:nil];
        
    }else{
        //注销失败
        
        NSDictionary *dic = notification.userInfo;
        
        NSString *errorDesc = [dic objectForKey:@"errorDesc"];
        
        [self presentSheet:errorDesc];
        
    }
    
    //    [self changeUserStatus];
        
}

- (void)alertView:(BBAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        switch ([_selectedCellArray count]) {
            case 0:
            {
                [Config currentConfig].messageFilter = [NSNumber numberWithInt:MessageFilterSelectNone];
            }
                break;
            case 1:
            {
                int type = [_cellsArray indexOfObject:[_selectedCellArray objectAtIndex:0]];
                
                if (type == 0)
                {
                    selecteType = MessageFilterSelectAll;
                    
                }else if (type == 1)
                {
                    selecteType = MessageFilterSelectSalesPromotion;
                    
                }else if (type == 2)
                {
                    selecteType = MessageFilterSelectPersonality;
                }else{
                    
                    selecteType = MessageFilterSelectLogistic;
                }
                
                [Config currentConfig].messageFilter = [NSNumber numberWithInt:selecteType];
                
                break;
            }
            case 2:
            {
                int type = [_cellsArray indexOfObject:[_selectedCellArray objectAtIndex:0]];
                
                int type1 = [_cellsArray indexOfObject:[_selectedCellArray objectAtIndex:1]];
                
                if ((type == 1&&type1 == 2)||(type == 2&&type1 == 1))
                {
                    selecteType = MessageFilterSelectSalesPromotionAndPersonality;
                    
                }else if ((type == 1&&type1 == 3)||(type == 3&&type1 == 1))
                {
                    selecteType = MessageFilterSelectSalesPromotionAndLogistic;
                    
                }else
                {
                    selecteType = MessageFilterSelectPersonalityAndLogistic;
                }
                
                [Config currentConfig].messageFilter = [NSNumber numberWithInt:selecteType];
                break;
            }
            default:
                [Config currentConfig].messageFilter = [NSNumber numberWithInt:MessageFilterSelectAll];
                break;
        }
        
        CollectDeviceTokenCommand *command = [CollectDeviceTokenCommand command];
        
        [command execute];
    }
    
    NSLog(@"acceptType is %@",[Config currentConfig].messageFilter);
    
    self.messageFilterTableview = nil;
    
    self.cellsArray = nil;
    
    self.selectedCellArray = nil;
    
    self.messageSelectedImage = nil;
    
    self.messageUnselectedImage = nil;
    
}


@end

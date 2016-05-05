//
//  PaymentModeViewController.m
//  SuningEBuy
//
//  Created by  on 12-9-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "PaymentModeViewController.h"
#import "ShopCartV2ViewController.h"
#import "UPPayPlugin.h"
#import "GlobalDataCenter.h"
#import "BoundPhoneViewController.h"
#import "CustomerPayTextField.h"
#import "CancelOrderCommand.h"

#import "SNSwitch.h"
#import "SNWebViewController.h"
#import "PayModeDTO.h"
#import "UPOMP.h"

#import "PaySuccessViewController.h"
#import "LoginViewController.h"
#define Pay_Confirm_Alert_Tag         100
#define Pay_BackHome_Alert_Tag        300
#define NormalChacracter @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

#define kPayNoticeString L(@"PFPleasePayAsSoonAsPossible")

@interface PaymentModeViewController() <UPOMPDelegate>
{
    UPOMP               *_upController;
    BOOL                allPayType;
}

@property (nonatomic, strong)UITextField            *easyPayPwdField;       // 易付宝密码

@property (nonatomic, strong)UIView                 *headerView;            // 表视图
@property (nonatomic, strong)UILabel                *totalPriceLbl;         // 价格显示标签
@property (nonatomic, strong)UILabel                *alertLbl;              // 友情提醒
@property (nonatomic, strong)UILabel                *portageLabel;          //运费

//dataSource
@property (nonatomic, strong)NSMutableArray         *payModeArr;          // 支付方式列表
@property (nonatomic, strong)NSMutableArray         *cashOnDeliveryArr;   // 货到付款行列表

@property (nonatomic, strong) CustomerPayTextField           *verifyField;

@property (nonatomic,strong)  UIButton              *verifyBtn;

- (void)setUpDataSource;

- (UIImageView *)createAccessoryImageSelect:(BOOL)isSelect;
- (UILabel *)createAccessoryLabel;


- (void)submitPayOrderHttpRequest;

@end

/*********************************************************************/

@implementation PaymentModeViewController

@synthesize payFlowService = _payFlowService;
@synthesize payDTO = _payDTO;
@synthesize shipMode = _shipMode;

@synthesize easyPayPwdField = _easyPayPwdField;
@synthesize headerView = _headerView;
@synthesize totalPriceLbl = _totalPriceLbl;
@synthesize alertLbl = _alertLbl;
@synthesize portageLabel = _portageLabel;


@synthesize payModeArr = _payModeArr;
@synthesize cashOnDeliveryArr = _cashOnDeliveryArr;
@synthesize verifyField = _verifyField;
@synthesize verifyBtn = _verifyBtn;
@synthesize isSecondPay;
@synthesize eppValidateService = _eppValidateService;

- (void)dealloc {
    SERVICE_RELEASE_SAFELY(_payFlowService);
    SERVICE_RELEASE_SAFELY(_eppValidateService);
    TT_RELEASE_SAFELY(_payDTO);
    
    TT_RELEASE_SAFELY(_easyPayPwdField);
    TT_RELEASE_SAFELY(_headerView);
    TT_RELEASE_SAFELY(_totalPriceLbl);
    TT_RELEASE_SAFELY(_alertLbl);
    TT_RELEASE_SAFELY(_portageLabel);
    
    TT_RELEASE_SAFELY(_payModeArr);
    TT_RELEASE_SAFELY(_cashOnDeliveryArr);
    TT_RELEASE_SAFELY(_verifyField);
    TT_RELEASE_SAFELY(_verifyBtn);
    
}

- (id)initWithPayFlowDTO:(payFlowDTO *)dto andShipMode:(ShipMode)mode
{
    self = [super init];
    if (self) {
        self.title = L(@"confirmPay");
        self.pageTitle = L(@"shopProcess_shop_payMethodChoice");
        self.payDTO = dto;
        self.shipMode = mode;
        
        [self.payDTO setPayMode:PayModeUnSelect];
        [self.payDTO setCashPayMode:CashOnDeliveryUnSelect];
        
        //设置提交按钮
//        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"payConfirm")];
        
        self.hidesBottomBarWhenPushed = YES;
        
        [self eppValidateService];
        
        self.bSupportPanUI = NO;
        
        self.isShowTotalPrice = YES;
    }
    return self;
}

- (id)initWithPayFlowDTO:(payFlowDTO *)dto andShipMode:(ShipMode)mode allPaytype:(BOOL)payType
{
    allPayType = payType;
    return [self initWithPayFlowDTO:dto andShipMode:mode];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)righBarClick
{
    [self confirmPurchase:nil];
}

- (void)backForePage
{
    [self.easyPayPwdField resignFirstResponder];
    
    if (isSecondPay)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        BBAlertView *alert = [[BBAlertView alloc]
                              initWithTitle:L(@"AlertFriendTips")
                              message:kPayNoticeString
                              delegate:self
                              cancelButtonTitle:L(@"Cancel")
                              otherButtonTitles:L(@"Ok")];
        
        alert.tag = Pay_BackHome_Alert_Tag;
        [alert show];
        
    }   
}

#pragma mark -
#pragma mark actions

- (void)backHomePage:(id)sender{
    
    [self.easyPayPwdField resignFirstResponder];
    
    if (isSecondPay)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        BBAlertView *alert = [[BBAlertView alloc]
                              initWithTitle:L(@"AlertFriendTips")
                              message:kPayNoticeString
                              delegate:self
                              cancelButtonTitle:L(@"Cancel")
                              otherButtonTitles:L(@"Ok")];
        
        alert.tag = Pay_BackHome_Alert_Tag;
        [alert show];
    }    
}

- (void)confirmPurchase:(id)sender
{
    //检测支付方式
    switch (self.payDTO.payMode) {
        case PayModeUnSelect:
        {
            [self presentCustomDlg:L(@"Please choose payment mode")];
            return;
            break;
        }
        case PayModeCashOnDelivery:
        {
            if (self.payDTO.cashPayMode == CashOnDeliveryUnSelect) {
                [self presentCustomDlg:L(@"Please choose payment mode")];
                return;
            }
            break;
        }
        case PayModeEfubao:
        {
            [self.easyPayPwdField resignFirstResponder];
            
            if([self.payDTO.isNeedValidate boolValue])
            {
                NSString *error = nil;
                if ([EppValidateCodeService checkVerifyCode:_verifyField.text error:&error])
                {
                    self.payDTO.verifyCode = _verifyField.text;
                }
                else
                {
                    BBAlertMessage(error);
                    return;
                }
            }
            
            if ([self.payDTO.prepay floatValue] > [self.payDTO.accountBalance floatValue])
            {
                [self presentSheet:L(@"Insufficient efubao balance") posY:80];//余额不足
                return;
                
            }
            if (self.easyPayPwdField.text == nil || [self.easyPayPwdField.text isEmptyOrWhitespace]) 
            {
                [self presentSheet:kLoginStatusMessageRequirePassword posY:80];
                [self.easyPayPwdField becomeFirstResponder];
                self.easyPayPwdField.text = nil;
                return;
            }
            
            self.payDTO.eppPayPwd = self.easyPayPwdField.text;
            break;
        }
        case PayModeOnStore:
        {
            if (self.shipMode == ShipModeSelfTake) {
                self.payDTO.cashPayMode = CashOnDeliveryMention;
            }else{
                self.payDTO.cashPayMode = CashOnDeliveryStore;
            }
            break;
        }
        default:
            break;
    }
    
    [self submitPayOrderHttpRequest];
}
//初始化数据
- (void)setUpDataSource
{    
    NSMutableArray *tempPayModeArr = [NSMutableArray array];
    if (allPayType) {
        //加货到付款 刷卡
        PayModeDTO *dto1 = [PayModeDTO POSOnDeliveryDTO:self.payDTO];
        [tempPayModeArr addObject:dto1];
        
        //加货到付款 现金
        PayModeDTO *dto11 = [PayModeDTO cashOnDeliveryDTO:self.payDTO];
        [tempPayModeArr addObject:dto11];
    }
    
    //易付宝在线支付
    if ([SNSwitch isOpenWebEppPay])
    {
        [tempPayModeArr addObject:[PayModeDTO webEfubaoDTO:self.payDTO]];
    }
    
    //易付宝sdk支付
    if ([SNSwitch isOpenSNPaySDK]) {
        [tempPayModeArr addObject:[PayModeDTO SNPaySDkDTO:self.payDTO]];
    }

    //异度支付
    if ([SNSwitch isOpenCyberPay])
    {
        [tempPayModeArr addObject:[PayModeDTO cyberPayDTO:self.payDTO]];
    }
    
    //银联2.0
    if ([SNSwitch isOpenUnionPay])
    {
        [tempPayModeArr addObject:[PayModeDTO uppay2_0DTO:self.payDTO]];
    }
    if (allPayType) {
        //门店支付
        [tempPayModeArr addObject:[PayModeDTO onStoreDTO:self.payDTO shipMode:self.shipMode]];
    }
    self.payModeArr = tempPayModeArr;
}

#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
    
    [self setUpDataSource];
    
    self.groupTableView.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    self.groupTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.groupTableView.backgroundColor = [UIColor view_Back_Color];
   	[self.view addSubview:self.groupTableView];
    
//    [self useBottomNavBar];
}

#pragma mark -
#pragma mark getters

- (PayFlowService *)payFlowService
{
    if (!_payFlowService) {
        _payFlowService = [[PayFlowService alloc] init];
        _payFlowService.delegate = self;
    }
    return _payFlowService;
}

- (EppValidateCodeService *)eppValidateService
{
    if (!_eppValidateService) {
        _eppValidateService = [[EppValidateCodeService alloc] init];
        _eppValidateService.delegate = self;
    }
    return _eppValidateService;
}

- (UITextField *)easyPayPwdField
{
    if (!_easyPayPwdField)
    {
        _easyPayPwdField = [[UITextField alloc] init];
        _easyPayPwdField.frame = CGRectMake(115, 0, 180, 43);
        _easyPayPwdField.borderStyle = UITextBorderStyleNone;
        _easyPayPwdField.backgroundColor = [UIColor clearColor];
        _easyPayPwdField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _easyPayPwdField.autocorrectionType = UITextAutocorrectionTypeNo;
        _easyPayPwdField.keyboardType = UIKeyboardTypeDefault;
        _easyPayPwdField.returnKeyType = UIReturnKeyDone;
        _easyPayPwdField.textAlignment = UITextAlignmentLeft;
        _easyPayPwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _easyPayPwdField.font = [UIFont systemFontOfSize:17.0f];
        _easyPayPwdField.delegate = self;
        _easyPayPwdField.placeholder = L(@"please input pay password");
        _easyPayPwdField.secureTextEntry = YES;
        _easyPayPwdField.returnKeyType = UIReturnKeyGo;
    }
    return _easyPayPwdField;
}


-(CustomerPayTextField *)verifyField
{
    if(!_verifyField)
    {
        _verifyField = [[CustomerPayTextField alloc] init];
        _verifyField.frame = CGRectMake(115, 2, 110, 39);
        _verifyField.borderStyle = UITextBorderStyleRoundedRect;      
        _verifyField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _verifyField.autocorrectionType = UITextAutocorrectionTypeNo;
        _verifyField.keyboardType = UIKeyboardTypeASCIICapable;
        _verifyField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _verifyField.returnKeyType = UIReturnKeyDone;
        _verifyField.textAlignment = UITextAlignmentLeft;
        _verifyField.placeholder = L(@"input_EfuBao_VerifyCode");
        _verifyField.font = [UIFont systemFontOfSize:12.0f];
        _verifyField.delegate = self;  
    }
    return _verifyField;
}

-(UIButton*)verifyBtn
{
    if (!_verifyBtn) 
    {
        _verifyBtn = [[UIButton alloc] init];                      
        _verifyBtn.frame = CGRectMake(230, 2, 65, 39);
        [_verifyBtn setTitle:L(@"get_VerifyCode") forState:UIControlStateNormal];
        [_verifyBtn setTitleColor:[UIColor colorWithRGBHex:0x0b76b2]forState:UIControlStateNormal];
        [_verifyBtn setBackgroundImage:[UIImage imageNamed:@"verifyCode_Btn.png"] forState:UIControlStateNormal];
        _verifyBtn.layer.masksToBounds = YES;
        _verifyBtn.layer.cornerRadius = 4;
       // [_verifyBtn setBackgroundColor:[UIColor blueColor]];
        [_verifyBtn addTarget:self action:@selector(getVerifyCode:) forControlEvents:UIControlEventTouchUpInside];        
    }
    return _verifyBtn;
}

- (UIView *)headerView
{
    if (!_headerView)
    {
        _headerView = [[UIView alloc] init];
        _headerView.backgroundColor = [UIColor view_Back_Color];
        CGSize detailMsgSize = CGSizeZero;
        detailMsgSize = [self.alertLbl.text heightWithFont:[UIFont boldSystemFontOfSize:14.0] 
                                                     width:280 
                                                 linebreak:NSLineBreakByWordWrapping];
                
        _headerView.frame = CGRectMake(0, 0, 320, 48+detailMsgSize.height);
        
        UILabel *productTotal = [[UILabel alloc] initWithFrame:CGRectMake(20, 7, 45, 30)];
        productTotal.backgroundColor = [UIColor clearColor];
        productTotal.font = [UIFont boldSystemFontOfSize:16];
        productTotal.textColor = [UIColor light_Black_Color];
        productTotal.text = [NSString stringWithFormat:@"%@:",L(@"PFTotalPrice")];
        [_headerView addSubview: productTotal];
        
        NSString *totalPrice = [NSString stringWithFormat:@"￥%.2f",[self.payDTO.prepay doubleValue]];
        CGSize size = [totalPrice sizeWithFont:[UIFont boldSystemFontOfSize:19]];
        self.totalPriceLbl.frame = CGRectMake(productTotal.right, 5, size.width + 5, 30);
        self.totalPriceLbl.text = totalPrice;
        [_headerView addSubview:self.totalPriceLbl];

        UILabel *portLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.totalPriceLbl.right, 7, 300 - self.totalPriceLbl.right, 30)];
        portLabel.backgroundColor = [UIColor clearColor];
        portLabel.font = [UIFont boldSystemFontOfSize:16];
        portLabel.textColor = [UIColor dark_Gray_Color];
        portLabel.text = self.payDTO.portage;
        [_headerView addSubview:portLabel];
        
        self.alertLbl.frame = CGRectMake(20, 35, 280, detailMsgSize.height);
        [_headerView addSubview:self.alertLbl];
    }
    
    return _headerView;
}

- (UILabel *)alertLbl
{
	if (!_alertLbl) 
    {
		_alertLbl = [[UILabel alloc] init];
		_alertLbl.backgroundColor = [UIColor clearColor];
        _alertLbl.textColor = [UIColor dark_Gray_Color];
        _alertLbl.numberOfLines = 0 ;
        _alertLbl.lineBreakMode = NSLineBreakByWordWrapping;
		_alertLbl.font = [UIFont boldSystemFontOfSize:13];
        //_alertLbl.text = self.payDTO.paymentLimitInfo;
        [_alertLbl setText:kPayNoticeString];
    }
	return _alertLbl;
}

- (UILabel *)totalPriceLbl
{
	if (!_totalPriceLbl) 
    {
		_totalPriceLbl = [[UILabel alloc] init];
		_totalPriceLbl.backgroundColor = [UIColor clearColor];
        _totalPriceLbl.textColor = [UIColor orange_Red_Color];
		_totalPriceLbl.font = [UIFont boldSystemFontOfSize:19];
        _totalPriceLbl.adjustsFontSizeToFitWidth = YES;
        _totalPriceLbl.textAlignment = UITextAlignmentLeft;
    }
	return _totalPriceLbl;
}


- (UILabel *)portageLabel{
	
	if (!_portageLabel) {
		UIFont *font = [UIFont systemFontOfSize:14];
        _portageLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 5, 100, 35)];
        _portageLabel.backgroundColor = [UIColor clearColor];
        _portageLabel.textAlignment = UITextAlignmentLeft;
        _portageLabel.font = font;
        _portageLabel.adjustsFontSizeToFitWidth = YES;
        _portageLabel.textColor = [UIColor redColor];
        _portageLabel.autoresizingMask = UIViewAutoresizingNone;
        _portageLabel.text = self.payDTO.portage;
	}
	return _portageLabel;
}

- (UIImageView *)createAccessoryImageSelect:(BOOL)isSelect
{
    UIImageView *_rightImage=[[UIImageView alloc] init];
    _rightImage.frame = CGRectMake(265, 9, 25, 25);
    _rightImage.backgroundColor=[UIColor clearColor];
    if (isSelect) {
        _rightImage.image=[UIImage imageNamed:@"payment_type_selected@2x.png"];
    }else{
        _rightImage.image=[UIImage imageNamed:@"payment_type_unselect@2x.png"];
    }
    return _rightImage;
}

- (UILabel *)createAccessoryLabel
{
    UILabel *_rightTextLbl = [[UILabel alloc] init];
    _rightTextLbl.frame = CGRectMake(115, 0, 180, 43);
    _rightTextLbl.backgroundColor = [UIColor clearColor];
    _rightTextLbl.textAlignment = UITextAlignmentLeft;
    _rightTextLbl.font = [UIFont systemFontOfSize:17];
    _rightTextLbl.textColor = [UIColor colorWithRGBHex:0xFF0000];//[UIColor redColor];
    return _rightTextLbl;
}

#pragma mark -
#pragma mark table view delegate and datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger rowNumbers = 0;
    
    switch (section) 
    {
        case 0:
            rowNumbers = [self.payModeArr count];
            break;
        case 1:
        {
            switch (self.payDTO.payMode)
            {
                case PayModeCashOnDelivery:
                {
                    rowNumbers = [self.cashOnDeliveryArr count];
                    break;
                }
                case PayModeEfubao:
                {
                    if([self.payDTO.isNeedValidate boolValue] == YES)  //self.payDTO.prepay floatValue] >200
                    {
                        rowNumbers = 4;
                    }
                    else
                    {
                        rowNumbers = 3;
                    }
                    
                    break;
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
    
    return rowNumbers;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    static NSString *SettlementIdentifier = @"CellIdentifier";
    
    SNUITableViewCell *cell = nil;
    
    if (cell == nil) 
    {
        cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:SettlementIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
        cell.textLabel.textColor =  [UIColor light_Black_Color];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
        cell.detailTextLabel.numberOfLines = 3;
        cell.detailTextLabel.textColor = [UIColor dark_Gray_Color];
        cell.detailTextLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
    {
        [cell.contentView removeAllSubviews];
    }

    switch (section) 
    {
        case 0: // 支付方式 payMode
        {
            PayModeDTO *dto = [self.payModeArr objectAtIndex:row];
            cell.textLabel.text = dto.mainDesc;
            if (dto.supportPay)
            {
                cell.detailTextLabel.text = dto.detailDesc;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.textColor = [UIColor light_Black_Color];
//                //是否是当前支付方式
//                if (self.payDTO.payMode == dto.payMode)
//                {
//                    cell.accessoryView = [self createAccessoryImageSelect:YES];
//                }
//                else
//                {
//                    cell.accessoryView = [self createAccessoryImageSelect:NO];
//                }
            }
            else
            {
                cell.textLabel.textColor = [UIColor dark_Gray_Color];
                cell.detailTextLabel.text = dto.detailUnsupportDesc;
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            
            //最新的支付方式
            if (dto.isNew)
            {
                CGRect frame = CGRectMake(150, 2, 100, 20);
                UILabel *lbl = [[UILabel alloc] initWithFrame:frame];
                lbl.backgroundColor = [UIColor clearColor];
                lbl.textColor = [UIColor colorWithRGBHex:0xFF0000];//[UIColor redColor];
                lbl.font = [UIFont italicSystemFontOfSize:15.0];
                lbl.text = @"New!";
                [cell.contentView addSubview:lbl];
            }
            
            break;
        }
        case 1: // 支付详情 第二个section
        {
            switch (self.payDTO.payMode) 
            {
                case PayModeCashOnDelivery: // 货到付款
                {
                    PayModeDTO *dto = [self.cashOnDeliveryArr objectAtIndex:row];
                    cell.textLabel.text = dto.mainDesc;
                    if (dto.supportPay)
                    {
                        cell.detailTextLabel.text = dto.detailDesc;
                        //是否是当前支付方式
//                        if (self.payDTO.cashPayMode == dto.subPayMode)
//                        {
//                            cell.accessoryView = [self createAccessoryImageSelect:YES];
//                        }else{
//                            cell.accessoryView = [self createAccessoryImageSelect:NO];
//                        }
                    }
                    else
                    {
                        cell.detailTextLabel.text = dto.detailUnsupportDesc;
                        cell.detailTextLabel.textColor = [UIColor dark_Gray_Color];
                    }
                    
                    break;
                }
                case PayModeEfubao: // 易付宝支付
                {
                    if (row == 0) 
                    {
                        cell.textLabel.text = L(@"YIfuaboBalance");
                        UILabel *rightLbl = [self createAccessoryLabel];
                        rightLbl.text = [NSString stringWithFormat:@"￥%@",self.payDTO.accountBalance];
                        [cell.contentView addSubview:rightLbl];
                    }
                    else if (row == 1)
                    {
                        cell.textLabel.text = L(@"need to pay");
                        UILabel *rightLbl = [self createAccessoryLabel];
                        rightLbl.text = [NSString stringWithFormat:@"￥%.2f",[self.payDTO.prepay doubleValue]];
                        [cell.contentView addSubview:rightLbl];
                    }
                    else if (row == 2)
                    {
                        
                        if([self.payDTO.isNeedValidate boolValue] == YES) 
                        {                        
                            cell.textLabel.text = [NSString stringWithFormat:@"%@:",L(@"PFMobilePhoneCode")];
                            [cell.contentView addSubview:self.verifyField];
                            [cell.contentView addSubview:self.verifyBtn];
                        }
                        else
                        {
                            cell.textLabel.text = L(@"passWordPay");
                            [cell.contentView addSubview:self.easyPayPwdField];
                        }
                    }
                    else if (row == 3)
                    {
                        cell.textLabel.text = L(@"passWordPay");
                        [cell.contentView addSubview:self.easyPayPwdField];
                    }

                    
                    break;
                }
                case PayModeOnStore:
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
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 && self.isShowTotalPrice)
    {
        CGFloat rowHeight = 48.0f;
        
        CGSize detailMsgSize = CGSizeZero;
        
        detailMsgSize = [self.alertLbl.text heightWithFont:[UIFont boldSystemFontOfSize:14.0] 
                                                     width:280 
                                                 linebreak:NSLineBreakByWordWrapping];
        rowHeight = 48 + detailMsgSize.height;
        
        return rowHeight;
        
    }else {
        return 48.0f;
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = nil;
    
    if (section == 1) 
    {
        if (self.payDTO.payMode == PayModeCashOnDelivery) 
        {
            sectionTitle = L(@"CodPay");
        }
        else if (self.payDTO.payMode == PayModeEfubao) 
        {
            sectionTitle = L(@"choosePayWayFor30");
        }
    }
    
    return sectionTitle;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;   
{
    
    UIView *tableSectionHeaderView = nil;
    
    if (section == 0)
    {
        if (self.isShowTotalPrice)
        {
            tableSectionHeaderView = self.headerView;
        }
        else
        {
            tableSectionHeaderView = [UIView new];
            tableSectionHeaderView.backgroundColor = [UIColor clearColor];
        }
    }
    
    return tableSectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat mainLabelHeight = 26.0f;
    CGFloat rowHeight = 44.0f;
    
    NSInteger row = indexPath.row;
    NSString *detailMessage = nil;
    CGSize detailMsgSize = CGSizeZero;
    
    switch (indexPath.section) 
    {
        case 0:
        {
            PayModeDTO *dto = [self.payModeArr objectAtIndex:row];
            
            CGFloat width;
            if (dto.supportPay) {
                detailMessage = dto.detailDesc;
                width = 240;
            }else{
                detailMessage = dto.detailUnsupportDesc;
                width = 279;
            }
            
            detailMsgSize = [detailMessage heightWithFont:[UIFont systemFontOfSize:13.0]
                                                    width:width
                                                linebreak:NSLineBreakByCharWrapping];
            CGFloat msgHeight = detailMsgSize.height>45?45:detailMsgSize.height;
            
            rowHeight = mainLabelHeight + msgHeight + 5;
            break;
        }
        case 1:
        {  
            // 货到付款
            if (self.payDTO.payMode == PayModeCashOnDelivery) 
            {
                PayModeDTO *dto = [self.cashOnDeliveryArr objectAtIndex:row];
                
                CGFloat width;
                if (dto.supportPay) {
                    detailMessage = dto.detailDesc;
                    width = 240;
                }else{
                    detailMessage = dto.detailUnsupportDesc;
                    width = 279;
                }
                
                detailMsgSize = [detailMessage heightWithFont:[UIFont systemFontOfSize:12.0]
                                                        width:279
                                                    linebreak:NSLineBreakByCharWrapping];
                CGFloat msgHeight = detailMsgSize.height>45?45:detailMsgSize.height;
                
                rowHeight = mainLabelHeight + msgHeight + 5;
            }
            break;
        }
        default:
            break;
    }
    
    return rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    switch (section)
    {
        case 0:
        {
            PayModeDTO *dto = [self.payModeArr objectAtIndex:row];
            
            if (dto.supportPay)
            {
                self.payDTO.payMode = dto.payMode;
                if (self.payDTO.payMode == PayModeCashOnDelivery) // 货到付款
                {
                    self.payDTO.cashPayMode = dto.subPayMode;
                    if (dto.subPayMode == CashOnDeliveryCashPay) {
                        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:@"" message:L(@"PFUseCashOnDeliveryAndPayByCash") delegate:self cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];
                        [alert setConfirmBlock:^{
                            [self confirmPurchase:nil];
                        }];
                        [alert show];
                    }else if (dto.subPayMode == CashOnDeliveryPOSPay){
                        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:@"" message:L(@"PFUseCashOnDeliveryAndPayByPos") delegate:self cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];
                        [alert setConfirmBlock:^{
                            [self confirmPurchase:nil];
                        }];
                        [alert show];
                    }
                }else if (self.payDTO.payMode == PayModeOnStore)
                {
                    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:@"" message:L(@"PFUseStorePayment") delegate:self cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];
                    [alert setConfirmBlock:^{
                        [self confirmPurchase:nil];
                    }];
                    [alert show];
                }else{
                    [self confirmPurchase:nil];
                }
            }
            
            break;
        }
        case 1:     // 支付详情
        {
            if (self.payDTO.payMode == PayModeCashOnDelivery) // 货到付款
            {
                PayModeDTO *dto = [self.cashOnDeliveryArr objectAtIndex:row];
                if (dto.supportPay)
                {
                    self.payDTO.cashPayMode = dto.subPayMode;
                    
                    [self confirmPurchase:nil];
                }
            }
            
            break;
        }
        default:
            break;
    }
}

#pragma mark -
#pragma mark text field delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{    
    NSCharacterSet *cs;          
    if(textField == _verifyField)  
    {  
        if([string length]>range.length&&[textField.text length]+[string length]-range.length>6)
        {
            return NO;
        }        
        cs = [[NSCharacterSet characterSetWithCharactersInString:NormalChacracter] invertedSet];          
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];          
        BOOL basicTest = [string isEqualToString:filtered];  
        if(!basicTest)  
        {          
            [self presentSheet:L(@"Please_input_correct_VerifyCode") posY:50];
            return NO;  
        }      
    }   
    return YES;          
    
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(_easyPayPwdField == textField &&[self.payDTO.isNeedValidate boolValue] == YES)
    {
        if(_verifyField.text.length == 0)
        {
          [self presentSheet:L(@"please_firstInput_VerifyCode")posY:50];
          [_verifyField becomeFirstResponder];
          return NO;
        }        
        NSString *verifyCodeRegex = [NSString stringWithFormat:@"([a-z,A-Z,0-9]{6})"];    
        NSPredicate *verifyCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", verifyCodeRegex];
        if ([verifyCodeTest evaluateWithObject:_verifyField.text]==NO) {            
            [self presentSheet:L(@"Please_input_correct_VerifyCode")posY:50];
            [_verifyField becomeFirstResponder];
            return NO;                       
        }         
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    if (textField == _easyPayPwdField)
    {

        [self confirmPurchase:textField];
    }
    
    return YES;
}

#pragma mark -
#pragma mark alert view delegate

- (void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == Pay_Confirm_Alert_Tag) {
        if (buttonIndex == 1) 
        {
            [self submitPayOrderHttpRequest];
        }
    }
    else if (alertView.tag == Pay_BackHome_Alert_Tag)
    {
        //确定
        if (buttonIndex == 1)
        {
            //回到购物车
            [self.navigationController popToRootViewControllerAnimated:NO];
            //去首页
            [self jumpToHomeBoard];
        }
    }
}

#pragma mark -
#pragma mark validate code


- (void)getVerifyCode:(id)sender
{
    if ([self.eppValidateService available]) {
        [self displayOverFlowActivityView:L(@"Loading...")];
        [self.eppValidateService requestValidateCode];
    }
}

- (void)requestValidateCodeComplete:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    if (isSuccess)
    {
        DLog(@"验证码获取成功");
    }
    else
    {
        DLog(@"验证码获取失败");
        [self presentSheet:errorMsg?errorMsg:L(@"PFGetVerificationCodeFailed")];
    }
}

- (void)eppRemainTimeToRetry:(NSInteger)seconds
{
    if(seconds <= 0)
    {
        _verifyBtn.enabled = YES;
        [_verifyBtn setTitle:L(@"get_VerifyCode") forState:UIControlStateNormal];
        return;
    }else{
        // Joe.2014年07月09日17:22:20
        // setTitle won't work when button is not enable on iOS7.1.
        _verifyBtn.enabled = YES;
        [_verifyBtn setTitle:[NSString stringWithFormat:@"%d秒",seconds]
                    forState:UIControlStateNormal];
        _verifyBtn.enabled = NO;
    }
}

#pragma mark -
#pragma mark submit pay request

- (void)submitPayOrderHttpRequest
{   
    
    [self displayOverFlowActivityView:L(@"Loading...")];
    self.navigationItem.leftBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem.enabled = NO;

    [self.payFlowService beginPaySubmitRequest:self.payDTO];
}

- (void)paySubmitCompletionWithResult:(BOOL)isSuccess
                             errorMsg:(NSString *)errorMsg 
                          punchoutUrl:(NSURL *)url
                          punchoutForm:(NSString *)xml
                            sdkstring:sdkstring

{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        if (self.payDTO.payMode == PayModeHuiFuWeb)
        {
            /* deprecated
            if (url == nil)
            {
                [self presentSheet:L(@"creat order error on line") posY:100];
                
            }else{
                
                PayModeWebViewController *payModeWebViewController =
                [[PayModeWebViewController alloc]initWithRequest:[NSURLRequest requestWithURL:url]];
                payModeWebViewController.orderId=self.payDTO.orderId;
                payModeWebViewController.isFromPaymentModeViewController=YES;
                [self.navigationController pushViewController:payModeWebViewController animated:YES];
                
                TT_RELEASE_SAFELY(payModeWebViewController);
            }
            */
        }
        else if (self.payDTO.payMode == PayModeUPPay1_0)
        {
            [self alertCustomDlg:L(@"PFNotSupportUnionPay1.0")];
//            [UPPayPlugin startPay:xml
//                       sysProvide:@"11173000"
//                             spId:@"0229"
//                             mode:@"00"
//                   viewController:self
//                         delegate:self];
        }
        else if (self.payDTO.payMode == PayModeWebEfubao && xml)
        {
            SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeEppPay attributes:@{@"form": xml}];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (self.payDTO.payMode == PayModeUPPay2_0)
        {
            [UPPayPlugin startPay:xml
                             mode:@"00"
                   viewController:self
                         delegate:self];
        }
        else if (self.payDTO.payMode == PayModeCyberPay)
        {
            //异度支付
            _upController = [[UPOMP alloc] init];
            _upController.viewDelegate = self;
            [self presentViewController:_upController animated:YES completion:nil];
            [_upController setXmlData:[xml dataUsingEncoding:NSUTF8StringEncoding]];
        }
        else if (self.payDTO.payMode == PayModeSNSDK){
            SNMPayRequest *request = [[SNMPayRequest alloc] init];
            request.orderType = SPOrderTypePayment;
            request.orderString = sdkstring;
            [SNMPaySDK setSDKUserType:SPUserTypeSNEG];
#ifdef kPreTest
            [SNMPaySDK setSDKRemoteAPIEnv:SPRemoteAPIEnvPre];
#elif kSitTest
            [SNMPaySDK setSDKRemoteAPIEnv:SPRemoteAPIEnvSit];
#elif kReleaseH
            [SNMPaySDK setSDKRemoteAPIEnv:SPRemoteAPIEnvPrd];
#endif
#ifdef DEBUGLOG
            [SNMPaySDK enableDebugMode:YES];
#else
            [SNMPaySDK enableDebugMode:NO];
#endif
            [SNMPaySDK submitOrderRequest:request delegate:self];

        }
        else
        {
            [self paySuccessed];
        }
        
    }else{
        [self presentSheet:errorMsg];
    }
    
    self.navigationItem.leftBarButtonItem.enabled = YES;
    self.navigationItem.rightBarButtonItem.enabled = YES;

}


/**
 加载收银台失败
 */
- (void)didFailLoadSDKWithError:(NSString *)errorMsg{
    [self presentSheet:L(@"PFPayFailed")];
    if (KPerformance)
    {
        PerformanceStatisticsHttp* temp = [[PerformanceStatisticsHttp alloc] init];
        temp.startTime = [NSDate date];
        temp.functionId = @"8";
        temp.interfaceId = @"null";
        temp.errorType = @"04";
        if ([errorMsg length])
        {
            temp.errorCode = [NSString stringWithFormat:@"%@",errorMsg];
        }
        else
        {
            temp.errorCode = @"null";
        }
        
        [[PerformanceStatistics sharePerformanceStatistics]sendCustomNetData:temp];
    }

}

/**
 完成支付
 */
- (void)didFinishSDKPayment{
    [self paySuccessed];
}

/**
 取消支付
 */
- (void)didCanceSDKPayment{
    
}

/**
 Passport会话超时
 
 会话超时，需要重新登录
 */
- (void)didPassportTimeOut{
    LoginViewController *_LoginViewController=[[LoginViewController alloc]init];
    _LoginViewController.nextController = self;
    _LoginViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    AuthManagerNavViewController *userNav = [[AuthManagerNavViewController alloc]
                                             initWithRootViewController:_LoginViewController];
    [self presentModalViewController:userNav animated:YES];

}
#pragma mark -
#pragma mark 支付成功

- (void)paySuccessed
{
  /*  if (self.payDTO.isCOrder) {
        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
                                                        message:@"支付成功，请至网站查看该订单"
                                                       delegate:nil
                                              cancelButtonTitle:@"去逛逛"
                                              otherButtonTitles:nil];
        
        __unsafe_unretained PaymentModeViewController *weakSelf = self;
        [alert setCancelBlock:^{
            [weakSelf goAroundWithCompleteBlock:^{                
                [weakSelf.navigationController popToRootViewControllerAnimated:NO];
            }];
        }];
        [alert show];

    }else{*/
    if (self.payDTO.payMode == PayModeCashOnDelivery || self.payDTO.payMode == PayModeOnStore) {
        PaySuccessViewController *success = [[PaySuccessViewController alloc] init];
        if (self.payDTO.payMode == PayModeCashOnDelivery) {
            if (self.payDTO.cashPayMode == CashOnDeliveryCashPay) {
                success.paymodeType = PayModeByCash;
            }else if (self.payDTO.cashPayMode == CashOnDeliveryPOSPay){
                success.paymodeType = PayModeByPOS;
            }
        }else if (self.payDTO.payMode == PayModeOnStore){
            if (self.shipMode == ShipModeSuningSend) {
                success.paymodeType = PayModeByStore;
            }else if (self.shipMode == ShipModeSelfTake){
                success.paymodeType = PayModeByMention;
            }
        }
        success.orderId = self.payDTO.orderId;
        success.totalPrice = self.payDTO.prepay;
        [self.navigationController pushViewController:success animated:YES];
        return;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"secondPaySuccess" object:Nil];
    
        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
                                                        message:L(@"PFOrderPaySuccess")
                                                       delegate:nil
                                              cancelButtonTitle:L(@"AlertCheckOrders")
                                              otherButtonTitles:L(@"AlertGoShopping")];
        
        __weak PaymentModeViewController *weakSelf = self;
        [alert setCancelBlock:^{
            [weakSelf.navigationController popToRootViewControllerAnimated:NO];
            [weakSelf jumpToOrderCenterBoard];
        }];
        
        [alert setConfirmBlock:^{
            
            [weakSelf goAroundWithCompleteBlock:^{
                
                [weakSelf.navigationController popToRootViewControllerAnimated:NO];
            }];
        }];
        
        [alert show];
        
//    }
}

#pragma mark -
#pragma mark 银联支付回调

- (void)UPPayPluginResult:(NSString*)result
{
    DLog(@"result:%@", result);
    if([result isEqualToString:@"cancel"])
    {
        //取消不做任何事情
    }
    else if(![result isEqualToString:@"fail"] &&![result isEqualToString:@"cancel"])
    {
        [self paySuccessed];
    }
    else
    {
        [self presentSheet:L(@"PFPayFailed")];
    }
    
}

#pragma mark -
#pragma mark 异度支付回调

- (void)viewClose:(NSData *)data
{
    _upController.viewDelegate = nil;
    _upController = nil;
    //    _uc = nil;
    
    UPOMP_KaTBXML *parser = [[UPOMP_KaTBXML alloc] initWithXMLData:data];
    UPOMP_TBXMLElement *rootElement = [parser getRootXMLElement];
    UPOMP_TBXMLElement *codeElement = [parser childElementNamed:@"respCode" parentElement:rootElement];
//    UPOMP_TBXMLElement *descElement = [parser childElementNamed:@"respDesc" parentElement:rootElement];
    
    NSString *code = [parser textForElement:codeElement];
    
    if ([code isEqualToString:@"0000"])
    {
        //支付成功
        [self paySuccessed];
    }
    else if ([code isEqualToString:@"9001"])
    {
        //用户退出插件
        //取消不做任何事情
    }
    else
    {
        //支付失败
        [self presentSheet:L(@"PFPayFailed")];
    }
}


@end

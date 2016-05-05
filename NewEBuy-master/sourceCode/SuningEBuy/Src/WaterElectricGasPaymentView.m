//
//  WaterElectricGasPaymentView.m
//  SuningEBuy
//
//  Created by 王家兴 on 13-6-13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "WaterElectricGasPaymentView.h"
#import "PayServicePaymentViewController.h"
#import "PayServiceHelpViewController.h"
#import "PayServiceQueryViewController.h"
#import "Preferences.h"
#import "PayServiceCell.h"
#import "RadioButton.h"
#import "SNLocalWebViewController.h"
#import "SNCityListViewController.h"


#define kTextFieldWidth                 188.0
#define kTextFieldHeight                25.0
#define kLeftMargin                     98.0
#define kTopMargin                      5.0

#define kNumberOfSectionsInTableView     2
#define kPaymentSection                  0
#define kQuerySection                    1

#define kHeightOfCell                    40
#define kHeightOfHintCell                30

#define kNoticeMessageLine1              L(@"Payment time is every month 1-25")
#define kNoticeMessageLine2              L(@"You can request the bill from China Everbright Bank")

@interface WaterElectricGasPaymentView ()
{
    //判断FeeMode调用是否成功
    BOOL        isGetFeeModeSuccess;
    //防止FeeMode调用失败后，无法自动从新进行FeeMode调用
    BOOL        isContinueReqAccountInfo;
    
    BOOL        isNeedGetAccount;
    
    BOOL        isRequrstForPickViewData;
    
    BOOL        isRequrstForCityListVC;
}

@property (nonatomic ,strong)SNDropDownMenuViewController  *accountHintTableView;
@property (nonatomic ,strong)UIView         *accountSuperView;
@property (nonatomic ,strong)NSMutableArray *accountHintArray;
@property (nonatomic ,strong)NSMutableArray *accountMatchArray;
@property (nonatomic ,assign)CGFloat  pointY;
@property (nonatomic ,assign)NSString       *preCompanyId;

- (void)goToNextController;
- (void)saveInfoToConfig;

- (void)getCompanyListRequest;
- (void)getRegionInfoRequest;
- (void)getAccountInfoRequest;

@end


@implementation WaterElectricGasPaymentView

@synthesize payType = _payType;
@synthesize payRegionTextField = _payRegionTextField;
@synthesize payCompanyTextField = _payCompanyTextField;
@synthesize payAccountTextField = _payAccountTextField;
@synthesize companyPickerView = _companyPickerView;
@synthesize waterElecGasService = _waterElecGasService;
@synthesize regionList = _regionList;
@synthesize companyList = _companyList;
@synthesize payServiceDTO = _payServiceDTO;
@synthesize payServiceList = _payServiceList;
@synthesize payServiceInfoList = _payServiceInfoList;
@synthesize payBalanceLabel = _payBalanceLabel;
@synthesize customerNameLabel = _customerNameLabel;
@synthesize payAccountNum = _payAccountNum;
@synthesize groupTableView = _groupTableView;
@synthesize settlementBtn=_settlementBtn;
@synthesize payWaterButton=_payWaterButton;
@synthesize payElectricButton=_payElectricButton;
@synthesize payGasButton=_payGasButton;
@synthesize contentController=_contentController;
@synthesize customerNameTextLabel = _customerNameTextLabel;
@synthesize payBalanceTextLabel = _payBalanceTextLabel;
@synthesize checkBox = _checkBox;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_groupTableView);
    
    TT_RELEASE_SAFELY(_payRegionTextField);
    TT_RELEASE_SAFELY(_payCompanyTextField);
    TT_RELEASE_SAFELY(_payAccountTextField);
    TT_RELEASE_SAFELY(_companyPickerView);
    
    SERVICE_RELEASE_SAFELY(_waterElecGasService);
    
    TT_RELEASE_SAFELY(_regionList);
    TT_RELEASE_SAFELY(_companyList);
    TT_RELEASE_SAFELY(_payServiceDTO);
    TT_RELEASE_SAFELY(_payServiceList);
    TT_RELEASE_SAFELY(_customerNameLabel);
    TT_RELEASE_SAFELY(_payBalanceLabel);
    TT_RELEASE_SAFELY(_payAccountNum);
    TT_RELEASE_SAFELY(_settlementBtn);
    TT_RELEASE_SAFELY(_customerNameTextLabel);
    TT_RELEASE_SAFELY(_payBalanceTextLabel);
    TT_RELEASE_SAFELY(_checkBox);
    
    TT_RELEASE_SAFELY(_contentController);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"isPaySuccess" object:nil];
}

#pragma mark -
#pragma mark Property methods
//-(CommonViewController *)contentController
//{
//    if (!_contentController) {
//        _contentController=[[CommonViewController alloc] init];
//    }
//    return _contentController;
//}


- (SNDropDownMenuViewController  *)accountHintTableView
{
    if (!_accountHintTableView) {
        
        if ([SystemInfo is_iPhone_5]) {
            _accountHintTableView =[[SNDropDownMenuViewController alloc] initWithSuperView:self.accountSuperView withFrame:CGRectMake(0, 0, 200, 95)];
        }
        else
        {
            _accountHintTableView =[[SNDropDownMenuViewController alloc] initWithSuperView:self.accountSuperView withFrame:CGRectMake(0, 0, 200, 65)];
        }
        
        [_accountSuperView addSubview:_accountHintTableView.view];
        _accountHintTableView.delegate = self;
        _accountHintTableView.menuTableViewOffset = UIEdgeInsetsMake(0.1, 0, 0, 0);
        
    }
    return _accountHintTableView;
}

- (UIView *)accountSuperView
{
    if (!_accountSuperView) {
        _accountSuperView = [[UIView alloc]initWithFrame:CGRectMake(90, self.pointY, 200, 95)];
        _accountSuperView.backgroundColor  = [UIColor clearColor];
        _accountSuperView.clipsToBounds = YES;
        
    }
    return _accountSuperView;
}

- (NSMutableArray *)accountHintArray
{
    if (!_accountHintArray) {
        
        if (self.payType == payWater) {
            _accountHintArray = [Config currentConfig].waterAccounts;
        } else if (self.payType == payElectricity) {
            _accountHintArray = [Config currentConfig].electricityAccounts;
        } else if (self.payType == payGas) {
            _accountHintArray = [Config currentConfig].gasAccounts;
        }
    }
    
    if (!_accountHintArray) {
        _accountHintArray = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _accountHintArray;
}
- (NSMutableArray *)accountMatchArray
{
    if (!_accountMatchArray) {
        _accountMatchArray = [NSMutableArray array];
    }
    return _accountMatchArray;
}

- (WaterElectricityGasService *)waterElecGasService
{
    if (!_waterElecGasService) {
        
        _waterElecGasService = [[WaterElectricityGasService alloc] init];
        _waterElecGasService.delegate = self;
    }
    
    return _waterElecGasService;
}

- (UITableView *)groupTableView{
	
	if(!_groupTableView){
		
        _groupTableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero
                                                                       style:UITableViewStyleGrouped];
		[_groupTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		[_groupTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		_groupTableView.scrollEnabled = YES;
		_groupTableView.userInteractionEnabled = YES;
		_groupTableView.delegate =self;
		_groupTableView.dataSource =self;
		_groupTableView.backgroundColor =[UIColor clearColor];
        _groupTableView.backgroundView = nil;
        _groupTableView.tableFooterView = nil;
	}
	
	return _groupTableView;
}

- (ToolBarTextField *)payRegionTextField
{
    if (_payRegionTextField == nil)
    {
        _payRegionTextField = [[ToolBarTextField alloc] initWithFrame:CGRectMake(kLeftMargin, kTopMargin, kTextFieldWidth, kTextFieldHeight)];
        _payRegionTextField.placeholder = L(@"Please click to select region");
        _payRegionTextField.borderStyle = UITextBorderStyleNone;
        _payRegionTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _payRegionTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _payRegionTextField.delegate = self;
        _payRegionTextField.toolBarDelegate = self;
        _payRegionTextField.font =[UIFont systemFontOfSize:14];
        if ([self.payServiceInfoList count] != 0) {
            
            _payRegionTextField.text = [self.payServiceInfoList objectAtIndex:2];
        }
    }
    return _payRegionTextField;
}

- (ToolBarTextField *)payCompanyTextField
{
    if (_payCompanyTextField == nil)
    {
        _payCompanyTextField = [[ToolBarTextField alloc] initWithFrame:CGRectMake(kLeftMargin, kTopMargin, kTextFieldWidth, kTextFieldHeight)];
        _payCompanyTextField.placeholder = L(@"Please click to select company");
        _payCompanyTextField.borderStyle = UITextBorderStyleNone;
        _payCompanyTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _payCompanyTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _payCompanyTextField.font =[UIFont systemFontOfSize:14];
        _payCompanyTextField.delegate =self;
        _payCompanyTextField.toolBarDelegate = self;
        if ([self.payServiceInfoList count] != 0) {
            
            _payCompanyTextField.text = [self.payServiceInfoList objectAtIndex:5];
            
        }
        _payCompanyTextField.inputView = self.companyPickerView;
    }
    return _payCompanyTextField;
}

- (UITextField *)payAccountTextField
{
    if (_payAccountTextField == nil)
    {
        _payAccountTextField = [[UITextField alloc] initWithFrame:CGRectMake(kLeftMargin, kTopMargin, kTextFieldWidth, kTextFieldHeight)];
        _payAccountTextField.placeholder = L(@"Please input your pay account");
        _payAccountTextField.borderStyle = UITextBorderStyleNone;
        _payAccountTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _payAccountTextField.font =[UIFont systemFontOfSize:14];
        _payAccountTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _payAccountTextField.returnKeyType = UIReturnKeyDone;
        _payAccountTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _payAccountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _payAccountTextField.delegate = self;
        if ([self.payServiceInfoList count] != 0) {
            
            _payAccountTextField.text = [self.payServiceInfoList objectAtIndex:6];
        }
    }
    return _payAccountTextField;
}

- (UILabel *)customerNameLabel
{
    if (_customerNameLabel == nil)
    {
        CGRect frame = CGRectMake(90, kTopMargin-1, 80, kTextFieldHeight);
        _customerNameLabel = [[UILabel alloc] initWithFrame:frame];
        _customerNameLabel.textColor = [UIColor blackColor];
        _customerNameLabel.font = [UIFont fontWithName:@"Arial" size:14.0];
        _customerNameLabel.textAlignment = UITextAlignmentLeft;
        _customerNameLabel.backgroundColor = [UIColor clearColor];
        if ([self.payServiceInfoList count] == 8) {
            
            _customerNameLabel.text = @"";//[self.payServiceInfoList objectAtIndex:7];
        }
        
    }
    
    return _customerNameLabel;
}

- (UILabel *)payBalanceLabel
{
    if (_payBalanceLabel == nil)
    {
        CGRect frame = CGRectMake(246, kTopMargin-1, 80, kTextFieldHeight);
        _payBalanceLabel = [[UILabel alloc] initWithFrame:frame];
        _payBalanceLabel.textColor = [UIColor orange_Red_Color];
        _payBalanceLabel.font = [UIFont fontWithName:@"Arial" size:14.0];
        _payBalanceLabel.textAlignment = UITextAlignmentLeft;
        _payBalanceLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _payBalanceLabel;
}

- (UILabel *)customerNameTextLabel
{
    if (_customerNameTextLabel == nil)
    {
        CGRect frame = CGRectMake(15, kTopMargin, 60, kTextFieldHeight);
        NSString *customerName = [NSString stringWithFormat:@"%@",L(@"Customer name")];
        _customerNameTextLabel = [[UILabel alloc] initWithFrame:frame];
        _customerNameTextLabel.text = customerName;
        _customerNameTextLabel.textColor = [UIColor blackColor];
        _customerNameTextLabel.font = [UIFont fontWithName:@"Arial" size:14.0];
        _customerNameTextLabel.textAlignment = UITextAlignmentLeft;
        _customerNameTextLabel.backgroundColor = [UIColor clearColor];
        _customerNameTextLabel.hidden = YES;
    }
    
    return _customerNameTextLabel;
}

- (UILabel *)payBalanceTextLabel
{
    if (_payBalanceTextLabel == nil)
    {
        CGRect frame = CGRectMake(184, kTopMargin, 60, kTextFieldHeight);
        NSString *payBalance = [NSString stringWithFormat:@"%@",L(@"Pay amount")];
        _payBalanceTextLabel = [[UILabel alloc] initWithFrame:frame];
        _payBalanceTextLabel.text = payBalance;
        _payBalanceTextLabel.textColor = [UIColor orange_Red_Color];
        _payBalanceTextLabel.font = [UIFont fontWithName:@"Arial" size:14.0];
        _payBalanceTextLabel.textAlignment = UITextAlignmentLeft;
        _payBalanceTextLabel.backgroundColor = [UIColor clearColor];
        _payBalanceTextLabel.hidden = YES;
    }
    
    return _payBalanceTextLabel;
}

-(UIButton *)settlementBtn
{
    if (_settlementBtn==nil) {
        CGRect frame=CGRectMake(15, 152, 290, 35);
        _settlementBtn=[[UIButton alloc] initWithFrame:frame];
        [_settlementBtn setTitle:L(@"VPPayImmediately") forState:UIControlStateNormal];
        [_settlementBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_settlementBtn setBackgroundImage:[UIImage streImageNamed:@"submit_button_normal.png" ] forState:UIControlStateNormal];
        
        _settlementBtn.titleLabel.font =[UIFont systemFontOfSize:15];
        
        [_settlementBtn addTarget:self action:@selector(payNextHeadler) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settlementBtn;
}

-(UIButton*)payWaterButton
{
    if (!_payWaterButton) {
        
        _payWaterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _payWaterButton.frame = CGRectMake(10, 15,100, 30);
        
        [_payWaterButton setTitle:L(@"Water Fee") forState:UIControlStateNormal];
        [_payWaterButton setTitle:L(@"Water Fee") forState:UIControlStateSelected];
        
        [_payWaterButton setTitleColor:[UIColor light_Black_Color] forState:UIControlStateSelected];
        [_payWaterButton setTitleColor:[UIColor light_Black_Color] forState:UIControlStateNormal];
        
        [_payWaterButton setBackgroundImage:[UIImage streImageNamed:@"button_white_normal"] forState:UIControlStateNormal];
        [_payWaterButton setBackgroundImage:[UIImage streImageNamed:@"button_gray_normal"] forState:UIControlStateSelected];
        
        [_payWaterButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        [_payWaterButton addTarget:self action:@selector(payWaterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payWaterButton;
}

-(UIButton*)payElectricButton
{
    if (!_payElectricButton) {
        _payElectricButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _payElectricButton.frame = CGRectMake(110, 15,100, 30);
        
        [_payElectricButton setTitle:L(@"Electric Fee") forState:UIControlStateNormal];
        [_payElectricButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        [_payElectricButton setTitleColor:[UIColor light_Black_Color] forState:UIControlStateSelected];
        [_payElectricButton setTitleColor:[UIColor light_Black_Color] forState:UIControlStateNormal];
        
        [_payElectricButton setBackgroundImage:[UIImage streImageNamed:@"button_white_normal"] forState:UIControlStateNormal];
        [_payElectricButton setBackgroundImage:[UIImage streImageNamed:@"button_gray_normal"] forState:UIControlStateSelected];
        
        [_payElectricButton addTarget:self action:@selector(payElectricButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payElectricButton;
}

-(UIButton*)payGasButton
{
    if (!_payGasButton) {
        _payGasButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _payGasButton.frame = CGRectMake(210, 15,100, 30);
        
        [_payGasButton setTitle:L(@"Gas Fee") forState:UIControlStateNormal];
        [_payGasButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        [_payGasButton setTitleColor:[UIColor light_Black_Color] forState:UIControlStateSelected];
        [_payGasButton setTitleColor:[UIColor light_Black_Color] forState:UIControlStateNormal];
        
        [_payGasButton setBackgroundImage:[UIImage streImageNamed:@"button_white_normal"] forState:UIControlStateNormal];
        [_payGasButton setBackgroundImage:[UIImage streImageNamed:@"button_gray_normal"] forState:UIControlStateSelected];
        
        [_payGasButton addTarget:self action:@selector(payGasButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payGasButton;
}

- (UIButton *)checkBox
{
    if (!_checkBox)
    {
        _checkBox = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect checkboxRect = CGRectMake(15,111,20,20);
        [_checkBox setFrame:checkboxRect];
        [_checkBox setImage:[UIImage imageNamed:@"TuisongFilterUnselected"] forState:UIControlStateNormal];
        [_checkBox setImage:[UIImage imageNamed:@"MessageFilterCheck"] forState:UIControlStateSelected];
        [_checkBox addTarget:self action:@selector(checkBoxClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkBox;
}

#pragma mark -
#pragma mark Picker Views and Tool bar view

- (UIPickerView *)companyPickerView
{
    if (_companyPickerView == nil)
    {
        _companyPickerView = [[UIPickerView alloc] init];
        [_companyPickerView setDelegate:self];
        [_companyPickerView setDataSource:self];
        [_companyPickerView setShowsSelectionIndicator:YES];
    }
    return _companyPickerView;
}

- (id)initWithContentController:(CommonViewController *)controller
{
    self = [super init];
    if (self)
    {
        self.contentController = controller;
        [self.checkBox setSelected:YES];
        isManual = NO;
        isGetAccountInfo = NO;
        isNeedGetAccount = YES;
        
         _payServiceDTO = [[PayServiceDTO alloc] init];
        self.payType = [[Config currentConfig].wegType intValue];
        if (self.payType == payWater) {
            self.payWaterButton.selected= YES;//if (_payType != payType):nil==0
            self.payServiceDTO.typeCode = [NSString stringWithFormat:@"0%d",self.payType + 1];
        }
        
        [self configPersistentData];
        
        //xiewei 11-8
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jump2PayQueue) name:@"isPaySuccess" object:nil];
        
    }
    return self;
}

- (void)dataInit
{
    /**
     *  异步提交，等待初始化属性完成才才执行
     *  @author liukun 2014/9/5
     *  @since 2.4.3
     */
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (!isGetAccountInfo) {
            
            [self configPersistentData];
            
            if ([self.payServiceList count] != 0) {
                [self loadSavePayService];
            } else {
                [self getChargeCityListInfoRequest];
            }
            
            [self.groupTableView reloadData];
            
        }
    });
    
}

- (void)loadSavePayService
{
    for (NSString *payServiceList in self.payServiceList) {
        
        if ([payServiceList hasPrefix:[NSString stringWithFormat:@"%d",self.payType]]) {
            
            self.payServiceInfoList = [payServiceList componentsSeparatedByString:@","];
            
            self.payServiceDTO.areaCode = [self.payServiceInfoList objectAtIndex:1];
            self.payServiceDTO.areaName = [self.payServiceInfoList objectAtIndex:2];
            self.payServiceDTO.companyId = [self.payServiceInfoList objectAtIndex:3];
            self.payServiceDTO.companyCode = [self.payServiceInfoList objectAtIndex:4];
            self.payServiceDTO.companyName = [self.payServiceInfoList objectAtIndex:5];
            self.payServiceDTO.chargeAccount = [self.payServiceInfoList objectAtIndex:6];
            if ([self.payServiceInfoList count] == 8) {
                self.payServiceDTO.customerName = @"";
            }
        }
        
        self.payRegionTextField.text=self.payServiceDTO.areaName;
        self.payCompanyTextField.text=self.payServiceDTO.companyName;
        //  self.payAccountTextField.text=self.payServiceDTO.chargeAccount;
        self.payAccountTextField.text=@"";
        self.payBalanceLabel.text = @"";
        self.customerNameLabel.text = @"";
        self.customerNameTextLabel.hidden = YES;
        self.customerNameTextLabel.hidden = YES;
        
        if (![self.accountHintArray containsObject:self.payServiceDTO.chargeAccount]) {
            [self.accountHintArray removeAllObjects];
            [self.accountHintArray addObject:self.payServiceDTO.chargeAccount ];
            if (self.payType == payWater) {
                [Config currentConfig].waterAccounts =self.accountHintArray;
            } else if (self.payType == payElectricity) {
                [Config currentConfig].electricityAccounts =self.accountHintArray;
            } else if (self.payType == payGas) {
                [Config currentConfig].gasAccounts =self.accountHintArray;
            }
            
        }
        
        break;
    }

}

- (void)viewAppear
{
    [self configPersistentData];
    
    if (self.payServiceList.count==0) {
        return;
    }
    
    [self loadSavePayService];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    UIView *contentView = self;
    CGRect frame = contentView.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.height = contentView.bounds.size.height;
    self.groupTableView.frame = frame;
    
    
    [self addSubview:self.groupTableView];
}

- (void)configPersistentData
{
    if (self.payType == payWater) {
        self.payServiceList = [Config currentConfig].payWaterList;
        self.accountHintArray = [Config currentConfig].waterAccounts;
    } else if (self.payType == payElectricity) {
        self.payServiceList = [Config currentConfig].payElectricList;
        self.accountHintArray = [Config currentConfig].electricityAccounts;
    } else if (self.payType == payGas) {
        self.payServiceList = [Config currentConfig].payGasList;
        self.accountHintArray = [Config currentConfig].gasAccounts;
    }

}

- (void)jump2PayQueue
{
    [self.contentController.navigationController popToViewController:self.contentController animated:NO];
    
    PayServiceQueryViewController *_queryViewController = [[PayServiceQueryViewController alloc] init];
    
    _queryViewController.typeCode = self.payServiceDTO.typeCode;
    
    [self.contentController.navigationController pushViewController:_queryViewController animated:YES];
    
    TT_RELEASE_SAFELY(_queryViewController);
}

#pragma mark -
#pragma mark Table View Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return kNumberOfSectionsInTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == kPaymentSection)
    {
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == kPaymentSection)
    {
        static NSString *PayServiceCellIdentifier = @"PayServiceCellIdentifier";
        
        PayServiceCell *cell = (PayServiceCell *)[tableView dequeueReusableCellWithIdentifier:PayServiceCellIdentifier];
        
        if (cell == nil)
        {
            cell = [[PayServiceCell alloc] initWithReuseIdentifier:PayServiceCellIdentifier];
            tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            cell.textLabel.font =[UIFont systemFontOfSize:14];
            switch (indexPath.row)
            {
                case 0:
                    cell.textLabel.text = L(@"Pay region");
                    [cell.contentView addSubview:self.payRegionTextField];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    
                    break;
                case 1:
                {
                    cell.textLabel.text = L(@"Pay company");
                    [cell.contentView addSubview:self.payCompanyTextField];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    
                    break;
                }
                case 2:
                {
                    cell.textLabel.text = L(@"Pay account");
                    [cell.contentView addSubview:self.payAccountTextField];
                    break;
                }
                    
                default:
                    break;
            }
        }
        return cell;
    }
    else
    {
        static NSString *PayServiceQueryCellIdentifier = @"PayServiceQueryCellIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PayServiceQueryCellIdentifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PayServiceQueryCellIdentifier];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = L(@"VPAskForPayHistory");
            cell.textLabel.textAlignment = UITextAlignmentLeft;
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.font = [UIFont fontWithName:@"Arial" size:15.0];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == kPaymentSection&&indexPath.row==2)
    {
        self.pointY = cell.bottom;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHeightOfCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == kPaymentSection) {
        return 185;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == kPaymentSection) {
        return 60;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == kPaymentSection) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
        
        [view addSubview:self.payWaterButton];
        [view addSubview:self.payElectricButton];
        [view addSubview:self.payGasButton];
        
        return view;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == kPaymentSection)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 185)];
        [view addSubview:self.customerNameTextLabel];
        [view addSubview:self.customerNameLabel];
        [view addSubview:self.payBalanceTextLabel];
        [view addSubview:self.payBalanceLabel];
        
        UILabel *noticeLabel_firstLine = [[UILabel alloc] initWithFrame:CGRectMake(60, 47, 200, 20)];
        NSString *noticeMessage1 = [NSString stringWithFormat:@"%@",kNoticeMessageLine1];
        noticeLabel_firstLine.text = noticeMessage1;
        noticeLabel_firstLine.textAlignment = NSTextAlignmentCenter;
        noticeLabel_firstLine.font = [UIFont systemFontOfSize:12];
        noticeLabel_firstLine.numberOfLines=1;
        noticeLabel_firstLine.adjustsFontSizeToFitWidth=YES;
        noticeLabel_firstLine.textColor =[UIColor dark_Gray_Color];
        noticeLabel_firstLine.lineBreakMode = NSLineBreakByWordWrapping;
        noticeLabel_firstLine.backgroundColor = [UIColor clearColor];
        
        
        UILabel *noticeLabel_secondLine = [[UILabel alloc] initWithFrame:CGRectMake(60, noticeLabel_firstLine.bottom+3, 200, 20)];
        NSString *noticeMessage2 = [NSString stringWithFormat:@"%@",kNoticeMessageLine2];
        noticeLabel_secondLine.text = noticeMessage2;
        noticeLabel_secondLine.textAlignment = NSTextAlignmentCenter;
        noticeLabel_secondLine.font = [UIFont systemFontOfSize:12];
        noticeLabel_secondLine.numberOfLines=1;
        noticeLabel_secondLine.adjustsFontSizeToFitWidth=YES;
        noticeLabel_secondLine.textColor =[UIColor dark_Gray_Color];
        noticeLabel_secondLine.lineBreakMode = NSLineBreakByWordWrapping;
        noticeLabel_secondLine.backgroundColor = [UIColor clearColor];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(40, noticeLabel_secondLine.bottom+20, 80, 20)];
        NSString *agreementMessage = [[NSString alloc] initWithFormat:L(@"VPAlreadyReadAndAgree")];
        lab.text = agreementMessage;
        lab.textAlignment = NSTextAlignmentLeft;
        lab.textColor = [UIColor light_Black_Color];
        lab.font = [UIFont systemFontOfSize:12];
        lab.numberOfLines=1;
        lab.adjustsFontSizeToFitWidth=YES;
        lab.lineBreakMode = NSLineBreakByWordWrapping;
        lab.backgroundColor = [UIColor clearColor];
        
        UIButton *agreementBt = [UIButton buttonWithType:UIButtonTypeCustom];
        agreementBt.frame = CGRectMake(115, noticeLabel_secondLine.bottom+22, 100, 20);
        [agreementBt setTitle: L(@"VPSelfServicePayNegotiate") forState:UIControlStateNormal];
        [agreementBt setTitleColor:[UIColor orange_Light_Color] forState:UIControlStateNormal];
        agreementBt.titleLabel.font = [UIFont systemFontOfSize:12];
        [agreementBt addTarget:self action:@selector(pushToAgreement:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:noticeLabel_firstLine];
        [view addSubview:noticeLabel_secondLine];
        [view addSubview:lab];
        [view addSubview:agreementBt];
        [view addSubview:_checkBox];
        
        //        UIButton *payHelpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //        payHelpButton.frame = CGRectMake(270, 20, 30, 30);
        //        [payHelpButton setImage:[UIImage imageNamed:@"lotteryHelp.png"] forState:UIControlStateNormal];
        //
        //        [payHelpButton addTarget:self action:@selector(helpButtonHeadler:) forControlEvents:UIControlEventTouchUpInside];
        //
        //        [view addSubview:payHelpButton];
        
        [view addSubview:self.settlementBtn];
        
        return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ([indexPath section] == kPaymentSection)
    {
        if (indexPath.row == 0)
        {
            [_payCompanyTextField resignFirstResponder];
            [_payAccountTextField resignFirstResponder];
            [_payRegionTextField becomeFirstResponder];
            
        }else if (indexPath.row == 1){
            [_payAccountTextField resignFirstResponder];
            [_payRegionTextField  resignFirstResponder];
            [_payCompanyTextField becomeFirstResponder];
            
        }
    }
    
    if ([indexPath section] == kQuerySection)
    {
        PayServiceQueryViewController *_queryViewController =
        [[PayServiceQueryViewController alloc] init];
        _queryViewController.typeCode = self.payServiceDTO.typeCode;
        [self.contentController.navigationController pushViewController:_queryViewController animated:YES];
        TT_RELEASE_SAFELY(_queryViewController);
    }
}


#pragma mark -  DropDownMenu Methods
#pragma mark    下拉列表的方法实现

- (CGFloat)dropDownMenu:(UITableView *)dropDownMenuView heghtForRowAtIndextPath:(NSIndexPath *)indextPath{
    
    return  kHeightOfHintCell;
}


- (UITableViewCell *)dropDownMenu:(UITableView *)dropDownMenuView cellForRowAtIndextPath:(NSIndexPath *)indextPath{
    
    static NSString *identify = @"HintCell";
    UITableViewCell *cell = [dropDownMenuView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = [UIColor whiteColor];
    }
    if (!IsNilOrNull(self.accountMatchArray)&&!([self.accountMatchArray count]-1<indextPath.row)) {
        cell.textLabel.text = [self.accountMatchArray objectAtIndex:indextPath.row];
    }
    return cell;
    
}

- (void)dropDownMenu:(UITableView *)dropDownMenuView didSelectRowAtIndextPath:(NSIndexPath *)indextPath{
    
    [self.payAccountTextField setText:[self.accountMatchArray objectAtIndex:indextPath.row]];
    
    [self.payAccountTextField  resignFirstResponder];
    
    [self.accountSuperView removeFromSuperview];
}

- (void)dropDownMenu:(UITableView *)dropDownMenuView willDisplayCell:(UITableViewCell *)cell forRowAtIndextPath:(NSIndexPath *)indextPath
{
    
}

#pragma mark -
#pragma mark Text Field Delegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.text.length>0) {
        [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    
    if (textField == self.payRegionTextField)
    {
        [self.payAccountTextField resignFirstResponder];
        [self.payCompanyTextField resignFirstResponder];
        
        if (textField.text.length==0) {
            
            if (self.cityDic.count>0) {
                [self goToCityListVC];
            }else{
                isRequrstForCityListVC = YES;
                [self getChargeCityListInfoRequest];
            }
            
            return NO;

        }
        
        if ([textField.text isEqualToString:L(@"SelectChargeCity")]) {
            if (self.cityDic.count>0) {
                [self goToCityListVC];
            }else{
                isRequrstForCityListVC = YES;
                [self getChargeCityListInfoRequest];
            }
            return NO;

        }
        
        if (self.cityDic.count == 0) {
            isRequrstForCityListVC = YES;
            [self getChargeCityListInfoRequest];
            return NO;
        }else{
          [self goToCityListVC];
          return NO;
        }
        
    }
    
    if (textField == self.payCompanyTextField)
    {
        [self.payRegionTextField  resignFirstResponder];
        [self.payAccountTextField resignFirstResponder];
        
        [self.companyPickerView reloadAllComponents];
        
        if ([self.payServiceDTO.areaCode isEqualToString:@""] || [self.payRegionTextField.text isEqualToString:@""])
        {
            //[self.contentController presentSheet:L(@"Please select pay region") posY:50];
            return NO;
        }
        
        if (self.companyList.count == 0) {
            isRequrstForPickViewData = YES;
            [self getCompanyListRequest];
            return NO;
        }
        
        if (self.companyList == nil)
        {
            [self.contentController presentSheet:L(@"Please check your network") posY:50];
            return NO;
        }
    }
    
    if (textField == self.payAccountTextField)
    {
        [self.payRegionTextField resignFirstResponder];
        [self.payCompanyTextField resignFirstResponder];
        
        if ([self.payServiceDTO.areaCode isEqualToString:@""] || [self.payRegionTextField.text isEqualToString:@""])
        {
            //[self.contentController presentSheet:L(@"Please select pay region") posY:50];
            [textField resignFirstResponder];
            return NO;
        }
        if ([self.payServiceDTO.companyId isEqualToString:@""] || [self.payCompanyTextField.text isEqualToString:@""])
        {
            [self.contentController presentSheet:L(@"Please select pay company") posY:50];
            [textField resignFirstResponder];
            return NO;
        }
        
        isFirst = NO;
        
        if (!isGetFeeModeSuccess||self.preCompanyId!=self.payServiceDTO.companyId) {//前面没有加载chargeMode或者没有成功加载chargeMode 或者换了公司了
            [self getChargeModeInfoRequest];
            return NO;
        }
        
        
        [self hintAccountViewMatchString:textField.text];
    }
    
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.payAccountTextField && !isManual)
    {
        isNeedGetAccount = NO;
        
        [textField resignFirstResponder];
        
        NSString *platform = [Preferences platform];
        
//        iPad1 以及模拟器，直接调出手动输入界面
        if ([platform isEqualToString:@"iPad1"] || [platform isEqualToString:@"iPhone Simulator"] || [platform hasPrefix:@"iPod"]||![self.payServiceDTO.modeCode isEqualToString:@"4"])
        {
            isManual = YES;
            [self.payAccountTextField becomeFirstResponder];
        }
        else
        {
            
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                     delegate:self
                                                            cancelButtonTitle:nil
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:L(@"VPBarCodeScan"), L(@"Manual_Input"), nil];
            [actionSheet showInView:[AppDelegate currentAppDelegate].window];
            TT_RELEASE_SAFELY(actionSheet);
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *matchStr = [NSMutableString stringWithString:textField.text];
    [matchStr replaceCharactersInRange:range withString:string];
    
    [self hintAccountViewMatchString:matchStr];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.payAccountTextField)
    {
        self.payServiceDTO.chargeAccount = textField.text;
        
        isManual = NO;
        
        //查询账户字段不为空时
        if (self.payAccountTextField.text != nil && ![self.payAccountTextField.text isEqualToString:@""] && isNeedGetAccount)
        {
            if (isGetFeeModeSuccess) {
                [self getAccountInfoRequest];
            }
            else
            {
                [self getChargeModeInfoRequest];
                isContinueReqAccountInfo = YES;
            }
         }
        isNeedGetAccount = YES;
    }
    
    [self.accountSuperView removeFromSuperview];
}

#pragma mark -

- (void)hintAccountViewMatchString:(NSString *)matchStr
{
    if (self.accountHintArray.count>0&&((NSString *)[self.accountHintArray firstObject]).length>0) {
        self.accountMatchArray = self.accountHintArray;
        if (matchStr.length>0)
        {
            self.accountMatchArray = [NSMutableArray arrayWithArray:[self.accountMatchArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self beginSwith[cd] %@",matchStr]]];
            if (self.accountMatchArray.count>0) {
                NSString *rowCount = [NSString stringWithFormat:@"%d",self.accountMatchArray.count];
                [self.accountHintTableView reloadDataWithNumberOfRowAndSection:[NSArray arrayWithObjects:rowCount, nil]];
                [self.groupTableView addSubview:self.accountSuperView];
                
            }else{
                [self.accountSuperView removeFromSuperview];
            }
        }else{
            NSString *rowCount = [NSString stringWithFormat:@"%d",self.accountMatchArray.count];
            [self.accountHintTableView reloadDataWithNumberOfRowAndSection:[NSArray arrayWithObjects:rowCount, nil]];
            [self.groupTableView addSubview:self.accountSuperView];
        }
    }else{
        [self.accountSuperView removeFromSuperview];
    }

}

#pragma mark Action Sheet Delegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        SNReaderViewController *readerViewController = [[SNReaderViewController alloc] init];
        readerViewController.snDelegate = self;
        readerViewController.isServicePay = YES;
        [self.contentController presentModalViewController:readerViewController animated:YES];
        
        TT_RELEASE_SAFELY(readerViewController);
    }
    else
    {
        isManual = YES;
        [self.payAccountTextField becomeFirstResponder];
    }
}

#pragma mark -
#pragma mark SNReaderDelegate Methods
- (void)readerView:(ZBarReaderView *)view
    didReadSymbols:(ZBarSymbolSet *)symbols
         fromImage:(UIImage *)image
{
    ZBarSymbol *symbol = nil;
    
    for (symbol in symbols)
    {
        break;
    }
    
    NSString *zbarString = symbol.data;
    
    [self.contentController dismissModalViewControllerAnimated: YES];
    
    self.payAccountTextField.text = zbarString;
    isNeedGetAccount = YES;
    
    [self textFieldDidEndEditing:self.payAccountTextField];
}

- (void)manualInput
{
    [self.contentController dismissModalViewControllerAnimated:YES];
    
    isManual = YES;
    
    [self.payAccountTextField becomeFirstResponder];
}

#pragma mark -
#pragma mark Picker View Delegate Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.companyList count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
        PayServiceDTO *_company = [self.companyList objectAtIndex:row];
        return _company.companyName;
}

#pragma mark -
#pragma mark actions
- (void)payNextHeadler
{
    [self.payRegionTextField resignFirstResponder];
    [self.payCompanyTextField resignFirstResponder];
    [self.payAccountTextField resignFirstResponder];
    
    
    
    if (isLoading) {
        return;
    }
    if (!self.checkBox.selected)
    {
        [self.contentController presentSheet:L(@"Please confirm agreement") posY:50];
        return;
    }
    if (self.payRegionTextField.text == nil ||[self.payRegionTextField.text isEqualToString:@""])
    {
        //[self.contentController presentSheet:L(@"Please select pay region") posY:50];
        return;
    }
    if (self.payCompanyTextField.text == nil ||[self.payCompanyTextField.text isEqualToString:@""])
    {
        [self.contentController presentSheet:L(@"Please select pay company") posY:50];
        return;
    }
    if (self.payAccountTextField.text == nil ||[self.payAccountTextField.text isEqualToString:@""])
    {
        [self.contentController presentSheet:L(@"Please input your pay account") posY:50];
        return;
    }
    if (self.payBalanceLabel.text == nil ||[self.payBalanceLabel.text isEqualToString:@""])
    {
        [self.contentController presentSheet:L(@"Please makesure your pay account") posY:50];
        return;
    }
    
    [self goToNextController];
}

- (void)goToNextController
{
    if ([self.payServiceDTO.payAmount floatValue] == 0.0)
    {
        [self.contentController presentSheet:L(@"Account don't need pay") posY:60];
        return;
    }
    
    [Config currentConfig].wegType = [NSNumber numberWithInt:self.payType];
    
    PayServicePaymentViewController *nextViewController = [[PayServicePaymentViewController alloc] init];
    nextViewController.payDataSource = self.payServiceDTO;
    [self.contentController.navigationController pushViewController:nextViewController animated:YES];
    TT_RELEASE_SAFELY(nextViewController);
}

- (void)doneButtonClicked:(id)sender
{
    {
        isFirst = YES;
        NSInteger selectedRow = [self.companyPickerView selectedRowInComponent:0];
        PayServiceDTO *selectedCompany = [self.companyList objectAtIndex:selectedRow];
        self.payServiceDTO.companyCode = selectedCompany.companyCode;
        self.payServiceDTO.companyId = selectedCompany.companyId;
        self.payServiceDTO.companyName = selectedCompany.companyName;
        [self.payCompanyTextField setText:self.payServiceDTO.companyName];
        
        if (![self.payAccountTextField.text isEqualToString:@""])
        {
            [self.payAccountTextField setText:@""];
        }
        if (![self.customerNameLabel.text isEqualToString:@""])
        {
            [self.customerNameLabel setText:@""];
        }
        if (![self.payBalanceLabel.text isEqualToString:@""])
        {
            [self.payBalanceLabel setText:@""];
        }
        self.customerNameTextLabel.hidden = YES;
        self.customerNameTextLabel.hidden = YES;
        
        [self getChargeModeInfoRequest];
    }
    
    [self.payRegionTextField resignFirstResponder];
    [self.payCompanyTextField resignFirstResponder];
    [self.payAccountTextField resignFirstResponder];
}

- (void)cancelButtonClicked:(id)sender
{
    [self.payRegionTextField resignFirstResponder];
    [self.payCompanyTextField resignFirstResponder];
    [self.payAccountTextField resignFirstResponder];
}

- (void)helpButtonHeadler:(id)sender
{
    [UIView beginAnimations:@"preferenceSettingsAnimations" context:nil];
    [UIView setAnimationDuration:0.8];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.contentController.navigationController.view cache:NO];
    
    PayServiceHelpViewController *controller = [[PayServiceHelpViewController alloc] init];
    [self.contentController.navigationController pushViewController:controller animated:NO];
    TT_RELEASE_SAFELY(controller);
    
    [UIView commitAnimations];
}

- (void)requestFail:(NSString *)errorCode
{
    if (errorCode == nil)
    {
        [self.contentController presentSheet:L(@"Request Failed") posY:50];
    }
    else
    {
        [self.contentController presentSheet:errorCode posY:50];
    }
}

- (void)saveInfoToConfig
{
    if ([self.payServiceList count] == 0)
    {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [array addObject:[NSString stringWithFormat:@"%d,%@,%@,%@,%@,%@,%@,%@",self.payType,self.payServiceDTO.areaCode,self.payServiceDTO.areaName,self.payServiceDTO.companyId,self.payServiceDTO.companyCode,self.payServiceDTO.companyName,self.payAccountTextField.text,self.customerNameLabel.text]];
        
        switch (self.payType)
        {
            case 0:
                [Config currentConfig].payWaterList = array;
                break;
            case 1:
                [Config currentConfig].payElectricList = array;
                break;
            case 2:
                [Config currentConfig].payGasList = array;
                break;
            default:
                break;
        }
        TT_RELEASE_SAFELY(array);
        //        [Config currentConfig].payServiceList = array;
        //        TT_RELEASE_SAFELY(array);
    }
    else
    {
        for (NSString *payServiceString in self.payServiceList)
        {
            if ([payServiceString hasPrefix:[NSString stringWithFormat:@"%d",self.payType]])
            {
                [self.payServiceList removeObject:payServiceString];
                [self.payServiceList addObject:[NSString stringWithFormat:@"%d,%@,%@,%@,%@,%@,%@,%@",self.payType,self.payServiceDTO.areaCode,self.payServiceDTO.areaName,self.payServiceDTO.companyId,self.payServiceDTO.companyCode,self.payServiceDTO.companyName,self.payAccountTextField.text,self.customerNameLabel.text]];
                //                [Config currentConfig].payServiceList = self.payServiceList;
                switch (self.payType)
                {
                    case 0:
                        [Config currentConfig].payWaterList = self.payServiceList;
                        break;
                    case 1:
                        [Config currentConfig].payElectricList = self.payServiceList;
                        break;
                    case 2:
                        [Config currentConfig].payGasList = self.payServiceList;
                        break;
                    default:
                        break;
                }
                return;
            }
        }
        
        [self.payServiceList addObject:[NSString stringWithFormat:@"%d,%@,%@,%@,%@,%@,%@,%@",self.payType,self.payServiceDTO.areaCode,self.payServiceDTO.areaName,self.payServiceDTO.companyId,self.payServiceDTO.companyCode,self.payServiceDTO.companyName,self.payAccountTextField.text,self.customerNameLabel.text]];
        //        [Config currentConfig].payServiceList = self.payServiceList;
        switch (self.payType) {
            case 0:
                [Config currentConfig].payWaterList = self.payServiceList;
                break;
            case 1:
                [Config currentConfig].payElectricList = self.payServiceList;
                break;
            case 2:
                [Config currentConfig].payGasList = self.payServiceList;
                break;
            default:
                break;
        }
    }
}

- (void)setPayType:(PayServiceType)payType
{
    if (_payType != payType) {
        _payType = payType;
        
        self.payServiceDTO.typeCode = [NSString stringWithFormat:@"0%d",_payType + 1];
        
        self.payWaterButton.selected=_payType==payWater?YES:NO;
        self.payElectricButton.selected=_payType==payElectricity?YES:NO;
        self.payGasButton.selected=_payType==payGas?YES:NO;
        
        self.payRegionTextField.text=@"";
        self.payCompanyTextField.text=@"";
        self.payAccountTextField.text=@"";
        self.customerNameLabel.text=@"";
        self.payBalanceLabel.text=@"";
        self.customerNameTextLabel.hidden = YES;
        self.customerNameTextLabel.hidden = YES;
    }
}

-(void)payWaterButtonClick:(id)sender
{
    isGetFeeModeSuccess = NO;
    self.payType=0;
    self.payWaterButton.selected=YES;
    self.payElectricButton.selected=NO;
    self.payGasButton.selected=NO;
    self.accountHintArray = [Config currentConfig].waterAccounts;//提示账户
    
    [self.cityDic removeAllObjects];
    [self.regionList removeAllObjects];
    [self.companyList removeAllObjects];
    
    _payServiceDTO.typeCode = [NSString stringWithFormat:@"0%d",self.payType + 1];
    
    [self.payServiceList removeAllObjects];
    DLog(@"%d",[[Config currentConfig].payWaterList count]);
    if (!IsArrEmpty([Config currentConfig].payWaterList)) {
        self.payServiceList = [Config currentConfig].payWaterList;
    }
    
    
    //    [self.groupTableView removeFromSuperview];
    if ([self.payServiceList count] == 0) {
        self.payRegionTextField.text=@"";
        self.payCompanyTextField.text=@"";
        self.payAccountTextField.text=@"";
        self.customerNameLabel.text=@"";
        self.payBalanceLabel.text=@"";
        self.customerNameTextLabel.hidden = YES;
        self.customerNameTextLabel.hidden = YES;
        
        [self getChargeCityListInfoRequest];
    }else{
    
            for (NSString *payServiceList in self.payServiceList) {
                
                if ([payServiceList hasPrefix:[NSString stringWithFormat:@"%d",self.payType]]) {
                    
                    self.payServiceInfoList = [payServiceList componentsSeparatedByString:@","];
                    
                    self.payServiceDTO.areaCode = [self.payServiceInfoList objectAtIndex:1];
                    self.payServiceDTO.areaName = [self.payServiceInfoList objectAtIndex:2];
                    self.payServiceDTO.companyId = [self.payServiceInfoList objectAtIndex:3];
                    self.payServiceDTO.companyCode = [self.payServiceInfoList objectAtIndex:4];
                    self.payServiceDTO.companyName = [self.payServiceInfoList objectAtIndex:5];
                    self.payServiceDTO.chargeAccount = [self.payServiceInfoList objectAtIndex:6];
                    if ([self.payServiceInfoList count] == 8) {
                        self.payServiceDTO.customerName = @"";//[self.payServiceInfoList objectAtIndex:7];
                    }
                    
                    self.payRegionTextField.text=self.payServiceDTO.areaName;
                    self.payCompanyTextField.text=self.payServiceDTO.companyName;
                    //  self.payAccountTextField.text=self.payServiceDTO.chargeAccount;
                    self.payAccountTextField.text=@"";
                    self.payBalanceLabel.text = @"";
                    self.customerNameLabel.text = @"";
                    self.customerNameTextLabel.hidden = YES;
                    self.customerNameTextLabel.hidden = YES;
                }
                
                if (![self.accountHintArray containsObject:self.payServiceDTO.chargeAccount]&&self.payServiceDTO.chargeAccount.length) {
                    
                /* [self.accountHintArray insertObject:self.payServiceDTO.chargeAccount atIndex:0];
                    if (self.accountHintArray.count>5) {
                     [self.accountHintArray removeLastObject];
                   }
                 */
                    
                    [self.accountHintArray removeAllObjects];
                    [self.accountHintArray addObject:self.payServiceDTO.chargeAccount];
                    
                    [Config currentConfig].waterAccounts =self.accountHintArray;
                    
                }
            }
    }
    [self.groupTableView reloadData];
}

-(void)payElectricButtonClick:(id)sender
{
    isGetFeeModeSuccess = NO;
    self.payType=1;
    self.payWaterButton.selected=NO;
    self.payElectricButton.selected=YES;
    self.payGasButton.selected=NO;
    self.accountHintArray = [Config currentConfig].electricityAccounts;//提示账户
    
    [self.cityDic removeAllObjects];
    [self.regionList removeAllObjects];
    [self.companyList removeAllObjects];
    
    _payServiceDTO.typeCode = [NSString stringWithFormat:@"0%d",self.payType + 1];
    
    [self.payServiceList removeAllObjects];
    
    //    [self.payServiceList addObjectsFromArray:[Config currentConfig].payElectricList];
    if (!IsArrEmpty([Config currentConfig].payElectricList)) {
        self.payServiceList = [Config currentConfig].payElectricList;
    }
    
    //    [self.groupTableView removeFromSuperview];
    if ([self.payServiceList count] == 0) {
        self.payRegionTextField.text=@"";
        self.payCompanyTextField.text=@"";
        self.payAccountTextField.text=@"";
        self.customerNameLabel.text=@"";
        self.payBalanceLabel.text=@"";
        self.customerNameTextLabel.hidden = YES;
        self.customerNameTextLabel.hidden = YES;
        
        [self getChargeCityListInfoRequest];
    }else{
            for (NSString *payServiceList in self.payServiceList) {
                
                if ([payServiceList hasPrefix:[NSString stringWithFormat:@"%d",self.payType]]) {
                    
                    self.payServiceInfoList = [payServiceList componentsSeparatedByString:@","];
                    
                    self.payServiceDTO.areaCode = [self.payServiceInfoList objectAtIndex:1];
                    self.payServiceDTO.areaName = [self.payServiceInfoList objectAtIndex:2];
                    self.payServiceDTO.companyId = [self.payServiceInfoList objectAtIndex:3];
                    self.payServiceDTO.companyCode = [self.payServiceInfoList objectAtIndex:4];
                    self.payServiceDTO.companyName = [self.payServiceInfoList objectAtIndex:5];
                    self.payServiceDTO.chargeAccount = [self.payServiceInfoList objectAtIndex:6];
                    if ([self.payServiceInfoList count] == 8) {
                        self.payServiceDTO.customerName = @"";//[self.payServiceInfoList objectAtIndex:7];
                    }
                    
                    self.payRegionTextField.text=self.payServiceDTO.areaName;
                    self.payCompanyTextField.text=self.payServiceDTO.companyName;
                    //            self.payAccountTextField.text=self.payServiceDTO.chargeAccount;
                    self.payAccountTextField.text=@"";
                    self.payBalanceLabel.text = @"";
                    self.customerNameLabel.text = @"";
                    self.customerNameTextLabel.hidden = YES;
                    self.customerNameTextLabel.hidden = YES;
                }
                
                if (![self.accountHintArray containsObject:self.payServiceDTO.chargeAccount]&&self.payServiceDTO.chargeAccount.length) {
                    
        //            [self.accountHintArray insertObject:self.payServiceDTO.chargeAccount atIndex:0];
        //            if (self.accountHintArray.count>5) {
        //                [self.accountHintArray removeLastObject];
        //            }
                    
                    [self.accountHintArray removeAllObjects];
                    [self.accountHintArray addObject:self.payServiceDTO.chargeAccount];

                    [Config currentConfig].electricityAccounts =self.accountHintArray;
                    
                }

            }
    }
   
    [self.groupTableView reloadData];
    
}

-(void)payGasButtonClick:(id)sender
{
    isGetFeeModeSuccess = NO;
    self.payType=2;
    self.payWaterButton.selected=NO;
    self.payElectricButton.selected=NO;
    self.payGasButton.selected=YES;
    self.accountHintArray = [Config currentConfig].gasAccounts;//提示账户
    
    [self.cityDic removeAllObjects];
    [self.regionList removeAllObjects];
    [self.companyList removeAllObjects];
    
    _payServiceDTO.typeCode = [NSString stringWithFormat:@"0%d",self.payType + 1];
    
    [self.payServiceList removeAllObjects];
    
    if (!IsArrEmpty([Config currentConfig].payGasList)) {
        self.payServiceList = [Config currentConfig].payGasList;
    }
    
    if ([self.payServiceList count] == 0) {
        self.payRegionTextField.text=@"";
        self.payCompanyTextField.text=@"";
        self.payAccountTextField.text=@"";
        self.customerNameLabel.text=@"";
        self.payBalanceLabel.text=@"";
        self.customerNameTextLabel.hidden = YES;
        self.customerNameTextLabel.hidden = YES;
        
        [self getChargeCityListInfoRequest];
    }else{
    
            for (NSString *payServiceList in self.payServiceList) {
                
                if ([payServiceList hasPrefix:[NSString stringWithFormat:@"%d",self.payType]]) {
                    
                    self.payServiceInfoList = [payServiceList componentsSeparatedByString:@","];
                    
                    self.payServiceDTO.areaCode = [self.payServiceInfoList objectAtIndex:1];
                    self.payServiceDTO.areaName = [self.payServiceInfoList objectAtIndex:2];
                    self.payServiceDTO.companyId = [self.payServiceInfoList objectAtIndex:3];
                    self.payServiceDTO.companyCode = [self.payServiceInfoList objectAtIndex:4];
                    self.payServiceDTO.companyName = [self.payServiceInfoList objectAtIndex:5];
                    self.payServiceDTO.chargeAccount = [self.payServiceInfoList objectAtIndex:6];
                    if ([self.payServiceInfoList count] == 8) {
                        self.payServiceDTO.customerName = @"";//[self.payServiceInfoList objectAtIndex:7];
                    }
                    
                    self.payRegionTextField.text=self.payServiceDTO.areaName;
                    self.payCompanyTextField.text=self.payServiceDTO.companyName;
                    //            self.payAccountTextField.text=self.payServiceDTO.chargeAccount;
                    self.payAccountTextField.text=@"";
                    self.payBalanceLabel.text = @"";
                    self.customerNameLabel.text = @"";
                    self.customerNameTextLabel.hidden = YES;
                    self.customerNameTextLabel.hidden = YES;
                }
                
                if (![self.accountHintArray containsObject:self.payServiceDTO.chargeAccount]&&self.payServiceDTO.chargeAccount.length) {
                    
                    [self.accountHintArray removeAllObjects];
                    [self.accountHintArray addObject:self.payServiceDTO.chargeAccount];

                    [Config currentConfig].gasAccounts =self.accountHintArray;
                    
                }
            }
    }
    [self.groupTableView reloadData];
    
}

- (void)pushToAgreement:(id)sender
{
    SNLocalWebViewController *webVC = [[SNLocalWebViewController alloc]init];
    webVC.pathName = L(@"VPWaterElectricityCoalPayNegotiate");
    webVC.title = L(@"VPSelfServicePayNegotiate1");
    [self.contentController.navigationController pushViewController:webVC animated:YES];
}

- (void)checkBoxClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
}

- (void)goToCityListVC
{
    SNCityListViewController *cityVC = [SNCityListViewController new];
    
    cityVC.cityDic =  self.cityDic;
    
    cityVC.cityCall = ^(SNCityFirstLetterDTO * cityDTO){
        
        _payRegionTextField.text  = cityDTO.cityName;
        [_payRegionTextField resignFirstResponder];
        
        self.payServiceDTO.areaCode = cityDTO.cityCode;
        self.payServiceDTO.areaName = cityDTO.cityName;
        
        if (![self.payCompanyTextField.text isEqualToString:@""])
        {
            [self.payCompanyTextField setText:@""];
        }
        if (![self.payAccountTextField.text isEqualToString:@""])
        {
            [self.payAccountTextField setText:@""];
        }
        if (![self.customerNameLabel.text isEqualToString:@""])
        {
            [self.customerNameLabel setText:@""];
        }
        if (![self.payBalanceLabel.text isEqualToString:@""])
        {
            [self.payBalanceLabel setText:@""];
        }
        self.customerNameTextLabel.hidden = YES;
        self.customerNameTextLabel.hidden = YES;
        
        [self getCompanyListRequest];
        
    };
    
    [self.contentController.navigationController pushViewController:cityVC animated:YES];

}

#pragma mark -
#pragma mark service

- (void)getChargeModeInfoRequest
{
    isLoading = YES;
    isGetFeeModeSuccess = NO;
    [self.contentController displayOverFlowActivityView];
    self.groupTableView.userInteractionEnabled = NO;
    [self.waterElecGasService beginGetChargeMode:self.payServiceDTO];
}

- (void)getChargeCityListInfoRequest
{
    isLoading = YES;
    [self.contentController displayOverFlowActivityView];
    self.groupTableView.userInteractionEnabled = NO;
    [self.waterElecGasService beginGetChargeCityList:self.payServiceDTO];
}

- (void)getRegionInfoRequest
{
    isLoading = YES;
    [self.contentController displayOverFlowActivityView];
    self.groupTableView.userInteractionEnabled = NO;
    [self.waterElecGasService beginGetRegionInfo:self.payServiceDTO];
}

- (void)getCompanyListRequest
{
    isLoading = YES;
    [self.contentController displayOverFlowActivityView];
    self.groupTableView.userInteractionEnabled = NO;
    [self.waterElecGasService beginGetCompanyList:self.payServiceDTO];
}

- (void)getAccountInfoRequest
{
    isGetAccountInfo = YES;
    isLoading = YES;
    [self.contentController displayOverFlowActivityView];
    self.groupTableView.userInteractionEnabled = NO;
    [self.waterElecGasService beginGetAccountInfo:self.payServiceDTO];
}

#pragma mark -
- (void)getCityListCompleteWithService:(WaterElectricityGasService *)service
                                Result:(BOOL)isSuccess
                              errorMsg:(NSString *)errorMsg
{
    isLoading = NO;
    
    self.groupTableView.userInteractionEnabled = YES;
    
    [self.contentController removeOverFlowActivityView];
  
    
    if (isSuccess)
    {
        
        self.regionList = service.regionList;
        self.cityDic    = service.cityDic;
        
        if (isRequrstForCityListVC) {
            isRequrstForCityListVC = NO;
            [self goToCityListVC];
            return;
        }
        
            BOOL isMatchLocationCity = NO;
            //如果没有上次交易城市,就取定位城市
            if (((NSString *)[self.payRegionTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]).length==0)
            {
                if ([Config currentConfig].locationCity.length>0) {
                    NSString *locationCity = [Config currentConfig].locationCity;
                    for (SNCityFirstLetterDTO *dto in service.regionList) {
                        NSRange range = [locationCity rangeOfString:dto.cityName];
                        if (range.location!=NSNotFound) {
                            self.payRegionTextField.text = dto.cityName;
                            self.payServiceDTO.areaCode  = dto.cityCode;
                            self.payServiceDTO.areaName  = dto.cityName;
                            isMatchLocationCity = YES;
                            break;
                        }
                    }
                }
            }
            if (!isMatchLocationCity)
            {
                self.payRegionTextField.text = L(@"SelectChargeCity");
                return;
            }else{
                [self getCompanyListRequest];
            }
        
    }
    else
    {
        [self.contentController removeOverFlowActivityView];
        
        if (!service.requestFail) {
            
            [self.contentController presentSheet:L(@"Request Failed") posY:60];
        }
        else
        {
            [self performSelectorOnMainThread:@selector(requestFail:) withObject:service.errorCode waitUntilDone:YES];
        }
    }

    
}

- (void)getCompanyListCompleteWithService:(WaterElectricityGasService *)service
                                   Result:(BOOL)isSuccess
                                 errorMsg:(NSString *)errorMsg
{
    isLoading = NO;
    
    self.groupTableView.userInteractionEnabled = YES;

    [self.contentController removeOverFlowActivityView];
    
    if (isSuccess)
    {
        self.companyList = service.companyList;
        [self.companyPickerView reloadAllComponents];
        
        if (isRequrstForPickViewData) {
            isRequrstForPickViewData = NO;
            return;
        }

          //默认第一个
        PayServiceDTO *selectedCompany = [self.companyList objectAtIndex:0];
        self.payServiceDTO.companyCode = selectedCompany.companyCode;
        self.payServiceDTO.companyId   = selectedCompany.companyId;
        self.payServiceDTO.companyName = selectedCompany.companyName;
        [self.payCompanyTextField setText:self.payServiceDTO.companyName];
    }
    else
    {
        [self.contentController removeOverFlowActivityView];

        if (!service.requestFail) {

            [self.contentController presentSheet:L(@"Request Failed") posY:60];
        }
        else
        {
            [self performSelectorOnMainThread:@selector(requestFail:) withObject:service.errorCode waitUntilDone:YES];
        }
    }
}

- (void)getChargeModeCompleteWithService:(WaterElectricityGasService *)service Result:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    isLoading = NO;
    
    self.groupTableView.userInteractionEnabled = YES;
    
    [self.contentController removeOverFlowActivityView];
    
    if (isSuccess) {
        
        if (!service.payServiceDTO.isChargeTime) {
            
            [self.contentController presentSheet:service.payServiceDTO.chargeTimeMessage posY:60];
            return;
        }
        
        isGetFeeModeSuccess = YES;
        
        self.payServiceDTO = service.payServiceDTO;
        self.preCompanyId  = service.payServiceDTO.companyId;
        
        if (!isFirst) {
            [self.payAccountTextField becomeFirstResponder];
            return;
        }
        
        
        if (isContinueReqAccountInfo && self.payServiceDTO.chargeAccount.length) {
            [self  getAccountInfoRequest];
        }
        
      }
    else
    {
        
        if (!service.requestFail) {
            
            [self.contentController presentSheet:L(@"Request Failed") posY:60];
        }
        else
        {
            [self performSelectorOnMainThread:@selector(requestFail:) withObject:service.errorCode waitUntilDone:YES];
        }
    }

}

- (void)getAccountInfoCompleteWithService:(WaterElectricityGasService *)service
                                   Result:(BOOL)isSuccess
                                 errorMsg:(NSString *)errorMsg
{
    isLoading = NO;
    isContinueReqAccountInfo = NO;
    
    [self.contentController removeOverFlowActivityView];
    self.groupTableView.userInteractionEnabled = YES;
    
    self.payAccountNum = service.payAccountNum;
    
    //保存提示账号
    
    if (self.payAccountTextField.text.length) {
        
        if (![self.accountHintArray containsObject:self.payAccountTextField.text]) {
            [self.accountHintArray removeAllObjects];
            [self.accountHintArray addObject:self.payAccountTextField.text];
            
            if (self.payType == payWater) {
                [Config currentConfig].waterAccounts =self.accountHintArray;
            } else if (self.payType == payElectricity) {
                [Config currentConfig].electricityAccounts =self.accountHintArray;
            } else if (self.payType == payGas) {
                [Config currentConfig].gasAccounts =self.accountHintArray;
            }
            
        }
        
    }
    //保存提示账号
    
    
    if (isSuccess) {
        self.payServiceDTO = service.payServiceDTO;
        self.customerNameLabel.text = service.customerName;
        self.payBalanceLabel.text = service.payBalance;
        self.customerNameTextLabel.hidden = NO;
        self.customerNameTextLabel.hidden = NO;
        isGetAccountInfo = service.isGetAccount;
        
        [self saveInfoToConfig];
    }
    else
    {
        if (!service.requestFail) {
            
            [self.contentController presentSheet:L(@"Request Failed") posY:60];
        }
        else
        {
            [self performSelectorOnMainThread:@selector(requestFail:) withObject:service.errorCode waitUntilDone:YES];
        }
        
        if (![self.customerNameLabel.text isEqualToString:@""])
        {
            [self.customerNameLabel setText:@""];
        }
        
        if (![self.payBalanceLabel.text isEqualToString:@""])
        {
            [self.payBalanceLabel setText:@""];
        }
        self.customerNameTextLabel.hidden = YES;
        self.customerNameTextLabel.hidden = YES;
    }
}

//#pragma mark - RadioButton Delegate Method
//-(void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString*)groupId
//{
//    self.payType=index;
//
//    _payServiceDTO.typeCode = [NSString stringWithFormat:@"0%d",self.payType + 1];
//
//    [self.groupTableView removeFromSuperview];
//    self.payRegionTextField.text=@"";
//    self.payCompanyTextField.text=@"";
//    self.payAccountTextField.text=@"";
//    self.customerNameLabel.text=@"";
//    self.payBalanceLabel.text=@"";
//
//    for (NSString *payServiceList in self.payServiceList) {
//
//        if ([payServiceList hasPrefix:[NSString stringWithFormat:@"%d",self.payType]]) {
//
//            self.payServiceInfoList = [payServiceList componentsSeparatedByString:@","];
//
//            self.payServiceDTO.areaCode = [self.payServiceInfoList objectAtIndex:1];
//            self.payServiceDTO.areaName = [self.payServiceInfoList objectAtIndex:2];
//            self.payServiceDTO.companyId = [self.payServiceInfoList objectAtIndex:3];
//            self.payServiceDTO.companyCode = [self.payServiceInfoList objectAtIndex:4];
//            self.payServiceDTO.companyName = [self.payServiceInfoList objectAtIndex:5];
//            self.payServiceDTO.chargeAccount = [self.payServiceInfoList objectAtIndex:6];
//            if ([self.payServiceInfoList count] == 8) {
//                self.payServiceDTO.customerName = [self.payServiceInfoList objectAtIndex:7];
//            }                    
//        }
//        
//        [self getRegionInfoRequest];
//    }
//    [self.regionPickerView reloadAllComponents];
//    [self addSubview:self.groupTableView];
//}

//#pragma mark 代理方法
//- (void)getRegionInfoCompleteWithService:(WaterElectricityGasService *)service
//                                  Result:(BOOL)isSuccess
//                                errorMsg:(NSString *)errorMsg
//{
//    isLoading = NO;
//    
//    self.groupTableView.userInteractionEnabled = YES;
//    
//    if (isFirst) {
//        [self.contentController removeOverFlowActivityView];
//    }
//    
//    if (isSuccess)
//    {
//        
//        self.regionList = service.regionList;
//        [self.regionPickerView reloadAllComponents];
//        
//        if (isRequrstForPickViewData) {
//            isRequrstForPickViewData = NO;
//            [_payRegionTextField becomeFirstResponder];
//            return;
//        }
//        
//        if (!isFirst)
//        {
//            //            [self.waterElecGasService beginGetCompanyList:self.payServiceDTO];
//            
//        }else{
//            
//            BOOL isMatchLocationCity = NO;
//            //如果没有上次交易城市,就取定位城市
//            if (((NSString *)[self.payRegionTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]).length==0)
//            {
//                if ([Config currentConfig].locationCity.length>0) {
//                    NSString *locationCity = [Config currentConfig].locationCity;
//                    for (PayServiceDTO *dto in service.regionList) {
//                        NSRange range = [locationCity rangeOfString:dto.areaName];
//                        if (range.location!=NSNotFound) {
//                            self.payRegionTextField.text = dto.areaName;
//                            self.payServiceDTO.areaCode  = dto.areaCode;
//                            self.payServiceDTO.areaName  = dto.areaName;
//                            isMatchLocationCity = YES;
//                            break;
//                        }
//                    }
//                }
//            }
//            if (!isMatchLocationCity)
//            {
//                PayServiceDTO *dto = [service.regionList objectAtIndex:0];
//                self.payServiceDTO.areaCode  = dto.areaCode;
//                self.payServiceDTO.areaName  = dto.areaName;
//                self.payRegionTextField.text = dto.areaName;
//            }
//            
//            [self.waterElecGasService beginGetCompanyList:self.payServiceDTO];
//        }
//    }
//    else
//    {
//        [self.contentController removeOverFlowActivityView];
//        
//        if (!service.requestFail) {
//            
//            [self.contentController presentSheet:L(@"Request Failed") posY:60];
//        }
//        else
//        {
//            [self performSelectorOnMainThread:@selector(requestFail:) withObject:service.errorCode waitUntilDone:YES];
//        }
//    }
//}



@end

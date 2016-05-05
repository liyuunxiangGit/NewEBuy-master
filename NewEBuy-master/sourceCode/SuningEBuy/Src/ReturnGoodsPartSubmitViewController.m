//
//  ReturnGoodsPartSubmitViewController.m
//  SuningEBuy
//
//  Created by zl on 14-10-21.
//  Copyright (c) 2014年 Suning. All rights reserved.
//
#import "RegexKitLite.h"
#import "ReturnGoodsPartSubmitViewController.h"
#import "PlaceholderTextView.h"
#import "OSGetStatusCommand.h"
#import "OSLeaveMessageViewController.h"
#import "NProOrderProductInfoCell.h"
#import "NProOrderListHeadCell.h"
#import "NOrderContactCell.h"
#import "ReturnGoodSDetailCell.h"
#import "OrderDetailBtnCell.h"
#import "ToolBarButton.h"
#import "ReturnPartLocationViewCell.h"
#import "StoreMentionViewController.h"

#define DefaultFont            [UIFont systemFontOfSize:16.0]
#define kTLeftMargin             90.0
#define kTopMargin              8.0
#define kTextFieldWidth         188.0
#define kTextFieldHeight        30.0
#define kTextFieldFontSize      15.0

@interface ReturnGoodsPartSubmitViewController ()<UITextFieldDelegate,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,ToolBarButtonDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,ReturnGoodsPicServiceDelegate,StoreMentionDelegate>
@property(nonatomic,strong) NSMutableArray *dateList;
@property(nonatomic,strong) NSMutableArray *getProductDateList;
@property(nonatomic,copy  ) NSString    *checkupDate;//检查日期
@property(nonatomic,copy  ) NSString    *checkupGetProductDate;


@property(nonatomic,strong) UIPickerView *datePickerView;
@property(nonatomic,strong) UIPickerView *getProductDatePickerView;
@property(nonatomic,strong) UIPickerView *reasonPickView;
@property(nonatomic,strong) UIToolbar *getProductDateDoneAndCancelBar;
@property(nonatomic,strong) UITextField *getProductDateTextField;
@property(nonatomic,strong) UITextField *returnGoodsDateTextField;
@property(nonatomic,strong) PlaceholderTextView *reasonInputTextField;
@property(nonatomic,strong) UIToolbar *doneAndCancelBar;
@property(nonatomic,strong) UIButton      *pointView;//点击尖头按钮
@property(nonatomic,strong) ToolBarButton *toolBarBtton;
@property(nonatomic,strong) UITextField          *addressTextField;//详细地址
@property(nonatomic,strong) UITextField                 *personTextField;//联系人
@property(nonatomic,strong) UITextField                 *phoneTextField;//号码
@property(nonatomic,strong) UILabel                 *descriptionText;//厂家和3c描述
@property(nonatomic,strong) UILabel                 *snLocationLab;//门店定位

@property(nonatomic,strong)NSMutableArray* picArray;
@property(nonatomic,assign)int  picIndex;
@property(nonatomic,strong)NSData* picData;
@property(nonatomic,strong)UIButton* upPicBt;
@property(nonatomic,copy  )NSString* numberStr;
@property(nonatomic,strong)UIButton* locationBt;
@end

@implementation ReturnGoodsPartSubmitViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = L(@"return goods appliance");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"member_myEbuy"),self.title];
        [self initAppraisalDate];
        _picIndex = -1;
        _picArray = [NSMutableArray new];
        _picHttp = [[ReturnGoodsPicService alloc] init];
        _picHttp.delegate = self;
        if (!_isGetOnlineStatusOk)
        {
            [self getOnlineServiceStatus];
        }
        
    }
    return self;
}

-(void)initAppraisalDate
{
    
    if (_dateList == nil) {
        
        _dateList = [[NSMutableArray alloc]initWithCapacity:7];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = nil;
    
    if (self.prepareDto.currentDay && ![self.prepareDto.currentDay isEqualToString:@""]) {
        //如果系统返回时间不为空，使用系统时间
        date = [dateFormatter dateFromString:self.prepareDto.currentDay];
        
    }else{
        //系统时间为空，使用本地时间
        date = [NSDate date];
    }
    
    for (int i=0; i<7; i++)
    {
        date = [date dateByAddingTimeInterval:3600*24];
        NSString *strDate = [dateFormatter stringFromDate:date];
        [_dateList addObject:strDate];
    }
}

- (void)loadView
{
    [super loadView];
    UIView *contentView = self.view;
    
    CGRect frame = contentView.frame;
    
    frame.origin.x = 0;
    
    frame.origin.y = 0;
    
    frame.size.height = contentView.bounds.size.height - 92;
    
    self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    self.tpTableView.frame = [self setCommonViewFrame:self.hasNav WithTab:YES];//[self setViewFrame:self.hasNav];//frame;
    
    self.tpTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tpTableView];
    self.hasSuspendButton = YES;

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.numberStr = self.prepareDto.quantityValue;
    if ([self.prepareDto.appraisal isEqualToString:@"0"] || [self.prepareDto.appraisal isEqualToString:@""]) {
        
        self.returnGoodsAppraisal = noAppraisal;
    }
    else if([self.prepareDto.appraisal isEqualToString:@"1"]){
        
        self.returnGoodsAppraisal  = myCompany;
        
    }else if([self.prepareDto.appraisal isEqualToString:@"2"]){
        
        
        self.returnGoodsAppraisal = factory;
    }
    else if([self.prepareDto.appraisal isEqualToString:@"3"]){
        
        self.returnGoodsAppraisal = store;
    }
}

- (UITextField *)phoneTextField
{
    if (_phoneTextField == nil)
    {
        CGRect frame = CGRectMake(kTLeftMargin, 0, kTextFieldWidth, 40);
        _phoneTextField = [[UITextField alloc] initWithFrame:frame];
        [_phoneTextField  setTag:1001];
        _phoneTextField.placeholder = @"请输入联系人号码";
        _phoneTextField.borderStyle = UITextBorderStyleNone;
        _phoneTextField.textColor = [UIColor light_Black_Color];
        _phoneTextField.font = [UIFont systemFontOfSize:kTextFieldFontSize];
        _phoneTextField.backgroundColor = [UIColor clearColor];
        _phoneTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.returnKeyType = UIReturnKeyDone;
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTextField.delegate = self;
    }
    
    return _phoneTextField;
}

-(UILabel*)descriptionText
{
    if (!_descriptionText)
    {
        _descriptionText = [[UILabel alloc] initWithFrame:CGRectMake(12, 15, self.view.frame.size.width-24,180-30)];
        _descriptionText.textColor = [UIColor whiteColor];
        _descriptionText.backgroundColor = [UIColor clearColor];
        _descriptionText.numberOfLines = 0;
        _descriptionText.font = [UIFont systemFontOfSize:13];
        
    }
    return _descriptionText;
}

- (UITextField *)personTextField
{
    if (_personTextField == nil)
    {
        CGRect frame = CGRectMake(kTLeftMargin, 0, kTextFieldWidth, 40);
        _personTextField = [[UITextField alloc] initWithFrame:frame];
        _personTextField.placeholder = @"请输入联系人姓名";
        _personTextField.borderStyle = UITextBorderStyleNone;
        _personTextField.textColor = [UIColor light_Black_Color];
        _personTextField.font = [UIFont systemFontOfSize:kTextFieldFontSize];
        _personTextField.backgroundColor = [UIColor clearColor];
        _personTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _personTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _personTextField.keyboardType = UIKeyboardTypeDefault;
        _personTextField.returnKeyType = UIReturnKeyDone;
        _personTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _personTextField.delegate = self;
    }
    
    return _personTextField;
}
- (UITextField *)addressTextField
{
    if (_addressTextField == nil)
    {
        CGRect frame = CGRectMake(90, 40, 200, 40);
        _addressTextField = [[UITextField alloc] initWithFrame:frame];
        _addressTextField.placeholder = L(@"Please input detail address");
        _addressTextField.borderStyle = UITextBorderStyleNone;
        _addressTextField.textColor = [UIColor light_Black_Color];
        _addressTextField.font = [UIFont systemFontOfSize:kTextFieldFontSize];
        _addressTextField.backgroundColor = [UIColor clearColor];
        _addressTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _addressTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _addressTextField.keyboardType = UIKeyboardTypeDefault;
        _addressTextField.returnKeyType = UIReturnKeyDone;
        _addressTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _addressTextField.delegate =self;
    }
    
    return _addressTextField;
}

- (ToolBarButton *)toolBarBtton{
    
    if (!_toolBarBtton) {
        
        _toolBarBtton = [[ToolBarButton alloc]initWithFrame:CGRectMake(95, 0, 200, 44)];
        
        _toolBarBtton.backgroundColor = [UIColor clearColor];
        
        [_toolBarBtton setTitle:L(@"please choose") forState:UIControlStateNormal];
        
        [_toolBarBtton setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateNormal];
        
        _toolBarBtton.inputView =self.reasonPickView;
        
        _toolBarBtton.delegate = self;
        
        _toolBarBtton.titleLabel.font = DefaultFont;
        
        _toolBarBtton.titleLabel.textAlignment = UITextAlignmentRight;
        
        _toolBarBtton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _toolBarBtton;
}

-(UIButton *)pointView
{
    if (!_pointView) {
        _pointView = [[UIButton alloc] init];
        _pointView.frame = CGRectMake(280, 20, 18/2, 29/2);
        _pointView.selected = NO;
    }
    return _pointView;
}

- (void)contactCShop
{
    MemberOrderNamesDTO *displayDTO = [self.headList safeObjectAtIndex:0];
    [self checkLoginWithLoginedBlock:^{
        if (_onlineStatus == 0)
        {
            OSLeaveMessageViewController *vc = [[OSLeaveMessageViewController alloc] initWithShopCode:displayDTO.supplierCode ShopName:displayDTO.cShopName ProductCode:nil ProductName:nil OrderId:self.prepareDto.orderId];
            AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
            [self presentModalViewController:nav animated:YES];
        }
        else
        {
            OSChatViewController *vc = [[OSChatViewController alloc] initAsCShop:displayDTO.supplierCode ProductName:nil ProductCode:nil OrderNo:self.prepareDto.orderId];
            vc.vendorName = displayDTO.cShopName;
            AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
            [self presentModalViewController:nav animated:YES];
        }
    } loginCancelBlock:nil];
}

- (void)getOnlineServiceStatus
{
    @weakify(self);
    
    OSGetStatusCommand *cmd_ = [[OSGetStatusCommand alloc] initAsB2CReturnOrderWithOrderNo:self.prepareDto.orderId];
    [CommandManage excuteCommand:cmd_ completeBlock:^(id<Command> cmd) {
        
        @strongify(self);
        OSGetStatusCommand *__cmd = (OSGetStatusCommand *)cmd;
        if (__cmd.onlineStatus >= -1)
        {
            self->_onlineStatus = __cmd.onlineStatus;
            self->_isGetOnlineStatusOk = YES;
            [self.tpTableView reloadData];
        }
        
    }];
}

-(PlaceholderTextView *)reasonInputTextField{
    
    if (_reasonInputTextField == nil) {
        
        _reasonInputTextField = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(0.5, 0.5, 289, 149)];
        
        _reasonInputTextField.placeholder = @"＊请输入详细的退货说明";
        
        
        _reasonInputTextField.textColor = [UIColor blackColor];
        _reasonInputTextField.font = [UIFont systemFontOfSize:15.0];
        _reasonInputTextField.backgroundColor = [UIColor clearColor];
        _reasonInputTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        
        _reasonInputTextField.keyboardType = UIKeyboardTypeDefault;
        
        _reasonInputTextField.returnKeyType = UIReturnKeyDone;
        
        _reasonInputTextField.delegate = self;
    
        _reasonInputTextField.font = DefaultFont;
        
    }
    
    return _reasonInputTextField;
}
-(UITextField *)returnGoodsDateTextField{
    
    if (_returnGoodsDateTextField == nil) {
        
        _returnGoodsDateTextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 0, 200, 44)];
        
        _returnGoodsDateTextField.delegate = self;
        
        _returnGoodsDateTextField.placeholder = L(@"must fill");
        
        _returnGoodsDateTextField.returnKeyType = UIReturnKeyDone;
        
        _returnGoodsDateTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        _returnGoodsDateTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        _returnGoodsDateTextField.font = DefaultFont;
        
        _returnGoodsDateTextField.inputView = self.datePickerView;
        
        _returnGoodsDateTextField.inputAccessoryView = self.doneAndCancelBar;
    }
    
    return _returnGoodsDateTextField;
}
-(UITextField *)getProductDateTextField{
    
    if (_getProductDateTextField == nil) {
        
        _getProductDateTextField = [[UITextField alloc]initWithFrame:CGRectMake(135, 0, 200, 44)];
        
        _getProductDateTextField.delegate = self;
        
        _getProductDateTextField.placeholder = @"请选择日期";
        
        _getProductDateTextField.returnKeyType = UIReturnKeyDone;
        
        _getProductDateTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        _getProductDateTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        _getProductDateTextField.font = DefaultFont;
        
        _getProductDateTextField.inputView = self.getProductDatePickerView;
        
        _getProductDateTextField.inputAccessoryView = self.getProductDateDoneAndCancelBar;
    }
    
    return _getProductDateTextField;
}

- (BMKGeoCodeSearch *)bmkGeoCodeSearch
{
    if (!_bmkGeoCodeSearch) {
        _bmkGeoCodeSearch = [[BMKGeoCodeSearch alloc] init];
        _bmkGeoCodeSearch.delegate = self;
    }
    return _bmkGeoCodeSearch;
}

- (void)getProductDatePickerCancelClicked
{
    [self.getProductDateTextField resignFirstResponder];
    
}

- (void)getProductDatePickerDoneClicked
{
    NSInteger selectPickerRow = [self.getProductDatePickerView selectedRowInComponent:0];
    
    self.checkupGetProductDate = [self.getProductDateList objectAtIndex:selectPickerRow];
    
    self.getProductDateTextField.text = self.checkupGetProductDate;
    
    [self.getProductDateTextField resignFirstResponder];
    
}

- (BMKLocationService *)bmkLocationService
{
    if (_bmkLocationService == nil) {
        _bmkLocationService = [[BMKLocationService alloc] init];
        _bmkLocationService.delegate = self;
    }
    return _bmkLocationService;
}

- (UIToolbar *)getProductDateDoneAndCancelBar
{
    if (!_getProductDateDoneAndCancelBar)
    {
        _getProductDateDoneAndCancelBar = [[UIToolbar alloc] init];
        _getProductDateDoneAndCancelBar.barStyle = UIBarStyleBlack;
        _getProductDateDoneAndCancelBar.translucent = YES;
        [_getProductDateDoneAndCancelBar sizeToFit];
        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                  target:nil
                                                                                  action:nil];
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:L(@"Cancel")
                                                                         style:UIBarButtonItemStyleBordered
                                                                        target:self
                                                                        action:@selector(getProductDatePickerCancelClicked)];
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:L(@"Ok")
                                                                       style:UIBarButtonItemStyleBordered
                                                                      target:self
                                                                      action:@selector(getProductDatePickerDoneClicked)];
        [_getProductDateDoneAndCancelBar setItems:[NSArray arrayWithObjects:cancelButton,flexItem,doneButton, nil]];
    }
    return _getProductDateDoneAndCancelBar;
    
}

-(void)datePickerCancelClicked{
    
    [self.returnGoodsDateTextField resignFirstResponder];
    [self.reasonInputTextField resignFirstResponder];
}

-(void)datePickerDoneClicked{
    
    NSInteger selectPickerRow = [self.datePickerView selectedRowInComponent:0];
    
    self.checkupDate = [self.dateList objectAtIndex:selectPickerRow];
    
    self.returnGoodsDateTextField.text = self.checkupDate;
    
    [self.returnGoodsDateTextField resignFirstResponder];
    [self.reasonInputTextField resignFirstResponder];
}

- (UIToolbar *)doneAndCancelBar
{
    if (!_doneAndCancelBar)
    {
        _doneAndCancelBar = [[UIToolbar alloc] init];
        _doneAndCancelBar.barStyle = UIBarStyleBlack;
        _doneAndCancelBar.translucent = YES;
        [_doneAndCancelBar sizeToFit];
        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                  target:nil
                                                                                  action:nil];
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:L(@"Cancel")
                                                                         style:UIBarButtonItemStyleBordered
                                                                        target:self
                                                                        action:@selector(datePickerCancelClicked)];
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:L(@"Ok")
                                                                       style:UIBarButtonItemStyleBordered
                                                                      target:self
                                                                      action:@selector(datePickerDoneClicked)];
        [_doneAndCancelBar setItems:[NSArray arrayWithObjects:cancelButton,flexItem,doneButton, nil]];
    }
    return _doneAndCancelBar;
    
}

- (UIPickerView *)datePickerView
{
    if (_datePickerView == nil)
    {
        _datePickerView = [[UIPickerView alloc] init];
        
        _datePickerView.frame = CGRectMake(0, 40, 320, 240);
        
        _datePickerView.delegate = self;
        
        _datePickerView.dataSource = self;
        
        _datePickerView.showsSelectionIndicator = YES;
        
        _datePickerView.opaque = NO;
    }
    
    return _datePickerView;
}


- (UIPickerView *)getProductDatePickerView
{
    if (_getProductDatePickerView == nil)
    {
        _getProductDatePickerView = [[UIPickerView alloc] init];
        
        _getProductDatePickerView.frame = CGRectMake(0, 40, 320, 240);
        
        _getProductDatePickerView.delegate = self;
        
        _getProductDatePickerView.dataSource = self;
        
        _getProductDatePickerView.showsSelectionIndicator = YES;
        
        _getProductDatePickerView.opaque = NO;
    }
    
    return _getProductDatePickerView;
}
- (UIPickerView *)reasonPickView{
    if (!_reasonPickView) {
        
        _reasonPickView = [[UIPickerView alloc]init];
        
        _reasonPickView.frame = CGRectMake(0, 40, 320, 240);
        
        _reasonPickView.delegate =self;
        
        _reasonPickView.dataSource =self;
        
        _reasonPickView.showsSelectionIndicator = YES;
        
        _reasonPickView.opaque = NO;
    }
    return  _reasonPickView;
}

#pragma  mark  UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.reasonInputTextField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }else{
        return YES;
    }
}
#pragma  mark - UIPickerViewDelegate UIPickerViewDatasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (pickerView == self.datePickerView)
    {
        
        return [self.dateList count];
    }
    if (pickerView == self.getProductDatePickerView)
    {
        return [self.getProductDateList count];
    }
    return [self.reasonList count]/3;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (pickerView == self.datePickerView) {
        
        return [self.dateList objectAtIndex:row];
    }
    if (pickerView == self.getProductDatePickerView) {
        return [self.getProductDateList safeObjectAtIndex:row];
    }
    
    NSString *reasonName = [self.reasonList objectAtIndex:row*3+1];
    
    NSRange range = [reasonName rangeOfString:@">"];
    
    if (range.location != NSNotFound) {
        
        reasonName = [reasonName substringFromIndex:range.location+1];
    }
    
    return reasonName;
}

- (NSString*)descriptionWord
{
    NSString* str = nil;
    if ([self.prepareDto.apprType isEqualToString:@"2"])
    {
        //送至3c服务网点鉴定
        str = [NSString stringWithFormat:@"%@",@"送至我司3C服务网点确认现象;请携带全部商品以及发票送至3C服务网点,"];
        if ([self.prepareDto.apprAddress length])
        {
            str = [NSString stringWithFormat:@"%@\n地址:%@%@",str,self.prepareDto.apprAddress,@","];
        }
        if ([self.prepareDto.telnum length])
        {
            str = [NSString stringWithFormat:@"%@\n联系方式:%@%@",str,self.prepareDto.apprAddress,@","];
        }
        if (([self.prepareDto.apprAddress length] == 0)&&([self.prepareDto.telnum length] == 0))
        {
            str = [NSString stringWithFormat:@"%@%@",str,@"在故障现象确认后,将为您提供售后或退换货服务。"];
        }
        else
        {
            str = [NSString stringWithFormat:@"%@\n%@",str,@"在故障现象确认后,将为您提供售后或退换货服务。"];
        }
    }
    else if ([self.prepareDto.apprType isEqualToString:@"3"])
    {
        //厂家鉴定
        str = [NSString stringWithFormat:@"%@",@"您的商品品类如发生性能故障需要联系厂家,经厂家人员确认并出具故障现象的确认函件后,将为您提供售后或退换货服务;"];
        BOOL isAddress = NO;
        if ([self.prepareDto.apprAddress length])
        {
            str = [NSString stringWithFormat:@"%@\n地址:%@%@",str,self.prepareDto.apprAddress,@","];
        }
        else
        {
            isAddress = YES;
        }
        if ([self.prepareDto.telnum length])
        {
            if (isAddress)
            {
                str = [NSString stringWithFormat:@"%@\n%@厂家联系方式:%@",str,@"厂家地址详见说明书/保修卡。",self.prepareDto.apprAddress];
            }
            else
            {
                str = [NSString stringWithFormat:@"%@\n厂家联系方式:%@",str,self.prepareDto.apprAddress];
            }
            
        }
    }
    else if ([self.prepareDto.apprType isEqualToString:@"4"])
    {
        //我司售后上门鉴定
        str = [NSString stringWithFormat:@"%@",@"我司售后上门确认故障现象:需要您选择上门作业的日期,我司工作人员会尽快安排,经确认并出具故障现象的确认函件后,将为您提供售后或退换货服务。"];
    }
    else if ([self.prepareDto.apprType isEqualToString:@"6"])
    {
        //送至苏宁门店鉴定
        str = [NSString stringWithFormat:@"%@",@"送至苏宁门店确认故障现象(搜索您身边的苏宁)请携带全部商品以及发票送至当地苏宁门店,由门店服务专员为您确认故障后,将为您提供售后或退换货服务。"];
    }
    return str;
    
}

-(CGFloat)heightView
{
    if (0 == [[self descriptionWord] length])
    {
        return 0;
    }
    NSString *contendInfoS =  [[self descriptionWord] trim];
    
    UIFont *cellFont = [UIFont systemFontOfSize:13];
    //CGSize labelHeight = [contendInfoS sizeWithFont:cellFont];
    
    CGSize size = [contendInfoS heightWithFont:cellFont width:self.view.frame.size.width-30 linebreak:UILineBreakModeCharacterWrap];
   // NSInteger numberOfLines = ceil(mainContendSize.height/labelHeight.height);
    return size.height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.returnType isEqualToString:@"2"])
    {
        if ([self.prepareDto.apprType isEqualToString:@"5"])
        {
            return 6;
        }
        else
        {
            return 7;
        }
    }
    if ([self.prepareDto.apprType isEqualToString:@"5"])
    {
        return 4;
    }
    else
    {
        return 5;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.returnType isEqualToString:@"2"])
    {
        if (section == 0)
        {
            return 4;
        }
        else if (section == 1)
        {
            return 5;
        }
        else if ((section == 2)||(section == 3))
        {
            return 2;
        }
        else if ((section == 4)||(section == 5)||(section == 6))
        {
            return 1;
        }
    }
    else if ([self.returnType isEqualToString:@"1"])
    {
        if (section == 0)
        {
            return 4;
        }
        else if (section == 1)
        {
            return 5;
        }
        else if (section == 2)
        {
            return 2;
        }
        else if (section == 3)
        {
            return 1;
        }
        else if(section == 4)
        {
            return 1;
        }
    }
    else if ([self.returnType isEqualToString:@"0"])
    {
        if (section == 0)
        {
            return 4;
        }
        else if (section == 1)
        {
            if (![self.prepareDto.apprType isEqualToString:@"5"])
            {
                return 1;
            }
            else if ([self.prepareDto.apprType isEqualToString:@"5"])
            {
                return 3;
            }
        }
        else if (section == 2)
        {
            if ([self.prepareDto.apprType isEqualToString:@"5"])
            {
                return 1;
            }
            else if (![self.prepareDto.apprType isEqualToString:@"5"])
            {
                return 5;
            }
        }
        else if (section == 3)
        {
            return 1;
        }
        else if(section == 4)
        {
            return 1;
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.returnType isEqualToString:@"2"])
    {
        if (indexPath.section == 0)
        {
            if (indexPath.row == 1)
            {
                return 197;
            }
            else
            {
                if (indexPath.row == 3)
                {
                    if (_onlineStatus != -1)
                    {
                        return 40;
                    }
                    else if (_onlineStatus == -1 && self.isCShopProduct == NO)
                    {
                        return 40;
                    }
                    else
                    {
                        return 0;
                    }
                }
                return 40;
            }
        }
        else if (indexPath.section == 1)
        {
            if (indexPath.row == 4)
            {
                return 180;
            }
            else
            {
                return 40;
            }

        }
        else if (indexPath.section == 2)
        {
            if (indexPath.row == 1)
            {
                return 80;
            }
            else
            {
                return 40;
            }

        }
        else
        {
            return 40;
        }
        
    }
    else if ([self.returnType isEqualToString:@"1"])
    {
        if (indexPath.section == 0)
        {
            if (indexPath.row == 1)
            {
                return 197;
            }
            else
            {
                if (indexPath.row == 3)
                {
                    if (_onlineStatus != -1)
                    {
                        return 40;
                    }
                    else if (_onlineStatus == -1 && self.isCShopProduct == NO)
                    {
                        return 40;
                    }
                    else
                    {
                        return 0;
                    }
                }

                return 40;
            }
        }
        else if (indexPath.section == 1)
        {
            if (indexPath.row == 4)
            {
                return 180;
            }
            else
            {
                return 40;
            }

        }
        else
        {
            return 40;
        }
    }
    else if ([self.returnType isEqualToString:@"0"])
    {
        if (indexPath.section == 0)
        {
            if (indexPath.row == 1)
            {
                return 110;
            }
            else
            {
                if (indexPath.row == 3)
                {
                    if (_onlineStatus != -1)
                    {
                        return 40;
                    }
                    else if (_onlineStatus == -1 && self.isCShopProduct == NO)
                    {
                        return 40;
                    }
                    else
                    {
                        return 0;
                    }
                }

                return 40;
            }
        }
        else if (indexPath.section == 1)
        {
            if(![self.prepareDto.apprType isEqualToString:@"5"])
            {
                if ([self heightView])
                {
                    return  [self heightView]+30;
                }
                else
                {
                    return 0;
                }

            }
            else
            {
                if(indexPath.row == 1)
                {
                    if(self.returnGoodsAppraisal == myCompany)
                    {
                        return 40;
                    }
                    else
                    {
                        return 0;
                    }
                }
                else if(indexPath.row == 3)
                {
                    return 180;
                    
                }
                else
                {
                    return 40;
                    
                }
            }
            
        }
        else if (indexPath.section == 2)
        {
            if (indexPath.row == 4)
            {
                return 180;
            }
            else
            {
                return 40;
            }

        }
        else
        {
            return 40;
        }
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row)
        {
            case 0://订单号
            {
                static NSString *productInfoCell = @"productInfoCell";
                NProOrderListHeadCell *cell = (NProOrderListHeadCell*)[tableView dequeueReusableCellWithIdentifier:productInfoCell];
                
                if(cell == nil)
                {
                    cell = [[NProOrderListHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productInfoCell];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                }
                
                [cell refreshReturnGoodsInfoCell:self.prepareDto];
                
                return cell;
            }
                break;
            case 1://商品行
            {
               if ([self.returnType eq:@"1"] || [self.returnType eq:@"2"])
               {
                   static NSString *proInfoCellId = @"NProOrderProductInfoCellId_ReturnProduct1";
                   
                   NProOrderProductInfoCell *cell = (NProOrderProductInfoCell*)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
                   
                   if(cell == nil)
                   {
                       cell = [[NProOrderProductInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                       cell.selectionStyle = UITableViewCellSelectionStyleNone;
                       
                   }
                   self.prepareDto.productCode = self.productCode;
                   self.prepareDto.price = self.proPrice;
                   [cell setNOReasonReturnGoodsCellInfo:self.prepareDto];
                   return cell;
               }
                else
                {
                    
                    static NSString *proInfoCellId = @"NProOrderProductInfoCellId_ReturnProduct2";
                    NProOrderProductInfoCell *cell = (NProOrderProductInfoCell*)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
                    
                    if(cell == nil)
                    {
                        cell = [[NProOrderProductInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        cell.isNumber = YES;
                        
                    }
                    self.prepareDto.productCode = self.productCode;
                    self.prepareDto.price = self.proPrice;
                    [cell setReturnGoodsCellInfo:self.prepareDto];
                    return cell;

                }

            }
                break;
            case 2://支付方式
            {
                static NSString *proInfoCellId = @"NProOrderLastCell_ReturnPayType";
                
                NProOrderLastCell *cell = (NProOrderLastCell*)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
                
                if(cell == nil)
                {
                    cell = [[NProOrderLastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                }
                
                [cell setReturnGoodsInfo:[NSString stringWithFormat:@"支付方式:%@",self.prepareDto.policyDesc?self.prepareDto.policyDesc:@""]];
                
                return cell;
                
            }
                break;
            case 3://客服
            {
                static NSString *nordercontaceCellIndentifier = @"nordercontaceCellIndentifier_5";
                NOrderContactCell *cell = [tableView dequeueReusableCellWithIdentifier:nordercontaceCellIndentifier];
                if (!cell) {
                    cell = [[NOrderContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nordercontaceCellIndentifier];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.contentView.backgroundColor = [UIColor whiteColor];
                    
                    cell.userInteractionEnabled = YES;
                    cell.contentView.userInteractionEnabled = YES;
                    cell.isLineView1 = YES;
                    if (self.isCShopProduct)
                    {
                        [cell.cShopConnect addTarget:self action:@selector(contactCShop) forControlEvents:UIControlEventTouchUpInside];
                    }
                    else
                    {
                        [cell.shopConnect addTarget:self action:@selector(contactSNShop) forControlEvents:UIControlEventTouchUpInside];
                        [cell.Phone addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
                    }
                    if(IOS7_OR_LATER)
                    {
                        
                    }
                    else
                    {
                        cell.backgroundColor = [UIColor whiteColor];
                    }
                }
                
                if( _onlineStatus != -1)
                {
                    [cell setState:self.isCShopProduct status:_onlineStatus];
                    
                }
                else if (_onlineStatus == -1 && self.isCShopProduct == NO)
                {
                    [cell setPhone:self.isCShopProduct status:_onlineStatus];
                }
                else
                {
                    return [[UITableViewCell alloc] init];
                }
                return cell;

            }
                break;
            default:
                break;
        }
        
        
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            if ([self.returnType isEqualToString:@"1"]||[self.returnType isEqualToString:@"2"])
            {//退货数量
                static NSString *proInfoCellId = @"NProOrderLastCell_ReturnNumber";
                ReturnGoodsNumberViewCell *cell = (ReturnGoodsNumberViewCell *)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
                
                if (nil == cell)
                {
                    cell = [[ReturnGoodsNumberViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.contentView.backgroundColor = [UIColor whiteColor];
                    cell.delegate = self;
                }
                
                cell.btnDelete.frame = CGRectMake(55+40, 10, 44, 20);
                cell.textNumber.frame = CGRectMake(139, 10, 30,20);
                cell.btnAdd.frame = CGRectMake(169, 10, 44, 20);
                
                cell.textNumber.text = [NSString stringWithFormat:@"%@",self.numberStr];
                if ([self.prepareDto.permitRetStatus isEqualToString:@"B"])
                {
                    if (([self.numberStr integerValue] == 1)&&([self.prepareDto.permitRetNum integerValue] == 1))
                    {
                        cell.btnDelete.enabled = NO;
                        cell.btnAdd.enabled = NO;
                    }
                    else if ([self.numberStr integerValue] == 1)
                    {
                        cell.btnDelete.enabled = NO;
                        cell.btnAdd.enabled = YES;
                    } else if ([self.numberStr integerValue] == [self.prepareDto.permitRetNum integerValue])
                    {
                        cell.btnAdd.enabled = NO;
                        cell.btnDelete.enabled = YES;
                    }
                    else
                    {
                        cell.btnDelete.enabled = YES;
                        cell.btnAdd.enabled = YES;
                    }
                }
                else
                {
                    cell.btnDelete.enabled = NO;
                    cell.btnAdd.enabled = NO;
                }
                return cell;
            }
            else if(![self.prepareDto.apprType isEqualToString:@"5"]&&(![_prepareDto.apprType isEqualToString:@"6"]))
            {//厂家描述或3c描述或我司上门或苏宁门店描述
                static NSString *infoCellId = @"infoCellIdCellAt3C";
                UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:infoCellId];
                if (!cell)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infoCellId];
                    cell.contentView.backgroundColor = [UIColor colorWithRGBHex:0xfc7c26];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    [cell.contentView addSubview:self.descriptionText];
                }
                self.descriptionText.frame = CGRectMake(12, 15, self.view.frame.size.width - 30, [self heightView]);
                self.descriptionText.text = [self descriptionWord];
                return cell;
            }
            else
            {
                static NSString *proInfoCellId = @"NProOrderLastCell_Return10";
                
                NProOrderLastCell *cell = (NProOrderLastCell*)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
                
                if(cell == nil)
                {
                    cell = [[NProOrderLastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.contentView.backgroundColor = [UIColor whiteColor];
                    
                    UIImageView* _lineView = [[UIImageView alloc]init];
                    
                    _lineView.backgroundColor = [UIColor clearColor];
                    
                    _lineView.frame = CGRectMake(0, 39.5, 320, 1);
                    
                    [_lineView setImage:[UIImage streImageNamed:@"line.png"]];
                    
                    [cell.contentView addSubview:_lineView];
                }
                
                [cell setReturnGoodsInfo:[NSString stringWithFormat:@"%@: %@",L(@"MyEBuy_RefundWay"),L(@"MyEBuy_RefundToYourPayAccount")]];
                
                cell.clipsToBounds = YES;
                
                return cell;
            }
        }
        else if(indexPath.row == 1)
        {
            if ([self.returnType isEqualToString:@"1"]||[self.returnType isEqualToString:@"2"])
            {//退货发票（凭据）
                static NSString *proInfoCellId = @"NProOrderLastCell_ReturnInvoice";
                
                ReturnGoodSDetailCell *cell = (ReturnGoodSDetailCell*)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
                
                if(cell == nil)
                {
                    cell = [[ReturnGoodSDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.contentView.backgroundColor = [UIColor whiteColor];
                    
                    
                }
                
                [cell setInvoice:self.prepareDto taxType:self.taxType];
                
                return cell;
            }
            else
            {
                //只有当是我司售后人员鉴定时，才提示选择鉴定时间
                
                static NSString *proInfoCellId = @"NProOrderLastCell_Return11";
                
                NProOrderLastCell *cell = (NProOrderLastCell*)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
                
                if(cell == nil)
                {
                    cell = [[NProOrderLastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                    cell.contentView.backgroundColor = [UIColor whiteColor];
                    
                    
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    UIImageView* _lineView = [[UIImageView alloc]init];
                    
                    _lineView.backgroundColor = [UIColor clearColor];
                    
                    _lineView.frame = CGRectMake(0, 39.5, 320, 1);
                    
                    [_lineView setImage:[UIImage streImageNamed:@"line.png"]];
                    
                    [cell.contentView addSubview:_lineView];
                    
                    self.returnGoodsDateTextField.textColor = [UIColor dark_Gray_Color];
                    
                    [cell.contentView addSubview:self.returnGoodsDateTextField];
                }
                
                [cell setReturnGoodsInfo:L(@"test date")];
                
                cell.clipsToBounds = YES;
                
                return cell;
            }
        }
        else if (indexPath.row == 2)
        {//退货方式
            if ([self.returnType eq:@"1"] || [self.returnType eq:@"2"])
            {
                static NSString *proInfoCellId = @"NProOrderLastCell_ReturnType";
                
                NProOrderLastCell *cell = (NProOrderLastCell*)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
                
                if(cell == nil)
                {
                    cell = [[NProOrderLastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.contentView.backgroundColor = [UIColor whiteColor];
                    
                    UIImageView* _lineView = [[UIImageView alloc]init];
                    
                    _lineView.backgroundColor = [UIColor clearColor];
                    
                    _lineView.frame = CGRectMake(0, 39.5, 320, 1);
                    
                    [_lineView setImage:[UIImage streImageNamed:@"line.png"]];
                    
                    [cell.contentView addSubview:_lineView];
                }
                
                [cell setReturnGoodsInfo:[NSString stringWithFormat:@"%@ : %@",L(@"MyEBuy_RefundWay"),L(@"MyEBuy_RefundToYourPayAccount")]];
                
                cell.clipsToBounds = YES;
                
                return cell;
                
            }
            else
            {
                static NSString *proInfoCellId = @"NProOrderLastCell_Return12";
                
                NProOrderLastCell *cell = (NProOrderLastCell*)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
                
                if(cell == nil)
                {
                    cell = [[NProOrderLastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                    [self.pointView addTarget:self action:@selector(arrowAction:) forControlEvents:UIControlEventTouchUpInside];
                    
                    if(self.pointView.selected == YES)
                    {
                        [self.pointView setBackgroundImage:[UIImage imageNamed:@"N_Arrow_Down.png"] forState:UIControlStateNormal];
                        
                    }
                    else
                    {
                        [self.pointView setBackgroundImage:[UIImage imageNamed:@"N_Arrow_Up.png"] forState:UIControlStateNormal];
                        
                    }
                    self.pointView.frame = CGRectMake(0, 0, 8.5, 7.5);
                    
                    cell.accessoryView = self.pointView;
                    
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    //                            [cell.contentView addSubview:self.toolBarBtton];
                    
                    cell.contentView.backgroundColor = [UIColor whiteColor];
                    
                    UIImageView* _lineView = [[UIImageView alloc]init];
                    
                    _lineView.backgroundColor = [UIColor clearColor];
                    
                    _lineView.frame = CGRectMake(0, 39.5, 320, 1);
                    
                    [_lineView setImage:[UIImage streImageNamed:@"line.png"]];
                    
                    [cell.contentView addSubview:_lineView];
                }
                for (UIView *btn in cell.contentView.subviews)
                {
                    if ([btn isKindOfClass:[ToolBarButton class]]) {
                        [btn removeFromSuperview];
                    }
                }
                
                [cell.contentView addSubview:self.toolBarBtton];
                
                [cell setReturnGoodsInfo:L(@"return  goods reason")];
                
                cell.clipsToBounds = YES;
                
                return cell;
            }
        }
        else if (indexPath.row == 3)
        {//退货原因
            if ([self.returnType eq:@"1"] || [self.returnType eq:@"2"])
            {
                static NSString *proInfoCellId = @"NProOrderLastCell_ReturnReason";
                
                NProOrderLastCell *cell = (NProOrderLastCell*)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
                
                if(cell == nil)
                {
                    cell = [[NProOrderLastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                    [self.pointView addTarget:self action:@selector(arrowAction:) forControlEvents:UIControlEventTouchUpInside];
                    
                    if(self.pointView.selected == YES)
                    {
                        [self.pointView setBackgroundImage:[UIImage imageNamed:@"N_Arrow_Down.png"] forState:UIControlStateNormal];
                        
                    }
                    else
                    {
                        [self.pointView setBackgroundImage:[UIImage imageNamed:@"N_Arrow_Up.png"] forState:UIControlStateNormal];
                        
                    }
                    self.pointView.frame = CGRectMake(0, 0, 8.5, 7.5);
                    
                    cell.accessoryView = self.pointView;
                    
                    cell.contentView.backgroundColor = [UIColor whiteColor];
                    
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    UIImageView* _lineView = [[UIImageView alloc]init];
                    
                    _lineView.backgroundColor = [UIColor clearColor];
                    
                    _lineView.frame = CGRectMake(0, 39.5, 320, 1);
                    
                    [_lineView setImage:[UIImage streImageNamed:@"line.png"]];
                    
                    [cell.contentView addSubview:_lineView];
                }
                for (UIView *btn in cell.contentView.subviews)
                {
                    if ([btn isKindOfClass:[ToolBarButton class]]) {
                        [btn removeFromSuperview];
                    }
                }
                
                [cell.contentView addSubview:self.toolBarBtton];
                
                [cell setReturnGoodsInfo:[NSString stringWithFormat:@"%@ :",L(@"MyEBuy_ReturnGoodsReason")]];
                
                cell.clipsToBounds = YES;
                
                return cell;
                
                
            }
            else
            {
                static  NSString  *returnGoodsDateCellIdentifier = @"returnGoodsDateCellIdentifier3";
                
                SNUITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:returnGoodsDateCellIdentifier];
                
                if (cell == nil)
                {
                    
                    cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:returnGoodsDateCellIdentifier];
                    
                    cell.contentView.backgroundColor = [UIColor whiteColor];
                    
                    cell.textLabel.font = [UIFont systemFontOfSize:16];
                    
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    UIView *reasonView = [[UIView alloc] init];
                    
                    reasonView.frame = CGRectMake(15, 15, 290, 150);
                    
                    reasonView.backgroundColor = [UIColor clearColor];
                    
                    reasonView.layer.borderWidth = 0.5;
                    reasonView.layer.masksToBounds = YES;
                    reasonView.layer.borderColor = [UIColor colorWithRGBHex:0xcbcaca].CGColor;
                    
                    [reasonView addSubview:self.reasonInputTextField];
                    
                    [cell.contentView addSubview:reasonView];
                }
                
                return cell;
                
            }
        }
        else if (indexPath.row == 4)
        {//退货说明
            static  NSString  *returnGoodsDateCellIdentifier = @"returnGoodsDateCellIdentifier3";
            
            SNUITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:returnGoodsDateCellIdentifier];
            
            if (cell == nil)
            {
                
                cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:returnGoodsDateCellIdentifier];
                
                cell.textLabel.font = [UIFont systemFontOfSize:16];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.contentView.backgroundColor = [UIColor whiteColor];
                
                UIView *reasonView = [[UIView alloc] init];
                
                reasonView.frame = CGRectMake(15, 15, 290, 150);
                
                reasonView.backgroundColor = [UIColor clearColor];
                
                reasonView.layer.borderWidth = 0.5;
                reasonView.layer.masksToBounds = YES;
                reasonView.layer.borderColor = [UIColor colorWithRGBHex:0xcbcaca].CGColor;
                
                [reasonView addSubview:self.reasonInputTextField];
                
                [cell.contentView addSubview:reasonView];
            }
            
            return cell;
        }
    }
    else if (indexPath.section == 2)
    {//返回方式
        if (([self.returnType eq:@"1"] || [self.returnType eq:@"2"])&&(![self.prepareDto.apprType isEqualToString:@"5"]))
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    
                    static NSString *proInfoCellId = @"NProOrderLastCell_ReturnBackType";
                    
                    ReturnGoodSDetailCell *cell = (ReturnGoodSDetailCell*)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
                    
                    if(cell == nil)
                    {
                        cell = [[ReturnGoodSDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        cell.contentView.backgroundColor = [UIColor whiteColor];
                        
                    }
                    if ([self.returnType eq:@"1"]) {
                        [cell setGoShopBackTypeContent:self.prepareDto];
                    }
                    else
                    {
                        [cell setBackTypeContent:self.prepareDto];
                        
                    }
                    
                    return cell;
                }
                    break;
                case 1:
                {
                    static NSString *proInfoCellId = @"NProOrderLastCell_ReturnTakeAddress";
                    
                    ReturnGoodSDetailCell *cell = (ReturnGoodSDetailCell*)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
                    
                    if(cell == nil)
                    {
                        cell = [[ReturnGoodSDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        cell.contentView.backgroundColor = [UIColor whiteColor];
                        
                    }
                    
                    if ([self.returnType eq:@"2"])
                    {
                        [cell setTakeAddress:self.prepareDto];
                        self.addressTextField.text = self.prepareDto.detailAddress;// self.shopAddress;
                        [cell.contentView addSubview:self.addressTextField];
                        cell.accessoryType = UITableViewCellAccessoryNone;
                        
                    }
                    else
                    {
                        [cell setGoShopTakeAddress:self.prepareDto shopAddress:self.shopAddress];
                    }
                    return cell;
                }
                    break;
                default:
                    break;
            }
            
            
        }
        else
        {
            if (indexPath.row == 0)
            {
                if ([self.returnType eq:@"1"] || [self.returnType eq:@"2"])
                {
                    //退货数量
                    static NSString *proInfoCellId = @"NProOrderLastCell_ReturnNumber";
                    ReturnGoodsNumberViewCell *cell = (ReturnGoodsNumberViewCell *)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
                    
                    if (nil == cell)
                    {
                        cell = [[ReturnGoodsNumberViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        cell.contentView.backgroundColor = [UIColor whiteColor];
                        cell.delegate = self;
                    }
                    
                    cell.btnDelete.frame = CGRectMake(55+40, 10, 44, 20);
                    cell.textNumber.frame = CGRectMake(139, 10, 30,20);
                    cell.btnAdd.frame = CGRectMake(169, 10, 44, 20);
                    
                    cell.textNumber.text = [NSString stringWithFormat:@"%@",self.numberStr];
                    if ([self.prepareDto.permitRetStatus isEqualToString:@"B"])
                    {
                        if (([self.numberStr integerValue] == 1)&&([self.prepareDto.permitRetNum integerValue] == 1))
                        {
                            cell.btnDelete.enabled = NO;
                            cell.btnAdd.enabled = NO;
                        }
                        else if ([self.numberStr integerValue] == 1)
                        {
                            cell.btnDelete.enabled = NO;
                            cell.btnAdd.enabled = YES;
                        } else if ([self.numberStr integerValue] == [self.prepareDto.permitRetNum integerValue])
                        {
                            cell.btnAdd.enabled = NO;
                            cell.btnDelete.enabled = YES;
                        }
                        else
                        {
                            cell.btnDelete.enabled = YES;
                            cell.btnAdd.enabled = YES;
                        }
                    }
                    else
                    {
                        cell.btnDelete.enabled = NO;
                        cell.btnAdd.enabled = NO;
                    }
                    return cell;
                    
                }
                else
                {
                    static NSString *proInfoCellId = @"NProOrderLastCell_Return10";
                    
                    NProOrderLastCell *cell = (NProOrderLastCell*)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
                    
                    if(cell == nil)
                    {
                        cell = [[NProOrderLastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        cell.contentView.backgroundColor = [UIColor whiteColor];
                        
                        UIImageView* _lineView = [[UIImageView alloc]init];
                        
                        _lineView.backgroundColor = [UIColor clearColor];
                        
                        _lineView.frame = CGRectMake(0, 39.5, 320, 1);
                        
                        [_lineView setImage:[UIImage streImageNamed:@"line.png"]];
                        
                        [cell.contentView addSubview:_lineView];
                    }
                    
                    [cell setReturnGoodsInfo:[NSString stringWithFormat:@"%@: %@",L(@"MyEBuy_RefundWay"),L(@"MyEBuy_RefundToYourPayAccount")]];
                    
                    cell.clipsToBounds = YES;
                    
                    return cell;
                    
                }

            }
            else if (indexPath.row == 1)
            {//发票
                if ([self.returnType eq:@"1"] || [self.returnType eq:@"2"])
                {
                    static NSString *proInfoCellId = @"NProOrderLastCell_ReturnInvoice";
                    
                    ReturnGoodSDetailCell *cell = (ReturnGoodSDetailCell*)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
                    
                    if(cell == nil)
                    {
                        cell = [[ReturnGoodSDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        cell.contentView.backgroundColor = [UIColor whiteColor];
                        
                        
                    }
                    
                    [cell setInvoice:self.prepareDto taxType:self.taxType];
                    
                    return cell;
                    
                }
                else
                {
                    //只有当是我司售后人员鉴定时，才提示选择鉴定时间
                    
                    static NSString *proInfoCellId = @"NProOrderLastCell_Return11";
                    
                    NProOrderLastCell *cell = (NProOrderLastCell*)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
                    
                    if(cell == nil)
                    {
                        cell = [[NProOrderLastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                        cell.contentView.backgroundColor = [UIColor whiteColor];
                        
                        
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        UIImageView* _lineView = [[UIImageView alloc]init];
                        
                        _lineView.backgroundColor = [UIColor clearColor];
                        
                        _lineView.frame = CGRectMake(0, 39.5, 320, 1);
                        
                        [_lineView setImage:[UIImage streImageNamed:@"line.png"]];
                        
                        [cell.contentView addSubview:_lineView];
                        
                        self.returnGoodsDateTextField.textColor = [UIColor dark_Gray_Color];
                        
                        [cell.contentView addSubview:self.returnGoodsDateTextField];
                    }
                    
                    [cell setReturnGoodsInfo:L(@"test date")];
                    
                    cell.clipsToBounds = YES;
                    
                    return cell;
                    
                }

            }
            
        }
        if (indexPath.row == 2)
        {//退货方式
            if ([self.returnType eq:@"1"] || [self.returnType eq:@"2"])
            {
                static NSString *proInfoCellId = @"NProOrderLastCell_ReturnType";
                
                NProOrderLastCell *cell = (NProOrderLastCell*)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
                
                if(cell == nil)
                {
                    cell = [[NProOrderLastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.contentView.backgroundColor = [UIColor whiteColor];
                    
                    UIImageView* _lineView = [[UIImageView alloc]init];
                    
                    _lineView.backgroundColor = [UIColor clearColor];
                    
                    _lineView.frame = CGRectMake(0, 39.5, 320, 1);
                    
                    [_lineView setImage:[UIImage streImageNamed:@"line.png"]];
                    
                    [cell.contentView addSubview:_lineView];
                }
                
                [cell setReturnGoodsInfo:[NSString stringWithFormat:@"%@ : %@",L(@"MyEBuy_RefundWay"),L(@"MyEBuy_RefundToYourPayAccount")]];
                
                cell.clipsToBounds = YES;
                
                return cell;
                
            }
            else
            {
                static NSString *proInfoCellId = @"NProOrderLastCell_Return12";
                
                NProOrderLastCell *cell = (NProOrderLastCell*)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
                
                if(cell == nil)
                {
                    cell = [[NProOrderLastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                    [self.pointView addTarget:self action:@selector(arrowAction:) forControlEvents:UIControlEventTouchUpInside];
                    
                    if(self.pointView.selected == YES)
                    {
                        [self.pointView setBackgroundImage:[UIImage imageNamed:@"N_Arrow_Down.png"] forState:UIControlStateNormal];
                        
                    }
                    else
                    {
                        [self.pointView setBackgroundImage:[UIImage imageNamed:@"N_Arrow_Up.png"] forState:UIControlStateNormal];
                        
                    }
                    self.pointView.frame = CGRectMake(0, 0, 8.5, 7.5);
                    
                    cell.accessoryView = self.pointView;
                    
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    //                            [cell.contentView addSubview:self.toolBarBtton];
                    
                    cell.contentView.backgroundColor = [UIColor whiteColor];
                    
                    UIImageView* _lineView = [[UIImageView alloc]init];
                    
                    _lineView.backgroundColor = [UIColor clearColor];
                    
                    _lineView.frame = CGRectMake(0, 39.5, 320, 1);
                    
                    [_lineView setImage:[UIImage streImageNamed:@"line.png"]];
                    
                    [cell.contentView addSubview:_lineView];
                }
                for (UIView *btn in cell.contentView.subviews)
                {
                    if ([btn isKindOfClass:[ToolBarButton class]]) {
                        [btn removeFromSuperview];
                    }
                }
                
                [cell.contentView addSubview:self.toolBarBtton];
                
                [cell setReturnGoodsInfo:L(@"return  goods reason")];
                
                cell.clipsToBounds = YES;
                
                return cell;
                
                
            }
        }
        else if (indexPath.row == 3)
        {//退款原因
            if ([self.returnType eq:@"1"] || [self.returnType eq:@"2"])
            {
                static NSString *proInfoCellId = @"NProOrderLastCell_ReturnReason";
                
                NProOrderLastCell *cell = (NProOrderLastCell*)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
                
                if(cell == nil)
                {
                    cell = [[NProOrderLastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                    [self.pointView addTarget:self action:@selector(arrowAction:) forControlEvents:UIControlEventTouchUpInside];
                    
                    if(self.pointView.selected == YES)
                    {
                        [self.pointView setBackgroundImage:[UIImage imageNamed:@"N_Arrow_Down.png"] forState:UIControlStateNormal];
                        
                    }
                    else
                    {
                        [self.pointView setBackgroundImage:[UIImage imageNamed:@"N_Arrow_Up.png"] forState:UIControlStateNormal];
                        
                    }
                    self.pointView.frame = CGRectMake(0, 0, 8.5, 7.5);
                    
                    cell.accessoryView = self.pointView;
                    
                    cell.contentView.backgroundColor = [UIColor whiteColor];
                    
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    UIImageView* _lineView = [[UIImageView alloc]init];
                    
                    _lineView.backgroundColor = [UIColor clearColor];
                    
                    _lineView.frame = CGRectMake(0, 39.5, 320, 1);
                    
                    [_lineView setImage:[UIImage streImageNamed:@"line.png"]];
                    
                    [cell.contentView addSubview:_lineView];
                }
                for (UIView *btn in cell.contentView.subviews)
                {
                    if ([btn isKindOfClass:[ToolBarButton class]]) {
                        [btn removeFromSuperview];
                    }
                }
                
                [cell.contentView addSubview:self.toolBarBtton];
                
                [cell setReturnGoodsInfo:[NSString stringWithFormat:@"%@ :",L(@"MyEBuy_ReturnGoodsReason")]];
                
                cell.clipsToBounds = YES;
                
                return cell;
                
                
            }
            else
            {
                static  NSString  *returnGoodsDateCellIdentifier = @"returnGoodsDateCellIdentifier3";
                
                SNUITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:returnGoodsDateCellIdentifier];
                
                if (cell == nil)
                {
                    
                    cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:returnGoodsDateCellIdentifier];
                    
                    cell.contentView.backgroundColor = [UIColor whiteColor];
                    
                    cell.textLabel.font = [UIFont systemFontOfSize:16];
                    
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    UIView *reasonView = [[UIView alloc] init];
                    
                    reasonView.frame = CGRectMake(15, 15, 290, 150);
                    
                    reasonView.backgroundColor = [UIColor clearColor];
                    
                    reasonView.layer.borderWidth = 0.5;
                    reasonView.layer.masksToBounds = YES;
                    reasonView.layer.borderColor = [UIColor colorWithRGBHex:0xcbcaca].CGColor;
                    
                    [reasonView addSubview:self.reasonInputTextField];
                    
                    [cell.contentView addSubview:reasonView];
                }
                
                return cell;
                
            }
            
        }
        else if (indexPath.row == 4)
        {//退货说明
            static  NSString  *returnGoodsDateCellIdentifier = @"returnGoodsDateCellIdentifier3";
            
            SNUITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:returnGoodsDateCellIdentifier];
            
            if (cell == nil)
            {
                
                cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:returnGoodsDateCellIdentifier];
                
                cell.textLabel.font = [UIFont systemFontOfSize:16];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.contentView.backgroundColor = [UIColor whiteColor];
                
                UIView *reasonView = [[UIView alloc] init];
                
                reasonView.frame = CGRectMake(15, 15, 290, 150);
                
                reasonView.backgroundColor = [UIColor clearColor];
                
                reasonView.layer.borderWidth = 0.5;
                reasonView.layer.masksToBounds = YES;
                reasonView.layer.borderColor = [UIColor colorWithRGBHex:0xcbcaca].CGColor;
                
                [reasonView addSubview:self.reasonInputTextField];
                
                [cell.contentView addSubview:reasonView];
            }
            
            
            return cell;
            
        
        }
    }
    else if (indexPath.section == 3)
    {
        if ([self.returnType eq:@"2"])
        {
            static NSString *proInfoCellId = @"NProOrderLastCell_ReturnPersonName";
            
            ReturnGoodSDetailCell *cell = (ReturnGoodSDetailCell*)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
            if (cell == nil)
            {
                cell = [[ReturnGoodSDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.contentView.backgroundColor = [UIColor whiteColor];
                
            }
            
            switch (indexPath.row)
            {
                case 0:
                {
                    //@"联系人
                    [cell setPersonName:self.prepareDto];
                    [cell.contentView addSubview:self.personTextField];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    break;
                }
                case 1:
                {
                    [cell setPersonPhoneNumber:self.prepareDto];
                    //手机
                    [cell.contentView addSubview:self.phoneTextField];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    break;
                }
                default:
                    break;
            }
            return cell;
        }
        else
        {
            if (indexPath.row == 0)
            {
                if ([_prepareDto.apprType isEqualToString:@"6"])
                {//送至苏宁门店鉴定
                    static NSString *locationInfoCellId = @"ReturnLocationViewCellId";
                    ReturnPartLocationViewCell* cell = [tableView dequeueReusableCellWithIdentifier:locationInfoCellId];
                    if (!cell)
                    {
                        cell = [[ReturnPartLocationViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:locationInfoCellId];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        cell.contentView.backgroundColor = [UIColor whiteColor];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        _locationBt = [[UIButton alloc] initWithFrame:CGRectMake(60, 5, 245, 30)];
                        _snLocationLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 245, 30)];
                        _snLocationLab.text = @"选择门店";
                        _snLocationLab.textColor = [UIColor light_Gray_Color];
                        _snLocationLab.userInteractionEnabled = YES;
                        [_locationBt addSubview:_snLocationLab];
                        //[_locationBt setTitleColor: forState:UIControlStateNormal];
                        //[self.locationBt setTitle:@"选择门店" forState:UIControlStateNormal];
                        [cell.contentView addSubview:_locationBt];
                        
                    }
                    [_locationBt addTarget:self action:@selector(clickLocation:) forControlEvents:UIControlEventTouchUpInside];
                    return cell;
                }
                else if (![_prepareDto.apprType isEqualToString:@"5"])
                {//图片鉴定
                    static NSString *picInfoCellId = @"ReturnPartPicViewCellId";
                    ReturnPartPicViewCell* cell = [tableView dequeueReusableCellWithIdentifier:picInfoCellId];
                    if (!cell)
                    {
                        cell = [[ReturnPartPicViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:picInfoCellId];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        cell.contentView.backgroundColor = [UIColor whiteColor];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        _upPicBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
                        
                        [cell.addImageView addSubview:_upPicBt];

                        int space = 5;
                        for (int i = 0;i < 3;i++)
                        {
                            UIButton* bt = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, 15, 15)];
                            bt.backgroundColor = [UIColor clearColor];
                            [bt setBackgroundImage:[UIImage imageNamed:@"btn_delete_orange"] forState:UIControlStateNormal];
                            bt.tag = 2000+i;
                            [bt addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
                            UIImageView* v = nil;
                            if (i != 0)
                            {
                                v = [[UIImageView alloc] initWithFrame:CGRectMake(90+50*i+space, 5, 30, 30)];
                            }
                            else
                            {
                                v = [[UIImageView alloc] initWithFrame:CGRectMake(90+50*i, 5, 30, 30)];
                            }
                            v.tag = 1000+i;
                            v.userInteractionEnabled = YES;
                            v.hidden = YES;
                            [cell.contentView addSubview:v];
                            [v addSubview:bt];
                        }
                    }
                    [_upPicBt addTarget:self action:@selector(clickPic:) forControlEvents:UIControlEventTouchUpInside];
                    
                    if (_picIndex >= 0)
                    {
                        for (int i = 0;i < [_picArray count];i++)
                        {
                            UIImageView* v = (UIImageView*)[cell viewWithTag:1000+i];
                            v.image = [UIImage imageWithData:nil];
                            v.hidden = YES;
                        }
                        [_picArray removeObjectAtIndex:_picIndex];
                        _picIndex = -1;
                    }
                    if ([_picArray count])
                    {
                        for (int i = 0;i < [_picArray count];i++)
                        {
                            UIImageView* v = (UIImageView*)[cell viewWithTag:1000+i];
                            v.hidden = NO;
                            ReturnGoodsPicDTO* temp = _picArray[i];
                            v.image = [UIImage imageWithData:temp.picData];
                        }
                        [cell addImage];
                    }
                    else
                    {
                        [cell deleteImage];
                    }
                    return cell;
                }
                else if ([_prepareDto.apprType isEqualToString:@"5"])
                {//无须鉴定
                    //提交
                    static NSString *btnsCellId = @"detailWayCellId_returnGoods";
                    
                    OrderDetailBtnCell *cell = (OrderDetailBtnCell*)[tableView dequeueReusableCellWithIdentifier:btnsCellId];
                    
                    if(cell == nil)
                    {
                        cell = [[OrderDetailBtnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:btnsCellId];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        
                        cell.contentView.backgroundColor = [UIColor whiteColor];
                    }
                    
                    
                    [cell setReturnBtncellInfo];
                    
                    [cell.cancelOrderBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
                    if (IsStrEmpty(self.reasonDes)) {
                        
                        cell.cancelOrderBtn.enabled = NO;
                    }
                    else if (self.returnGoodsAppraisal == myCompany  && !self.checkupDate) {
                        
                        cell.cancelOrderBtn.enabled = NO;
                        
                    }
                    else
                    {
                        cell.cancelOrderBtn.enabled = YES;
                        
                    }
                    return cell;

                }
            }
        }
    }
    else if (indexPath.section == 4)
    {
        if ([self.returnType  isEqualToString:@"2"])
        {//上门取件时间
            static NSString *proInfoCellId = @"NProOrderLastCell_ReturnTakeTime";
            
            ReturnGoodSDetailCell *cell = (ReturnGoodSDetailCell*)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
            
            if(cell == nil)
            {
                cell = [[ReturnGoodSDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.contentView.backgroundColor = [UIColor whiteColor];
                
            }
            [cell setTakeTime:self.prepareDto];
            [cell.contentView addSubview:self.getProductDateTextField];
            return cell;
        }
        else
        {//提交
            static NSString *btnsCellId = @"detailWayCellId_returnGoods";
            
            OrderDetailBtnCell *cell = (OrderDetailBtnCell*)[tableView dequeueReusableCellWithIdentifier:btnsCellId];
            
            if(cell == nil)
            {
                cell = [[OrderDetailBtnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:btnsCellId];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.contentView.backgroundColor = [UIColor whiteColor];
            }
            
            
            [cell setReturnBtncellInfo];
            
            [cell.cancelOrderBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
            if (IsStrEmpty(self.reasonDes)) {
                
                cell.cancelOrderBtn.enabled = NO;
            }
            else if (self.returnGoodsAppraisal == myCompany  && !self.checkupDate) {
                
                cell.cancelOrderBtn.enabled = NO;
                
            }
            else
            {
                cell.cancelOrderBtn.enabled = YES;
                
            }
            
            return cell;

        }
    }
    else if (indexPath.section == 5)
    {
        if (![_prepareDto.apprType isEqualToString:@"6"]&&(![_prepareDto.apprType isEqualToString:@"5"]))
        {//图片鉴定
            static NSString *picInfoCellId = @"ReturnPartPicViewCellId";
            ReturnPartPicViewCell* cell = [tableView dequeueReusableCellWithIdentifier:picInfoCellId];
            if (!cell)
            {
                cell = [[ReturnPartPicViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:picInfoCellId];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.contentView.backgroundColor = [UIColor whiteColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                _upPicBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
                
                [cell.addImageView addSubview:_upPicBt];
                int space = 5;
                for (int i = 0;i < 3;i++)
                {
                    UIButton* bt = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, 15, 15)];
                    bt.backgroundColor = [UIColor clearColor];
                    [bt setBackgroundImage:[UIImage imageNamed:@"btn_delete_orange"] forState:UIControlStateNormal];
                    bt.tag = 2000+i;
                    [bt addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
                    UIImageView* v = nil;
                    if (i != 0)
                    {
                        v = [[UIImageView alloc] initWithFrame:CGRectMake(90+50*i+space, 5, 30, 30)];
                    }
                    else
                    {
                        v = [[UIImageView alloc] initWithFrame:CGRectMake(90+50*i, 5, 30, 30)];
                    }
                    v.tag = 1000+i;
                    v.userInteractionEnabled = YES;
                    v.hidden = YES;
                    [cell.contentView addSubview:v];
                    [v addSubview:bt];
                }
            }
            [_upPicBt addTarget:self action:@selector(clickPic:) forControlEvents:UIControlEventTouchUpInside];
            
            if (_picIndex >= 0)
            {
                for (int i = 0;i < [_picArray count];i++)
                {
                    UIImageView* v = (UIImageView*)[cell viewWithTag:1000+i];
                    v.image = [UIImage imageWithData:nil];
                    v.hidden = YES;
                }
                [_picArray removeObjectAtIndex:_picIndex];
                _picIndex = -1;
            }
            if ([_picArray count])
            {
                for (int i = 0;i < [_picArray count];i++)
                {
                    UIImageView* v = (UIImageView*)[cell viewWithTag:1000+i];
                    v.hidden = NO;
                    ReturnGoodsPicDTO* temp = _picArray[i];
                    v.image = [UIImage imageWithData:temp.picData];
                }
                [cell addImage];
            }
            else
            {
                [cell deleteImage];
            }
            return cell;
        }
        else if([_prepareDto.apprType isEqualToString:@"5"])
        {
            static NSString *btnsCellId = @"detailWayCellId_returnGoods";
            
            OrderDetailBtnCell *cell = (OrderDetailBtnCell*)[tableView dequeueReusableCellWithIdentifier:btnsCellId];
            
            if(cell == nil)
            {
                cell = [[OrderDetailBtnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:btnsCellId];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.contentView.backgroundColor = [UIColor whiteColor];
            }
            
            [cell setReturnBtncellInfo];
            
            [cell.cancelOrderBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
            if (IsStrEmpty(self.reasonDes)) {
                
                cell.cancelOrderBtn.enabled = NO;
            }
            else if (self.returnGoodsAppraisal == myCompany  && !self.checkupDate)
            {
                cell.cancelOrderBtn.enabled = NO;
            }
            else
            {
                cell.cancelOrderBtn.enabled = YES;
            }
            return cell;
        }
        else if ([_prepareDto.apprType isEqualToString:@"6"])
        {//送至苏宁门店鉴定
            static NSString *locationInfoCellId = @"ReturnLocationViewCellId";
            ReturnPartLocationViewCell* cell = [tableView dequeueReusableCellWithIdentifier:locationInfoCellId];
            if (!cell)
            {
                cell = [[ReturnPartLocationViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:locationInfoCellId];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.contentView.backgroundColor = [UIColor whiteColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                _locationBt = [[UIButton alloc] initWithFrame:CGRectMake(60, 5, 245, 30)];
                _snLocationLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 245, 30)];
                _snLocationLab.text = @"选择门店";
                _snLocationLab.textColor = [UIColor light_Gray_Color];
                _snLocationLab.userInteractionEnabled = YES;
                [_locationBt addSubview:_snLocationLab];
                [cell.contentView addSubview:_locationBt];
                
            }
            [_locationBt addTarget:self action:@selector(clickLocation:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        
    }
    else if (indexPath.section == 6)
    {//提交
        static NSString *btnsCellId = @"detailWayCellId_returnGoods";
        
        OrderDetailBtnCell *cell = (OrderDetailBtnCell*)[tableView dequeueReusableCellWithIdentifier:btnsCellId];
        
        if(cell == nil)
        {
            cell = [[OrderDetailBtnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:btnsCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.contentView.backgroundColor = [UIColor whiteColor];
            
        }
        
        
        [cell setReturnBtncellInfo];
        
        [cell.cancelOrderBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        if (IsStrEmpty(self.reasonDes)) {
            
            cell.cancelOrderBtn.enabled = NO;
        }
        else if (self.returnGoodsAppraisal == myCompany  && !self.checkupDate) {
            
            cell.cancelOrderBtn.enabled = NO;
            
        }
        else
        {
            cell.cancelOrderBtn.enabled = YES;
            
        }
        
        return cell;

    }
    return [[UITableViewCell alloc] init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self.returnType isEqualToString:@"0"])
    {
        if (section == 1)
        {
            if ([self heightView] == 0)
            {
                return 0.00001;
            }
        }
    }
    return 15;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([self.returnType isEqualToString:@"0"])
    {
        if (section == 1)
        {
            if ([self heightView] == 0)
            {
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.00001)];
                view.backgroundColor = [UIColor clearColor];
                return view;
            }
        }
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 15)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.00001)];
    
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

-(void)deleteClick:(UIButton*)sender
{//删除照片
    if ([_picArray count] == 0)
    {
        NSLog(@"sender.tag:%d",sender.tag);
        return;
    }
    _upPicBt.enabled = NO;
    _picIndex = sender.tag - 2000;
    ReturnGoodsPicDTO* temp = _picArray[_picIndex];
    [self.picHttp requestPostPicture:nil orderId:self.prepareDto.orderId ownerId:temp.picId];
}

-(void)clickLocation:(UIButton*)sender
{//定位
    [self.bmkLocationService startUserLocationService];
    [self.locationBt setTitle:@"正在定位..." forState:UIControlStateNormal];
    NSLog(@"clickLocation");
}

-(void)clickPic:(UIButton*)sender
{//添加图片
    if([_picArray count] >= 3)
    {
        NSLog(@"最多三张");
        return;
    }
    UIActionSheet *selectChangeType = [[UIActionSheet alloc] initWithTitle:L(@"选择上传图片方式") delegate:self cancelButtonTitle:L(@"Cancel") destructiveButtonTitle:nil otherButtonTitles:L(@"BTTakePic"),L(@"BTPhotoAlbum"),nil];
    selectChangeType.tag = 100;
    [selectChangeType showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)callPhone
{
    if (!_callWebView) {
        _callWebView = [[UIWebView alloc] init];
    }
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"730309"], nil]];
    [_callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://4008365365"]]];
}
- (void)hideKeyboard
{
    [self.addressTextField resignFirstResponder];
	[self.personTextField resignFirstResponder];
	[self.phoneTextField resignFirstResponder];
    [self.getProductDateTextField resignFirstResponder];
}

- (BOOL) validateChineseName: (NSString *) shouhuoren {
    
    if (!shouhuoren || [shouhuoren isEmptyOrWhitespace])
    {
        return NO;
    }
    
    NSString *shouhuorenRegex = @"[\\u4e00-\\u9fa5]{2,6}";
    
    NSPredicate *shouhuorenTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", shouhuorenRegex];
    
    return [shouhuorenTest evaluateWithObject:shouhuoren];
}

- (BOOL) validateMobileNo: (NSString *) mobileNo {
    
    NSString *mobileNoRegex = @"1\\d{10}";
    NSPredicate *mobileNoTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNoRegex];
    return [mobileNoTest evaluateWithObject:mobileNo];
}

- (BOOL)isContains4byteChar:(NSString *)string
{
    __block BOOL is4Byte = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop)
     {
         if ([substring lengthOfBytesUsingEncoding:NSUTF8StringEncoding] >= 4)
         {
             is4Byte = YES;
             *stop = YES;
         }
     }];
    
    return is4Byte;
}

- (BOOL)validateAddressDetail:(NSString *)addressDetail error:(NSString **)error
{
    NSString *errorRegex = @"[`~!$%^&*+=|':;',\"\\[\\].<>/?~！￥%……&*——+|【】‘；：”“’。，、？\\\\]";
    if ([addressDetail isMatchedByRegex:errorRegex])
    {
        *error = @"详细地址不能包含非法字符!";
        return NO;
    }
    
    if ([self isContains4byteChar:addressDetail])
    {
        *error = @"详细地址不能包含表情符号!";
        return NO;
    }
    
    if ([addressDetail length] > 30) {
        *error = @"详细地址请输入30个字以内!";
        return NO;
    }
    return YES;
    
}
- (void)submit:(id)sender
{//提交
    
    [self hideKeyboard];
    
    NSString *title = nil;
    
    NSString *message= nil;
    NSString *addressDetailError = nil;
    if ((![self.prepareDto.apprType isEqualToString:@"6"])&&(![self.prepareDto.apprType isEqualToString:@"5"]))
    {
        message =L(@"Please upload a picture");
        [self presentCustomDlg:message];
        return;
    }

    if ([self.returnType eq:@"2"])
    {
        if (self.reasonDes == nil)
        {
            message = L(@"please choose return goods reason");
            [self presentCustomDlg:L(message)];
            return;
        }
        else if (self.returnGoodsAppraisal == myCompany  && !self.checkupDate)
        {
            
            message = L(@"please choose checkupDate");
            
            [self presentCustomDlg:L(message)];
            return;
            
        }
        else if((self.addressTextField.text == nil) || [self.addressTextField.text isEqualToString:@""]){
            [self presentSheet:L(@"Please input detail address") posY:50];
            return;
        }
        
        else if((self.personTextField.text == nil) || [self.personTextField.text isEqualToString:@""]){
            [self presentSheet:@"请输入联系人姓名" posY:50];
            return;
        }
        else if ([self.personTextField.text length] < 2 && [self.personTextField.text length] > 6)
        {
            [self presentSheet:@"联系人名称应为2~6个中文字符"];
            
            return;
            
        }
        //验证收货人为中文
        else if ([self validateChineseName:self.personTextField.text] == NO)
        {
            [self presentSheet: L(@"Please input chinese name")];
            
            return;
        }
        else if((self.phoneTextField.text == nil) || [self.phoneTextField.text isEqualToString:@""]){
            [self presentSheet:@"请输入联系人手机" posY:50];
            return;
        }
        else if (![self validateMobileNo:self.phoneTextField.text]) {
            [self presentSheet:L(@"please input your real number") posY:50];
            return;
        }
        else if (![self validateAddressDetail:self.addressTextField.text error:&addressDetailError])
        {
            [self presentSheet:addressDetailError posY:50];
            return;
        }
        else if (self.getProductDateTextField.text == nil || [self.getProductDateTextField.text eq:@""])
        {
            [self presentSheet:L(@"请选择上门取件日期") posY:50];
            return;
        }
        else
        {
            
            title = L(@"system-error");
            
            message = L(@"are you sure to return goods");
            
            BBAlertView *alertView = [[BBAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];
            
            alertView.tag = 10;
            
            [alertView show];
            
            TT_RELEASE_SAFELY(alertView);
        }
        
    }
    else
    {
        if (self.reasonDes == nil) {
            
            message = L(@"please choose return goods reason");
            
            [self presentCustomDlg:L(message)];
        }
        else if (self.returnGoodsAppraisal == myCompany  && !self.checkupDate) {
            
            message = L(@"please choose checkupDate");
            
            [self presentCustomDlg:L(message)];
            
        }
        else{
            
            title = L(@"system-error");
            
            message = L(@"are you sure to return goods");
            
            BBAlertView *alertView = [[BBAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];
            
            alertView.tag = 10;
            
            [alertView show];
            
            TT_RELEASE_SAFELY(alertView);
        }
        
    }
}

- (void)contactSNShop
{
    //b2c客服
    [self checkLoginWithLoginedBlock:^{
        OSChatViewController *vc = [[OSChatViewController alloc] initAsB2CReturnOrderWithOrderNo:self.prepareDto.orderId];
        AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
        [self presentModalViewController:nav animated:YES];
    } loginCancelBlock:nil];
}

- (void)arrowAction:(id)sender
{
    [self setArrowBtnImage];
    
    [self.toolBarBtton becomeFirstResponder];
}

- (void)setArrowBtnImage
{
    self.pointView.enabled = YES;
    self.pointView.selected = !self.pointView.isSelected;
    if(self.pointView.selected == YES)
    {
        [self.pointView setBackgroundImage:[UIImage imageNamed:@"N_Arrow_Down.png"] forState:UIControlStateNormal];
        self.pointView.enabled = NO;
        
    }
    else
    {
        [self.pointView setBackgroundImage:[UIImage imageNamed:@"N_Arrow_Up.png"] forState:UIControlStateNormal];
        self.pointView.enabled = YES;
    }
    
}

- (void)cancelButtonClicked:(id)sender
{
    [self setArrowBtnImage];
}

- (void)singleClickButton:(id)sender
{
    [self setArrowBtnImage];
    [self.toolBarBtton becomeFirstResponder];
}

- (void)doneButtonClicked:(id)sender{
    
    [self setArrowBtnImage];
    
    NSInteger selectPickerRow = [self.reasonPickView selectedRowInComponent:0];
    
    NSString *reasonName = [self.reasonList objectAtIndex:selectPickerRow*3+1];
    
    self.reasonDes = reasonName;
    
    NSRange range = [reasonName rangeOfString:@">"];
    
    if (range.location != NSNotFound) {
        
        reasonName = [reasonName substringFromIndex:range.location+1];
    }
    
    self.reasonId = [self.reasonList objectAtIndex:selectPickerRow*3];
    
    DLog(@"退货原因ID:%@，退货原因:%@", self.reasonId,L(@"MyEBuy_ReturnGoodsReason"),self.reasonDes);
    if ([self.distribution eq:L(@"MyEBuy_Delivery")])
    {//服务原因－无理由退换货和配送
        if ([self.reasonDes eq:L(@"MyEBuy_ServiceReason_NoReasonToReturn")])
        {
            self.returnType = @"2";
        }
        else if ([self.reasonId isEqualToString:@"1"])
        {
            self.returnType = @"2";
        }
        else if ([self.reasonId isEqualToString:@"0"])
        {
            self.returnType = @"0";
        }
    }
    else if ([self.distribution eq:L(@"MyEBuy_PickedUpInStores")])
    {//服务原因－无理由退换货和自提
        if ([self.reasonDes eq:L(@"MyEBuy_ServiceReason_NoReasonToReturn")])
        {
            self.returnType = @"1";
        }
        else if ([self.reasonId isEqualToString:@"1"])
        {
            self.returnType = @"1";
        }
        else if ([self.reasonId isEqualToString:@"0"])
        {
            self.returnType = @"0";
        }
    }
    else
    {
        self.returnType = @"0";
    }
    [self.toolBarBtton setTitle:reasonName forState:UIControlStateNormal];
    
    [self.tpTableView reloadData];
}

//UIActionSheet相册按钮响应事件
- (void)changeImageByPhoto
{
    NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] &&[mediatypes count]>0)
    {
        UIImagePickerController* picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing=YES;
        picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

//UIActionSheet相机按钮响应事件
- (void)changeImageByCamera
{
    NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&[mediatypes count]>0)
    {
        UIImagePickerController  *eImagePickerController = [[UIImagePickerController alloc] init];
        eImagePickerController.delegate=self;
        eImagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        eImagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        eImagePickerController.showsCameraControls = YES;
        eImagePickerController.navigationBarHidden = NO;
        eImagePickerController.cameraDevice=UIImagePickerControllerCameraDeviceRear;
        eImagePickerController.wantsFullScreenLayout = NO;
        [self presentViewController:eImagePickerController animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"错误信息!" message:@"当前设备不支持拍摄功能" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (actionSheet.tag) {
        case 100:{
            switch (buttonIndex) {
                case 0:
                    [self changeImageByCamera];
                    break;
                case 1:
                    [self changeImageByPhoto];
                    break;
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}
#pragma mark - AlertMessageViewDelegate

- (void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1 && alertView.tag ==10) {
        
        if (_service == nil) {
            
            _service = [[ReturnGoodsApplicationService alloc]init];
            
            _service.delegate = self;
        }
        NSString *stateName = self.prepareDto.province;
        NSString *city = self.prepareDto.city;
        NSString *districtName = self.prepareDto.area;
        if (IsNilOrNull(stateName)) {
            stateName = @"";
        }
        if (IsNilOrNull(city)) {
            city = @"";
        }
        if (IsNilOrNull(districtName)) {
            districtName = @"";
        }
        
        
        NoReasonReturnDTO *noReasonDto = [[NoReasonReturnDTO alloc] init];
        noReasonDto.realname = self.personTextField.text;
        noReasonDto.mobilePhone = self.phoneTextField.text;
        noReasonDto.retDate = self.getProductDateTextField.text;
        noReasonDto.freightLog = self.prepareDto.payFreeForReturn;
        noReasonDto.placerAddressDetail = [NSString stringWithFormat:@"%@%@%@%@",stateName,city,districtName,self.addressTextField.text];
        if (IsStrEmpty(noReasonDto.realname)) {
            noReasonDto.realname = @"";
        }
        if (IsStrEmpty(noReasonDto.mobilePhone)) {
            noReasonDto.mobilePhone = @"";
        }
        if (IsStrEmpty(noReasonDto.retDate)) {
            noReasonDto.retDate = @"";
        }
        if (IsStrEmpty(noReasonDto.freightLog)) {
            noReasonDto.freightLog = @"";
        }
        if (IsStrEmpty(noReasonDto.placerAddressDetail)) {
            noReasonDto.placerAddressDetail = @"";
        }
        
        //245
        noReasonDto.retQuantity = self.numberStr;
        if ([_picArray count])
        {
            NSMutableArray* tmpArray = [NSMutableArray new];
            for (ReturnGoodsPicDTO* t in _picArray)
            {
                [tmpArray addObject:t.picId];
            }
            noReasonDto.picId = [tmpArray componentsJoinedByString:@","];
        }
        noReasonDto.apprType = self.prepareDto.apprType;
        
        if ([self.prepareDto.apprType isEqualToString:@"2"])
        {
            noReasonDto.apprTele = self.prepareDto.telnum;
        }
        else  if ([self.prepareDto.apprType isEqualToString:@"3"])
        {
            noReasonDto.mfrsTelnum = self.prepareDto.telnum;
        }
        
        if ([self.prepareDto.apprType isEqualToString:@"6"])
        {
            noReasonDto.apprAddress = self.locationBt.currentTitle;
        }
        else
        {
            noReasonDto.apprAddress = self.prepareDto.apprAddress;
        }
        
        
        [self displayOverFlowActivityView];
        
        [_service beginSendReturnPartGoodsSubmitHttpRequest:self.prepareDto checkUpDate:self.checkupDate reasonDes:self.reasonDes reasonId:self.reasonId noReasonReturnDto:noReasonDto];
        
    }
    else if(buttonIndex == 0 && alertView.tag ==123){
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)retunGoodsSubmitRequestCompletedWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg;{
    
    [self removeOverFlowActivityView];
    
    if (isSuccess == YES) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:RETURN_GOODS_OK_MESSAGE object:nil];
        
        BBAlertView *alertView = [[BBAlertView alloc]initWithTitle:nil message:L(@"return goods success")  delegate:self cancelButtonTitle:L(@"Ok") otherButtonTitles:nil];
        
        alertView.tag = 123;
        
        [alertView show];
        
        TT_RELEASE_SAFELY(alertView);
    }else{
        [self presentCustomDlg:errorMsg];
    }
}

#pragma mark - UIPickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    /*添加代码，处理选中图像又取消的情况*/
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    if([[info objectForKey:UIImagePickerControllerMediaType] isEqual:(NSString *)kUTTypeMovie])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示信息!" message:@"系统只支持图片格式" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
         [alert show];
        return;
        
    }
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil)
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil)
    {
        data = UIImageJPEGRepresentation(image, 1);
        
    }
    else
    {
        data = UIImagePNGRepresentation(image);
    }
    self.picData = data;
    [self dismissViewControllerAnimated:YES completion:nil];
    _upPicBt.enabled = NO;
    [self.picHttp requestPostPicture:data orderId:self.prepareDto.orderId ownerId:nil];

}

- (void)delegate_httpService_result:(NSDictionary *)result
                            usrInfo:(id)userInfo
                              error:(NSError *)error
                                cmd:(E_CMDCODE)cmd
{
    _upPicBt.enabled = YES;
    if (cmd == CC_ReturnGoodsUpPic)
    {
        if (result)
        {
            if ([EncodeStringFromDic(result,@"status")isEqualToString:@"success"])
            {
                NSString *ownerId = EncodeStringFromDic(result,@"ownerId");
                if ([ownerId length])
                {
                    ReturnGoodsPicDTO* temp = [ReturnGoodsPicDTO new];
                    temp.picId = ownerId;
                    temp.picData = self.picData;
                    [self.picArray addObject:temp];
                    
                    [self.tpTableView reloadData];
                }
            }
            else
            {
                [self presentCustomDlg:L(@"Failed to upload pictures")];
            }
        }
        else
        {
            [self presentCustomDlg:L(@"Failed to upload pictures")];
        }
    }
    else if (cmd == CC_ReturnGoodsDeletePic)
    {
        if (result)
        {
            if ([EncodeStringFromDic(result,@"status")isEqualToString:@"success"])
            {
                [self.tpTableView reloadData];
            }
            else
            {
                [self presentCustomDlg:L(@"Delete picture failure")];
                _picIndex = -1;
            }
        }
        else
        {
            [self presentCustomDlg:L(@"Delete picture failure")];
        }
    }
}

-(void)valueChange:(NSUInteger)number
{
    self.numberStr = [NSString stringWithFormat:@"%d",number];
    [self.tpTableView reloadData];
}

-(void)goToStoreMentionViewController
{//门店地址
    StoreMentionViewController *storeMentionViewController =
    [[StoreMentionViewController alloc] initWithStoreInfo:nil];
    storeMentionViewController.delegate = self;
    [self.navigationController pushViewController:storeMentionViewController
                                         animated:YES];
    
    TT_RELEASE_SAFELY(storeMentionViewController);
}

#pragma mark -
#pragma mark BMKLocationServiceDelegate

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    self.userLocation = userLocation.location.coordinate;
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
    BOOL flag = [self.bmkGeoCodeSearch reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag)
    {
        DLog(@"反geo检索发送成功");
    }
    else
    {
        DLog(@"反geo检索发送失败");
    }
    
    [self.bmkLocationService stopUserLocationService];
}

/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    [self goToStoreMentionViewController];
    
}
#pragma mark -
#pragma mark BMKGeoCodeSearchDelegate

/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
    AddressInfoDTO *addressInfo = [dao getProvinceAndCityInfoLikeCityName:result.addressDetail.city];
    NSString *cityId = addressInfo.city;
    if ([cityId length])
    {
        [self.nearStoreService getNearestSuningStoreWithCityId:cityId
                                                     longitude:[NSString stringWithFormat:@"%f",self.userLocation.longitude]
                                                      latitude:[NSString stringWithFormat:@"%f",self.userLocation.latitude]];
    }
    else
    {
        [self goToStoreMentionViewController];
    }
    
}

#pragma mark -NearestSuning
- (void)getNearestSuningStore:(NearStoreService *)service isSuccess:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    if (isSuccess)
    {
        if (0 == [service.nearStore.address length])
        {
             [self.locationBt setTitle:_prepareDto.detailAddress forState:UIControlStateNormal];
            
        }
        else
        {
           [self goToStoreMentionViewController];
        }
    }
    else
    {
        [self goToStoreMentionViewController];
    }
}

- (NearStoreService *)nearStoreService
{
    if(_nearStoreService == nil)
    {
        _nearStoreService = [[NearStoreService alloc]init];
        _nearStoreService.serviceDelegate = self;
    }
    
    return _nearStoreService;
    
}
#pragma mark -Address
- (void)didSelectStoreInfo:(StoreInfoDto *)storeInfo
{
    _snLocationLab.text = [NSString stringWithFormat:@"%@",storeInfo.storeAddress];
    [self.tpTableView reloadData];
}
@end

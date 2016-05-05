//
//  ReturnGoodsSubmitViewController.m
//  SuningEBuy
//
//  Created by 漫 王 on 12-10-8.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ReturnGoodsSubmitViewController.h"

#import "ReturnStandardView.h"

#import "ReturnGoodsSubmitInfoCell.h"

#import "OSGetStatusCommand.h"
#import "OSChatViewController.h"


#import "NProOrderListHeadCell.h"
#import "NProOrderProductInfoCell.h"
#import "NProOrderLastCell.h"
#import "OrderDetailBtnCell.h"
#import "PlaceholderTextView.h"
#import "RegexKitLite.h"
#define   DefaultFont            [UIFont systemFontOfSize:16.0]
#define kLeftMargin         90.0
#define kTopMargin          8.0
#define kTextFieldWidth     188.0
#define kTextFieldHeight    30.0
#define kTextFieldFontSize  15.0


@interface ReturnGoodsSubmitViewController()

@property (nonatomic, strong)UIView  *footView;

@property(nonatomic,strong)UIPickerView *reasonPickView;

@property (nonatomic ,strong)ReturnGoodsApplicationService *service;

@property (nonatomic, assign)ReturnGoodsAppraisal returnGoodsAppraisal;

@property(nonatomic,strong) NSMutableArray *dateList;

@property(nonatomic,strong) NSMutableArray *getProductDateList;

@property(nonatomic,copy  ) NSString    *checkupDate;

@property(nonatomic,copy  ) NSString    *checkupGetProductDate;


@property(nonatomic,strong) UIToolbar *doneAndCancelBar;

@property(nonatomic,strong) UIPickerView *datePickerView;

@property(nonatomic,strong) UITextField *returnGoodsDateTextField;

@property (nonatomic, strong)ReturnStandardView *standardView;

@property (nonatomic, strong)ToolBarButton *toolBarBtton;

@property(nonatomic,strong) PlaceholderTextView *reasonInputTextField;

@property (nonatomic, readonly, strong) UITextField                 *personTextField;

@property (nonatomic, readonly, strong) UITextField                 *phoneTextField;

@property(nonatomic,strong) UIToolbar *getProductDateDoneAndCancelBar;

@property(nonatomic,strong) UIPickerView *getProductDatePickerView;

@property(nonatomic,strong) UITextField *getProductDateTextField;


-(void)initAppraisalDate;

@end

@implementation ReturnGoodsSubmitViewController

@synthesize  returnGoodsListDto = _returnGoodsListDto;

@synthesize reasonList = _reasonList;

@synthesize prepareDto = _prepareDto;

@synthesize footView = _footView;

@synthesize reasonPickView = _reasonPickView;

@synthesize service = _service;

@synthesize returnGoodsAppraisal = _returnGoodsAppraisal;

@synthesize reasonDes = _reasonDes;

@synthesize reasonId = _reasonId;

@synthesize dateList = _dateList;

@synthesize checkupDate = _checkupDate;

@synthesize doneAndCancelBar = _doneAndCancelBar;

@synthesize datePickerView = _datePickerView;

@synthesize returnGoodsDateTextField = _returnGoodsDateTextField;

@synthesize standardView = _standardView;

@synthesize toolBarBtton = _toolBarBtton;

@synthesize personTextField = _personTextField;

@synthesize phoneTextField = _phoneTextField;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_returnGoodsListDto);
    
    TT_RELEASE_SAFELY(_reasonList);
    
    TT_RELEASE_SAFELY(_footView);
    
    TT_RELEASE_SAFELY(_reasonPickView);
    
    TT_RELEASE_SAFELY(_service);
    
    TT_RELEASE_SAFELY(_dateList);
    
    TT_RELEASE_SAFELY(_checkupDate);
    
    TT_RELEASE_SAFELY(_doneAndCancelBar);
    
    TT_RELEASE_SAFELY(_datePickerView);
    
    TT_RELEASE_SAFELY(_returnGoodsDateTextField);
    
    TT_RELEASE_SAFELY(_standardView);
    
    TT_RELEASE_SAFELY(_toolBarBtton);
    
    TT_RELEASE_SAFELY(_personTextField);
    
    TT_RELEASE_SAFELY(_phoneTextField);
    
    [CommandManage cancelCommandByClass:[OSGetStatusCommand class]];
}

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.title = L(@"return goods appliance");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"member_myEbuy"),self.title];

//        UIBarButtonItem  *right = [[UIBarButtonItem alloc]initWithTitle:L(@"commit") style:UIBarButtonItemStylePlain target:self action:@selector(submit:)
//        ];
//        
//        self.navigationItem.rightBarButtonItem = right;
//        
//        TT_RELEASE_SAFELY(right);
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.backgroundColor = [UIColor clearColor];
//        btn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
//        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
//        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 2.5, 0, 0)];
//        [btn setTitleColor:[UIColor colorWithRGBHex:0x444444] forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage imageNamed:@"right_item_light_btn.png"] forState:UIControlStateNormal];
//        [btn setTitle:@"确定" forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
//        btn.frame = CGRectMake(0, 6, 50, 32);
//        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
//        self.navigationItem.rightBarButtonItem = item;
//        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"commit")];
        
        isLoaded = NO;
        
        [self initAppraisalDate];
    }
    return self;
}

- (void)righBarClick
{
    [self submit:nil];
}

-(void)callAction{
    
    if (!_callWebView) {
        _callWebView = [[UIWebView alloc] init];
    }
    
    [_callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://4008365365"]]];
    
//    NSString *number = @"4008-365-365";// 此处读入电话号码
//    // NSString *num = [[NSString alloc]initWithFormat:@"tel://%@",number]; //number为号码字符串 如果使用这个方法结束电话之后会进入联系人列表
//    
//    NSString *num = [[NSString alloc]initWithFormat:@"tel://%@",number];
//    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
}

#pragma mark - Action
- (void)submit:(id)sender
{
    
    [self hideKeyboard];
    
    NSString *title = nil;
    
    NSString *message= nil;
    NSString *addressDetailError = nil;
    if ([self.returnType eq:@"2"])
    {
        if (self.reasonDes == nil)
        {
            
            message = L(@"please choose return goods reason");
            
            [self presentCustomDlg:L(message)];
        }
        else if (self.returnGoodsAppraisal == myCompany  && !self.checkupDate)
        {
            
            message = L(@"please choose checkupDate");
            
            [self presentCustomDlg:L(message)];
            
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
    
- (void)initGetProductDate
{
    if (_getProductDateList == nil) {
        
        _getProductDateList = [[NSMutableArray alloc]initWithCapacity:15];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = nil;
    
    if (self.prepareDto.minDeliverDate && ![self.prepareDto.minDeliverDate isEqualToString:@""]) {
        //如果系统返回时间不为空，使用系统时间
        date = [dateFormatter dateFromString:self.prepareDto.minDeliverDate];
        
    }else{
        //系统时间为空，使用本地时间
        date = [NSDate date];
    }
    
    NSDate *maxDeliverDate = [dateFormatter dateFromString:self.prepareDto.maxDeliverDate];
    
    NSDate *minDeliverDate = [dateFormatter dateFromString:self.prepareDto.minDeliverDate];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    unsigned int unitFlags = NSDayCalendarUnit;
    
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:minDeliverDate toDate:maxDeliverDate options:0];
    
    int days = [comps day];
    for (int i=0; i <days; i++) {
        
        date = [date dateByAddingTimeInterval:3600*24];
        
        NSString *strDate = [dateFormatter stringFromDate:date];
        
        [_getProductDateList addObject:strDate];
    }
    if (!IsArrEmpty(_getProductDateList)) {
        [_getProductDateList insertObject:[dateFormatter stringFromDate:minDeliverDate] atIndex:0];//
    }

}
-(void)initAppraisalDate{
    
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
    
    for (int i=0; i<7; i++) {
        
        date = [date dateByAddingTimeInterval:3600*24];
        
        NSString *strDate = [dateFormatter stringFromDate:date];
        
        [_dateList addObject:strDate];
    }
    
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


- (void)loadView{
    
    [super loadView];
    
    UIView *contentView = self.view;
    
    CGRect frame = contentView.frame;
    
    frame.origin.x = 0; 
    
    frame.origin.y = 0;
    
    frame.size.height = contentView.bounds.size.height - 92;
    
    
    self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    self.tpTableView.frame = [self setCommonViewFrame:self.hasNav WithTab:YES];//[self setViewFrame:self.hasNav];//frame;
    
    self.tpTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    self.groupTableView.sectionFooterHeight = 7.5;
    //    self.groupTableView.sectionHeaderHeight = 7.5;
    
    [self.view addSubview:self.tpTableView];
    self.hasSuspendButton = YES;
    
    if (![self.returnType eq:@"0"] || self.returnType == nil) {
        [self.toolBarBtton setTitle:@"无理由退换货" forState:UIControlStateNormal];
    }
    if ([self.returnType eq:@"2"]) {
        [self initGetProductDate];
    }


//    self.groupTableView.frame = [self setViewFrame:self.hasNav];//frame;
//
//    self.groupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
////    self.groupTableView.sectionFooterHeight = 7.5;
////    self.groupTableView.sectionHeaderHeight = 7.5;
//    
//    [self.view addSubview:self.groupTableView];
//    [self useBottomNavBar];
//    [self.bottomNavBar addSubview:self.bottomCell];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
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

    if (!_isGetOnlineStatusOk) {
        [self getOnlineServiceStatus];
    }
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


- (void)viewDidLoad{
    
    [super viewDidLoad];
}

- (void)viewDidUnload{
    
    [super viewDidUnload];
}
#pragma all delegate/datasource

#pragma mark - 
#pragma mark tableView delegate/datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.returnType eq:@"1"]) {
        return 5;
    }
    else if ([self.returnType eq:@"2"])
    {
        return 7;
    }
    else
    {
        return 4;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.returnType eq:@"1"])
    {
        if (section == 0) {
            return 3;
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
        else
        {
            return 1;
        }
    }
    else if ([self.returnType eq:@"2"])
    {
        if (section == 0)
        {
            return 3;
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
            return 2;
        }
        else //  5 6 7行都是1
        {
            return 1;
        }

    }
    else
    {
        if(section == 2)
        {
            return 1;
        }
        else if(section == 1)
        {
            return 4;
        }
        else if (section == 3)
        {
            return 1;
        }
        else
        {
            return 3;
        }

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.returnType eq:@"1"])
    {
        if (indexPath.section == 0)
        {
            if (indexPath.row == 1)
            {
                return 197;
            }
            else
            {
                return 40;
            }
        }
        else if (indexPath.section == 1)
        {
//            if (indexPath.row == 3)
//            {
//                if(self.returnGoodsAppraisal == myCompany)
//                {
//                    return 40;
//                }
//                else
//                {
//                    return 0;
//                }
//
//            }
            if (indexPath.row == 4) {
                return 180;
            }
            else
            {
                return 40;
            }
        }
        else if (indexPath.section ==3)
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
        else
        {
            return 40;
        }
    }
    else if ([self.returnType eq:@"2"])
    {
        if (indexPath.section == 0)
        {
            if (indexPath.row == 1)
            {
                return 197;
            }
            else
            {
                return 40;
            }
        }
        else if (indexPath.section == 1)
        {
//            if (indexPath.row == 3)
//            {
//                if(self.returnGoodsAppraisal == myCompany)
//                {
//                    return 40;
//                }
//                else
//                {
//                    return 0;
//                }
//                
//            }
            if (indexPath.row == 4) {
                return 180;
            }
            else
            {
                return 40;
            }
        }
        else if (indexPath.section == 2)
        {
            if (indexPath.row == 1) {
                return 80;
            }
            else
            {
                return 40;

            }
        }
        else if (indexPath.section == 5)
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

        else
        {
            return 40;
        }

    }
    else
    {
        if(indexPath.section == 0)
        {
            if(indexPath.row == 1)
            {
                return 110;
            }
            else if(indexPath.row == 2)
            {
                return 50;
                
            }
            
            else
            {
                return 40;
                
            }
        }
        
        else  if(indexPath.section == 1)
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
        else
        {
            return 40;
        }
        
        return 0;

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
                    if ([self.returnType eq:@"1"] || [self.returnType eq:@"2"]) {
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
                    else{
                        static NSString *proInfoCellId = @"NProOrderProductInfoCellId_ReturnProduct2";
                        
                        NProOrderProductInfoCell *cell = (NProOrderProductInfoCell*)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
                        
                        if(cell == nil)
                        {
                            cell = [[NProOrderProductInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            
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
                default:
                    break;
            }

        
    }
    
    else if (indexPath.section == 1)
    {
            switch (indexPath.row) {
                case 0://退货数量
                {
                    if ([self.returnType eq:@"1"] || [self.returnType eq:@"2"])
                    {
                        static NSString *proInfoCellId = @"NProOrderLastCell_ReturnNumber";
                        
                        ReturnGoodSDetailCell *cell = (ReturnGoodSDetailCell*)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
                        
                        if(cell == nil)
                        {
                            cell = [[ReturnGoodSDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            cell.contentView.backgroundColor = [UIColor whiteColor];
                            
                        }
                        
                        [cell setReturnNumber:self.prepareDto];
                        
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
                        
                        [cell setReturnGoodsInfo:@"退款方式: 退款至付款帐号"];
                        
                        cell.clipsToBounds = YES;
                        
                        return cell;
                    }
                    
                }
                    break;
                case 1://发票
                {
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
                    break;
                case 2://退货方式
                {
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
                        
                        [cell setReturnGoodsInfo:@"退款方式 : 退款至付款帐号"];
                        
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
                    break;
                case 3://退货原因
                {
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

                        [cell setReturnGoodsInfo:@"退货原因 :"];
                        
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
                    break;
                case 4://退货说明
                {
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
                    break;
                    
                default:
                    break;
            }

        
    }
    
    else if (indexPath.section == 2)//返回方式
    {
        if ([self.returnType eq:@"1"] || [self.returnType eq:@"2"]) {
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
            
            static NSString *nordercontaceCellIndentifier = @"nordercontaceCellIndentifier_52";
            NOrderContactCell *cell = [tableView dequeueReusableCellWithIdentifier:nordercontaceCellIndentifier];
            if (!cell) {
                cell = [[NOrderContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nordercontaceCellIndentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.contentView.backgroundColor = [UIColor whiteColor];

                cell.userInteractionEnabled = YES;
                cell.contentView.userInteractionEnabled = YES;
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
    }
    else if (indexPath.section == 3)//联系人 手机
    {
        if ([self.returnType eq:@"1"]) {
            static NSString *nordercontaceCellIndentifier = @"nordercontaceCellIndentifier_5";
            NOrderContactCell *cell = [tableView dequeueReusableCellWithIdentifier:nordercontaceCellIndentifier];
            if (!cell) {
                cell = [[NOrderContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nordercontaceCellIndentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.contentView.backgroundColor = [UIColor whiteColor];

                cell.userInteractionEnabled = YES;
                cell.contentView.userInteractionEnabled = YES;
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
        else if ([self.returnType eq:@"2"])
        {
            static NSString *proInfoCellId = @"NProOrderLastCell_ReturnPersonName";
            
            ReturnGoodSDetailCell *cell = (ReturnGoodSDetailCell*)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
            if (cell == nil)
            {
                cell = [[ReturnGoodSDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                
//                cell.backgroundColor = [UIColor cellBackViewColor];
//                cell.textLabel.font = [UIFont systemFontOfSize:15];
//                cell.textLabel.textColor = [UIColor light_Black_Color];
//                cell.textLabel.backgroundColor = [UIColor clearColor];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.contentView.backgroundColor = [UIColor whiteColor];

            }
            
            switch (indexPath.row) {
                case 0:
                {
//                    cell.textLabel.text =  @"联系人 :";//
                    [cell setPersonName:self.prepareDto];
                    [cell.contentView addSubview:self.personTextField];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    break;
                }
                case 1:
                {
                    [cell setPersonPhoneNumber:self.prepareDto];
//                    cell.textLabel.text = @"手机 :";//L(@"AddressPerson");
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
    else if (indexPath.section == 4)//上门取件时间
    {
        if ([self.returnType eq:@"1"]) {
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
        else if ([self.returnType eq:@"2"])
        {
            static NSString *proInfoCellId = @"NProOrderLastCell_ReturnTakeTime";
            
            ReturnGoodSDetailCell *cell = (ReturnGoodSDetailCell*)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
            
            if(cell == nil)
            {
                cell = [[ReturnGoodSDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.contentView.backgroundColor = [UIColor whiteColor];

            }
//                    self.returnGoodsDateTextField.inputView = self.datePickerView;
//                    self.returnGoodsDateTextField.inputAccessoryView = self.doneAndCancelBar;
            [cell setTakeTime:self.prepareDto];

            [cell.contentView addSubview:self.getProductDateTextField];
            return cell;
        }
        else
        {
            return  nil;
        }
    }
    else  if (indexPath.section == 5)//客服
    {
        static NSString *nordercontaceCellIndentifier = @"nordercontaceCellIndentifier_5";
        NOrderContactCell *cell = [tableView dequeueReusableCellWithIdentifier:nordercontaceCellIndentifier];
        if (!cell) {
            cell = [[NOrderContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nordercontaceCellIndentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor = [UIColor whiteColor];

            cell.userInteractionEnabled = YES;
            cell.contentView.userInteractionEnabled = YES;
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
    else if (indexPath.section == 6)//提交申请
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
    return 15;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 15)];
    
//    if(IOS7_OR_LATER)
//    {
////        view.backgroundColor = [UIColor uiviewBackGroundColor];
//        
//    }
//    else
//    {
        view.backgroundColor = [UIColor clearColor];
        
//    }
    
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

- (void)contactSNShop
{
    //b2c客服
    [self checkLoginWithLoginedBlock:^{
        OSChatViewController *vc = [[OSChatViewController alloc] initAsB2CReturnOrderWithOrderNo:self.prepareDto.orderId];
        AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
        [self presentModalViewController:nav animated:YES];
    } loginCancelBlock:nil];
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

- (void)callPhone
{
    if (!_callWebView) {
        _callWebView = [[UIWebView alloc] init];
    }
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"730309"], nil]];
    [_callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://4008365365"]]];
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
    return [self.reasonList count]/2;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (pickerView == self.datePickerView) {
        
        return [self.dateList objectAtIndex:row];
    }
    if (pickerView == self.getProductDatePickerView) {
        return [self.getProductDateList safeObjectAtIndex:row];
    }
    
    NSString *reasonName = [self.reasonList objectAtIndex:row*2+1];
    
    NSRange range = [reasonName rangeOfString:@">"];
    
    if (range.location != NSNotFound) {
        
        reasonName = [reasonName substringFromIndex:range.location+1];
    }
    
    return reasonName;
}

#pragma  mark - ToolBarButtonDelegate
-(UIButton *)pointView
{
    if (!_pointView) {
        _pointView = [[UIButton alloc] init];
        _pointView.frame = CGRectMake(280, 20, 18/2, 29/2);
        _pointView.selected = NO;
    }
    return _pointView;
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
    
    NSString *reasonName = [self.reasonList objectAtIndex:selectPickerRow*2+1];
    
    self.reasonDes = reasonName;
    
    NSRange range = [reasonName rangeOfString:@">"];
    
    if (range.location != NSNotFound) {
        
        reasonName = [reasonName substringFromIndex:range.location+1];
    }
    
    self.reasonId = [self.reasonList objectAtIndex:selectPickerRow*2];
    
    DLog(@"退货原因ID:%@，退货原因:%@", self.reasonId,self.reasonDes);
    if ([self.reasonDes eq:@"服务原因>无理由退换货"] &&  [self.distribution eq:@"配送"])
    {
        self.returnType = @"2";
    }
    else if ([self.reasonDes eq:@"服务原因>无理由退换货"] &&  [self.distribution eq:@"自提"])
    {
        self.returnType = @"1";
    }
    else
    {
        self.returnType = @"0";
    }

    [self.toolBarBtton setTitle:reasonName forState:UIControlStateNormal];
    
    [self.tpTableView reloadData];
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
        
        
        [self displayOverFlowActivityView];
        
        [_service beginSendReturnGoodsSubmitHttpRequest:self.prepareDto checkUpDate:self.checkupDate reasonDes:self.reasonDes reasonId:self.reasonId noReasonReturnDto:noReasonDto];
        
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

#pragma mark ----------------------------- 在线客服

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

//- (void)contactSNShop
//{
//    //b2c客服
//    [self checkLoginWithLoginedBlock:^{
//        OSChatViewController *vc = [[OSChatViewController alloc] initAsB2CReturnOrderWithOrderNo:self.prepareDto.orderId];
//        AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
//        [self presentModalViewController:nav animated:YES];
//    } loginCancelBlock:nil];
//}


#pragma mark 联系人 手机 地址格式检查
#pragma mark action

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
#pragma mark
#pragma mark property getters
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


- (UITextField *)personTextField
{
    if (_personTextField == nil)
    {
        CGRect frame = CGRectMake(kLeftMargin, 0, kTextFieldWidth, 40);
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
        _personTextField.delegate =self;
    }
    
    return _personTextField;
}

- (UITextField *)phoneTextField
{
    if (_phoneTextField == nil)
    {
        CGRect frame = CGRectMake(kLeftMargin, 0, kTextFieldWidth, 40);
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
        _phoneTextField.delegate =self;
    }
    
    return _phoneTextField;
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

- (UIView *)footView{
    
    if (!_footView) {
        
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
        
        UILabel *footLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 280, 150)];
        
        footLabel.text = L(@"help info for return goods");
        
        footLabel.numberOfLines = 0;
        
        footLabel.backgroundColor = [UIColor clearColor];
        
        footLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
        footLabel.textColor = [UIColor grayColor];
        
        [_footView addSubview:footLabel];
        
        TT_RELEASE_SAFELY(footLabel);
        
    }
    
    return  _footView;
}


- (ReturnStandardView *)standardView{
    
    if (!_standardView) {
        
        _standardView = [[ReturnStandardView alloc]initWithDTO:self.prepareDto];
        
        _standardView.backgroundColor  = [UIColor clearColor];
        
    }
    
    return _standardView;
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
        
        //        _reasonInputTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        
        _reasonInputTextField.font = DefaultFont;
        
    }
    
    return _reasonInputTextField;
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


@end

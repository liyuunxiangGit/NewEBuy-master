//
//  CShopReturnApplicationViewController.m
//  SuningEBuy
//
//  Created by 荀晓冬 on 13-12-13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CShopReturnApplicationViewController.h"
#import "OSGetStatusCommand.h"
#import "OSLeaveMessageViewController.h"

#import "NProOrderListHeadCell.h"
#import "NProOrderProductInfoCell.h"
#import "NProOrderLastCell.h"
#import "OrderDetailBtnCell.h"

#define   DefaultFont            [UIFont boldSystemFontOfSize:16.0]

@implementation CShopReturnApplicationViewController

-(void)dealloc
{
    SERVICE_RELEASE_SAFELY(_service);
    [CommandManage cancelCommandByClass:[OSGetStatusCommand class]];
}

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.title = L(@"MyEBuy_RequestToReturn");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"member_myEbuy"),self.title];
        
        //        UIBarButtonItem  *right = [[UIBarButtonItem alloc]initWithTitle:L(@"commit") style:UIBarButtonItemStylePlain target:self action:@selector(submit:)
        //        ];
        //
        //        self.navigationItem.rightBarButtonItem = right;
        //
        //        TT_RELEASE_SAFELY(right);
        
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(righBarClick)
//                                                     name:UIKeyboardWillHideNotification
//                                                   object:nil];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 2.5, 0, 0)];
        [btn setTitleColor:[UIColor colorWithRGBHex:0x444444] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"right_item_light_btn.png"] forState:UIControlStateNormal];
        [btn setTitle:L(@"MyEBuy_ReturnInstructions") forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(righBarClick) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(0, 6, 80, 32);
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.rightBarButtonItem = item;
        //self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"commit")];
        
        //isLoaded = NO;
        
        //   [self initAppraisalDate];
        
        _onlineStatus = -1; //默认开始不展示
       

        
    }
    return self;
}


//-(PlaceholderTextView *)returnGoodsContents
//{
//    if (!_returnGoodsContents) {
//        _returnGoodsContents = [[PlaceholderTextView alloc]init];
//        _returnGoodsContents.backgroundColor = [UIColor whiteColor];
//        _returnGoodsContents.font = [UIFont systemFontOfSize:16.0f];
//        _returnGoodsContents.textColor = [UIColor darkTextColor];
//        _returnGoodsContents.textAlignment = NSTextAlignmentLeft;
//        _returnGoodsContents.editable = YES;
//        _returnGoodsContents.layer.cornerRadius = 8.0f;
//        _returnGoodsContents.layer.borderColor = [UIColor colorWithRGBHex:0xcbcaca].CGColor;//k233TextBorderColor.CGColor;
//        _returnGoodsContents.layer.borderWidth = 0.5;
//        _returnGoodsContents.placeholderColor = [UIColor dark_Gray_Color];//RGBCOLOR(0x89, 0x89, 0x89);
//        _returnGoodsContents.delegate = self;
//        _returnGoodsContents.frame = CGRectMake(90, 79.5, 195.5, 142.5);
//        _returnGoodsContents.autocorrectionType = UITextAutocapitalizationTypeNone;
//        _returnGoodsContents.placeholder = @"＊请输入详细的退货说明";
//
//        if (IOS5_OR_LATER) {
//            _returnGoodsContents.spellCheckingType = UITextSpellCheckingTypeNo;
//        }
//        _returnGoodsContents.placeholder = @"请输入咨询内容";
//        // _returnGoodsContents.returnKeyType = UIReturnKeySend;
//        
//        //[self.contentView addSubview:_returnGoodsContents];
//    }
//    return _returnGoodsContents;
//    
//    
//}

-(PlaceholderTextView *)returnGoodsContents
{
    
    if (_returnGoodsContents == nil) {
        
        _returnGoodsContents = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(0.5, 0.5, 289, 149)];
        
        _returnGoodsContents.delegate = self;
        
        _returnGoodsContents.placeholder = L(@"MyEBuy_PleaseEnterTheDetailReturnInstructions");
        
        _returnGoodsContents.returnKeyType = UIReturnKeyDone;
        
        _returnGoodsContents.font = DefaultFont;
        _returnGoodsContents.autocorrectionType = UITextAutocorrectionTypeNo;

    }
    
    return _returnGoodsContents;
}

#pragma  mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.returnGoodsContents resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.returnGoodsContents resignFirstResponder];
    
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

- (void)righBarClick
{
    [self addAnimation1];
  //  [self keyboardWillShow];
    [self.returnGoodsContents resignFirstResponder];
}


#pragma mark - Action
- (void)submit:(id)sender{
    
    NSString *title = nil;
    
    NSString *message= nil;
    
    if (self.reasonId.length == 0) {
        
        message = L(@"please choose return goods reason");
        
        [self presentSheet:L(message)];
        return;
    }
    
    
    if (self.toolBarBtton.titleLabel.text.trim.length == 0)
    {
        [self presentSheet:L(@"MyEBuy_PleaseEnterReturnInstructions")];
        return;
    }
    
    if (self.toolBarBtton.titleLabel.text.length > 60)
    {
        [self presentSheet:L(@"MyEBuy_ReturnInstructionsLessThanSixtyWords")];
        return;
    }
    
    self.reasonDes = self.toolBarBtton.titleLabel.text.trim;
    
    title = L(@"system-error");
    
    message = L(@"are you sure to return goods");
    
    BBAlertView *alertView = [[BBAlertView alloc]
                              initWithTitle:title
                              message:message
                              delegate:nil
                              cancelButtonTitle:L(@"Cancel")
                              otherButtonTitles:L(@"Ok")];
    
    [alertView setConfirmBlock:^{
        
        [self displayOverFlowActivityView];
        
        [self.service CShopBeginSendReturnGoodsSubmitHttpRequest:self.prepareDto
                                                     reasonName:self.reasonName
                                                       reasonDes:self.reasonDes
                                                        reasonId:self.reasonId];
    }];
    
    [alertView show];
}

- (CShopReturnApplicationService *)service
{
    if (_service == nil) {
        
        _service = [[CShopReturnApplicationService alloc]init];
        
        _service.delegate = self;
    }
    return _service;
}

- (void)loadView{
    
    [super loadView];
    
    self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    self.tpTableView.frame = [self setCommonViewFrame:self.hasNav WithTab:YES];//[self setViewFrame:self.hasNav];//frame;
    
    self.tpTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    self.groupTableView.sectionFooterHeight = 7.5;
    //    self.groupTableView.sectionHeaderHeight = 7.5;
    
    [self.view addSubview:self.tpTableView];
    
    self.hasSuspendButton = YES;
//    self.groupTableView.frame = [self setViewFrame:self.hasNav];//frame;
//    
//    self.groupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    //    self.groupTableView.sectionFooterHeight = 7.5;
//    //    self.groupTableView.sectionHeaderHeight = 7.5;
//    
//    [self.view addSubview:self.groupTableView];
//    [self useBottomNavBar];
//    [self.bottomNavBar addSubview:self.bottomCell];
    
//    UIView *contentView = self.view;
//    
//    CGRect frame = contentView.frame;
//    
//    frame.origin.x = 0;
//    
//    frame.origin.y = 0;
//    
//    frame.size.height = contentView.bounds.size.height - 92;
//    
//    self.tpTableView.frame = frame;
    
    //团购规则
    
    if ([SystemInfo is_iPhone_5]) {
        self.tipBackView.frame = CGRectMake(0, 278, 320, 290);
        
        self.tipTitleView.frame = CGRectMake(-2, 239, 325, 40);
    }
    else
    {
        self.tipBackView.frame = CGRectMake(0, 190, 320, 290);
        
        self.tipTitleView.frame = CGRectMake(-2, 162, 325, 40);
    }
    [[AppDelegate currentAppDelegate].window addSubview:self.blackView];
    [self.blackView addSubview:self.btn];
    [self.blackView addSubview:self.tipBackView];
    [self.blackView addSubview:self.tipTitleView];
    [self.blackView bringSubviewToFront:self.btn];
    [self.blackView bringSubviewToFront:self.tipBackView];
    [self.blackView bringSubviewToFront:self.tipTitleView];

//    [self.view addSubview:self.tpTableView];
}

- (void)groupRuleClick
{
    [self addAnimation1];
  
}

//- (void)righBarClick
//{
//    [self addAnimation1];
//    //    self.blackView.hidden = NO;
//    //    self.tipTitleView.hidden = NO;
//    //    self.tipBackView.hidden = NO;
//}

- (void)addAnimation1{
    isClickingRight = TRUE;
    CGRect rect = [AppDelegate currentAppDelegate].window.bounds;
    
    [UIView animateWithDuration:0.5f animations:^{
        self.blackView.frame = CGRectMake(0, 0, 320, rect.size.height);
        
        
    } completion:^(BOOL finished) {
        isClickingRight = FALSE;
    }];
}

- (void)disAnimation1
{
    CGRect rect = [AppDelegate currentAppDelegate].window.bounds;
    [UIView animateWithDuration:0.5f animations:^{
        self.blackView.frame = CGRectMake(0, 2*(rect.size.height), 320, rect.size.height);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (UIView *)blackView
{
    if (!_blackView) {
        
        CGRect rect = [AppDelegate currentAppDelegate].window.bounds;
        
        _blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 2*(rect.size.height), 320, rect.size.height)];
        _blackView.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
        //_blackView.hidden = YES;
        
        
    }
    return _blackView;
}

-(UIButton *)btn
{
    if (!_btn) {
        _btn = [[UIButton alloc]init];
        CGRect rect = [AppDelegate currentAppDelegate].window.bounds;
        _btn.frame = CGRectMake(0, 0, 320, rect.size.height);
        _btn.backgroundColor = [UIColor clearColor];
        [_btn addTarget:self action:@selector(closeRuleTip1) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btn;
}

- (UIView *)tipBackView
{
    if (!_tipBackView) {
        _tipBackView = [[UIView alloc] init];
        _tipBackView.backgroundColor = RGBCOLOR(242, 238, 225);
        // _tipBackView.hidden = YES;
        _tipBackView.userInteractionEnabled = YES;
        
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 10, 320, 280)];
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor darkGrayColor];
        textView.font = [UIFont boldSystemFontOfSize:15.0];
        textView.delegate = self;
        textView.editable = NO;
        NSError *error;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"returnGoods" ofType:@"txt"];
        NSString *shellTitleText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        textView.text = shellTitleText;
        [_tipBackView addSubview:textView];
        TT_RELEASE_SAFELY(textView);
    }
    return _tipBackView;
}

- (UIView *)tipTitleView
{
    if (!_tipTitleView) {
        _tipTitleView = [[UIView alloc]init];
        _tipTitleView.backgroundColor = RGBCOLOR(242, 238, 225);
        _tipTitleView.frame = CGRectMake(-2, 239, 325, 40);
        // _tipTitleView.hidden = YES;
        _tipTitleView.userInteractionEnabled = YES;
        _tipTitleView.layer.shadowOffset = CGSizeMake(0, 1);
        _tipTitleView.layer.shadowColor = [UIColor grayColor].CGColor;
        _tipTitleView.layer.shadowRadius = 2;
        _tipTitleView.layer.shadowOpacity = 0.5;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, 320, 23)];
        title.backgroundColor = [UIColor clearColor];
        title.text = L(@"MyEBuy_ReturnInstructions");
        title.textAlignment = UITextAlignmentCenter;
        title.textColor = [UIColor darkGrayColor];
        title.font = [UIFont boldSystemFontOfSize:15.0];
        title.shadowColor = [UIColor whiteColor];
        title.shadowOffset = CGSizeMake(1, 1);
        [_tipTitleView addSubview:title];
        TT_RELEASE_SAFELY(title);
        
        UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(282, 0, 40, 40)];
        closeBtn.backgroundColor = [UIColor clearColor];
        [closeBtn setBackgroundImage:[UIImage imageNamed:@"qiandaoguize-guanbi.png"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeRuleTip) forControlEvents:UIControlEventTouchUpInside];
        [_tipTitleView addSubview:closeBtn];
        TT_RELEASE_SAFELY(closeBtn);
        
    }
    return _tipTitleView;
}

- (void)closeRuleTip
{
    [self disAnimation1];
    //    self.blackView.hidden = YES;
    //    self.tipTitleView.hidden = YES;
    //    self.tipBackView.hidden = YES;
}

- (void)closeRuleTip1
{
    [self disAnimation1];
    //    self.blackView.hidden = YES;
    //    self.tipTitleView.hidden = YES;
    //    self.tipBackView.hidden = YES;
}


- (void)viewDidLoad{
    
    [super viewDidLoad];
}

- (void)viewDidUnload{
    
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem =nil;
    
    if (!_getOSStatusOk)
    {
        [self getOnlineServiceStatus];
    }
}

#pragma  mark - ToolBarButtonDelegate
-(UIButton *)pointView
{
    if (!_pointView) {
        _pointView = [[UIButton alloc] init];
        _pointView.frame = CGRectMake(280, 20, 18/2, 29/2);
        [_pointView setBackgroundImage:[UIImage imageNamed:@"N_Arrow_Down.png"] forState:UIControlStateNormal];
        _pointView.backgroundColor = [UIColor clearColor];
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
    
    self.reasonName = reasonName;
    
    NSRange range = [reasonName rangeOfString:@">"];
    
    if (range.location != NSNotFound) {
        
        reasonName = [reasonName substringFromIndex:range.location+1];
    }
    
    self.reasonId = [self.reasonList objectAtIndex:selectPickerRow*2];
    
    DLog(@"退货原因ID:%@，退货原因:%@", self.reasonId,self.reasonName);
    
//    [self.resonsTextField setTitle:reasonName forState:UIControlStateNormal];
    [self.toolBarBtton setTitle:reasonName forState:UIControlStateNormal];

    [self.tpTableView reloadData];
}

#pragma mark -
//- (ToolBarButton *)toolBarBtton{
//    
//    if (!_toolBarBtton) {
//        
//        _toolBarBtton = [[ToolBarButton alloc]init];
//        _toolBarBtton.backgroundColor = [UIColor clearColor];
//        
//        _toolBarBtton.frame = CGRectMake(151.5, 0, 28.5, 25);
//        _toolBarBtton.backgroundColor = [UIColor clearColor];
//        [_toolBarBtton setBackgroundImage:[UIImage imageNamed:@"tuihuoyuanyin-xuanze-xiala.png"] forState:UIControlStateNormal];
//        _toolBarBtton.inputView =self.reasonPickView;
//        
//        _toolBarBtton.delegate = self;
//        
//        _toolBarBtton.titleLabel.font = DefaultFont;
//        
//        _toolBarBtton.titleLabel.textAlignment = UITextAlignmentRight;
//    }
//    return _toolBarBtton;
//}
- (ToolBarButton *)toolBarBtton{
    
    if (!_toolBarBtton) {
        
        _toolBarBtton = [[ToolBarButton alloc]initWithFrame:CGRectMake(90, 0, 200, 44)];
        
        _toolBarBtton.backgroundColor = [UIColor clearColor];
        
        [_toolBarBtton setTitle:L(@"please choose") forState:UIControlStateNormal];
        
        [_toolBarBtton setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateNormal];
        
        _toolBarBtton.inputView =self.reasonPickView;
        
        _toolBarBtton.delegate = self;
        
        _toolBarBtton.titleLabel.font = [UIFont systemFontOfSize:16];
        
        _toolBarBtton.titleLabel.textAlignment = UITextAlignmentRight;
        
        _toolBarBtton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _toolBarBtton;
}

-(UIView *)fisrtView
{
    if (!_fisrtView) {
        _fisrtView = [[UIView alloc]init];
        _fisrtView.backgroundColor = [UIColor clearColor];
        _fisrtView.frame = CGRectMake(0, 0, 320, 58);
        [_fisrtView addSubview:self.zhuLable];
        
    }
    return _fisrtView;
}
-(UIView *)secondView
{
    if (!_secondView) {
        _secondView = [[UIView alloc]init];
        _secondView.frame = CGRectMake(0, 0, 320, 62);
        [_secondView addSubview:self.submitReturnGoodsApplication];
        
    }
    return _secondView;
}


-(UILabel *)zhuLable
{
    if (!_zhuLable) {
        _zhuLable = [[UILabel alloc]init];
        _zhuLable.backgroundColor = [UIColor clearColor];
        _zhuLable.frame = CGRectMake(10, 0, 305, 30);
        _zhuLable.text = L(@"MyEBuy_Note:BusinessStaffWillContactYouSoon");
        _zhuLable.font = [UIFont systemFontOfSize:13.0];
        _zhuLable.textColor = [UIColor colorWithRGBHex:0x898989];
        
    }
    return _zhuLable;
}

-(UIButton *)submitReturnGoodsApplication
{
    if (!_submitReturnGoodsApplication) {
        _submitReturnGoodsApplication = [[UIButton alloc]init];
        _submitReturnGoodsApplication.frame = CGRectMake(44.5, 20, 231.5, 42);
        [_submitReturnGoodsApplication setTitle:L(@"MyEBuy_SubmitReturnApplication") forState:UIControlStateNormal];
        [_submitReturnGoodsApplication setBackgroundImage:[UIImage streImageNamed:@"wuliuchaxun-normal.png"] forState:UIControlStateNormal];
        [_submitReturnGoodsApplication addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        [_submitReturnGoodsApplication setTitleColor:RGBCOLOR(130, 82, 1) forState:UIControlStateNormal];
        _submitReturnGoodsApplication.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        
    }
    return _submitReturnGoodsApplication;
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

-(UIButton *)resonsTextField
{
    if (!_resonsTextField) {
        _resonsTextField = [UIButton buttonWithType:UIButtonTypeCustom];
        _resonsTextField.backgroundColor = [UIColor clearColor];
        [_resonsTextField setTitleColor:RGBCOLOR(0, 0, 0) forState:UIControlStateNormal];
        [_resonsTextField setBackgroundImage:[UIImage streImageNamed:@"shu ru kuang@2x.png"] forState:UIControlStateNormal];
        _resonsTextField.titleLabel.font  = [UIFont systemFontOfSize:14];
        [_resonsTextField setTitle:L(@"MyEBuy_PleaseSelect") forState:UIControlStateNormal];
        _resonsTextField.frame = CGRectMake(90, 24, 180, 25);
        _resonsTextField.titleLabel.textAlignment = UITextAlignmentLeft;
        _resonsTextField.adjustsImageWhenHighlighted = NO;
        // [_resonsTextField addSubview:self.reasonsSelect];
        //_resonsTextField.highlighted = NO;
        
    }
    return _resonsTextField;
    
    
}

#pragma  mark - UIPickerViewDelegate UIPickerViewDatasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    //    if (pickerView == self.datePickerView) {
    //
    //        return [self.dateList count];
    //    }
    return [self.reasonList count]/2;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    //    if (pickerView == self.datePickerView) {
    //
    //        return [self.dateList objectAtIndex:row];
    //    }
    
    NSString *reasonName = [self.reasonList objectAtIndex:row*2+1];
    
    NSRange range = [reasonName rangeOfString:@">"];
    
    if (range.location != NSNotFound) {
        
        reasonName = [reasonName substringFromIndex:range.location+1];
    }
    
    return reasonName;
}

#pragma mark -
#pragma mark tableView delegate/datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 2)
    {
        return 1;
    }
    else if(section == 0)
    {
        return 4;
    }
    else
    {
        return 3;
    }
//    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
//    return 2;
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
//        view.backgroundColor = [UIColor uiviewBackGroundColor];
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


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if (section == 1) {
//        return self.fisrtView;
//    }
//    return nil;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
////    if (section ==1) {
////        return self.secondView;
////    }
//    return nil;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
////    if (section == 1) {
////        return 40;
////    }
//    return 0;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    if (section == 1) {
//        return 87;
//    }
//    return 0;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
        else if(indexPath.row == 3)
        {
            return [CShopApplicationCell height:self.prepareDto status:_onlineStatus];
        }
        else
        {
            return 40;
            
        }
    }
    
    else  if(indexPath.section == 1)
    {
        if(indexPath.row == 2)
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
//    if (indexPath.section == 0) {
//        
//        return [CShopApplicationCell height:self.prepareDto status:_onlineStatus];
//    }
//    
//    return 275;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0)
    {
        switch (indexPath.row) {
            case 0:
            {
                static NSString *proInfoCellId = @"proInfoCellId_CReturn";
                
                NProOrderListHeadCell *cell = (NProOrderListHeadCell*)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
                
                if(cell == nil)
                {
                    cell = [[NProOrderListHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                }
                
                [cell refreshReturnGoodsInfoCell:self.prepareDto];
                
                return cell;
                
                
            }
                break;
                
            case 1:
            {
                static NSString *proInfoCellId = @"NProOrderProductInfoCellId_CReturn";
                
                NProOrderProductInfoCell *cell = (NProOrderProductInfoCell*)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
                
                if(cell == nil)
                {
                    cell = [[NProOrderProductInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                }
                
//                self.prepareDto.partNumber = self.productCode;
                self.prepareDto.productCode = self.productCode;
                self.prepareDto.price = self.proPrice;
                self.prepareDto.payWay = self.payWay;
                
                [cell setCShopReturnGoodsCellInfo:self.prepareDto];
                
                return cell;
                
            }
                break;
                
            case 2:
            {
                static NSString *proInfoCellId = @"NProOrderLastCell_CReturn";
                
                NProOrderLastCell *cell = (NProOrderLastCell*)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
                
                if(cell == nil)
                {
                    cell = [[NProOrderLastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                }
                
                self.prepareDto.policyDesc = self.payWay;

                [cell setReturnGoodsInfo:[NSString stringWithFormat:@"%@:%@",L(@"MyEBuy_PaymentWay"),self.prepareDto.policyDesc?self.prepareDto.policyDesc:@""]];
                
                return cell;
                
            }
                break;
                
                case 3:
            {
                static  NSString  *returnGoodsInfoIdentifier = @"returnGoodsInfoIdentifier_cshopReturn";
                
                CShopApplicationCell *cell = [tableView dequeueReusableCellWithIdentifier:returnGoodsInfoIdentifier];
                
                if (cell == nil) {
                    
                    cell = [[CShopApplicationCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:returnGoodsInfoIdentifier];
                    
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                }
                
                [cell setItem:self.prepareDto status:_onlineStatus];
                
                [cell.cShopConnect addTarget:self action:@selector(contactMe) forControlEvents:UIControlEventTouchUpInside];
               
                return cell;

            }
                break;
                
            default:
                break;
        }
    }
    
    if(indexPath.section == 1)
    {
        
        if(indexPath.row == 0)
        {
            static NSString *proInfoCellId = @"NProOrderLastCell_CReturn10";
            
            NProOrderLastCell *cell = (NProOrderLastCell*)[tableView dequeueReusableCellWithIdentifier:proInfoCellId];
            
            if(cell == nil)
            {
                cell = [[NProOrderLastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proInfoCellId];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UIImageView* _lineView = [[UIImageView alloc]init];
                
                _lineView.backgroundColor = [UIColor clearColor];
                
                _lineView.frame = CGRectMake(0, 39.5, 320, 1);
                
                [_lineView setImage:[UIImage streImageNamed:@"line.png"]];
                
                [cell.contentView addSubview:_lineView];
            }
            
            NSString *str = [NSString stringWithFormat:@"%@: %@",L(@"MyEBuy_RefundWay"),self.prepareDto.returnType?self.prepareDto.returnType:@""];
            
            [cell setReturnGoodsInfo:str];
            
            cell.clipsToBounds = YES;
            
            return cell;
            
            
        }
        else if(indexPath.row == 1)
        {
            static NSString *proInfoCellId = @"NProOrderLastCell_CReturn12";
            
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
                
                [cell.contentView addSubview:self.toolBarBtton];
//                [self.resonsTextField addSubview:self.toolBarBtton];

                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UIImageView* _lineView = [[UIImageView alloc]init];
                
                _lineView.backgroundColor = [UIColor clearColor];
                
                _lineView.frame = CGRectMake(0, 39.5, 320, 1);
                
                [_lineView setImage:[UIImage streImageNamed:@"line.png"]];
                
                [cell.contentView addSubview:_lineView];
            }
            
            [cell setReturnGoodsInfo:L(@"return  goods reason")];
            
            cell.clipsToBounds = YES;
            
            return cell;
            
        }
        else
        {
            
            static  NSString  *returnGoodsDateCellIdentifier = @"returnGoodsDateCellIdentifier3_CShopReturn";
            
            SNUITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:returnGoodsDateCellIdentifier];
            
            if (cell == nil)
            {
                
                cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:returnGoodsDateCellIdentifier];
                
                cell.textLabel.font = [UIFont systemFontOfSize:16];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                UIView *reasonView = [[UIView alloc] init];
                
                reasonView.frame = CGRectMake(15, 15, 290, 150);
                
                reasonView.backgroundColor = [UIColor clearColor];
                
                reasonView.layer.borderWidth = 0.5;
                reasonView.layer.masksToBounds = YES;
                reasonView.layer.borderColor = [UIColor colorWithRGBHex:0xcbcaca].CGColor;
                
                [reasonView addSubview:self.returnGoodsContents];
                
                [cell.contentView addSubview:reasonView];
            }
            
            
            return cell;
            
            
        }
        
    }
    
    if(indexPath.section == 2)
    {
        static NSString *btnsCellId = @"detailWayCellId_CShopreturnGoods";
        
        OrderDetailBtnCell *cell = (OrderDetailBtnCell*)[tableView dequeueReusableCellWithIdentifier:btnsCellId];
        
        if(cell == nil)
        {
            cell = [[OrderDetailBtnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:btnsCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.contentView.backgroundColor = [UIColor clearColor];
            
            cell.backgroundColor = [UIColor clearColor];
        }
        
        
        [cell setReturnBtncellInfo];
        
        [cell.cancelOrderBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        

        if (self.reasonId.length == 0) {
            
            cell.cancelOrderBtn.enabled = NO;
        }
        else if (self.toolBarBtton.titleLabel.text.trim.length == 0)
        {
            cell.cancelOrderBtn.enabled = NO;
            
        }
        else
        {
            cell.cancelOrderBtn.enabled = YES;
            
        }
        
        return cell;
    }
    
    return [[UITableViewCell alloc] init];
 /*   if (indexPath.section ==0) {
        static  NSString  *returnGoodsInfoIdentifier = @"returnGoodsInfoIdentifier_cshopReturn";
        
        CShopApplicationCell *cell = [tableView dequeueReusableCellWithIdentifier:returnGoodsInfoIdentifier];
        
        if (cell == nil) {
            
            cell = [[CShopApplicationCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:returnGoodsInfoIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            
        }
        
        [cell setItem:self.prepareDto status:_onlineStatus];
        [cell.cShopConnect addTarget:self action:@selector(contactMe) forControlEvents:UIControlEventTouchUpInside];
        UIImage *backImage = nil;
        backImage = [UIImage streImageNamed:@"yellowbackground.png"];
        
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:backImage];
        
        imageV.backgroundColor = [UIColor clearColor];
        
        cell.backgroundView = imageV;
        return cell;
        
    }
    
    static  NSString  *returnGoodsInfoIdentifier = @"returnGoodsInfoIdentifier_cshopreturn2";
    
    CShopApplicationSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:returnGoodsInfoIdentifier];
    
    if (cell == nil) {
        
        cell = [[CShopApplicationSecondCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:returnGoodsInfoIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImage *backImage = nil;
        backImage = [UIImage streImageNamed:@"yellowbackground.png"];
        
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:backImage];
        
        imageV.backgroundColor = [UIColor clearColor];
        
        cell.backgroundView = imageV;
        [cell.contentView addSubview:self.returnGoodsContents];
        [cell.contentView addSubview:self.resonsTextField];
        [self.resonsTextField addSubview:self.toolBarBtton];
        
    }
    [cell setItem:self.prepareDto];
    return cell;*/
}
#pragma mark - AlertMessageViewDelegate


- (void)CshoopRetunGoodsSubmitRequestCompletedWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    
    [self removeOverFlowActivityView];
    
    if (isSuccess == YES) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:RETURN_GOODS_OK_MESSAGE object:nil];
        
        BBAlertView *alertView = [[BBAlertView alloc]
                                  initWithTitle:nil
                                  message:L(@"return goods success")
                                  delegate:nil
                                  cancelButtonTitle:L(@"Ok")
                                  otherButtonTitles:nil];
        
        [alertView setCancelBlock:^{
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        [alertView show];
        
    }else{
        [self presentSheet:errorMsg];
    }
}




#pragma mark ----------------------------- 在线客服

- (void)getOnlineServiceStatus
{
    OSGetStatusCommand *cmd_ = [[OSGetStatusCommand alloc] initAsCShop:self.prepareDto.vendorCode ProductName:nil ProductCode:nil OrderNo:self.prepareDto.orderId];
    
    __weak CShopReturnApplicationViewController *weakSelf = self;
    [CommandManage excuteCommand:cmd_ completeBlock:^(id<Command> cmd) {
        
        CShopReturnApplicationViewController *self = weakSelf;
        OSGetStatusCommand *__cmd = (OSGetStatusCommand *)cmd;
        if (__cmd.onlineStatus >= -1)
        {
            self->_onlineStatus = __cmd.onlineStatus;
            self->_getOSStatusOk = YES;
            [self.tpTableView reloadData];
        }

    }];
}

- (void)contactMe
{
    [self checkLoginWithLoginedBlock:^{
        if (_onlineStatus == 0)
        {
            OSLeaveMessageViewController *vc = [[OSLeaveMessageViewController alloc]initWithShopCode:self.prepareDto.vendorCode ShopName:self.prepareDto.vendorCShopName ProductCode:nil ProductName:nil OrderId:self.prepareDto.orderId];
            AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
            [self presentModalViewController:nav animated:YES];
        }
        else
        {
            OSChatViewController *vc = [[OSChatViewController alloc] initAsCShop:self.prepareDto.vendorCode ProductName:nil ProductCode:nil OrderNo:self.prepareDto.orderId];
            vc.vendorName = self.prepareDto.vendorCShopName;
            AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
            [self presentModalViewController:nav animated:YES];
        }
    } loginCancelBlock:nil];
}

@end

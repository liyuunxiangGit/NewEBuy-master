//
//  GBPayViewController.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-2-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBPayViewController.h"
#import "GBPayModelViewController.h"


@interface GBPayViewController ()

@property (nonatomic, strong) keyboardNumberPadReturnTextField          *numberTextField;

@property (nonatomic, strong) keyboardNumberPadReturnTextField          *mobileTextField;

@property (nonatomic, strong) UIButton                                  *submitBtn;

- (BOOL)validateMobileNo:(NSString *)mobileNo;

@end

@implementation GBPayViewController

@synthesize numberTextField             = _numberTextField;
@synthesize mobileTextField             = _mobileTextField;
@synthesize submitBtn                   = _submitBtn;
@synthesize gbGoodsDetailDTO            = _gbGoodsDetailDTO;
@synthesize tuanGouType                 = _tuanGouType;
@synthesize gbPayService                = _gbPayService;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_gbPayService);
    TT_RELEASE_SAFELY(_gbGoodsDetailDTO);
    TT_RELEASE_SAFELY(_tuanGouType);
    TT_RELEASE_SAFELY(_submitBtn);
    TT_RELEASE_SAFELY(_mobileTextField);
    TT_RELEASE_SAFELY(_numberTextField);
    
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"commitPay");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_gourpBuy"),self.title];
        if (!_gbGoodsDetailDTO) {
            _gbGoodsDetailDTO = [[GBGoodsDetailDTO alloc] init];
        }
        
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.tpTableView.frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    
    [self.view addSubview:self.tpTableView];
    
    
    [self changeButtonState];
    
}

- (keyboardNumberPadReturnTextField *)numberTextField
{
    if (!_numberTextField)
    {
        _numberTextField = [[keyboardNumberPadReturnTextField alloc] init];
        
        _numberTextField.frame = CGRectMake(100, 5, 160, 30);
        
        _numberTextField.delegate = self;
        
        _numberTextField.doneButtonDelegate = self;
        
        _numberTextField.keyboardType = UIKeyboardTypeNumberPad;
        
        _numberTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        _numberTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        
        _numberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _numberTextField.text = @"1";
        
        _numberTextField.font =[UIFont boldSystemFontOfSize:15];
    }
    return _numberTextField;
}


- (keyboardNumberPadReturnTextField *)mobileTextField
{
    if (!_mobileTextField)
    {
        _mobileTextField = [[keyboardNumberPadReturnTextField alloc] init];
        
        _mobileTextField.frame = CGRectMake(100, 5, 200, 30);
        
        _mobileTextField.delegate = self;
        
        _mobileTextField.doneButtonDelegate = self;
        
        [_mobileTextField drawTextInRect:CGRectMake(20, 0, 140, 34)];
        
        _mobileTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        _mobileTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        
        _mobileTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _mobileTextField.placeholder = L(@"input phoneNum");
        
        _mobileTextField.text = [UserCenter defaultCenter].userInfoDTO.phoneNo?[UserCenter defaultCenter].userInfoDTO.phoneNo:@"";
        
        _mobileTextField.font =[UIFont systemFontOfSize:15];
    }
    return _mobileTextField;
}

- (UIButton *)submitBtn
{
    if (!_submitBtn)
    {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _submitBtn.frame = CGRectMake(15, 50, 290, 35);
        
//        [_submitBtn setBackgroundImage:[UIImage imageNamed:@"join_YellowButton.png"] forState:UIControlStateNormal];
        
        [_submitBtn setBackgroundImage:[UIImage imageNamed:@"button_gray_normal.png"] forState:UIControlStateNormal];

        [_submitBtn setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateNormal];
        
        [_submitBtn setBackgroundImage:[UIImage imageNamed:@"button_orange_normal.png"] forState:UIControlStateHighlighted];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        [_submitBtn setTitle:L(@"commitPay") forState:UIControlStateNormal];
        
        [_submitBtn addTarget:self action:@selector(goToSumit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

- (void)goToSumit:(id)sender
{
    //团购数量校验
    if (IsStrEmpty(self.numberTextField.text) || [self.numberTextField.text isEqualToString:@""]) {
        [self presentSheet:L(@"GB_select_number")];
        [self.numberTextField becomeFirstResponder];
        return;
    }else if (![self isAllNumber:self.numberTextField.text]
              ||[self.numberTextField.text intValue] > [self.gbGoodsDetailDTO.singleLimit intValue]
              || [self.numberTextField.text intValue] > 99)
    {
        [self presentSheet:L(@"Number wrong,please enter again")];
        [self.numberTextField becomeFirstResponder];
        return;
    }
    
    //手机号码校验
    if (IsStrEmpty(self.mobileTextField.text) || [self.mobileTextField.text isEqualToString:@""]) {
        [self presentSheet:L(@"input phoneNum")];
        [self.mobileTextField becomeFirstResponder];
        return;
    }else if (![self validateMobileNo:self.mobileTextField.text]){
        [self presentSheet:L(@"please input your real number") posY:50];
        [self.mobileTextField becomeFirstResponder];
        return;
    }
    
    [self.numberTextField resignFirstResponder];
    [self.mobileTextField resignFirstResponder];
    
    //提交订单
    [self displayOverFlowActivityView:L(@"Commit_Order...")];
    
    [self.gbPayService beginGetReferOrder:self.gbGoodsDetailDTO.snProId saleCount:self.numberTextField.text telePhone:self.mobileTextField.text  groupType:self.tuanGouType];
}

- (GBPayService *)gbPayService
{
    if (!_gbPayService) {
        _gbPayService = [[GBPayService alloc] init];
        _gbPayService.delegate = self;
    }
    return _gbPayService;
}

- (void)getReferOrderComplete:(GBPayService *)service Result:(BOOL)isSuccess orderId:(GBSubmitBackDTO *)backDto
{
    [self removeOverFlowActivityView];
    GBSubmitBackDTO *submitDto = backDto;
    if (isSuccess && [submitDto.ifSuccess isEqualToString:@"0"]) {
        GBSubmitDTO *dto = [[GBSubmitDTO alloc] init];
       // dto.gbType = self.tuanGouType;
        dto.gbType = [self.tuanGouType intValue];
        dto.orderId = submitDto.orderId;
        dto.payAmount = submitDto.orderPrice;
        dto.eppAmount = dto.payAmount;
        dto.snProId = self.gbGoodsDetailDTO.snProId;
        
        GBPayModelViewController *gbModel = [[GBPayModelViewController alloc] init];
        gbModel.gbSubmitDto = dto;
        gbModel.gbSubmitDto.snProName = self.gbGoodsDetailDTO.goodsName;
        
        [self.navigationController pushViewController:gbModel animated:YES];
    }else{
        [self presentSheet:self.gbPayService.errorMsg];
    }
}

#pragma mark -
#pragma mark tableview delegate/datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 4;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 100;
    }
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1)
    {
        UIView *foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
        foot.backgroundColor = [UIColor clearColor];
        foot.userInteractionEnabled = YES;
        [foot addSubview:self.submitBtn];
        return foot;
    }
    UIView *foot =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
    foot.backgroundColor =[UIColor clearColor];
    
    return foot;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
    view.backgroundColor =[UIColor uiviewBackGroundColor];
    
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 290, 20)];
    label.backgroundColor =[UIColor clearColor];
    label.font =[UIFont systemFontOfSize:15];
    label.textColor =[UIColor dark_Gray_Color];
    
    if(section == 0)
    {
        NSInteger canBuyNum = [self.gbGoodsDetailDTO.singleLimit integerValue];
        
        if (canBuyNum > 99) {
            
            canBuyNum = 99;
        }
        
        label.text =[NSString stringWithFormat:@"%@%d%@",L(@"GBBuyInfoPartOne"),canBuyNum,L(@"GBBuyInfoPartTwo")];
    }
    else if (section == 1)
    {
        label.text = L(@"LinkMan_Info");
    }

    [view addSubview:label];
    
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *gbPayIdentifier = @"gbPayIdentifier";
    
    GBPayTableviewCell *cell = [tableView dequeueReusableCellWithIdentifier:gbPayIdentifier];
    
    if (cell ==nil) {
        cell = [[GBPayTableviewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:gbPayIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                    [cell setTitle:L(@"LBProjectName2") detailStr:self.gbGoodsDetailDTO.goodsName];
                
                    break;
                case 1:
                    [cell setTitle:L(@"LBUnitPrice") detailStr:[NSString stringWithFormat:@"￥%0.2f",[self.gbGoodsDetailDTO.presentPrice floatValue]]];
                   
                    break;
                case 2:
                    [cell setTitle:L(@"LBAmount3") detailStr:@""];
                    
                    [cell.contentView addSubview:self.numberTextField];
                    break;
                case 3:
                    [cell setTitle:L(@"LBTotalPrice") detailStr:[NSString stringWithFormat:@"￥%0.2f",[self.gbGoodsDetailDTO.presentPrice floatValue] * [self.numberTextField.text integerValue]]];
                    
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:
            [cell setTitle:L(@"mobile phone:") detailStr:@""];

            [cell.contentView addSubview:self.mobileTextField];
            break;
        default:
            break;
    }
    return cell;
}

#pragma mark -
#pragma mark KeyboardDoneTappedDelegate

- (void)doneTapped:(id)sender
{
    [self.numberTextField resignFirstResponder];
    [self.mobileTextField resignFirstResponder];
    
    [self changeButtonState];
    
    if ([self.numberTextField isFirstResponder]) {
        [self.tpTableView reloadData];
    }
}

- (void)changeButtonState
{
    if (!IsStrEmpty(self.numberTextField.text) && !IsStrEmpty(self.mobileTextField.text) && [self isAllNumber:self.numberTextField.text] ) {
        [self.submitBtn setHighlighted:YES];
    }
    else
    {
        [self.submitBtn setHighlighted:NO];
    }
}
#pragma mark -
#pragma mark textfield delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.mobileTextField) {
        
        if (textField.text.length >=11 && range.location >= 11) {
            return NO;
        }
        if (textField.text.length + string.length - range.length > 11) {
            
            return NO;
        }
    }
    else if(textField == self.numberTextField){
        
        NSString *changedStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (![self isAllNumber:changedStr]
            || [changedStr integerValue] > [self.gbGoodsDetailDTO.singleLimit intValue]
            || [changedStr integerValue] > 99
            || [changedStr integerValue] < 0)
        {
            
            [self presentSheet:L(@"Number wrong,please enter again")];
            return NO;
        }
    }
 
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self changeButtonState];
    
    if (textField == self.numberTextField) {
        
        if ([self.numberTextField.text isEqualToString:@"0"]
            || IsStrEmpty(self.numberTextField.text)) {
            
            self.numberTextField.text = @"1";
        }
        
        //刷新总价
//        NSArray *array = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:3 inSection:0]];
//        
//        [self.tpTableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationNone];
        
        [self.tpTableView reloadData];
    }
}

- (BOOL)isAllNumber:(NSString *)checkStr{
    
    NSString *ruleNumber = @"0123456789";
    
    for (int i=0; i<[checkStr length]; i++) {
        
        BOOL isNumber = NO;
        for (int j=0; j<10; j++) {
            
            if ([ [checkStr substringWithRange:NSMakeRange(i, 1)] isEqualToString:[ruleNumber substringWithRange:NSMakeRange(j, 1)]]) {
                
                isNumber = YES;
                break;
            }
        }
        
        if (NO == isNumber) {
            
            return isNumber;
        }
    }
    
    return YES;
}

//13、14、15、18开头
- (BOOL)validateMobileNo:(NSString *)mobileNo{
    
    if (mobileNo.length<2) {
        return NO;
    }
    
    NSString *mobileNoRegex = @"1\\d{10}";
    NSPredicate *mobileNoTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNoRegex];
    BOOL islegal = YES;
    NSString *top = [mobileNo substringWithRange:NSMakeRange(1, 1)];
    if ([top isEqualToString:@"3"] || [top isEqualToString:@"4"] || [top isEqualToString:@"5"] || [top isEqualToString:@"8"]) {
        islegal = YES;
    }
    else
    {
        islegal = NO;
    }
    return [mobileNoTest evaluateWithObject:mobileNo]&&islegal;
}

@end

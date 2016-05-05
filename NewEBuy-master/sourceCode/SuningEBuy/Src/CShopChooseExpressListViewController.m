//
//  CShopChooseExpressListViewController.m
//  SuningEBuy
//
//  Created by 荀晓冬 on 13-12-22.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CShopChooseExpressListViewController.h"
#import "ExpressListFirstCell.h"
#import "ExpressSecondCell.h"

#import "OrderDetailBtnCell.h"
#import "NProOrderLastCell.h"
#import "ReturnGoodsTiaoXingMa.h"

@interface CShopChooseExpressListViewController()
{
//    UITextField *expressNumberTextView;

//    CommonTextField *expressNumberTextView;
    PlaceholderTextView *detailDescribeTextView;
}

@end

/*********************************************************************/

@implementation CShopChooseExpressListViewController

- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_service);
}

- (id)init {
    self = [super init];
    if (self) {
        
        self.title = L(@"MyEBuy_SelectExpress");
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"member_myEbuy"),self.title];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 2.5, 0, 0)];
        [btn setTitleColor:[UIColor colorWithRGBHex:0x444444] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"right_item_light_btn.png"] forState:UIControlStateNormal];
        [btn setTitle:L(@"Ok") forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(0, 6, 50, 32);
//        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        //self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:@"确定"];
//        self.navigationItem.rightBarButtonItem = item;
        // self.hotKeywordsController.expressList = self.expressList;
        //self.expressList = [Config currentConfig].payGasList;
        self.expressNameSelect = @"";
    }
    return self;
}

- (void)righBarClick
{
    [self submit:nil];
}


#pragma mark - Action

- (void)submit:(id)sender
{
//    if (self.expressDto == nil && self.expressNameTextView.text.trim.length == 0)
//    if (self.expressDto == nil && self.toolBarBtton.titleLabel.text.trim.length == 0 && ![self.toolBarBtton.titleLabel.text isEqualToString:@"请选择"])
//    if (self.toolBarBtton.titleLabel.text.trim.length == 0 && ![self.toolBarBtton.titleLabel.text isEqualToString:@"请选择"])
    if (self.expressDto == nil && self.expressNameSelect.trim.length == 0 )

    {
        [self presentSheet:L(@"MyEBuy_PleaseSelectOrFillInTheExpress")];
        return;
    }
    
    if (self.expressNumberTextView.text.trim.length == 0)
    {
        [self presentSheet:L(@"MyEBuy_PleaseFillInTheExpressNumber")];
        return;
    }
    
    [self.expressNameTextView resignFirstResponder];
    [self.expressNumberTextView resignFirstResponder];
    [detailDescribeTextView resignFirstResponder];
    
    
    CShopReturnGoodsDTO *dto = nil;
    NSString *companyName = nil;
    NSString *expressNum = self.expressNumberTextView.text.trim;
    NSString *expressDetail = detailDescribeTextView.text.trim;
    
//    if (self.expressDto && [self.expressNameTextView.text isEqualToString:self.expressDto.expressName])
    if (self.expressDto && [self.expressNameSelect isEqualToString:self.expressDto.expressName])
    {
        dto = self.expressDto;
    }
    else
    {
        companyName = self.expressNameSelect.trim;

//        companyName = self.expressNameTextView.text.trim;
    }
    
    NSString *title = L(@"system-info");
    
    NSString *message= L(@"MyEBuy_ConfirmTheDeliveryInformation");
    
    BBAlertView *alertView = [[BBAlertView alloc]
                              initWithTitle:title
                              message:message
                              delegate:nil
                              cancelButtonTitle:L(@"Cancel")
                              otherButtonTitles:L(@"Ok")];
    
    [alertView setConfirmBlock:^{
        
        [self displayOverFlowActivityView];
        
        [self.service confirmReturnGoods:dto
                            orderItemsId:self.queryDto.orderItemId
                              expressNum:expressNum
                             companyName:companyName
                           expressDetail:expressDetail];
    }];
    
    [alertView show];
}

- (ReturnGoodsQueryService *)service
{
    if (!_service) {
        _service = [[ReturnGoodsQueryService alloc]init];
        
        _service.delegate = self;
    }
    return _service;
}

- (void)returnGoodsCompletedWith:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    
    if (isSuccess == YES) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:RETURN_GOODS_OK_MESSAGE object:nil];
        
        BBAlertView *alertView = [[BBAlertView alloc]
                                  initWithTitle:nil
                                  message:L(@"MyEBuy_FillInSendBackGoodsInformationSuccess")
                                  delegate:nil
                                  cancelButtonTitle:L(@"Ok")
                                  otherButtonTitles:nil];
        
        [alertView setCancelBlock:^{
            
            NSMutableArray *vcs = [self.navigationController.viewControllers mutableCopy];
            [vcs removeLastObject]; [vcs removeLastObject];
            UIViewController *vc = [vcs lastObject];
            [self.navigationController popToViewController:vc animated:YES];
        }];
        
        [alertView show];
        
    }
    else
    {
        [self presentSheet:errorMsg];
    }
    
}


#pragma mark ----------------------------- view lifycycle

- (void)loadView{
    
    [super loadView];
    
    self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    
    UIView *contentView = self.view;
    
    CGRect frame = contentView.frame;
    
    frame.size.height = contentView.bounds.size.height -92;
    
    frame.origin.x = 0;
    
    frame.origin.y = 0;
    
    self.tpTableView.frame = [self setCommonViewFrame:self.hasNav WithTab:YES];//[self setViewFrame:self.hasNav];//frame;
    
    self.tpTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tpTableView];
//    self.groupTableView.frame = [self setCommonViewFrame:self.hasNav WithTab:YES];//[self setViewFrame:self.hasNav];//frame;
//    
//    self.groupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:self.groupTableView];
    
    self.hasSuspendButton = YES;
//    [self useBottomNavBar];
//    [self.bottomNavBar addSubview:self.bottomCell];
//    self.bottomCell.yiGouBtn.hidden = YES;
//    self.bottomCell.payBtn.hidden = NO;
//    self.bottomCell.payBtn.frame = CGRectMake(200, 10, 102, 35);
//    
//    [self.bottomCell.payBtn setTitle:@"提交申请" forState:UIControlStateNormal];
//    [self.bottomCell.payBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    
}

//扫描条形码
- (void)tiaoXingMaBtnAction
{

//    SNReaderViewController *readerViewController = [[SNReaderViewController alloc] init];
//    readerViewController.snDelegate = self;
//    readerViewController.isServicePay = YES;
//    [self presentModalViewController:readerViewController animated:YES];
    
    ReturnGoodsTiaoXingMa *vc = [[ReturnGoodsTiaoXingMa alloc] init];
    
    vc.title = L(@"MyEBuy_OrderId");
    vc.snDelegate = self;
    vc.isServicePay = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark ----------------------------- bar code reader call back

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
    
    [self.navigationController popViewControllerAnimated:YES];
    
//    [self dismissModalViewControllerAnimated: YES];
    
    self.expressNumberTextView.text = zbarString;
    
    [self.tpTableView reloadData];
}


#pragma mark - textView delegate

//点击完成按钮或者done时，失去焦点
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    [self.tpTableView reloadData];

    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }else{
        return YES;
    }
    
}
#pragma mark -
#pragma mark tableView delegate/datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(IsNilOrNull(self.queryDto))
    {
        return 0;
    }
    
    if(indexPath.section == 0)
    {
        return [NProOrderLastCell setExpressHeight:self.queryDto WithRow:indexPath.row];
    }
    

    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 3;
    }
    
    if(section == 1)
    {
        return 2;
    }
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == 0)
    {
        
        if(IsStrEmpty(self.queryDto.reMark))
        {
            return 0.00001;
        }
        else
        {
            NSString *str = [NSString stringWithFormat:@"%@:%@",L(@"MyEBuy_Remarks"),self.queryDto.reMark];

            CGSize sizeStr = [str sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(290, MAXFLOAT)];
            
            return sizeStr.height + 10;
        }
    }
    return 0.00001;
}

- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if(section == 0)
    {
        if(IsStrEmpty(self.queryDto.reMark))
        {
            return nil;
        }
        else{
            NSString *str = [NSString stringWithFormat:@"%@:%@",L(@"MyEBuy_Remarks"),self.queryDto.reMark];

            return str;
        }
    }
    
    return nil;
    
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





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section ==0)
    {
        static NSString *lastCell = @"ReturnGoods_NProOrderLastCell";
        
        NProOrderLastCell *cell = [tableView dequeueReusableCellWithIdentifier:lastCell];
        
        if(cell == nil)
        {
            cell = [[NProOrderLastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lastCell];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if(IOS7_OR_LATER)
            {
                
            }
            else
            {
                cell.contentView.backgroundColor = [UIColor whiteColor];
                cell.backgroundColor = [UIColor whiteColor];
            }
            
        }
        
        
        
        [cell setReturnGoodsExpressInfo:self.queryDto WithRow:indexPath.row];
        
        return cell;

        
    }
    else if (indexPath.section ==1) {

    static  NSString  *returnGoodsInfoIdentifier = @"returnGoodsInfoIdentifier_cshop";
    
    ExpressListFirstCell *cell = (ExpressListFirstCell*)[tableView dequeueReusableCellWithIdentifier:returnGoodsInfoIdentifier];
    
    if (cell == nil) {
        
        cell = [[ExpressListFirstCell alloc] initWithStyle:UITableViewCellSelectionStyleDefault reuseIdentifier:returnGoodsInfoIdentifier];
        if(IOS7_OR_LATER)
        {
            
        }
        else
        {
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor whiteColor];
        }

        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        UIImageView *_lineView = [[UIImageView alloc]init];
        
        _lineView.backgroundColor = [UIColor clearColor];
        
        _lineView.frame = CGRectMake(0, 39.5, 320, 0.5);
        
        [_lineView setImage:[UIImage streImageNamed:@"line.png"]];
        
        [cell.contentView addSubview:_lineView];
        
        if(indexPath.row == 0)
        {
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor whiteColor];
            
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
            
        }

        if(indexPath.row == 0)
        {
            cell.expressName.frame = CGRectMake(15, 7.5, 80, 25);
            
            self.toolBarBtton.frame = CGRectMake(85, 7.5, 190, 25);
            
            [cell.contentView addSubview:self.toolBarBtton];
            
            
        }
        else
        {

            cell.tiaoXingMaBtn.frame = CGRectMake(275, 2.5, 35, 35);
            cell.expressNumber.frame = CGRectMake(15, 0, 80, 40);
            
            self.expressNumberTextView.frame = CGRectMake(85, 0, 190, 40);
            
//            self.expressNumberTextView.returnKeyType = UIReturnKeyDefault;

//            self.expressNumberTextView = cell.expressNumberTextView;
            [cell.contentView addSubview:self.expressNumberTextView];
            [cell.tiaoXingMaBtn addTarget:self action:@selector(tiaoXingMaBtnAction) forControlEvents:UIControlEventTouchUpInside];

        }

    }
        
    return cell;
        
    }
    else
    {
        static NSString *lastCell = @"ReturnGoods_OrderDetailBtnCell";
        
        OrderDetailBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:lastCell];
        
        if(cell == nil)
        {
            cell = [[OrderDetailBtnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lastCell];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell.cancelOrderBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.backgroundColor = [UIColor clearColor];
        }
        self.applyBtn = cell.cancelOrderBtn;
        [cell setReturnBtncellInfo];
        
//        if (self.expressDto == nil && self.toolBarBtton.titleLabel.text.trim.length == 0 && ![self.toolBarBtton.titleLabel.text isEqualToString:@"请选择"])
        
        if (self.expressDto == nil && self.expressNameSelect.trim.length == 0 )
        {
            cell.cancelOrderBtn.enabled = NO;

        }
        else if (self.expressNumberTextView.text.trim.length == 0)
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
}


#pragma  mark - UIPickerViewDelegate UIPickerViewDatasource

#pragma mark -

#pragma  mark - ToolBarButtonDelegate
- (void)arrowAction:(id)sender
{
    [self setArrowBtnImage];

    [self.toolBarBtton becomeFirstResponder];
}

- (void)cancelButtonClicked:(id)sender
{
    [self setArrowBtnImage];


}

- (void)doneButtonClicked:(id)sender{
    
    [self setArrowBtnImage];

    
    NSInteger selectPickerRow = [self.expressPickView selectedRowInComponent:0];
    
    CShopReturnGoodsDTO *expressDTO = [self.expressList safeObjectAtIndex:selectPickerRow];
    
    self.expressName = expressDTO.expressName;
    
    self.expressId = expressDTO.expressId;
    
    self.expressDto = expressDTO;
    
    self.expressNameSelect = self.expressName;
//    self.expressNameTextView.text = self.expressName;
    
    [self.toolBarBtton setTitle:self.expressName forState:UIControlStateNormal];
    
    [self.tpTableView reloadData];
    
}

- (void)singleClickButton:(id)sender
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


//- (ToolBarButton *)toolBarBtton{
//    
//    if (!_toolBarBtton) {
//        
//        _toolBarBtton = [[ToolBarButton alloc]initWithFrame:CGRectMake(155, 4, 200, 44)];
//        
//        _toolBarBtton.backgroundColor = [UIColor redColor];
//        
//        [_toolBarBtton setTitle:L(@"please choose") forState:UIControlStateNormal];
//
//        //        [_toolBarBtton setTitleColor:RGBCOLOR(0, 141, 239) forState:UIControlStateNormal];
//        
//        [_toolBarBtton setTitleColor:[UIColor colorWithRGBHex:0x707070] forState:UIControlStateNormal];
//
//        _toolBarBtton.inputView =self.expressPickView;
//        
//        _toolBarBtton.delegate = self;
//        
//        _toolBarBtton.titleLabel.font = [UIFont systemFontOfSize:13];
//        
//        _toolBarBtton.titleLabel.textAlignment = UITextAlignmentLeft;
//    }
//    return _toolBarBtton;
//}

- (ToolBarButton *)toolBarBtton{
    
    if (!_toolBarBtton) {
        
        _toolBarBtton = [[ToolBarButton alloc]initWithFrame:CGRectMake(100, 0, 200, 44)];
        
        _toolBarBtton.backgroundColor = [UIColor clearColor];
        
        [_toolBarBtton setTitle:L(@"please choose") forState:UIControlStateNormal];
        
        [_toolBarBtton setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateNormal];
        
        _toolBarBtton.titleLabel.font = [UIFont systemFontOfSize:16];

        _toolBarBtton.inputView =self.expressPickView;
        
        _toolBarBtton.delegate = self;
        
        _toolBarBtton.titleLabel.frame = CGRectMake(0, 0, 190, 25);

        _toolBarBtton.titleLabel.font = [UIFont systemFontOfSize:16];
        
        _toolBarBtton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

//        [_toolBarBtton.titleLabel setTextAlignment:UITextAlignmentLeft];

        
    }
    return _toolBarBtton;
}

- (UITextField *)expressNumberTextView
{
    if (!_expressNumberTextView)
    {
        _expressNumberTextView = [[UITextField alloc]init];
//        _expressNumberTextView.placeholder = @"晒出主题";
//        _expressNumberTextView.borderStyle = UITextBorderStyleNone;
        _expressNumberTextView.textColor = [UIColor light_Black_Color];
        _expressNumberTextView.font = [UIFont systemFontOfSize:16];
        _expressNumberTextView.backgroundColor = [UIColor clearColor];
        _expressNumberTextView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _expressNumberTextView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _expressNumberTextView.autocorrectionType = UITextAutocorrectionTypeNo;
        _expressNumberTextView.keyboardType = UIKeyboardTypeDefault;
        _expressNumberTextView.returnKeyType = UIReturnKeyDone;
        _expressNumberTextView.clearButtonMode = UITextFieldViewModeWhileEditing;
        _expressNumberTextView.userInteractionEnabled = YES;
        _expressNumberTextView.delegate = self;
        
//        _expressNumberTextView.layer.borderWidth = 0.4;
//        _expressNumberTextView.layer.borderColor = RGBCOLOR(235, 235, 235).CGColor;
//        _expressNumberTextView.layer.masksToBounds = YES;
    }
    
    return _expressNumberTextView;
}

- (CommonTextField *)expressNameTextView
{
    if (!_expressNameTextView)
    {
        _expressNameTextView = [[CommonTextField alloc] init];
        _expressNameTextView.frame = CGRectMake(85, 7.5, 190, 25);
        
        //_expressNameTextView.placeholder = @"请输入快递名称";
        [_expressNameTextView setPlaceholder:L(@"MyEBuy_PleaseSelect")];
        
        
        _expressNameTextView.textColor = [UIColor dark_Gray_Color];
        _expressNameTextView.font = [UIFont systemFontOfSize:16.0];
        _expressNameTextView.backgroundColor = [UIColor whiteColor];
        _expressNameTextView.autocorrectionType = UITextAutocorrectionTypeNo;
        
        _expressNameTextView.keyboardType = UIKeyboardTypeDefault;
        _expressNameTextView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _expressNameTextView.leftPadding = 7.0f;
        _expressNameTextView.layer.cornerRadius = 5.0f;
        _expressNameTextView.layer.borderColor = k233TextBorderColor.CGColor;
        _expressNameTextView.layer.borderWidth = 0.5;
        _expressNameTextView.delegate = self;
        _expressNameTextView.returnKeyType = UIReturnKeyDefault;
        _expressNameTextView.inputView = self.expressPickView;
        
    }
    return _expressNameTextView;
}

//-(UIImageView *)pointView
//{
//    if (!_pointView) {
//        _pointView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"N_Arrow_Up.png"]];
//        _pointView.frame = CGRectMake(280, 20, 18/2, 29/2);
//    }
//    return _pointView;
//}

-(UIButton *)pointView
{
    if (!_pointView) {
        _pointView = [[UIButton alloc] init];
        _pointView.frame = CGRectMake(280, 20, 18/2, 29/2);
        _pointView.selected = NO;
    }
    return _pointView;
}

- (UIPickerView *)expressPickView{
    if (!_expressPickView) {
        
        _expressPickView = [[UIPickerView alloc]init];
        
        _expressPickView.frame = CGRectMake(0, 40, 320, 240);
        
        _expressPickView.delegate =self;
        
        _expressPickView.dataSource =self;
        
        _expressPickView.showsSelectionIndicator = YES;
        
        _expressPickView.opaque = NO;
    }
    return  _expressPickView;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return [self.expressList count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    CShopReturnGoodsDTO *expressDTO = [self.expressList safeObjectAtIndex:row];
    
    return expressDTO.expressName;
}
//
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
//{
//    [self.pointView setImage:[UIImage imageNamed:@"N_Arrow_Down.png"] forState:UIControlStateNormal];
//}
#pragma mark
#pragma UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.expressNameSelect = textField.text;
    [self.tpTableView reloadData];

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    self.expressNameSelect = [NSString stringWithFormat:@"%@%@",textField.text,string];
    
    if (self.expressDto == nil || (textField.text.trim.length == 1 && [string eq:@""] && range.location == 0) ) {
        self.applyBtn.enabled = NO;
    }
    else
    {
        self.applyBtn.enabled = YES;
    }
    
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    self.applyBtn.enabled = NO;

    return YES;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self.tpTableView reloadData];
    return YES;
}



@end

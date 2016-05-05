//
//  AddressEditViewController.m
//  SuningEBuy
//
//  Created by xy ma on 12-8-27.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
//  Modifyed by liukun

#import "AddressEditViewController.h"

@interface AddressEditViewController()

@property (nonatomic, strong) UIBarButtonItem *editButtonNew;

@property (nonatomic, strong) UIBarButtonItem *updateButtonNew;

- (void)setEditDisable;
- (void)setEditEnable;

- (void)sendUpdateAddressRequest;

@end

/*********************************************************************/

@implementation AddressEditViewController

@synthesize baseAddressInfoDTO = _baseAddressInfoDTO;

@synthesize editButtonNew = _editButtonNew;
@synthesize updateButtonNew = _updateButtonNew;

- (void)dealloc {
    TT_RELEASE_SAFELY(_baseAddressInfoDTO);
    
    TT_RELEASE_SAFELY(_editButtonNew);
    TT_RELEASE_SAFELY(_updateButtonNew);
}

- (id)initWithBaseAddress:(AddressInfoDTO *)baseAddress
{
    self = [super init];
    if (self) {
        self.title = L(@"AddressEdit");
        
        self.pageTitle = L(@"shopProcess_shop_addressEdit");
        
        self.baseAddressInfoDTO = baseAddress;
        
        self.isCheckPrefer = self.baseAddressInfoDTO.preferFlag;
        self.checkBtn.selected = self.isCheckPrefer;
        
        [self setEditEnable];
    }
    return self;
}

-(void)loadView{
    [super loadView];
//    self.hasSuspendButton = YES;
    
//    self.footerView.frame = CGRectMake(0, 0, 320, 150);
    CGRect frame = [[UIScreen mainScreen] bounds];
    frame.origin.y = frame.size.height - 114;
    self.footView.frame = CGRectMake(0, frame.origin.y, 320, 50);
    [self.view addSubview:self.footView];
    [self.view bringSubviewToFront:self.footView];
    
    self.hasSuspendButton = NO;
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.addressTextField.text = self.addressInfoDTO.addressContent;
    self.personTextField.text = self.addressInfoDTO.recipient;
    self.phoneTextField.text = self.addressInfoDTO.tel;
}

#pragma mark -
#pragma mark propertys

- (AddressInfoDTO *)addressInfoDTO
{
    if (!_addressInfoDTO) {
        if (self.baseAddressInfoDTO) {
            _addressInfoDTO = [self.baseAddressInfoDTO copy];
        }else{
            _addressInfoDTO = [[AddressInfoDTO alloc] init];
        }
    }
    return _addressInfoDTO;
}

- (UIView *)footView
{
    if (!_footView) {
        _footView = [[UIView alloc] init];
        _footView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
        lineImg.image = [UIImage imageNamed:@"line.png"];
        [_footView addSubview:lineImg];
        [_footView addSubview:self.deleteBtn];
    }
    return _footView;
}

- (UIButton *)deleteBtn
{
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(33, 7, 255, 36)];
        _deleteBtn.backgroundColor = [UIColor colorWithRGBHex:0xf35935];
//        [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"button_white_normal.png"] forState:UIControlStateNormal];
//        [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"button_white_clicked.png"] forState:UIControlStateHighlighted];
        [_deleteBtn setTitle:L(@"ADDeleteTheAddress") forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [_deleteBtn setTitleColor:RGBCOLOR(126, 126, 126) forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

- (UIBarButtonItem *)editButtonNew
{
    

    
    if (!_editButtonNew)
    {
//        _editButtonNew = [UIBarButtonItem initWithImage:nil withName:@"编辑"];// wihtSel:nil];
//        if (_editButtonNew.customView) {
//            UIButton *btn = (UIButton *)_editButtonNew.customView;
//            [btn addTarget:self action:@selector(setEditEnable) forControlEvents:UIControlEventTouchUpInside];
//        }

        _editButtonNew = [[SNBarButtonItem alloc] initWithSNStyle:SNBarItemStyleDone title:L(@"BTEdit") target:self selector:@selector(setEditEnable)];
    }
    return _editButtonNew;
}

- (UIBarButtonItem *)updateButtonNew
{
    if (_updateButtonNew == nil)
    {
//        _updateButtonNew = [UIBarButtonItem initWithImage:@"right_item_btn.png" withName:L(@"Done")];// wihtSel:nil];
//        if (_updateButtonNew.customView) {
//            UIButton *btn = (UIButton *)_updateButtonNew.customView;
//            [btn addTarget:self action:@selector(updateAddress:) forControlEvents:UIControlEventTouchUpInside];
//        }
   
        _updateButtonNew = [[SNBarButtonItem alloc] initWithSNStyle:SNBarItemStyleDone title:L(@"Done") target:self selector:@selector(updateAddress:)];
    }
    return _updateButtonNew;
}

#pragma mark -
#pragma mark action
- (void)deleteAction
{
    if (self.baseAddressInfoDTO.addressType == MainAddress) {
        [self presentSheet:L(@"Main_Address_Can_Not_Delete")];
    }else{
        [self deleteAddress:self.baseAddressInfoDTO];
    }
}

- (void)deleteAddress:(AddressInfoDTO *)address
{
    if (!address) {
        return;
    }
    BBAlertView  *alertView = [[BBAlertView alloc]initWithTitle:nil message:L(@"ADIsDeleteTheAddress") delegate:nil cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];
    
    [alertView setConfirmBlock:^{
        [self displayOverFlowActivityView:L(@"Delete_Address...")];
        
        [self.service beginDeleteAddressRequest:address.addressNo];
        
    }];
    
    [alertView show];
    
    
}

- (void)setStatusEdit
{
    [self setEditEnable];
}

- (void)setEditDisable
{
    [self hideKeyboard];
    
    self.navigationItem.rightBarButtonItem = self.editButtonNew;
    
    self.defaultAddressTextField.userInteractionEnabled = NO;
    
    self.personTextField.userInteractionEnabled = NO;
    
    self.phoneTextField.userInteractionEnabled = NO;
    
    self.addressTextField.userInteractionEnabled = NO;
    
    self.checkBtn.userInteractionEnabled = NO;
}

- (void)setEditEnable
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:L(@"Done") forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orange_Red_Color] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(updateAddress:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(20, 6, 44, 44);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
//    self.navigationItem.rightBarButtonItem = self.updateButtonNew;
    
    self.defaultAddressTextField.userInteractionEnabled = YES;
    
    self.personTextField.userInteractionEnabled = YES;
    
    self.phoneTextField.userInteractionEnabled = YES;
    
    self.addressTextField.userInteractionEnabled = YES;
    
    self.checkBtn.userInteractionEnabled = YES;
    
    [self.personTextField becomeFirstResponder];
}

- (void)updateAddress:(id)sender{
    
    [self hideKeyboard];
    
    //验证收货人
    if((self.personTextField.text == nil) || [self.personTextField.text isEqualToString:@""]){
        [self presentSheet:L(@"Please input your real name") posY:50];
        return;
    }
    if ([self validateChineseName:self.personTextField.text] == NO)
    {
        [self presentSheet: L(@"Please input chinese name")];
        
        return;
    }
    
    //手机号码
    if((self.phoneTextField.text == nil) || [self.phoneTextField.text isEqualToString:@""]){
        [self presentSheet:L(@"Please input receive phone") posY:50];
		return;
	}
    if (![self validateMobileNo:self.phoneTextField.text]) {
		[self presentSheet:L(@"please input your real number") posY:50];
		return;
	}
    
    //区域
    if (self.addressInfoDTO.province == nil || [self.addressInfoDTO.province isEqualToString:@""] || 
        self.addressInfoDTO.city == nil || [self.addressInfoDTO.city isEqualToString:@""] ||
        self.addressInfoDTO.district == nil || [self.addressInfoDTO.district isEqualToString:@""] ||
        self.addressInfoDTO.town == nil || [self.addressInfoDTO.town isEqualToString:@""]){
        
        [self presentSheet:L(@"Please input area address") posY:50];
        
        return;
    }
    if((self.addressTextField.text == nil) || [self.addressTextField.text isEqualToString:@""]){
        [self presentSheet:L(@"Please input detail address") posY:50];
		return;
	}

    //检验详细地址
    NSString *addressDetailError = nil;
    if (![self validateAddressDetail:self.addressTextField.text error:&addressDetailError])
    {
        [self presentSheet:addressDetailError posY:50];
        return;
    }
    
    self.addressInfoDTO.addressContent = self.addressTextField.text;
    self.addressInfoDTO.recipient = self.personTextField.text;
    self.addressInfoDTO.tel = self.phoneTextField.text;
    
    if ([self.addressInfoDTO isEqualToAddress:self.baseAddressInfoDTO]) {
        [self presentSheet:L(@"Address_No_Change") posY:50];
        return;
    }
    
    [self sendUpdateAddressRequest];
    
}

//address picker
- (void)addressPickerLoadDataOkWithSelectInfo:(AddressInfoDTO *)addressInfo
{
    if (addressInfo) {
        NSString *AddressContent = [NSString stringWithFormat:@"%@ %@ %@ %@",
                                    addressInfo.provinceContent,
                                    addressInfo.cityContent,
                                    addressInfo.districtContent,
                                    addressInfo.townContent];
        
        self.defaultAddressTextField.text = AddressContent;
        
        [self.addressInfoDTO copySimpleAddressInfoFromAnotherAddress:addressInfo];
    }
}

#pragma mark -
#pragma mark http request

- (void)sendUpdateAddressRequest
{
    [self displayOverFlowActivityView];
    self.updateButtonNew.enabled = NO;
    [self.service beginEditAddressRequest:self.addressInfoDTO];
}

- (void)editAddressCompletionWithResult:(BOOL)isSuccess
                               errorMsg:(NSString *)errorMsg
                                address:(AddressInfoDTO *)dto
{
    [self removeOverFlowActivityView];
    self.updateButtonNew.enabled = YES;
    if (isSuccess) {
        
        /*更新userInfo中的地址信息*/
        NSMutableArray *addressInfoArray = [UserCenter defaultCenter].userInfoDTO.addressArray;
        for (AddressInfoDTO *addressDTO in addressInfoArray)
        {
            if ([addressDTO.addressNo isEqualToString:self.baseAddressInfoDTO.addressNo]) {
                [addressInfoArray removeObject:addressDTO];
                break;
            }
        }
        [addressInfoArray addObject:dto];
        
        //设置为默认地址
        [Config currentConfig].defaultAddressId = dto.addressNo;

        [self presentCustomDlg:L(@"address update success")];
        
    }else{
        [self presentSheet:errorMsg];
    }
}

- (void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ([_delegate conformsToProtocol:@protocol(AddressChangeDelegate)]) {
        if ([_delegate respondsToSelector:@selector(addressListNeedRefresh)]) {
            [_delegate addressListNeedRefresh];
        }
        if ([_delegate respondsToSelector:@selector(didSelectAddress:)]) {
            [_delegate didSelectAddress:self.addressInfoDTO];
        }
    }

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark
#pragma mark - 删除地址回调
- (void)deleteAddressCompletionWithResult:(BOOL)isSuccess
                                 errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"AlertTips")
                                                        message:L(@"ADDeleteAddressSuccess")
                                                       delegate:nil
                                              cancelButtonTitle:L(@"Ok")
                                              otherButtonTitles:nil];
        [alert setCancelBlock:^{
            if ([_delegate conformsToProtocol:@protocol(AddressChangeDelegate)]) {
                if ([_delegate respondsToSelector:@selector(addressListNeedRefresh)]) {
                    [_delegate addressListNeedRefresh];
                }
                if ([_delegate respondsToSelector:@selector(didSelectAddress:)]) {
                    [_delegate didSelectAddress:self.addressInfoDTO];
                }
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert show];
    }else{
        [self presentSheet:errorMsg];
    }
}

@end

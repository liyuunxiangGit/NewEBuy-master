//
//  AddressInfoListViewController.m
//  SuningEBuy
//
//  Created by xy ma on 12-8-27.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
//  Modifyed by liukun

#import "AddressInfoListViewController.h"
#import "AddressNewViewController.h"
#import "AddressEditViewController.h"
#import "ReceiveInfoViewController.h"

#import "UITableViewCell+BgView.h"

#define kAddAddressAlertTag     16
#define kDeleteAddressAlertTag 17

@interface AddressInfoListViewController()
{
    BOOL _isFromNewAdderss;
    BOOL _isPriceChanged;
}

- (void)refreshAddressList;
- (void)deleteAddress:(AddressInfoDTO *)address;

- (void)selectAddressOk:(NSInteger)row;

@end

/*********************************************************************/

@implementation AddressInfoListViewController

@synthesize service = _service;
@synthesize delegate = _delegate;
@synthesize addressList = _addressList;
@synthesize selectAddressDTO = _selectAddressDTO;
@synthesize deleteAddressDTO = _deleteAddressDTO;
@synthesize isFromEasilyBuy;
@synthesize isFromAddressInfo;


- (void)dealloc {
    
    if (_payFlowService.delegate == self) {
        _payFlowService.delegate = nil;
    }
    SERVICE_RELEASE_SAFELY(_service);
    TT_RELEASE_SAFELY(_addressList);
    TT_RELEASE_SAFELY(_selectAddressDTO);
    TT_RELEASE_SAFELY(_deleteAddressDTO);
}
- (UIButton *)addBtn
{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.frame = CGRectMake(80, 2, 60, 44);
        [_addBtn setImage:[UIImage imageNamed:@"addMark.png"] forState:UIControlStateNormal];

        [_addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bottomNavBar addSubview:_addBtn];
    }
    return _addBtn;
}

- (UIButton *)editBtn
{
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _editBtn.frame = CGRectMake(180, 2, 60, 44);
        [_editBtn setImage:[UIImage imageNamed:@"addressEdit.png"] forState:UIControlStateNormal];
        
       // [_editBtn setImage:nil forState:UIControlStateSelected];
        
        [_editBtn setTitle:@"" forState:UIControlStateNormal];
        
        [_editBtn setTitle:L(@"BTFinish") forState:UIControlStateSelected];
        [_editBtn setTitleColor:[UIColor colorWithRGBHex:0x009944] forState:UIControlStateSelected];
        
        [_editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bottomNavBar addSubview:_editBtn];
    }
    return _editBtn;
}
- (id)init
{
    self = [super init];
    
    if (self)
    {
        currentRow = -1;
        
        [self.view addGestureRecognizer:self.swipeRight];
        self.swipeRight.enabled=YES;
        _isFromNewAdderss = NO;
        _isPriceChanged = NO;
        self.hidesBottomBarWhenPushed = YES;
        
        self.bSupportPanUI = NO;
    }
    return self;
}

- (id)initWith:(ReceiveInfoViewController *)object
{
    self=[super init];
    if (self) {
        self.obj = object;
        currentRow = -1;
        [self.view addGestureRecognizer:self.swipeRight];
        self.swipeRight.enabled=YES;
        self.hidesBottomBarWhenPushed = YES;
        self.bSupportPanUI = NO;
    }
    return self;
}

- (UISwipeGestureRecognizer *)swipeRight
{
    if (!_swipeRight) {
        _swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backForePage)];
        [_swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
        _swipeRight.delegate = self;
    }
    return _swipeRight;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

- (void)righBarClick
{
    [self addNewAddress];
}

- (void)backForePage
{
//    if (self.cellType == FromShop) {
//        if (_delegate && [_delegate respondsToSelector:@selector(didSelectAddress:)]) {
//            [_delegate didSelectAddress:self.selectAddressDTO];
//        }
//        [self displayOverFlowActivityView];
//        [self.payFlowService beginConfirmDeliveryAddressRequest:ShipModeSuningSend addressInfo:self.selectAddressDTO storeInfo:nil];
//    }
//    else
//    {
        [super backForePage];
//    }
}

#pragma mark -
#pragma mark 从购物车二过来确认地址的回调

- (void)saveDeliveryAndAddressCompletionWithResult:(BOOL)isSuccess service:(PayFlowService *)service payDTO:(payFlowDTO *)dto errorCode:(NSString *)errorCode
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        [self.obj saveAddressResult:YES service:service payDTO:dto errorCode:errorCode];
        
//        if (_isPriceChanged == YES) {
            [self backForePage];
//        }
//        isSaveDeliveryOK = YES;
//        self.canUseEleInvoice    = service.canUseEleInvoice;
//        self.eleInvoiceIsDefault = service.eleInvoiceIsDefault;
//        if (self.eleInvoiceIsDefault) {
//            invoiceType = 2;
//        }else
//            invoiceType = 0;
//        
//        // 导航到去结算页面
//        [self calculateProduct:self.payFlowService.shopCartItemList];
//        if (self.shipMode == ShipModeSuningSend) {
//            self.addressInfo = self.payFlowService.addressInfoDto;
//        }else{
//            self.storeInfo = self.payFlowService.storeInfoDto;
//        }
//        [self refreshOrderPrice];
        [Config currentConfig].defaultProvince = self.selectAddressDTO.province;
        [Config currentConfig].defaultCity = self.selectAddressDTO.city;
        [[NSNotificationCenter defaultCenter] postNotificationName:DEFAULT_CITY_CHANGE_NOTIFICATION object:nil];
        
    }else{
        if ([errorCode isEqualToString:@"priceChange"]) {
            BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"AlertTips") message:L(@"ADSorryGoodsPriceChange") delegate:self cancelButtonTitle:L(@"AlertBack") otherButtonTitles:L(@"AlertContinueToBuy")];
            [alert setCancelBlock:^{
                NSUInteger index = [[self.navigationController viewControllers] count] - 3;
                UIViewController *vc = [[self.navigationController viewControllers] safeObjectAtIndex:index];
                [self.navigationController popToViewController:vc animated:YES];
            }];
            [alert setConfirmBlock:^{
                [self displayOverFlowActivityView];
                _isPriceChanged = YES;
                [self.payFlowService beginConfirmDeliveryAddressRequest:ShipModeSuningSend addressInfo:self.payFlowService.addressInfoDto storeInfo:nil];
            }];
            [alert show];
            return;
        }
        [self presentSheet:service.errorMsg];
    }
    
}

#pragma mark -
#pragma mark view life cycle

- (void)loadView{
    
    [super loadView];
    
    self.groupTableView.frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    [self.view addSubview:self.groupTableView];

    if (self.cellType == FromEbuy) {
        self.title = L(@"ADAddressManagement");
        self.pageTitle = L(@"member_myEbuy_addressManage");
       // frame.size.height = contentView.bounds.size.height - 92;
    }
    else
    {
        self.title = L(@"address list");
        self.pageTitle = L(@"shopProcess_shop_addressList");
       // frame.size.height = contentView.bounds.size.height - 44;

    }
    
//    [self useBottomNavBar];
//    self.bottomNavBar.backButton.hidden = YES;
    [self editBtn];
    [self addBtn];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:L(@"ADAdd") forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orange_Red_Color] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(righBarClick) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(20, 6, 44, 44);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    
    [self.view addSubview:self.groupTableView];
    
    self.hasSuspendButton = NO;

}


-(void)addAction:(id)sender{
    
    [self addNewAddress];
}
-(void)editAction:(id)sender{
    
    self.editBtn.selected = !self.editBtn.isSelected;
    
    
    [UIView animateWithDuration:0.7 animations:^{
        
        
        if (self.editBtn.isSelected) {
            
            self.addBtn.hidden = YES;
            [_editBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            
            self.editBtn.frame = CGRectMake(260, 2, 60, 44);
            
        }
        else{
            
            self.addBtn.hidden = NO;
            [_editBtn setImage:[UIImage imageNamed:@"addressEdit.png"] forState:UIControlStateNormal];
            self.editBtn.frame = CGRectMake(180, 2, 60, 44);
        }
        
        self.isEditing = self.editBtn.isSelected;
        
    }];
    
    
    [self.groupTableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated{
	    
	[super viewWillAppear:animated];
    //初始化刷新
	if(!isAddressListLoaded){
        
        [self refreshAddressList];
	}
   }

- (void)viewDidDisappear:(BOOL)animated{
	
	[super viewDidDisappear:animated];
}


#pragma mark -
#pragma mark action

- (void)addNewAddress
{
    AddressNewViewController *newAddress = [[AddressNewViewController alloc] init];
    
    newAddress.delegate = self;
    
    newAddress.isFromEasilyBuy = self.isFromEasilyBuy;
    
    [self.navigationController pushViewController:newAddress animated:YES];
    
    TT_RELEASE_SAFELY(newAddress);
    
}

- (void)selectAddressOk:(NSInteger)row
{
    if (row >= 0 && row < [self.addressList count]) {
        
        AddressInfoDTO *rowAddress = [self.addressList objectAtIndex:row];
        
        //如果地址抛出null异常
        if ([rowAddress isThrowNULLError]) {
            
            BBAlertView *alert = [[BBAlertView alloc] 
                                  initWithTitle:L(@"system-info")
                                  message:L(@"Cod_Address_Throw_NULL_Error_Need_Reset")
                                  delegate:nil
                                  cancelButtonTitle:L(@"Cancel")
                                  otherButtonTitles:L(@"Ok")];
            
            [alert setConfirmBlock:^{
                AddressEditViewController *addressEditVC = 
                [[AddressEditViewController alloc] initWithBaseAddress:rowAddress];
                addressEditVC.delegate = self;
                addressEditVC.isFromEasilyBuy = self.isFromEasilyBuy;
                [self.navigationController pushViewController:addressEditVC animated:YES];
                TT_RELEASE_SAFELY(addressEditVC);
            }];
            
            [alert show];
            
        }else{
            
            [Config currentConfig].defaultAddressId = rowAddress.addressNo;
            self.selectAddressDTO = rowAddress;
            currentRow = row;
            [self.groupTableView reloadData];
//            if (_delegate && [_delegate respondsToSelector:@selector(didSelectAddress:)]) {
//                [_delegate didSelectAddress:self.selectAddressDTO];
//            }
        }
        
    }else{  //当地址列表为空时的情况 row为-1
        currentRow = -1;
        self.selectAddressDTO = nil;
        [self.groupTableView reloadData];
        [Config currentConfig].defaultAddressId = nil;
        
//        if (_delegate && [_delegate respondsToSelector:@selector(didSelectAddress:)]) {
//            [_delegate didSelectAddress:nil];
//        }
    }
        
    
}

#pragma mark -
#pragma mark Table View Delegate Methods


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressInfoDTO *dto = [self.addressList objectAtIndex:indexPath.row];
    
    return [AddressItemCell height:dto type:self.cellType edit:self.isEditing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _addressList?[_addressList count]:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger row = indexPath.row;
    
    static NSString *AddressListItemCellIdentifier = @"AddressListItemCellIdentifier";
    
    AddressItemCell *cell = (AddressItemCell*)[tableView dequeueReusableCellWithIdentifier:AddressListItemCellIdentifier];
    
    if(cell == nil){
        
        cell = [[AddressItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AddressListItemCellIdentifier];
//        cell.backgroundColor = [UIColor cellBackViewColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    
   // cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    AddressInfoDTO *dto = [self.addressList objectAtIndex:row];
    
    cell.cellType = self.cellType;
    cell.tag = indexPath.row + 100;
    
    if (self.cellType != FromEbuy
        && !self.isEditing) {
        
        if (indexPath.row == currentRow)
        {
            cell.isSelect = YES;
        }
        else
        {
            cell.isSelect = NO;
        }
    }
    
    //cell.addressInfoItem = dto;
    
    [cell setAddressInfoItem:dto edit:self.isEditing];
    
    return cell;
    
}
//+ (void)setExtraCellLineHidden: (UITableView *)tableView
//{
//    UIView *view = [UIView new];
//    view.backgroundColor = [UIColor clearColor];
//    [tableView setTableFooterView:view];
//    [view release];
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 15)];
    return v;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isEditing) {
        //从购物车进来
        //没有激发了界面的编辑按钮  是选择送货地址

        AddressInfoDTO *rowAddress = [self.addressList objectAtIndex:indexPath.row];
        
        AddressEditViewController *addressEditViewController =
        [[AddressEditViewController alloc] initWithBaseAddress:rowAddress];
        
        addressEditViewController.delegate = self;
        
        addressEditViewController.isFromEasilyBuy = self.isFromEasilyBuy;
        
        [self.navigationController pushViewController:addressEditViewController animated:YES];
        
        TT_RELEASE_SAFELY(addressEditViewController);
    }
//    else if(self.cellType == FromShop){
    
        AddressInfoDTO *rowAddress = [self.addressList objectAtIndex:indexPath.row];
        
        AddressEditViewController *addressEditViewController =
        [[AddressEditViewController alloc] initWithBaseAddress:rowAddress];
        
        addressEditViewController.delegate = self;
        
        addressEditViewController.isFromEasilyBuy = self.isFromEasilyBuy;
        
        [self.navigationController pushViewController:addressEditViewController animated:YES];
        
        TT_RELEASE_SAFELY(addressEditViewController);
        
//        [self selectAddressOk:indexPath.row];
//        
//        [self displayOverFlowActivityView];
//        [self.payFlowService beginConfirmDeliveryAddressRequest:ShipModeSuningSend addressInfo:self.selectAddressDTO storeInfo:nil];
//    }
//    self.cellType != FromEbuy
//    && !
    
}

- (void)tableView:(UITableView *) tableView 
    accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    // NSInteger idx= indexPath.row ;
    
    AddressInfoDTO *rowAddress = [self.addressList objectAtIndex:indexPath.row];
    
    AddressEditViewController *addressEditViewController = 
    [[AddressEditViewController alloc] initWithBaseAddress:rowAddress];
    
    addressEditViewController.delegate = self;
    
    addressEditViewController.isFromEasilyBuy = self.isFromEasilyBuy;
    
    [self.navigationController pushViewController:addressEditViewController animated:YES];
        
    TT_RELEASE_SAFELY(addressEditViewController);
    
}


- (void)tableView:(UITableView *)tableView 
    commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) 
    {
        willDeleteRow = indexPath.row;
        
        AddressInfoDTO *addressDTO = [self.addressList objectAtIndex:willDeleteRow];
        
        if (addressDTO.addressType == MainAddress) {
            [self presentSheet:L(@"Main_Address_Can_Not_Delete")];
        }else{
            [self deleteAddress:addressDTO];
        }
        
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark -
#pragma mark 新增或修改完成后执行的回调

- (void)addressListNeedRefresh
{
    _isFromNewAdderss = YES;
    [self refreshAddressList];
}

#pragma mark -
#pragma mark 点击编辑地址的回调

- (void)editAddressItemAction:(AddressInfoDTO *)dto withTag:(NSInteger)tag
{
//    AddressInfoDTO *rowAddress = dto;
//    
//    AddressEditViewController *addressEditViewController =
//    [[AddressEditViewController alloc] initWithBaseAddress:rowAddress];
//    
//    addressEditViewController.delegate = self;
//    
//    addressEditViewController.isFromEasilyBuy = self.isFromEasilyBuy;
//    
//    [self.navigationController pushViewController:addressEditViewController animated:YES];
//    
//    TT_RELEASE_SAFELY(addressEditViewController);

    
    AddressInfoDTO *rowAddress = dto;
    [Config currentConfig].defaultAddressId = rowAddress.addressNo;
    self.selectAddressDTO = rowAddress;
    currentRow = tag - 100;
    [self.groupTableView reloadData];
    
    [self displayOverFlowActivityView];
    [self.payFlowService beginConfirmDeliveryAddressRequest:ShipModeSuningSend addressInfo:self.selectAddressDTO storeInfo:nil];
}

#pragma mark -
#pragma mark data

- (void)reloadTableViewData
{
    //先判断如果地址列表为空，提示用户创建
    if (!_addressList || [_addressList count] == 0) {
        
        [self selectAddressOk:-1];
        
        BBAlertView *alertView = [[BBAlertView alloc] 
                                  initWithTitle:L(@"system-info")
                                  message:L(@"No_Address_Info_Go_To_Set_An_Delivery_Address?")
                                  delegate:self
                                  cancelButtonTitle:L(@"Cancel")
                                  otherButtonTitles:L(@"Ok")];
        alertView.tag = kAddAddressAlertTag;
        [alertView show];
    }else{
        
        // 循环list，将每个addressid和config中的默认值比较，将索引值给currentRow，
        // 达到关闭应用之后下次再打开还能保留上次选中的默认配送地址 
        BOOL hasDefaultAddress = NO;
        for (int i = 0; i < [self.addressList count]; i++)
        {
            AddressInfoDTO *tempdto = [self.addressList objectAtIndex:i];
            NSString *defaultAddressNo = [Config currentConfig].defaultAddressId;
            if ([tempdto.addressNo isEqualToString:defaultAddressNo])
            {
                hasDefaultAddress = YES;
                
                [self selectAddressOk:i];
                break;
            }
        }
        //如果未找到，则将第一个地址设置为默认地址
        if (!hasDefaultAddress) {
        
            [self selectAddressOk:0];
        }
        
        [self.groupTableView reloadData];
    }
}

- (UserAddressService *)service
{
    if (!_service) {
        _service = [[UserAddressService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

- (PayFlowService *)payFlowService
{
    if (!_payFlowService) {
        _payFlowService = [[PayFlowService alloc] init];
        _payFlowService.delegate = self;
    }
    return _payFlowService;
}

- (void)refreshAddressList
{
    [self displayOverFlowActivityView];
    
    [self.service beginGetAddressListRequest];
}

- (void)getAddressListCompletionWithResult:(BOOL)isSuccess 
                                  errorMsg:(NSString *)errorMsg 
                               addressList:(NSArray *)list
{
    [self removeOverFlowActivityView];
    
    if (isSuccess) {
        isAddressListLoaded = YES;
        
        self.addressList = [NSMutableArray arrayWithArray:list];
        
        //更新userInfoDto
        [UserCenter defaultCenter].userInfoDTO.addressArray = _addressList;
        
        [self reloadTableViewData];
        
        if (self.cellType == FromShop) {
            if (_isFromNewAdderss == YES) {
                _isFromNewAdderss = NO;
//                [self selectAddressOk:0];
                [self displayOverFlowActivityView];
                [self.payFlowService beginConfirmDeliveryAddressRequest:ShipModeSuningSend addressInfo:self.selectAddressDTO storeInfo:nil];
            }
        }
        
    }else{
        [self presentSheet:errorMsg];
    }
}

- (void)deleteAddress:(AddressInfoDTO *)address
{
    if (!address) {
        return;
    }
    BBAlertView  *alertView = [[BBAlertView alloc]initWithTitle:nil message:L(@"ADIsDeleteTheAddress") delegate:self cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];
    
    [alertView setConfirmBlock:^{
        [self displayOverFlowActivityView:L(@"Delete_Address...")];
        
        [self.service beginDeleteAddressRequest:address.addressNo];
        
    }];      
    
    [alertView show];
    
    
}

- (void)deleteAddressCompletionWithResult:(BOOL)isSuccess 
                                 errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    
    if (isSuccess) {
        //如果删除掉的是默认地址，那么先改变用户的默认地址为用户主地址，再删除。
        AddressInfoDTO *deleteDto = [self.addressList objectAtIndex:willDeleteRow];
        if ([self.selectAddressDTO.addressNo isEqualToString:deleteDto.addressNo]) {
            [self setSelectAddressDTO:0];
        }
        
        // 刷新地址列表
        [self.addressList removeObjectAtIndex:willDeleteRow];
        
        // 刷新地址列表视图
        NSIndexPath *deleteIndexPath = [NSIndexPath indexPathForRow:willDeleteRow inSection:0];
        [self.groupTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:deleteIndexPath]
                                   withRowAnimation:UITableViewRowAnimationFade];
        [self reloadTableViewData];
        
    }else{
        [self presentSheet:errorMsg];
    }
}

#pragma mark -
#pragma mark alert view delegate

- (void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == kAddAddressAlertTag && buttonIndex == 1) {
        [self addNewAddress];
    }
    else if(alertView.tag == kAddAddressAlertTag && buttonIndex == 0){
        [self.navigationController popViewControllerAnimated:YES];
    }
  
    
}

@end

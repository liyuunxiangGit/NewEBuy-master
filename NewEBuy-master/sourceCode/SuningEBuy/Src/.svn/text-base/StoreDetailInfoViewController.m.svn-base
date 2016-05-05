//
//  StoreDetailInfoViewController.m
//  SuningEBuy
//
//  Created by xingxianping on 14-2-14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "StoreDetailInfoViewController.h"

@interface StoreDetailInfoViewController ()
{
    BOOL   isLoadOK;
    BOOL   isFirstIn;
}

@end

@implementation StoreDetailInfoViewController

@synthesize service = _service;
@synthesize infoDTO = _infoDTO;
@synthesize floorArr = _floorArr;
@synthesize serviceArr = _serviceArr;
@synthesize callWeb = _callWeb;
@synthesize headView = _headView;
@synthesize listDto = _listDto;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_service);
    TT_RELEASE_SAFELY(_infoDTO);
    TT_RELEASE_SAFELY(_floorArr);
    TT_RELEASE_SAFELY(_serviceArr);
    TT_RELEASE_SAFELY(_callWeb);
    TT_RELEASE_SAFELY(_headView);
    TT_RELEASE_SAFELY(_listDto);
    
    _service.serviceDelegate =nil;
    
}

- (id)init
{
    self =[super init];
    if (self) {
        _serviceArr = [[NSMutableArray alloc]init];
        _floorArr = [[NSMutableArray alloc]init];
        
        _service = [[SuningStoreInfoService alloc]init];
        _service.serviceDelegate = self;
        
        _infoDTO = [[StoreDetailInfoDTO alloc]init];
        _listDto = [[StoreListDTO alloc]init];
        
        _index =0;

        isFirstIn = YES;
        isLoadOK = NO;
        isFristLoad = YES;
        
        self.hidesBottomBarWhenPushed =YES;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.pageTitle=L(@"PageTitleNearbySuningStoreInfo");
    self.title =self.listDto.storeName;
    
    if (!IsNilOrNull(self.infoDTO)) {
        [self.groupTableView reloadData];
    }
    
    if (isFristLoad) {
        [self refreshData];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.groupTableView.frame =[self visibleBoundsShowNav:YES showTabBar:NO];
    
}

- (UIWebView *)callWeb
{
    if (!_callWeb) {
        _callWeb = [[UIWebView alloc]init];
        _callWeb.backgroundColor = [UIColor clearColor];
    }
    return _callWeb;
}

- (StoreHeadImageView *)headView
{
    if (!_headView) {
        _headView = [[StoreHeadImageView alloc]init];
        _headView.frame = CGRectMake(0, 0, 320, 176);
        _headView.dto=self.infoDTO;
    }
    return _headView;
}

- (StoreServiceScrollView *)serviceView
{
    if (!_serviceView) {
        _serviceView = [[StoreServiceScrollView alloc]init];
        _serviceView.buttonDelegate = self;
        _serviceView.backgroundColor =[UIColor cellBackViewColor];
       
    }
    return _serviceView;
}

- (void)serviceButtonClickedDelegate:(int)tag
{
    _index = tag;
    self.storeServiceDTO =[self.serviceArr objectAtIndex:_index];
    [self.groupTableView beginUpdates];
    
    NSArray *array =[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:1],[NSIndexPath indexPathForRow:2 inSection:1], nil];
    [self.groupTableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.groupTableView endUpdates];
    
}
#pragma mark
#pragma mark - tableview datasource and delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
//    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 2;
//          return 4;
        }
            break;
        case 1:
        {
            return 4;
//            if (IsArrEmpty(self.serviceArr)) {
//                return 0;
//            }
//            return 3;
        }
            break;
//        case 2:
//        {
//            return [self.floorArr count];
//        }
//            break;
        
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0) {
//        return [NearbySuningStoreDetailCell height:self.infoDTO withRow:indexPath.row];
//    }
//    else if (indexPath.section == 1)
//    {
//        if (IsArrEmpty(self.serviceArr)) {
//            return 0;
//        }
//        else if (indexPath.row ==0)
//            return 90;
//        else
//            return [NearbySuningStoreDetailCell height:self.storeServiceDTO withTag:indexPath.row];
//    }
//    else if (indexPath.section == 2)
//    {
//        if (IsArrEmpty(self.floorArr)) {
//            return 0;
//        }
//        return [NearbySuningStoreDetailCell height:[self.floorArr objectAtIndex:indexPath.row] withIndex:indexPath.row];
//    }
//    else
//        return 40;
    
    return [NearbySuningStoreDetailCell height:self.infoDTO withIndexPath:indexPath];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
//        return 172;
        return 40;
    }
    else if (section ==1)
    {
//        if (IsArrEmpty(self.serviceArr)) {
//            return 0;
//        }
//        return 35;
        return 10;
    }
//    else if (section == 2)
//    {
//        if (IsArrEmpty(self.floorArr)) {
//            return 0;
//        }
//        return 40;
//    }
//    else
        return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
//        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 240)];
//        view.backgroundColor = [UIColor clearColor];
//        self.headView.dto =self.infoDTO;
//        [self.headView layoutSubviews];
//        
//        [view addSubview:self.headView];
//        
//        return view;
        
        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:16.0];
        label.textColor = [UIColor light_Gray_Color];
        label.text = L(@"NearbySuning_StoreInfo");
        label.textAlignment = UITextAlignmentCenter;
        [view addSubview:label];
        return view;
    }
//    else if(section ==1)
//    {
//        if (IsArrEmpty(self.serviceArr)) {
//            return nil;
//        }
//        else
//        {
//            if (IsArrEmpty(self.serviceArr)) {
//                return nil;
//            }
//            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
//            view.backgroundColor =[UIColor uiviewBackGroundColor];
//            
//            UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 290, 40)];
//            title.text =@"门店服务";
//            title.textColor =[UIColor light_Black_Color];
//            title.backgroundColor = [UIColor clearColor];
//            
//            [view addSubview:title];
//            
//            return view;
//        }
//    }
//    else if (section == 2)
//    {
//        if (IsArrEmpty(self.floorArr)) {
//            return nil;
//        }
//        UIView *floorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
//        floorView.backgroundColor = [UIColor uiviewBackGroundColor];
//        
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 290, 40)];
//        label.backgroundColor = [UIColor clearColor];
//        label.text = @"楼层信息";
//        label.textColor =[UIColor light_Black_Color];
//        
//        [floorView addSubview:label];
//        
//        return floorView;
//    }
    
        return nil;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *infoIdentifier =@"infoTableviewIdentifier";
    
    NearbySuningStoreDetailCell *infoCell = [tableView dequeueReusableCellWithIdentifier:infoIdentifier];
    
    if (infoCell == nil) {
        infoCell = [[NearbySuningStoreDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infoIdentifier];
        infoCell.backgroundColor =[UIColor cellBackViewColor];
        infoCell.selectionStyle =UITableViewCellSelectionStyleNone;
        //            tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    [infoCell setItem:self.infoDTO withIndexPath:indexPath];
    
    return infoCell;
    
    
//    if (indexPath.section == 0) {
//        static NSString *infoIdentifier =@"infoTableviewIdentifier";
//        
//        NearbySuningStoreDetailCell *infoCell = [tableView dequeueReusableCellWithIdentifier:infoIdentifier];
//        
//        if (infoCell == nil) {
//            infoCell = [[NearbySuningStoreDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infoIdentifier];
//            infoCell.backgroundColor =[UIColor cellBackViewColor];
//            infoCell.selectionStyle =UITableViewCellSelectionStyleNone;
////            tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        }
//        [infoCell setItem:self.infoDTO withRow:indexPath.row];
//        
//        return infoCell;
//        
//    }
//    else if (indexPath.section ==1)
//    {
//        if (IsArrEmpty(self.serviceArr)) {
//            return nil;
//        }
//        if (indexPath.row ==0) {
//            static NSString *cellIdentifier =@"buttonIdentifier";
//            
//            UITableViewCell *buttonCell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//            
//            if (buttonCell ==nil) {
//                buttonCell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//                buttonCell.backgroundColor =[UIColor cellBackViewColor];
//                buttonCell.selectionStyle =UITableViewCellSelectionStyleNone;
//                tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
//            }
//            
//            self.serviceView.frame =CGRectMake(0, 0, 320, 90);
//            
//            self.serviceView.dataArr =self.serviceArr;
//            [self.serviceView creatServiceButtons:[self.serviceArr count]];
//            [self.serviceView updateBtnWithArr:self.serviceArr andIndex:_index];
//            
//            UIButton *btn =[self.serviceView.buttonArr objectAtIndex:[self.serviceView.buttonArr count]-1];
//            self.serviceView.contentSize = CGSizeMake(20+btn.right, 70);
//            
//            [buttonCell.contentView addSubview:self.serviceView];
//
//            return buttonCell;
//        }
//        else
//        {
//            static NSString *serviceIdentifier =@"serviceTableviewIdentifier";
//            
//            NearbySuningStoreDetailCell *serviceCell = [tableView dequeueReusableCellWithIdentifier:serviceIdentifier];
//            
//            if (serviceCell == nil) {
//                serviceCell = [[NearbySuningStoreDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:serviceIdentifier];
//                serviceCell.backgroundColor =[UIColor cellBackViewColor];
//                serviceCell.selectionStyle =UITableViewCellSelectionStyleNone;
////                tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//
//            }
//            [serviceCell setServiceDto:[self.serviceArr objectAtIndex:_index] withTag:indexPath.row];
//            
//            return serviceCell;
//        }
//    }
//    else if (indexPath.section ==2)
//    {
//        static NSString *floorIdentifier =@"floorTableviewIdentifier";
//        
//        NearbySuningStoreDetailCell *floorCell = [tableView dequeueReusableCellWithIdentifier:floorIdentifier];
//        
//        if (floorCell == nil) {
//            floorCell = [[NearbySuningStoreDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:floorIdentifier];
//            floorCell.backgroundColor =[UIColor cellBackViewColor];
//            floorCell.selectionStyle =UITableViewCellSelectionStyleNone;
////            tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        }
//        [floorCell setFloorDto:[self.floorArr objectAtIndex:indexPath.row] withRow:indexPath.row];
//        
//        return floorCell;
//    }
//    
//    return nil;
}


#pragma mark
#pragma mark - service
- (void)refreshData
{
    [self.service getSuningStoreDetailInfoWithStoreId:self.infoDTO.storeId];
    
}

- (void)getNearBySuningStoreDetailInfo:(SuningStoreInfoService *)service isSuccess:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    if (!isSuccess) {
        [self displayOverFlowActivityView:errorMsg];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        self.infoDTO = service.storeInfoDTO;
        
        [self.floorArr removeAllObjects];
        self.floorArr = [NSMutableArray arrayWithArray:service.floorInfoArr];
        
        [self.serviceArr removeAllObjects];
        
        // xzoscar 2014-06-06 add,容错（部分服务名称返回是空字符串）
        // 过滤掉 毫无意义的 空数据
        if (!IsArrEmpty(service.storeServiceArr)
            && service.storeServiceArr.count > 0) {
            [service.storeServiceArr filterUsingPredicate:[NSPredicate predicateWithFormat:@"serviceName != \"\""]];
        }
        
        self.serviceArr = [NSMutableArray arrayWithArray:service.storeServiceArr];
        if (!IsArrEmpty(self.serviceArr)) {
            self.storeServiceDTO=[self.serviceArr objectAtIndex:_index];
            
        }
        
        if (self.groupTableView.superview == nil) {
            [self.view addSubview:self.groupTableView];
        }
        [self.groupTableView reloadData];

    }
    
    isFristLoad = NO;
    
}


@end

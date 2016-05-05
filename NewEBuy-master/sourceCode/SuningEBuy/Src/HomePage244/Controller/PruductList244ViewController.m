//
//  PruductList244ViewController.m
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-25.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "PruductList244ViewController.h"
#import "HomeProductDTO.h"
#import "ProductUtil.h"
#import "ProductDetailViewController.h"



@interface PruductList244ViewController ()

@end

@implementation PruductList244ViewController


-(void)dealloc
{
    [self unRegistKVO];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pageTitle = L(@"PageTitleProductList");
        self.hasNav = YES;
        self.iOS7FullScreenLayout = YES;
        
        //是否是最后一页，父类里依据这个标志位判断能否加载更多
        self.isLastPage = NO;
        
        //总页数默认设置为1
        pageTotalCount = 1;
        
        //初始化时，当前页面显示第一页数据
        pageIndex = 1;
        
        //是否有广告图片
        hasAdImageView = NO;
        
        //是否有广告文字
        hasAdDescription = NO;
        
        self.whereFrom = SNRouteSourceNone;
        
        tableDataArray = [[NSMutableArray alloc] init];
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

#pragma mark -
#pragma mark KVO

- (void)registKVO
{
    [self addObserver:self
           forKeyPath:@"AdActiveRuleCellHeight"
              options:NSKeyValueObservingOptionNew
              context:NULL];
}

- (void)unRegistKVO
{
    [self removeObserver:self
              forKeyPath:@"AdActiveRuleCellHeight"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"AdActiveRuleCellHeight"])
    {
        [self.tableView reloadData];
    }
}

-(void)setAdRowHeight:(CGFloat)height
{
    self.AdActiveRuleCellHeight = height;
}


- (ZhuanTiService244 *)zhuanTiService {
    if (!_zhuanTiService) {
        _zhuanTiService = [[ZhuanTiService244 alloc] init];
        _zhuanTiService.delegate = self;
    }
    
    return _zhuanTiService;
}

- (void)loadView
{
    [super loadView];
    
    [self refreshData];
    [self registKVO];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    //解决在商品四级页里更改城市后，再返回列表页，列表里已经显示在页面上的那些cell的价格图片还是不变的问题
    NSArray *visibleIndexPath = [self.tableView indexPathsForVisibleRows];
    for (NSIndexPath *indexPath in visibleIndexPath) {
        if (indexPath.section == 1) {
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            if ([cell respondsToSelector:@selector(updateCellProductPriceImage)]) {
                [cell performSelector:@selector(updateCellProductPriceImage) withObject:nil];
            }
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //取消请求
    [self.zhuanTiService cancelProductListRequestAndDelegate];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.tableView.frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.multipleTouchEnabled = NO;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.backgroundColor = [UIColor view_Back_Color];
    [self.tableView addSubview:self.refreshHeaderView];
    [self.view addSubview:self.tableView];
}


#pragma mark - UITableViewDelegate & UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //广告信息、商品列表
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    //第一个section包含图片和文字
    if (section == 0) {
        return 2;
    }
    else {
        //不同的类型，cell数量不同
        NSUInteger count = [tableDataArray count];
        if (self.templateID == 1 || self.templateID == 2) {
            //一行一个大图    一行一个小图
            return count;
        }
        else if (self.templateID == 3) {
            //一行两个
            return (count%2==0) ? count/2 : count/2+1;
        }
        else {
            //一行3个
            return (count%3==0) ? count/3 : count/3+1;
        }
    }
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *tempView = nil;
//    if (NotNilAndNull(_dataDTO.topAD)) {
//        tempView  = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 200)];
//        tempView.backgroundColor = [UIColor light_Gray_Color];
//    }
//    return tempView;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int row = indexPath.row;
    TopADInfoDTO *adInfo = _dataDTO.topAD;
    
    if (indexPath.section == 0) {
        if (row == 0) {
            //广告图片
            static NSString *innerImageViewIdentifier = @"innerImageViewIdentifier";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:innerImageViewIdentifier];
            
            if(cell == nil){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:innerImageViewIdentifier];
                cell.accessoryType = UITableViewCellStyleDefault;
            }
            
            EGOImageButton *innerImageView = [[EGOImageButton alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
            [innerImageView setImageURL:[NSURL URLWithString:adInfo.adImg]];
            [innerImageView addTarget:self action:@selector(jumpToActivity) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:innerImageView];
            cell.clipsToBounds = YES;
            return cell ;
        }
        else {
            //广告文字
            static NSString *ActiveRuleCellIdentifier = @"ActiveRuleCellIdentifier——model4";
            
            AdActiveRuleCell *acell = (AdActiveRuleCell *)[tableView dequeueReusableCellWithIdentifier:ActiveRuleCellIdentifier];
            if(acell == nil){
                acell = [[AdActiveRuleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ActiveRuleCellIdentifier];
                acell.accessoryType = UITableViewCellAccessoryNone;
                acell.delegate=self;
            }
            [acell setRuleContent:adInfo.activityInfo];
            acell.clipsToBounds = YES;
            return acell;
        }
    }
    else {
        //商品行
        if (self.templateID == 1) {
            //一行一个大图
            static NSString *InnerImageViewCell = @"InnerImageViewCell";
            AdModel4Cell *cell = (AdModel4Cell *)[tableView dequeueReusableCellWithIdentifier:InnerImageViewCell];
            
            if(cell == nil){
                cell = [[AdModel4Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:InnerImageViewCell];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.backgroundColor = [UIColor clearColor];
                cell.imageDidDelegate = self;
            }
            
            HomeProductDTO *productDTO = [tableDataArray safeObjectAtIndex:row];
            InnerProductDTO  *innerDto = [[InnerProductDTO alloc] init];
            innerDto.partNum = productDTO.orderNO;
            innerDto.productId = productDTO.productID;
            innerDto.productName = productDTO.productName;
            innerDto.productCode = productDTO.productCode;
            innerDto.vendorCode = productDTO.providerCode;
            innerDto.bigBang = productDTO.bigBang;
            innerDto.promIcon = productDTO.promIcon;
            innerDto.productDesc = productDTO.productDescription;
            innerDto.priceImageURL = [ProductUtil minPriceImageOfProductId:productDTO.productID productCode:productDTO.productCode city:[Config currentConfig].defaultCity shopCode:productDTO.providerCode];
            
            [cell setItem:innerDto withTag:indexPath.row];
            return cell;
        }
        else if (self.templateID == 2) {
            //一行一个小图
            static NSString *searchResultCellIdentifier = @"SearchResultCellIdentifier";
            
            SolrProductCell *cell = (SolrProductCell *)[tableView dequeueReusableCellWithIdentifier:searchResultCellIdentifier];
            
            if(cell == nil){
                cell = [[SolrProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchResultCellIdentifier];
                
                cell.isShowEvaluation = NO;
                
                cell.accessoryType = UITableViewCellStyleDefault;
                cell.accessoryType = UITableViewCellSeparatorStyleNone;
                cell.backgroundColor = [UIColor whiteColor];
            }
            
            HomeProductDTO *productDTO = [tableDataArray safeObjectAtIndex:row];
            InnerProductDTO  *innerDto = [[InnerProductDTO alloc] init];
            innerDto.partNum = productDTO.orderNO;
            innerDto.productId = productDTO.productID;
            innerDto.productName = productDTO.productName;
            innerDto.productCode = productDTO.productCode;
            innerDto.vendorCode = productDTO.providerCode;
            innerDto.bigBang = productDTO.bigBang;
            innerDto.promIcon = productDTO.promIcon;
            innerDto.productDesc = productDTO.productDescription;
            //最优价格
            innerDto.priceImageURL = [ProductUtil minPriceImageOfProductId:productDTO.productID productCode:productDTO.productCode city:[Config currentConfig].defaultCity shopCode:productDTO.providerCode];
            
            DataProductBasic *dto = [[DataProductBasic alloc] init];
            dto.productId =  innerDto.productId;
            dto.productCode = innerDto.productCode;
            dto.productImageURL = nil;
            dto.productName = innerDto.productName;
            dto.price =[NSNumber numberWithFloat:[innerDto.productPrice floatValue]] ;
            dto.cityCode = [[Config currentConfig] defaultCity];
            dto.special = innerDto.productDesc;
            [cell setItem:dto withDto:innerDto];
            
            TT_RELEASE_SAFELY(dto);
            TT_RELEASE_SAFELY(innerDto);
            return cell;
        }
        else if (self.templateID == 3) {
            //一行两个
            static NSString *adModel3CellIdentifier = @"adModel3CellIdentifier";
            
            AdModel6Cell *cell = (AdModel6Cell *)[tableView dequeueReusableCellWithIdentifier:adModel3CellIdentifier];
            
            if(cell == nil){
                cell = [[AdModel6Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:adModel3CellIdentifier];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.accessoryType = UITableViewCellAccessoryNone;
                
                cell.backgroundColor = [UIColor clearColor];
                
                cell.imageDidDelegate = self;
            }
            
            int row = indexPath.row;
            int count;
            
            InnerProductDTO *leftDto = nil;
            InnerProductDTO *rightDto = nil;
            
            count = [tableDataArray count];
            
            if (row*2 < count) {
                HomeProductDTO *productDTO = [tableDataArray safeObjectAtIndex:row*2];
                leftDto = [[InnerProductDTO alloc] init];
                leftDto.partNum = productDTO.orderNO;
                leftDto.productId = productDTO.productID;
                leftDto.productName = productDTO.productName;
                leftDto.productCode = productDTO.productCode;
                leftDto.vendorCode = productDTO.providerCode;
                leftDto.bigBang = productDTO.bigBang;
                leftDto.promIcon = productDTO.promIcon;
                leftDto.productDesc = productDTO.productDescription;
                //最优价格
                leftDto.priceImageURL = [ProductUtil minPriceImageOfProductId:productDTO.productID productCode:productDTO.productCode city:[Config currentConfig].defaultCity shopCode:productDTO.providerCode];
            }
            
            if (row*2+1 < count) {
                HomeProductDTO *productDTO = [tableDataArray safeObjectAtIndex:row*2+1];
                rightDto = [[InnerProductDTO alloc] init];
                rightDto.partNum = productDTO.orderNO;
                rightDto.productId = productDTO.productID;
                rightDto.productName = productDTO.productName;
                rightDto.productCode = productDTO.productCode;
                rightDto.vendorCode = productDTO.providerCode;
                rightDto.bigBang = productDTO.bigBang;
                rightDto.promIcon = productDTO.promIcon;
                rightDto.productDesc = productDTO.productDescription;
                //最优价格
                rightDto.priceImageURL = [ProductUtil minPriceImageOfProductId:productDTO.productID productCode:productDTO.productCode city:[Config currentConfig].defaultCity shopCode:productDTO.providerCode];
            }
            
            [cell setItem:leftDto rightItem:rightDto withTag:row];
            return cell;
        }
        else {
            //一行3个
            static NSString *adModel3CellIdentifier = @"adModel3CellIdentifier";
            
            AdModel3Cell *cell = (AdModel3Cell *)[tableView dequeueReusableCellWithIdentifier:adModel3CellIdentifier];
            
            if(cell == nil){
                cell = [[AdModel3Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:adModel3CellIdentifier];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.accessoryType = UITableViewCellAccessoryNone;
                
                cell.imageDidDelegate = self;
                
                cell.backgroundColor = [UIColor clearColor];
            }
            
            int row = indexPath.row;
            int count;
            
            InnerProductDTO *leftDto = nil;
            InnerProductDTO *centerDto = nil;
            InnerProductDTO *rightDto = nil;
            
            count = [tableDataArray count];
            
            if (row*3 < count) {
                HomeProductDTO *productDTO = [tableDataArray safeObjectAtIndex:row*3];
                leftDto = [[InnerProductDTO alloc] init];
                leftDto.partNum = productDTO.orderNO;
                leftDto.productId = productDTO.productID;
                leftDto.productName = productDTO.productName;
                leftDto.productCode = productDTO.productCode;
                leftDto.vendorCode = productDTO.providerCode;
                leftDto.bigBang = productDTO.bigBang;
                leftDto.promIcon = productDTO.promIcon;
                leftDto.productDesc = productDTO.productDescription;
                //最优价格
                leftDto.priceImageURL = [ProductUtil minPriceImageOfProductId:productDTO.productID productCode:productDTO.productCode city:[Config currentConfig].defaultCity shopCode:productDTO.providerCode];
            }
            
            if (row*3+1 < count) {
                HomeProductDTO *productDTO = [tableDataArray safeObjectAtIndex:row*3+1];
                centerDto = [[InnerProductDTO alloc] init];
                centerDto.partNum = productDTO.orderNO;
                centerDto.productId = productDTO.productID;
                centerDto.productName = productDTO.productName;
                centerDto.productCode = productDTO.productCode;
                centerDto.vendorCode = productDTO.providerCode;
                centerDto.bigBang = productDTO.bigBang;
                centerDto.promIcon = productDTO.promIcon;
                centerDto.productDesc = productDTO.productDescription;
                //最优价格
                centerDto.priceImageURL = [ProductUtil minPriceImageOfProductId:productDTO.productID productCode:productDTO.productCode city:[Config currentConfig].defaultCity shopCode:productDTO.providerCode];
            }
            
            if (row*3+2 < count) {
                HomeProductDTO *productDTO = [tableDataArray safeObjectAtIndex:row*3+2];
                rightDto = [[InnerProductDTO alloc] init];
                rightDto.partNum = productDTO.orderNO;
                rightDto.productId = productDTO.productID;
                rightDto.productName = productDTO.productName;
                rightDto.productCode = productDTO.productCode;
                rightDto.vendorCode = productDTO.providerCode;
                rightDto.bigBang = productDTO.bigBang;
                rightDto.promIcon = productDTO.promIcon;
                rightDto.productDesc = productDTO.productDescription;
                //最优价格
                rightDto.priceImageURL = [ProductUtil minPriceImageOfProductId:productDTO.productID productCode:productDTO.productCode city:[Config currentConfig].defaultCity shopCode:productDTO.providerCode];
            }
            
            [cell setItem:leftDto centerItem:centerDto rightItem:rightDto withTag:row];
            return cell;
        }
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0)
    {
        //广告图片，行高度为150
        if (indexPath.row == 0) {
            if (hasAdImageView) {
                return 150;
            }
            else {
                return 0;
            }
        }
        else {
            //广告文字，返回动态高度
            if (hasAdDescription) {
                return self.AdActiveRuleCellHeight;
            }
            else {
                return 0;
            }
        }
        
    } else {
        if (self.templateID == 1) {
            return 370;
        }
        else if (self.templateID == 2) {
            return 105;
        }
        else if (self.templateID == 3) {
            //一行两个
            return 190+30;
        }
        else {
            //一行3个
            return 140;
        }
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section >= 1) {
        
        //需要判断模板类型
        if (self.templateID == 1) {
            ;
        }
        else if (self.templateID == 2) {
            
            HomeProductDTO *productDTO = [tableDataArray safeObjectAtIndex:indexPath.row];
            InnerProductDTO  *innerDto = [[InnerProductDTO alloc] init];
            innerDto.partNum = productDTO.orderNO;
            innerDto.productId = productDTO.productID;
            innerDto.productName = productDTO.productName;
            innerDto.productCode = productDTO.productCode;
            innerDto.vendorCode = productDTO.providerCode;
            innerDto.bigBang = productDTO.bigBang;
            innerDto.promIcon = productDTO.promIcon;
            innerDto.productDesc = productDTO.productDescription;
            //最优价格
            innerDto.priceImageURL = [ProductUtil minPriceImageOfProductId:productDTO.productID productCode:productDTO.productCode city:[Config currentConfig].defaultCity shopCode:productDTO.providerCode];
            
            if (innerDto)
            {
                DataProductBasic *basicDTO = innerDto.transformToProductDTO;
                //处理自营商品，商品集、连版专题接口返回的自营商品的供应商编码是10个0，需要修改一下。
                if ([basicDTO.shopCode isEqualToString:@"0000000000"]) {
                    basicDTO.shopCode = @"";
                }
                else if ([basicDTO.shopCode isEqualToString:@""]){
                    basicDTO.shopCode = nil;
                }
                
                ProductDetailViewController *productController = [[ProductDetailViewController  alloc] initWithDataBasicDTO:basicDTO];
                productController.productType = EightBannerProduct;
                [self.navigationController pushViewController:productController animated:YES];
            }
            
        }
        else if (self.templateID == 3) {
            
        }
        else if (self.templateID == 6) {
            
        }
    }
}

- (CGFloat)getRuleHeight{
    TopADInfoDTO *adInfo = _dataDTO.topAD;
    
    if (![AdActiveRuleCell canShowRuleCell:adInfo.activityInfo]) {
        
        return 0;
        
    } else {
        return [AdActiveRuleCell height: adInfo.activityInfo];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)zhuanTiServiceCompleted:(ZhuanTiDTO *)dto isSuccess:(BOOL)isSuccess errorMsg:(NSString *)errMsg {

    if (isSuccess) {
        if (_dataDTO != dto) {
            _dataDTO = dto;
        }
        
        if (self.isFromHead) {
            //下拉刷新
            [self refreshDataComplete];
            
            if (IsArrEmpty(_dataDTO.dataArray)) {
                BBAlertView *alert = [[BBAlertView alloc] initWithTitle:@""
                          message:L(@"AlertVisitedPageInexistence")
                         delegate:self
                cancelButtonTitle:L(@"AlertIKnow")
                otherButtonTitles:nil];
                [alert show];
            }
            else {
                [tableDataArray removeAllObjects];
                [tableDataArray addObjectsFromArray:_dataDTO.dataArray];
                
                //处理广告
                TopADInfoDTO *adInfo = _dataDTO.topAD;
                if (!IsStrEmpty(adInfo.adImg)) {
                    hasAdImageView = YES;
                }
                else {
                    hasAdImageView = NO;
                }
                
                //算出广告文字的高度
                if (!IsStrEmpty(adInfo.activityInfo)) {
                    hasAdDescription = YES;
                    self.AdActiveRuleCellHeight = [AdActiveRuleCell cellHeight:adInfo.activityInfo];
                }
                else {
                    hasAdDescription = NO;
                }
            }
        }
        else {
            //加载更多，增加一页数据
            [self loadMoreDataComplete];
            [tableDataArray addObjectsFromArray:_dataDTO.dataArray];
        }
        
        //处理页面分页
        if (!IsStrEmpty(dto.totalPageNum)) {
            pageTotalCount = [dto.totalPageNum intValue];
        }
        
        if (!IsStrEmpty(dto.subjectName)) {
            self.title = dto.subjectName ? dto.subjectName : @"";
            self.pageTitle = [NSString stringWithFormat:@"%@-%@", L(@"PageTitleProductListPrefix"), dto.subjectName];
        }
        
        //有可能会下拉刷新，所以不需要重复收集页面in的时间
        if (!haveColloctedPageTitle) {
            haveColloctedPageTitle = YES;
            [SSAIOSSNDataCollection multiPagesInCollection:self.pageTitle];
        }

        //处理页面模板类型，缺省条件下一行两个
        switch ([dto.templateID intValue]) {
            case 1:
            case 2:
            case 3:
            case 6: {
                self.templateID = [dto.templateID intValue];
                break;
            }
            default:
                self.templateID = 3;
                break;
        }

        [self.tableView reloadData];
    }
    else {
        if (_whereFrom == SNRouteSourceNone)
        {
            [self presentSheet:errMsg];
        }else{
            BBAlertView *alert = [[BBAlertView alloc] initWithTitle:@""
                                                            message:L(@"AlertVisitedPageInexistence")
                                                           delegate:self
                                                  cancelButtonTitle:L(@"AlertIKnow")
                                                  otherButtonTitles:nil];
            [alert show];
        }
        
    }
}

#pragma mark - BBAlertViewDelegate
- (void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self backForePage];
}


#pragma mark - EGORegreshHeader&FooterDelegate
- (void)refreshData
{
    [super refreshData];
    
    //下拉刷新，重新加载第一页数据
    pageIndex = 1;
    [self.zhuanTiService queryProductListWithModuleID:self.targetModuleID pageNum:pageIndex pageSize:10];
}

- (void)refreshDataComplete{
    [super refreshDataComplete];
}

- (void)loadMoreData {
    [super loadMoreData];
    
    //下拉加载更多
    if (pageIndex >= pageTotalCount) {
        //不弹提示，直接恢复到原来的位置
//        [self presentSheet:@"没有更多商品了"];
        [self loadMoreDataComplete];
    }
    else {
        pageIndex++;
        [self.zhuanTiService queryProductListWithModuleID:self.targetModuleID pageNum:pageIndex pageSize:10];
    }
}

- (void)loadMoreDataComplete {
    [super loadMoreDataComplete];
}


#pragma mark - TopAdImageClickMethod
- (void)jumpToActivity {
    TopADInfoDTO *adInfo = _dataDTO.topAD;
    
    //web管理端暂时不支持配置跳转类型，所以客户端只能默认作为url处理
    [self handleTargetType:@"4" targetURLString:adInfo.targetURL];
}


#pragma mark - Model4Delegate && Model6Delegate && AdModel3Cell
- (void)cellImageDidClicked:(DataProductBasic *)dto {
    
    if (dto == nil) {
        return;
    }
    
    //处理自营商品，商品集、连版专题接口返回的自营商品的供应商编码是10个0，需要修改一下。
    if ([dto.shopCode isEqualToString:@"0000000000"]) {
        dto.shopCode = @"";
    }
    else if ([dto.shopCode isEqualToString:@""]){
        dto.shopCode = nil;
    }
    
    ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithDataBasicDTO:dto];
    controller.productType = EightBannerProduct;
    [self.navigationController pushViewController:controller animated:YES];
    TT_RELEASE_SAFELY(controller);
}


#pragma mark -SolrProductCellDelegate
- (void)solrProductImageDidClicked:(DataProductBasic *)dto {
    
    if (dto == nil) {
        
        return;
    }
    
    //处理自营商品，商品集、连版专题接口返回的自营商品的供应商编码是10个0，需要修改一下。
    if ([dto.shopCode isEqualToString:@"0000000000"]) {
        dto.shopCode = @"";
    }
    else if ([dto.shopCode isEqualToString:@""]){
        dto.shopCode = nil;
    }
    
    ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithDataBasicDTO:dto];
    controller.productType = EightBannerProduct;
    [self.navigationController pushViewController:controller animated:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

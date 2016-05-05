//
//  AdModel2ViewController.m
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "AdModel2ViewController.h"
#import "SolrProductCell.h"
#import "DataProductBasic.h"
#import "ProductUtil.h"

#import "SNWebViewController.h"
#import "ProductDetailViewController.h"

//颜色创建
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface AdModel2ViewController ()

@property (nonatomic, strong) AdModelService *modelService;

-(void)registKVO;
- (void)unRegistKVO;
@end


@implementation AdModel2ViewController

@synthesize advertiseId = advertiseId_;

@synthesize innerProductList = innerProductList_;

@synthesize activeName = activeName_;

@synthesize activeRule = activeRule_;

@synthesize innerProductTableView = innerProductTableView_;

@synthesize modelService = modelService_;

@synthesize AdActiveRuleCellHeight;

-(void)dealloc{
    
    TT_RELEASE_SAFELY(advertiseId_);
    TT_RELEASE_SAFELY(innerProductList_);
    TT_RELEASE_SAFELY(activeName_);
    TT_RELEASE_SAFELY(activeRule_);
    TT_RELEASE_SAFELY(innerProductTableView_);
    SERVICE_RELEASE_SAFELY(modelService_);
    TT_RELEASE_SAFELY(_activeInnerImageUrl);
    TT_RELEASE_SAFELY(_bigBangName);
    
    [self unRegistKVO];
    
}

- (AdModelService *)modelService
{
    if(!modelService_)
    {
        modelService_ = [[AdModelService alloc] init];
        modelService_.delegate = self;
    }
    return modelService_;
}

- (UILabel *)emptyLabel
{
    if (!_emptyLabel)
    {
        _emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 320, 60)];
        _emptyLabel.backgroundColor = [UIColor clearColor];
        _emptyLabel.text = L(@"No_Data_Error");
        _emptyLabel.textColor = [UIColor grayColor];
        _emptyLabel.font = [UIFont boldSystemFontOfSize:20.0];
        _emptyLabel.textAlignment = UITextAlignmentCenter;
        _emptyLabel.numberOfLines = 0;
    }
    return _emptyLabel;
}


- (id)initWithAdvertiseId:(NSString*)advertiseId{
    
    self = [super init];
    
    if (self) {
        
        self.title = @"";
        advertiseId_ = advertiseId;
        self.hidesBottomBarWhenPushed = YES;
    }
    
    return self;
}

#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
    //    self.view.backgroundColor = [UIColor clearColor];
    self.title = self.activeName;
    
    self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"sale_eightPage"),self.title];
    
    
    self.innerProductTableView.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    
    UIView *footerView = [[UIView alloc] init];
    
    self.innerProductTableView.tableFooterView = footerView;
    
    TT_RELEASE_SAFELY(footerView);
    
    [self.view addSubview:self.innerProductTableView];
    
    self.AdActiveRuleCellHeight = [AdActiveRuleCell cellHeight:self.activeRule];
    [self registKVO];
    
    self.hasSuspendButton = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    if (!_isHaveLoaded)
    {
        [self refreshData];
    }
}

#pragma mark -
#pragma mark TabelView Methods

-(UITableView *)innerProductTableView{
    
    if (!innerProductTableView_) {
        
        innerProductTableView_ = [[UITableView alloc] initWithFrame: CGRectZero style:UITableViewStylePlain];
        
        innerProductTableView_.delegate = self;
        
        innerProductTableView_.dataSource = self;
        
        innerProductTableView_.userInteractionEnabled = YES;
        
        innerProductTableView_.indicatorStyle = UIScrollViewIndicatorStyleDefault;
        
        innerProductTableView_.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        //        innerProductTableView_.separatorColor = [UIColor redColor];// RGBCOLOR(222, 216, 190);//[UIColor grayColor];
        
        innerProductTableView_.backgroundColor = [UIColor clearColor];// RGBCOLOR(239, 234, 218);
    }
    
    return innerProductTableView_;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        if(IsStrEmpty(self.activeInnerImageUrl)){
            return 0;
        }else{
            return 150;
        }
    }else if (indexPath.section == 1) {
        if ([self getRuleHeight] == 0) {
            return 0;
            
        }else{
            
            return  self.AdActiveRuleCellHeight;
            
        }
        
    }else{
        
        return 105;
    }
}

- (CGFloat)getRuleHeight{
    CGFloat returnValue = 0;
    if ([AdActiveRuleCell canShowRuleCell:self.activeRule])
    {
        returnValue = [AdActiveRuleCell height: self.activeRule];
    }
    return returnValue;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (IsArrEmpty(self.serviceProductArr)) {
        return 3;
    }
    else{
        return [self.innerProductList count] + 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        if(IsStrEmpty(self.activeInnerImageUrl)){
            return 0;
        }else{
            return 1;
        }
    }else if (section == 1) {
        return 1;
    }else{
        if (IsArrEmpty(self.serviceProductArr)) {
            return [self.innerProductList count];
        }
        else{
            InnerProductBaseDTO *dto = [self.innerProductList objectAtIndex:(section-2)];
            NSArray *array = [dto innerProduct];
            return [array count];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    else if (section == 1)
    {
        return 0;
    }
    else{
        
        if (IsArrEmpty(self.serviceProductArr)) {
            return 0;
        }
        else{
            if(self.innerProductList.count == 0)
            {
                return 0;
            }else{
                
                InnerProductBaseDTO *dto = [self.innerProductList objectAtIndex:(section-2)];
                
                NSArray *array = [dto innerProduct];
                
                if (IsArrEmpty(array)) {
                    return 0;
                }
                else{
                    return 30;
                }
                
            }
            
        }
        
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return nil;
    }
    else if (section == 1)
    {
        return nil;
    }
    else{
        if (IsArrEmpty(self.serviceProductArr)) {
            return nil;
        }
        else{
            if(self.innerProductList.count == 0)
            {
                return nil;
            }else{
                
                InnerProductBaseDTO *dto = [self.innerProductList objectAtIndex:(section-2)];
                
                NSArray *array = [dto innerProduct];
                
                if (IsArrEmpty(array)){
                    return nil;
                }
                else{
                    UIView *headView = [[UIView alloc] init];
                    headView.frame = CGRectMake(0, 0, 320, 30);
                    headView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];//[UIColor colorWithHexString:@"#F2F2F2"];//RGBCOLOR(240, 235, 221);
                    
                    UILabel *flooNameLabel = [[UILabel alloc] init];
                    flooNameLabel.frame = CGRectMake(15, 0, 305, 30);
                    flooNameLabel.font = [UIFont boldSystemFontOfSize:16.0];
                    flooNameLabel.backgroundColor = [UIColor clearColor];
                    flooNameLabel.textColor = RGBCOLOR(93, 93, 93);
                    flooNameLabel.textAlignment = UITextAlignmentLeft;
                    flooNameLabel.text = [NSString stringWithFormat:@"%@",[[self.innerProductList objectAtIndex:(section - 2)] floorName]];
                    
                    [headView addSubview:flooNameLabel];
                    
                    return headView;
                }
                
            }
            
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    else if(section == 1)
    {
        return 1;
        
    }else{
        return 0;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    else if(section == 1)
    {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        
        //        line.image = [UIImage imageNamed:@"cellSeparatorLine.png"];
        
        lineView.backgroundColor = [UIColor colorWithHexString:@"#E0E0E0"];
        
        [lineView addSubview:line];
        
        return lineView;
        
    }
    else
    {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        
        if(IsStrEmpty(self.activeInnerImageUrl))
        {
            return nil;
            
        }else{
            
            static NSString *innerImageViewIdentifier = @"innerImageViewIdentifier";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:innerImageViewIdentifier];
            
            if(cell == nil){
                
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:innerImageViewIdentifier];
                
                cell.accessoryType = UITableViewCellStyleDefault;
                cell.accessoryType = UITableViewCellSeparatorStyleNone;
            }
            
            
            EGOImageButton *innerImageView = [[EGOImageButton alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
            
            [innerImageView setImageURL:[NSURL URLWithString:self.activeInnerImageUrl]];
            
            [innerImageView addTarget:self action:@selector(jumpToActivity) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:innerImageView];
            
            //            TT_RELEASE_SAFELY(innerImageView);
            //            cell.backgroundColor = [UIColor blackColor];
            return cell ;
        }
        
    }else if (indexPath.section == 1) {
        
        if ([self getRuleHeight]==0) {
            
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            
            return cell;
        }
        
        static NSString *ActiveRuleCellIdentifier = @"ActiveRuleCellIdentifier——model2";
        
        AdActiveRuleCell *acell = (AdActiveRuleCell *)[tableView dequeueReusableCellWithIdentifier:ActiveRuleCellIdentifier];
        
        
        if(acell == nil){
            
            acell = [[AdActiveRuleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ActiveRuleCellIdentifier];
            
            acell.accessoryType = UITableViewCellStyleDefault;
            acell.accessoryType = UITableViewCellSeparatorStyleNone;
            acell.delegate=self;
        }
        
        [acell setRuleContent:self.activeRule];
        
        //        acell.backgroundColor = [UIColor redColor];
        return acell;
        
    }else{
        
        
        static NSString *searchResultCellIdentifier = @"SearchResultCellIdentifier";
        
        SolrProductCell *cell = (SolrProductCell *)[tableView dequeueReusableCellWithIdentifier:searchResultCellIdentifier];
        
        if(cell == nil){
            
            cell = [[SolrProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchResultCellIdentifier];
            
            cell.isShowEvaluation = NO;
            
            cell.accessoryType = UITableViewCellStyleDefault;
            cell.accessoryType = UITableViewCellSeparatorStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            
        }
        
        DataProductBasic *dto = [[DataProductBasic alloc] init];
        
        InnerProductDTO *innerDto;
        
        if (IsArrEmpty(self.serviceProductArr)) {
            innerDto = (InnerProductDTO*)[self.innerProductList objectAtIndex:indexPath.row];
        }
        else
        {
            InnerProductBaseDTO *Dto = (InnerProductBaseDTO *)[self.innerProductList objectAtIndex:(indexPath.section-2)];
            
            innerDto = [Dto.innerProduct objectAtIndex:indexPath.row];
        }
        
        
        
        if (![innerDto isKindOfClass:[NSNull class]]) {
            
            dto.productId =  innerDto.productId;
            dto.productCode = innerDto.productCode;
            dto.productImageURL = nil;//[NSURL URLWithString:innerDto.productImageURL];
            if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
                
                dto.productImageURL = [ProductUtil getImageUrlWithProductCode:innerDto.productCode size:ProductImageSize160x160];
            }
            else{
                
                dto.productImageURL = [ProductUtil getImageUrlWithProductCode:innerDto.productCode size:ProductImageSize100x100];
            }
            dto.productName = innerDto.productName;
            dto.price =[NSNumber numberWithFloat:[innerDto.productPrice floatValue]] ;
            dto.cityCode = [[Config currentConfig] defaultCity];
            dto.special = innerDto.productDesc;
            
            //#warning bigbang待完成
            
            //            self.bigbangNameLabel.text = innerDto.bigBang;//@"热销";
            //
            //
            //
            //            [self.salesSmallImage insertSubview:self.bigbangNameLabel aboveSubview:self.salesSmallImage];
            //
            //            if ([innerDto.bigBang isEqualToString:@""]) {
            //                self.salesSmallImage.hidden = YES;
            //            }
            //            else
            //            {
            //                self.salesSmallImage.hidden = NO;
            //                [self.salesSmallImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"sales_small.png"]]];
            //            }
            //
            //
            //            [cell.contentView insertSubview:self.salesSmallImage aboveSubview:cell.contentView];
            
            [cell setItem:dto withDto:innerDto];
            
        }else{
            
            TT_RELEASE_SAFELY(dto);
            
            return nil;
            
        }
        
        TT_RELEASE_SAFELY(dto);
        
        return cell;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section >= 2) {
        
        InnerProductDTO *innerDto;
        
        if (IsArrEmpty(self.serviceProductArr)) {
            innerDto = [self.innerProductList objectAtIndex:indexPath.row];
        }
        else
        {
            InnerProductBaseDTO *evaDto = (InnerProductBaseDTO *)[self.innerProductList objectAtIndex:(indexPath.section - 2)];
            
            NSArray *array = evaDto.innerProduct;
            innerDto = (InnerProductDTO *)[array objectAtIndex:indexPath.row];
        }
        
        if (innerDto)
        {
            ProductDetailViewController *productController = [[ProductDetailViewController  alloc] initWithDataBasicDTO:innerDto.transformToProductDTO];
            productController.productType = EightBannerProduct;
            [self.navigationController pushViewController:productController animated:YES];
            
            
        }
    }else{
        
        return ;
    }
}

- (void)jumpToActivity
{
    NSString *url = self.modelService.dto.innerImageWebURL;
    if (url.length)
    {
        SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeAdModel attributes:@{@"url": url}];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
        [self innerProductTableViewReloadData];
    }
}

#pragma mark - Delegate Method
-(void)setAdRowHeight:(CGFloat)height
{
    self.AdActiveRuleCellHeight = height;
}

- (BOOL)isInnerDataEmpty
{
    
    BOOL isEmpty = YES;
    for (InnerProductBaseDTO *dto in self.innerProductList) {
        NSArray *array = [dto innerProduct];
        if (!IsArrEmpty(array)) {
            isEmpty = NO;
            break;
        }
    }
    return isEmpty;
}

- (void)innerProductTableViewReloadData{
    [self.innerProductTableView reloadData];
    
    if (_isHaveLoaded) {
        if (IsArrEmpty(self.serviceProductArr)) {
            if (IsArrEmpty(self.innerProductList)) {
                self.innerProductTableView.tableFooterView =self.emptyLabel;
            }
        }
        else
        {
            if ([self isInnerDataEmpty] == YES)
            {
                self.innerProductTableView.tableFooterView =self.emptyLabel;
            }
        }
    }
}

#pragma mark ----------------------------- refresh

- (void)refreshData
{
    [self displayOverFlowActivityView];
    [self.modelService requestModelListWithAdId:self.advertiseId];
}

- (void)service:(AdModelService *)service getAdModelListComplete:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    
    if (isSuccess)
    {
        [self.view hideNetworkErrorView];
        
        self.serviceProductArr = service.innerProductBaseList;
        _isHaveLoaded = YES;
        if (IsArrEmpty(service.innerProductBaseList)) {
            self.innerProductList = service.innerProductList;
        }
        else{
            self.innerProductList = service.innerProductBaseList;
        }
        
        [self innerProductTableViewReloadData];
    }
    else
    {
        //        [self presentSheet:service.errorMsg];
        
        __weak AdModel2ViewController *weakSelf = self;
        [self.view showNetworkErrorViewWithRefreshBlock:^{
            
            [weakSelf refreshData];
        }];
    }
}

@end

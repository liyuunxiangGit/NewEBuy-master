//
//  AdModel4ViewController.m
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "AdModel4ViewController.h"
#import "DataProductBasic.h"
#import "InnerAdDTO.h"
#import "AdModel4InnerImageCell.h"

#import "SNWebViewController.h"
#import "ProductDetailViewController.h"

@interface AdModel4ViewController () 

@property (nonatomic, strong) AdModelService *modelService;

-(void)registKVO;
- (void)unRegistKVO;
@end


@implementation AdModel4ViewController

@synthesize advertiseId = advertiseId_;
@synthesize innerProductList = innerProductList_;
@synthesize innerAdList = innerAdList_;
@synthesize activeName = activeName_;
@synthesize activeRule = activeRule_;
@synthesize innerProductTableView = innerProductTableView_; 
@synthesize innerAdImageView = innerAdImageView_;
@synthesize modelService = modelServic_;
@synthesize AdActiveRuleCellHeight;

-(void)dealloc{
    
    TT_RELEASE_SAFELY(advertiseId_);
    TT_RELEASE_SAFELY(innerProductList_);
    TT_RELEASE_SAFELY(innerAdList_)
    TT_RELEASE_SAFELY(activeName_);
    TT_RELEASE_SAFELY(activeRule_);
    TT_RELEASE_SAFELY(innerProductTableView_);
    TT_RELEASE_SAFELY(innerAdImageView_);
    SERVICE_RELEASE_SAFELY(modelServic_);
    TT_RELEASE_SAFELY(_activeInnerImageUrl);
    
    [self unRegistKVO];
    
}

- (id)initWithAdvertiseId:(NSString*)advertiseId{
    
    self = [super init];
    
    if (self) {
        
        self.title = @"";
        advertiseId_ = advertiseId;
        setionCount = 3;
        self.hidesBottomBarWhenPushed = YES;
        
    }
    
    return self;
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


-(EGOImageViewEx *)innerAdImageView{

    if (!innerAdImageView_) {
        
        innerAdImageView_ = [[EGOImageViewEx alloc] init];
        innerAdImageView_.backgroundColor = [UIColor whiteColor];
        
    }

    return innerAdImageView_;
}

- (AdModelService *)modelService
{
    if(!modelServic_)
    {
        modelServic_ = [[AdModelService alloc] init];
        modelServic_.delegate = self;
    }
    return modelServic_;
}


#pragma mark -
#pragma mark AdModelServiceDelegate

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
//        self.innerProductList = service.innerProductBaseList;
        if (IsArrEmpty(service.innerProductBaseList)) {
            self.innerProductList = service.innerProductList;
        }
        else{
            self.innerProductList = service.innerProductBaseList;
        }
        
        self.innerAdList = service.innerAdvertiseList;
        [self innerProductTableViewReloadData];
    }
    else
    {
//        [self presentSheet:service.errorMsg];
        __weak AdModel4ViewController *weakSelf = self;
        [self.view showNetworkErrorViewWithRefreshBlock:^{
            
            [weakSelf refreshData];
        }];
    }
}

#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
    
    self.title = self.activeName;

    self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"sale_eightPage"),self.title];

    self.innerProductTableView.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    
    [self.view addSubview:self.innerProductTableView];
    
    self.AdActiveRuleCellHeight = [AdActiveRuleCell cellHeight:self.activeRule];
    
    [self registKVO];
    
    self.hasSuspendButton = YES;
}

- (void)viewWillAppear:(BOOL)animated
{    
    [super viewWillAppear:YES];
    
    if (!_isHaveLoaded)
    {
        [self refreshData];
    }
}

#pragma mark - 
#pragma mark TabelView Methods

- (UITableView *)innerProductTableView
{    
    if (!innerProductTableView_) {
        
        innerProductTableView_ = [[UITableView alloc] initWithFrame: CGRectZero style:UITableViewStylePlain];
        
        innerProductTableView_.delegate = self;
        
        innerProductTableView_.dataSource = self;
        
        innerProductTableView_.userInteractionEnabled = YES;
        
        innerProductTableView_.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        innerProductTableView_.backgroundColor = [UIColor clearColor];// RGBCOLOR(239, 234, 218);
        
        innerProductTableView_.separatorStyle =UITableViewCellSeparatorStyleNone;
        
//        innerProductTableView_.separatorColor = RGBCOLOR(222, 216, 190);
        
        UIView *footerView = [[UIView alloc] init];
        
        innerProductTableView_.tableFooterView = footerView;
        
        TT_RELEASE_SAFELY(footerView);
        
    }
    
    return innerProductTableView_;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0)
    {
        if(IsStrEmpty(self.activeInnerImageUrl))
        {
            return 0;
            
        }else{
            
            return 150;
            
        }

    }else if (indexPath.section == 1) {
        
        if ([self getRuleHeight] == 0) {
            
            return 0;
            
        }else{
           
            return self.AdActiveRuleCellHeight;
            
        }

    }
    else {
        
        return 370;

    } 
    
    return 0;
    
}

- (CGFloat)getRuleHeight{
    
    if (![AdActiveRuleCell canShowRuleCell:self.activeRule]) {
        
        return 0;
        
    }else{

        return   [AdActiveRuleCell height: self.activeRule];
    }
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   
    if (IsArrEmpty(self.serviceProductArr)) {
        return 3;
    }
    else{
        return [self.innerProductList count] + 2;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        if(IsStrEmpty(self.activeInnerImageUrl))
        {
            return 0;
            
        }else{
            
            return 1;
            
        }
    }
    else if (section == 1)
    {
        if ([self getRuleHeight] == 0) {
            
            return 0;
            
        }else{
            
            return 1;
        }

    }
    else
    {
        
        if (IsArrEmpty(self.serviceProductArr)) {
            return [self.innerProductList count];
        }
        else
        {
            InnerProductBaseDTO *dto = [self.innerProductList objectAtIndex:(section-2)];
            
            NSArray *array = [dto innerProduct];
            
            return [array count];
            
        }

    }

}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return 0;
//    }
//    else if(section == 1)
//    {
//        return 0;
//        
//    }else{
//        if (IsArrEmpty(self.serviceProductArr)) {
//            if (IsArrEmpty(self.innerProductList)) {
//                return 100;
//            }
//            else{
//                return 0;
//            }
//        }
//        else
//        {
//            if ([self isInnerDataEmpty] == YES)
//            {
//                return 100;
//            }
//            else
//            {
//                return 0;
//            }
//        }
//    }
//}

//- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return nil;
//    }
//    else if(section == 1)
//    {
//        return nil;
//    }
//    else
//    {
//        if (IsArrEmpty(self.serviceProductArr)) {
//            if (IsArrEmpty(self.innerProductList)) {
//                return self.emptyLabel;
//            }
//            else{
//                return nil;
//            }
//        }
//        else
//        {
//            if ([self isInnerDataEmpty] == YES)
//            {
//                return self.emptyLabel;
//            }
//            else
//            {
//                return nil;
//            }
//        }
//    }
//}

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
        
        //line.image = [UIImage imageNamed:@"cellSeparatorLine.png"];
        
        lineView.backgroundColor = [UIColor colorWithHexString:@"#E0E0E0"];
        
        [lineView addSubview:line];
        
        return lineView;
        
    }
    else
    {
        return nil;
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
        if(self.innerProductList.count == 0)
        {
            return nil;
        }else{
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
                        headView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];//RGBCOLOR(240, 235, 221);
                        
                        UILabel *flooNameLabel = [[UILabel alloc] init];
                        flooNameLabel.frame = CGRectMake(15, 8, 305, 20);
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
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0){
            
            if(IsStrEmpty(self.activeInnerImageUrl))
            {
                return nil;
                
            }else{
                
                static NSString *innerImageViewIdentifier = @"innerImageViewIdentifier";
                
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:innerImageViewIdentifier];
                
                if(cell == nil){
                    
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:innerImageViewIdentifier];
                    
                    cell.accessoryType = UITableViewCellStyleDefault;
                }
                
                
                EGOImageButton *innerImageView = [[EGOImageButton alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
                
                [innerImageView setImageURL:[NSURL URLWithString:self.activeInnerImageUrl]];
                [innerImageView addTarget:self action:@selector(jumpToActivity) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:innerImageView];
                
//                TT_RELEASE_SAFELY(innerImageView);
                
                return cell ;
            }

        }
        
            
    else if (indexPath.section == 1){
            
        static NSString *ActiveRuleCellIdentifier = @"ActiveRuleCellIdentifier——model4";
            
        AdActiveRuleCell *acell = (AdActiveRuleCell *)[tableView dequeueReusableCellWithIdentifier:ActiveRuleCellIdentifier];
        
            
        if(acell == nil){
                
            acell = [[AdActiveRuleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ActiveRuleCellIdentifier];
                
            acell.accessoryType = UITableViewCellAccessoryNone;
            acell.delegate=self;
        }
            
            
        [acell setRuleContent:self.activeRule];

        return acell;

//            static NSString *InnerImageViewCell = @"InnerImageViewCell";
//            
//            AdModel4InnerImageCell *acell = (AdModel4InnerImageCell *)[tableView dequeueReusableCellWithIdentifier:InnerImageViewCell];
//            
//            if(acell == nil){
//                
//                acell = [[[AdModel4InnerImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:InnerImageViewCell] autorelease];
//                
//                acell.accessoryType = UITableViewCellAccessoryNone;
//            }
//            
//            InnerAdDTO *imageDto = [self.innerAdList objectAtIndex:indexPath.row];
//            
//            [acell setInnerAdImageURL:[NSURL URLWithString:imageDto.productImageURL]];
//            
//            return acell;
            
            
        }

        else
        {
            
            static NSString *InnerImageViewCell = @"InnerImageViewCell";
            
            AdModel4Cell *cell = (AdModel4Cell *)[tableView dequeueReusableCellWithIdentifier:InnerImageViewCell];
            
            if(cell == nil){
                
                cell = [[AdModel4Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:InnerImageViewCell];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.accessoryType = UITableViewCellAccessoryNone;
                
                cell.backgroundColor = [UIColor clearColor];
                
                cell.imageDidDelegate = self;
                
            }
            
            InnerProductDTO  *innerDto;
            
            if (IsArrEmpty(self.serviceProductArr)) {
                innerDto = [self.innerProductList objectAtIndex:indexPath.row];
            }
            else
            {
                InnerProductBaseDTO *Dto = (InnerProductBaseDTO *)[self.innerProductList objectAtIndex:(indexPath.section-2)];
                
                innerDto = [Dto.innerProduct objectAtIndex:indexPath.row];
            }
            
            [cell setItem:innerDto withTag:indexPath.row];
            
            return cell;
        }
    
//
//            if ([self getRuleHeight]==0) {
//                
//                UITableViewCell *cell = [[[UITableViewCell alloc] init] autorelease];
//                
//                return cell;
//            }
//            
//            static NSString *ActiveRuleCellIdentifier = @"ActiveRuleCellIdentifier";
//            
//            AdActiveRuleCell *acell = (AdActiveRuleCell *)[tableView dequeueReusableCellWithIdentifier:ActiveRuleCellIdentifier];
//            acell.delegate=self;
//            
//            if(acell == nil){
//                
//                acell = [[[AdActiveRuleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ActiveRuleCellIdentifier] autorelease];
//                
//                acell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            }
//            
//            [acell setRuleContent:self.activeRule];
//            
//            return acell;
//            
      
    
 /*   switch (indexPath.section) {
        case 0:{
  
            static NSString *InnerImageViewCell = @"InnerImageViewCell";
            
            AdModel4InnerImageCell *acell = (AdModel4InnerImageCell *)[tableView dequeueReusableCellWithIdentifier:InnerImageViewCell];
            
            if(acell == nil){
                
                acell = [[[AdModel4InnerImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:InnerImageViewCell] autorelease];
                
                acell.accessoryType = UITableViewCellAccessoryNone;
            }
            
            InnerAdDTO *imageDto = [self.innerAdList objectAtIndex:indexPath.row];
            
            [acell setInnerAdImageURL:[NSURL URLWithString:imageDto.productImageURL]];
                        
            return acell;
            
        
        }
            break;
            
        case 1:{
                        
            if ([self getRuleHeight]==0) {
                
                UITableViewCell *cell = [[[UITableViewCell alloc] init] autorelease];
                
                return cell;
            }
            
            static NSString *ActiveRuleCellIdentifier = @"ActiveRuleCellIdentifier";
            
            AdActiveRuleCell *acell = (AdActiveRuleCell *)[tableView dequeueReusableCellWithIdentifier:ActiveRuleCellIdentifier];
            acell.delegate=self;

            if(acell == nil){
                
                acell = [[[AdActiveRuleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ActiveRuleCellIdentifier] autorelease];
                
                acell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            
            [acell setRuleContent:self.activeRule];
            
            return acell;
        
        }
            break;
            
         default:{
            
            static NSString *adModel3CellIdentifier = @"adModel3CellIdentifier";
            
            AdModel3Cell *cell = (AdModel3Cell *)[tableView dequeueReusableCellWithIdentifier:adModel3CellIdentifier];
            
            if(cell == nil){
                
                cell = [[[AdModel3Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:adModel3CellIdentifier] autorelease];
                                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.accessoryType = UITableViewCellAccessoryNone;
                
                cell.imageDidDelegate = self;
            }
            
             int row = indexPath.row;
             
             int count = [self.innerProductList count];
             InnerProductDTO *leftDto = nil;
             InnerProductDTO *centerDto = nil;
             InnerProductDTO *rightDto = nil;
             
             if (row*3 < count) {
                 leftDto = [self.innerProductList objectAtIndex:row*3];
             }
             
             if (row*3+1 < count) {
                 centerDto = [self.innerProductList objectAtIndex:row*3+1];
             }
             
             if (row*3+2 < count) {
                 rightDto = [self.innerProductList objectAtIndex:row*3+2];
             }
             
             [cell setItem:leftDto centerItem:centerDto rightItem:rightDto withTag:row];

            return cell;    
             
             break;
        }    
    }*/
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

- (void)cellImageDidClicked:(DataProductBasic *)dto{

    DLog(@"here clicked");
    
    if (dto == nil) {
        
        return;
    }
    
    ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithDataBasicDTO:dto];
    controller.productType = EightBannerProduct;
    [self.navigationController pushViewController:controller animated:YES];
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
//    InnerProductBaseDTO *Dto = (InnerProductBaseDTO *)[self.innerProductList objectAtIndex:(indexPath.section-2)];
//    
//    innerDto = [Dto.innerProduct objectAtIndex:indexPath.row];

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

@end

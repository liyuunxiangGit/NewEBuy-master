//
//  AdModel3ViewController.m
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "AdModel3ViewController.h"
#import "DataProductBasic.h"

#import "SNWebViewController.h"
#import "ProductDetailViewController.h"

@interface AdModel3ViewController ()

@property (nonatomic, strong) AdModelService *modelService;

-(void)registKVO;
- (void)unRegistKVO;

@end


@implementation AdModel3ViewController

@synthesize advertiseId = _advertiseId;
@synthesize innerProductList = _innerProductList;
@synthesize activeName = _activeName;
@synthesize activeRule = _activeRule;
@synthesize innerProductTableView = _innerProductTableView;
@synthesize modelService = _modelService;
@synthesize AdActiveRuleCellHeight;

-(void)dealloc
{
    TT_RELEASE_SAFELY(_advertiseId);
    TT_RELEASE_SAFELY(_innerProductList);
    TT_RELEASE_SAFELY(_activeName);
    TT_RELEASE_SAFELY(_activeRule);
    TT_RELEASE_SAFELY(_innerProductTableView);
    SERVICE_RELEASE_SAFELY(_modelService);
    TT_RELEASE_SAFELY(_activeInnerImageUrl);

    [self unRegistKVO];
}

- (AdModelService *)modelService
{
    if(!_modelService)
    {
        _modelService = [[AdModelService alloc] init];
        _modelService.delegate = self;
    }
    return _modelService;
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

- (id)initWithAdvertiseId:(NSString*)advertiseId
{
    self = [super init];
    
    if (self) {
        
        self.title = @"";
        _advertiseId = advertiseId;
        self.hidesBottomBarWhenPushed = YES;
        
        [self registKVO];
    }
    return self;
}

#pragma mark -
#pragma mark AdModelServiceServiceDelegate

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
//        [self.innerProductTableView reloadData];
        [self innerProductTableViewReloadData];
    }
    else
    {
//        [self presentSheet:service.errorMsg];
        __weak AdModel3ViewController *weakSelf = self;
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
    
    self.AdActiveRuleCellHeight = [AdActiveRuleCell cellHeight: self.activeRule];
    
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
- (UITableView *)innerProductTableView{
    
    if (!_innerProductTableView) {
        
        _innerProductTableView = [[UITableView alloc] initWithFrame: CGRectZero style:UITableViewStylePlain];
        
        _innerProductTableView.delegate = self;
        
        _innerProductTableView.dataSource = self;
        
        _innerProductTableView.userInteractionEnabled = YES;
        
        _innerProductTableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        
        _innerProductTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
//        _innerProductTableView.separatorColor = RGBCOLOR(243,204,222);
        
        UIView *footerView = [[UIView alloc] init];
        
        _innerProductTableView.tableFooterView = footerView;
        
//        _innerProductTableView.backgroundColor = RGBCOLOR(239, 234, 218);
        _innerProductTableView.backgroundColor = [UIColor clearColor];
        
        TT_RELEASE_SAFELY(footerView);
        
    }
    
    return _innerProductTableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
            
//            CGFloat height = [self getRuleHeight]+30;
//            
//            DLog(@"height is : %f", height);
//            
//            return height;
            return self.AdActiveRuleCellHeight;
        }
        
    }else{
        
        return 140;
        
    }
}

- (CGFloat)getRuleHeight{
    
    if (![AdActiveRuleCell canShowRuleCell:self.activeRule]) {
        
        return 0;
        
    }else{
        
        return   [AdActiveRuleCell height: self.activeRule];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
//    return [self.innerProductList count] + 2;
    if (IsArrEmpty(self.serviceProductArr)) {
        return 3;
    }
    else{
        return [self.innerProductList count] + 2;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section==0)
    {
        if(IsStrEmpty(self.activeInnerImageUrl))
        {
            return 0;
        }else{
            
            return 1;
            
        }
        
    }else if (section == 1) {
        
        if ([self getRuleHeight] == 0) {
            
            return 0;
            
        }else{
            
            return 1;
        }
        
    }else{
        
        if (IsArrEmpty(self.serviceProductArr)) {
            NSUInteger count = [self.innerProductList count];
            
            return (count%3==0) ? count/3 : count/3+1;
        }
        else
        {
            InnerProductBaseDTO *dto = [self.innerProductList objectAtIndex:(section-2)];
            
            NSArray *array = [dto innerProduct];
            
            NSUInteger count = [array count];
            
            return (count%3==0) ? count/3 : count/3+1;
        }
        
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
            }
            
            
            EGOImageButton *innerImageView = [[EGOImageButton alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
            
            [innerImageView setImageURL:[NSURL URLWithString:self.activeInnerImageUrl]];
            [innerImageView addTarget:self action:@selector(jumpToActivity) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:innerImageView];
            
//            TT_RELEASE_SAFELY(innerImageView);
            
            return cell ;
        }
        
    }else if (indexPath.section == 1) {
        
        if ([self getRuleHeight]==0) {
            
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            
            return cell;
        }
        
        static NSString *ActiveRuleCellIdentifier = @"ActiveRuleCellIdentifier——model3";
        
        AdActiveRuleCell *acell = (AdActiveRuleCell *)[tableView dequeueReusableCellWithIdentifier:ActiveRuleCellIdentifier];
        
        
        if(acell == nil){
            
            acell = [[AdActiveRuleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ActiveRuleCellIdentifier];
            
            acell.accessoryType = UITableViewCellAccessoryNone;
            acell.delegate=self;
        }
        
        [acell setRuleContent:self.activeRule];
        
        return acell;
        
    }else{
        
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
        
        if (IsArrEmpty(self.serviceProductArr)) {
            count = [self.innerProductList count];
            
            if (row*3 < count) {
                leftDto = [self.innerProductList objectAtIndex:row*3];
            }
            
            if (row*3+1 < count) {
                centerDto = [self.innerProductList objectAtIndex:row*3+1];
            }
            
            if (row*3+2 < count) {
                rightDto = [self.innerProductList objectAtIndex:row*3+2];
            }
        }
        else
        {
            InnerProductBaseDTO *Dto = (InnerProductBaseDTO *)[self.innerProductList objectAtIndex:(indexPath.section-2)];
            
            NSArray *array = [Dto innerProduct];
            
            count = [array count];
            
            if (row*3 < count) {
                leftDto = [array objectAtIndex:row*3];
            }
            
            if (row*3+1 < count) {
                centerDto = [array objectAtIndex:row*3+1];
            }
            
            if (row*3+2 < count) {
                rightDto = [array objectAtIndex:row*3+2];
            }
        }

        [cell setItem:leftDto centerItem:centerDto rightItem:rightDto withTag:row];
        return cell;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    else if (section == 1)
    {
        return 0;
    }
    else{
        
        if(self.innerProductList.count == 0)
        {
            return 0;
        }else{
            
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
//                    headView.backgroundColor = RGBCOLOR(240, 235, 221);
                    headView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];//[UIColor colorWithHexString:@"#F2F2F2"];
                    
                    UILabel *flooNameLabel = [[UILabel alloc] init];
                    flooNameLabel.frame = CGRectMake(15, 8, 305, 20);
                    flooNameLabel.font = [UIFont boldSystemFontOfSize:14.0];
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

- (void)cellImageDidClicked:(DataProductBasic *)dto
{
    DLog(@"here clicked");
    
    ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithDataBasicDTO:dto];
    controller.productType = EightBannerProduct;
    [self.navigationController pushViewController:controller animated:YES];
    
    TT_RELEASE_SAFELY(controller);
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
//        [self.innerProductTableView reloadData];
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
@end

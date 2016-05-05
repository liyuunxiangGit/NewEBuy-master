//
//  CategoryViewController.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-4-10.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryItemCell.h"
#import "ProductCategoryDTO.h"
#import "SecondCategoryViewController.h"
#import "VirtualProductViewController.h"
#import "SecondCategoryCell.h"
#import "V2FristCategoryDTO.h"
#import "SearchParamDTO.h"
#import "SearchListViewController.h"
#import "FilterRootViewController.h"
#import "JASidePanelController.h"
#import "FilterNavigationController.h"
@interface CategoryViewController ()


-(void)secondCategoryOpenOperate:(NSInteger)cellRow;

//2级分类一共可以分几行
-(NSInteger)secNums:(NSInteger)row;
@end

@implementation CategoryViewController
@synthesize cateService = _cateService;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (id)init{
	
    self = [super init];
	
    if (self) {
		self.isNeedBackItem = NO;
        self.title = L(@"CTSelectClassification");
        
        self.pageTitle = L(@"show_firstCategory");
        
        iOpenCell = -1;
        
        self.iOS7FullScreenLayout = YES;
    }
    return self;
}

#pragma mark ========================

- (void)dealloc {
	
    _cateService.delegate = nil;
    TT_RELEASE_SAFELY(_cateService);

}


-(void)viewWillDisappear:(BOOL)animated{
	
	[super viewWillDisappear:animated];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    if (!self.cateService.isCategoryLoaded) {
        
        [self displayOverFlowActivityView:kCategoryStatusMessageStartHttp];
        
        [self.cateService sendCategoryRequest:kCategoryEnmuElec];
        
    }
    
}

- (void)loadView {
	
	[super loadView];
    
	self.tableView.frame = [self visibleBoundsShowNav:YES showTabBar:YES];
    [self.tableView setExclusiveTouch:YES];
	[self.view addSubview:self.tableView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark -
#pragma mark Data Service DelegateMethods

- (void)service:(CategoryService *)service loadCateComplete:(BOOL)isSuccess
{    
    [self removeOverFlowActivityView];
    
    if (isSuccess && 0 < [service.categoryList count]) {
//        去除图书
        for (V2FristCategoryDTO *dto in service.categoryList) {
            if ([dto.catelogIds isEqualToString:@"22001"]) {
                [service.categoryList removeObject:dto];
                break;
            }
        }
        [self.tableView reloadData];
        
        return;
    }
    [self presentSheet:service.errorMsg];
    

}

#pragma mark -
#pragma mark TableView Delegate Method
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	

    if (iOpenCell == indexPath.row) {
        
        NSInteger detailTableCellNum = [self secNums:iOpenCell];
        
        if (DetailCEllMaxNum < detailTableCellNum) {
            
            detailTableCellNum = DetailCEllMaxNum;
        }
        
        return  [CategoryItemCell height:nil] + DetailCellH*detailTableCellNum + 6;
    }
	return [CategoryItemCell height:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 < [self.cateService.categoryList count]) {
        return [self.cateService.categoryList count]+3;
    }
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CategoryCellCellIdentifier = @"CategoryCellCellIdentifier";
    
    CategoryItemCell *cell = (CategoryItemCell*)[tableView dequeueReusableCellWithIdentifier:CategoryCellCellIdentifier];
    
    if(cell == nil)
    {
        
        cell = [[CategoryItemCell alloc]initWithReuseIdentifier:CategoryCellCellIdentifier];
        cell.myDelegate = self;
        
    }
    
    V2FristCategoryDTO *dto;
    
    if (0 == indexPath.row) {
        //红好孩
        dto = [[V2FristCategoryDTO alloc] init];
        
        dto.categoryName = L(@"redBaby");
        dto.categoryDes = L(@"redBabyDes");

        UIImage *image = [UIImage imageNamed:@"redbaby.png"];

        CGSize size = CGSizeMake(55, 55);

        cell.menuImageView.image = [image resizeImage:size];
        UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"category_arrow.png"]];
        arrow.frame = CGRectMake(280, 14, 18/2, 29/2);

        cell.accessoryView = arrow;
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if(1 == indexPath.row){
        //缤纷购
        dto = [[V2FristCategoryDTO alloc] init];
        
        dto.categoryName = L(@"binfengnet");
        dto.categoryDes = L(@"binfengnetDes");
        
        UIImage *image = [UIImage imageNamed:@"hairdressing.png"];
        
        CGSize size = CGSizeMake(55, 55);
        
        cell.menuImageView.image = [image resizeImage:size];
        UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"category_arrow.png"]];
        arrow.frame = CGRectMake(280, 14, 18/2, 29/2);
        
        cell.accessoryView = arrow;

//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if(2 == indexPath.row){
        //图书
        dto = [[V2FristCategoryDTO alloc] init];
        
        dto.categoryName = L(@"CTBook");
        dto.categoryDes = L(@"CTBestSellingBook/ChildBook/SpecialBook");
        
        UIImage *image = [UIImage imageNamed:@"category_book.png"];
        
        CGSize size = CGSizeMake(55, 55);
        
        cell.menuImageView.image = [image resizeImage:size];

        UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"category_arrow.png"]];
        arrow.frame = CGRectMake(280, 14, 18/2, 29/2);
        
        cell.accessoryView = arrow;

//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else{
        
//        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryView = nil;
        dto = [self.cateService.categoryList objectAtIndex:(indexPath.row-3)];
    }

    cell.isSelect = NO;
    

    
    if (indexPath.row == iOpenCell) {

        cell.isSelect = YES;
    }
    
    [cell setItem:dto withDescription: nil];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == self.tableView) {
        

        [self secondCategoryOpenOperate:indexPath.row];
        
        
        [self.tableView beginUpdates];
        NSArray *array = [NSArray arrayWithObject:indexPath];
        [self.tableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
        
        
        [self.tableView scrollToRowAtIndexPath:indexPath
                              atScrollPosition:UITableViewScrollPositionNone
                                      animated:YES];
    }
    
//    ProductCategoryDTO *productCategory = [[ProductCategoryDTO alloc] init];
//    
//    if (indexPath.row == 0) {
//        VirtualProductViewController *virController = [[VirtualProductViewController alloc] init];
//        [self.navigationController pushViewController:virController animated:YES];
//        TT_RELEASE_SAFELY(virController);
//    }
//    
//    if (indexPath.row == 1) {
//        
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        HomeFirstCategoryDTO *categoryDTO = [self.cateService.categoryList objectAtIndex:0];
//        SecondCategoryViewController *secondViewController = [[SecondCategoryViewController alloc] init];
//        [secondViewController.service saveFirstCateInfo:categoryDTO isBook:YES];
//        [self.navigationController pushViewController:secondViewController animated:YES];
//        TT_RELEASE_SAFELY(secondViewController)  ;
//    }
//    
//    if (indexPath.row >1) {
//        
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        
//        HomeFirstCategoryDTO *categoryDTO = [self.cateService.categoryList objectAtIndex:indexPath.row];
//        SecondCategoryViewController *secondViewController = [[SecondCategoryViewController alloc] init];
//        [secondViewController.service saveFirstCateInfo:categoryDTO isBook:NO];
//        [self.navigationController pushViewController:secondViewController animated:YES];
//        [secondViewController release];
//        
//    }
//    
//    TT_RELEASE_SAFELY(productCategory);
}



- (CategoryService *)cateService{
    
    
    if (!_cateService) {
        
        _cateService = [[CategoryService alloc] init];
        
        _cateService.delegate = self;
    }
    return _cateService;
}





-(void)secondCategoryOpenOperate:(NSInteger)cellRow{
    
    if (-1 == iOpenCell) {
        
        if (0 == [self secNums:cellRow]) {
            

            if (0 == cellRow) {
                //进入母婴
                SecondCategoryViewController *secondVC = [[SecondCategoryViewController alloc] initWithCategoryType:RedBabyCategory];
                [self.navigationController pushViewController:secondVC animated:YES];
                TT_RELEASE_SAFELY(secondVC)  ;
            }
            else if(1 == cellRow){
                //进入化妆品
                SecondCategoryViewController *secondVC = [[SecondCategoryViewController alloc] initWithCategoryType:CosmeticsCategory];
                [self.navigationController pushViewController:secondVC animated:YES];
                TT_RELEASE_SAFELY(secondVC)  ;
            }
            else if(2 == cellRow){
                //进入图书
                SecondCategoryViewController *secondVC = [[SecondCategoryViewController alloc] initWithCategoryType:BookCategory];
                [self.navigationController pushViewController:secondVC animated:YES];
                TT_RELEASE_SAFELY(secondVC)  ;
            }
            else{
                
                [self presentSheet:L(@"search records is null")];
            }
           
            return;
        }
        //如果没有打开 则打开二级目录
        
        iOpenCell = cellRow;
        self.tableView.scrollEnabled = NO;
        
    }
    else{
        
        int tempOpendCell = iOpenCell;
        
        iOpenCell = -1;
        [self.tableView beginUpdates];
        NSArray *array = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:tempOpendCell inSection:0]];
        [self.tableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
        

        
        self.tableView.scrollEnabled = YES;
        
    }
}

-(NSInteger)secNums:(NSInteger)row{
    
    if (0 > row-3) {
        
        return 0;
    }
    
    V2FristCategoryDTO *dto = [self.cateService.categoryList objectAtIndex:(row-3)];
    
    NSInteger secNum = [dto.secList count];
    
    NSInteger rowNum = secNum/IMG_NUM;
    
    if (0 != secNum%IMG_NUM) {
        
        rowNum = rowNum + 1;
    }
    return rowNum;
}


#pragma mark -
#pragma mark SecondCategoryMarkViewDelegate
- (void)topImageView:(id)obj{
    
    V2SecCategoryDTO *secDto = (V2SecCategoryDTO *)obj;
    
    
    SearchSet searchType = SearchSetMix;
    
    //如果是图书就搜索图书
    if ([kBookCatelogIds isEqualToString:secDto.catelogIds]) {
        
        searchType = SearchSetBook;
    }
    
    SearchParamDTO *solrParam = [[SearchParamDTO alloc] initWithSearchType:SearchTypeCategory_2
                                                                       set:searchType];
    solrParam.categoryId = secDto.categoryId;
    solrParam.title = secDto.categoryName;
    
    //如果该类目为筛选项的情况下
    if (secDto.categoryCi.trim.length > 0)
    {
        solrParam.categoryId = secDto.categoryCi;
    }
    if (secDto.categoryCf.trim.length > 0)
    {
        NSArray *cfList = [secDto.categoryCf componentsSeparatedByString:@":"];
        if (cfList && [cfList count] >= 2) {
            [solrParam.checkedFilters setObject:[cfList objectAtIndex:1]
                                         forKey:[cfList objectAtIndex:0]];
        }
    }
    
    [SearchListViewController goToSearchResultWithParamDTO:solrParam fromNav:self.navigationController];

}

@end

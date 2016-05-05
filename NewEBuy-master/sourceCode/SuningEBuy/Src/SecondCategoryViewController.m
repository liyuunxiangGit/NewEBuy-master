//
//  SecondCategoryViewController.m
//  SuningEBuy
//
//  Created by shasha on 12-8-23.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SecondCategoryViewController.h"
#import "CategoryItemCell.h"
#import "SearchListViewController.h"
#import "FilterRootViewController.h"
#import "JASidePanelController.h"
#import "FilterNavigationController.h"
@interface SecondCategoryViewController() 



@end

@implementation SecondCategoryViewController
@synthesize service = _service;
@synthesize categoryType = _categoryType;
@synthesize tableBackground = _tableBackground;

- (id)initWithCategoryType:(SecondCategoryType)type {
    self = [super init];
    if (self) {
        
        self.categoryType = type;
    }
    return self;
}


- (void)dealloc {
    
    SERVICE_RELEASE_SAFELY(_service);
    TT_RELEASE_SAFELY(_tableBackground)
}


- (void)viewWillAppear:(BOOL)animated{
	
	[super viewWillAppear:animated];
    

    
    if (!self.service.isCategoryLoaded) {
        
        [self displayOverFlowActivityView:kCategoryStatusMessageStartHttp];
        
        
        NSString *categoryStr = nil;
        if (RedBabyCategory == _categoryType) {
            
            categoryStr = kCategoryEnmuBaby;
        }
        else if(CosmeticsCategory == _categoryType){
            
            categoryStr = kCategoryEnmuCosmetics;
        }else if (BookCategory == _categoryType){
            categoryStr = kCategoryEnmuBook;
        }
        [self.service sendCategoryRequest:categoryStr];
        
    }
    	
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
 }


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	
	[super loadView];
    
    if (RedBabyCategory == _categoryType) {
        
        self.title = L(@"redBaby");
    }
    else if(CosmeticsCategory == _categoryType){
        
        self.title = L(@"binfengnet");
    }else if (BookCategory == _categoryType){
        self.title = L(@"CTBook");
    }
    self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"show_secondCategory"),self.title];
    
	UIView *contentView = self.view;
	
	CGRect frame = contentView.frame;
	
	frame.origin.x = 0;
	
	frame.origin.y = 0;
	
	frame.size.height = contentView.bounds.size.height - 92;
	
	self.tableView.frame = frame;
    
    self.tableView.allowsSelection = NO;
//    self.tableView.backgroundColor = [UIColor colorWithRed:242.0/255
//                                                     green:242.0/255
//                                                      blue:242.0/255
//                                                     alpha:1.0];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView setExclusiveTouch:YES];
	[self.view addSubview:self.tableView];
    
    
}

- (void)service:(CategoryService *)service loadCateComplete:(BOOL)isSuccess
{ 
    
    [self removeOverFlowActivityView];
    
    if (isSuccess && 0 < [self.service.categoryList count]) {
        
        [self.tableView reloadData];
        
        return;
    }
    
    [self presentSheet:service.errorMsg];
    
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	return 165;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    

    return [self.service.categoryList count];
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    RedbabyAndCosmeticsCell *cell;
    
    static NSString *CategoryCellCellIdentifier = @"CategoryCellCellIdentifier";
    
    cell = (RedbabyAndCosmeticsCell*)[tableView dequeueReusableCellWithIdentifier:CategoryCellCellIdentifier];
    
    if(cell == nil){
        
        cell = [[RedbabyAndCosmeticsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CategoryCellCellIdentifier];
        cell.mydelegate = self;
    }
           
    
    V2FristCategoryDTO *dto = [self.service.categoryList objectAtIndex:indexPath.row];
    
    [cell setItem:dto cellIndex:(indexPath.row + 1)];
 
	return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CategoryService *)service{

    if (!_service) {
        
        _service = [[CategoryService alloc] init];
        
        _service.delegate = self;
    }
    
    return _service;
}
- (UIImageView *)tableBackground{
    
    if (!_tableBackground) {
        
        _tableBackground = [[UIImageView alloc] init];
    }
    
    return _tableBackground;
}
#pragma mark -
#pragma mark RedbabyAndCosmeticsCellDelegate

-(void)secondCategorySelect:(id)obj{
    
    if ([obj isKindOfClass:[V2SecCategoryDTO class]]) {
        
        V2SecCategoryDTO *secDto = (V2SecCategoryDTO *)obj;
        
        SearchParamDTO *solrParam = [[SearchParamDTO alloc] initWithSearchType:SearchTypeCategory_2
                                                                           set:SearchSetMix];
        solrParam.categoryId = secDto.categoryId;
        solrParam.title = secDto.categoryName;
        
        //如果该类目为筛选项的情况下
        if (secDto.categoryCi && ![secDto.categoryCi isEmptyOrWhitespace]) {
            solrParam.categoryId = secDto.categoryCi;
        }
        if (secDto.categoryCf && ![secDto.categoryCf isEmptyOrWhitespace]) {
            NSArray *cfList = [secDto.categoryCf componentsSeparatedByString:@":"];
            if (cfList && [cfList count] >= 2) {
                [solrParam.checkedFilters setObject:[cfList objectAtIndex:1]
                                             forKey:[cfList objectAtIndex:0]];
            }
        }
        
        [SearchListViewController goToSearchResultWithParamDTO:solrParam fromNav:self.navigationController];

    }
}
@end

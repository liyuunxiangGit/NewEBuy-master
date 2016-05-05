//
//  AllCategoryViewController.m
//  SuningEBuy
//
//  Created by 周俊杰 on 13-12-20.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#define Category_CELL_HEIGHT       77

#import "AllCategoryViewController.h"
#import "CategoryViewCell.h"
#import "NextCategoryViewController.h"
#import "SNSwitch.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>
@interface AllCategoryViewController ()
@property (nonatomic, strong) V2FristCategoryDTO *currentDto;
@end

@implementation AllCategoryViewController
@synthesize cateService = _cateService;

#pragma mark init

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
        self.title = L(@"Categories");
        
        self.pageTitle = L(@"show_firstCategory");
        
        self.iOS7FullScreenLayout = YES;
        self.bSupportPanUI = NO;
        
        self.bShowSepLine = YES;
        
        self.selectedRow = -1;
    }
    return self;
}

- (CategoryService *)cateService{
    
    
    if (!_cateService) {
        
        _cateService = [[CategoryService alloc] init];
        
        _cateService.delegate = self;
    }
    return _cateService;
}

#pragma mark - View LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tableView.rowHeight = Category_CELL_HEIGHT;
    
    UISwipeGestureRecognizer *swapLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swapLeft:)];
    swapLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swapLeft];
    
    UISwipeGestureRecognizer *swapRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swapRight:)];
    swapRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swapRight];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    SERVICE_RELEASE_SAFELY(_cateService);
}


-(void)viewWillDisappear:(BOOL)animated{
	
	[super viewWillDisappear:animated];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.cateService.isCategoryLoaded)
    {
        [self displayOverFlowActivityView:kCategoryStatusMessageStartHttp];
        
        if ([SNSwitch isLoadOk])
        {
            [self.cateService sendCategoryRequest:kCategoryAll];
        }
        else
        {
            //__weak AllCategoryViewController *weakSelf = self;
            [SNSwitch updateWithCallBack:^{
                
                [self.cateService sendCategoryRequest:kCategoryAll];
            }];
        }
    }
    
}

- (void)loadView {
	
	[super loadView];
	
	self.tableView.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:YES];
//    [self.tableView setExclusiveTouch:YES];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
	[self.view addSubview:self.tableView];
}

#pragma mark -
#pragma mark Data Service DelegateMethods

- (void)service:(CategoryService *)service loadCateComplete:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    
    if (isSuccess && 0 < [service.categoryList count]) {
//        //        去除图书
//        for (V2FristCategoryDTO *dto in service.categoryList) {
//            if ([dto.catelogIds isEqualToString:@"22001"]) {
//                [service.categoryList removeObject:dto];
//                break;
//            }
//        }
        self.currentDto = [self.cateService.categoryList safeObjectAtIndex:0];
        [self.tableView reloadData];
    }else{
        [self presentSheet:service.errorMsg];
    }
}

#pragma mark -
#pragma mark TableView DataSource Method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.cateService.categoryList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CategoryCellIdentifier = @"CategoryCellIdentifier";
    
    CategoryViewCell *cell = (CategoryViewCell *)[tableView dequeueReusableCellWithIdentifier:CategoryCellIdentifier];
    
    if(cell == nil)
    {
        cell = [[CategoryViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CategoryCellIdentifier];
        
        UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellDetail.png"]];
        cell.accessoryView = arrow;
    }
    
    cell.leftArrow.hidden = YES;
    
    V2FristCategoryDTO *dto = [self.cateService.categoryList objectAtIndex:indexPath.row];

    [cell setItem:dto];
    
    if (self.bShowSepLine)
    {
        cell.cellSeparatorLine.hidden = NO;
        cell.verticalLine.hidden = YES;
    }
    else
    {
        cell.cellSeparatorLine.hidden = YES;
        cell.verticalLine.hidden = NO;
        
        if (self.selectedRow == indexPath.row)
        {
            cell.leftArrow.hidden = NO;
        }
    }
    return cell;
}

#pragma mark -
#pragma mark TableView Delegate Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* str = nil;
    if (indexPath.row < 9)
    {
        str = [NSString stringWithFormat:@"910%d",indexPath.row + 1];
    }
    else
    {
      str = [NSString stringWithFormat:@"91%d",indexPath.row + 1];
    }
    
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",str], nil]];
    
    V2FristCategoryDTO *dto = [self.cateService.categoryList objectAtIndex:indexPath.row];
//    self.navigationItem.titleView
    UILabel *label = (UILabel *)self.navigationItem.titleView;
    label.width = 320;
    label.text = dto.kindName;
    
    self.currentDto = dto;
    self.nextCataViewController.dto = dto;

    if (!self.bShowingNextCata) //推入二级分类页面
    {
        [self showNextCata:YES];
    }
    
    
    self.selectedRow = indexPath.row;
    self.nextCataViewController.iFirstCatatorySelectedRow = indexPath.row + 1;
    [self.tableView reloadData];
    
//    CategoryViewCell *cell = (CategoryViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//    if (self.bShowSepLine)
//    {
//        cell.leftArrow.hidden = YES;
//    }
//    else
//    {
//        cell.leftArrow.hidden = NO;
//    }
}

- (void)swapLeft:(UISwipeGestureRecognizer *)ges
{
    if (self.bShowingNextCata)
        return;
    self.nextCataViewController.dto = self.currentDto;
    [self showNextCata:YES];
}

- (void)swapRight:(UISwipeGestureRecognizer *)ges
{
    if (!self.bShowingNextCata)
        return;
    
    [self showNextCata:NO];
}

- (void)showNextCata:(BOOL)show
{
    if (show)
    {
        self.bShowingNextCata = YES;
        
        
        [UIView animateWithDuration:0.5 animations:^{
            self.nextCataViewController.view.left = 92;
        } completion:^(BOOL finished) {
            self.bShowSepLine = NO;
            [self.tableView reloadData];
        }];
    }
    else
    {
        self.bShowingNextCata = NO;
        
        self.bShowSepLine = YES;
        [self.tableView reloadData];
        [UIView animateWithDuration:0.5 animations:^{
            self.nextCataViewController.view.left = 320;
        } completion:^(BOOL finished) {
            self.title = L(@"Categories");
        }];
    }
}

- (NextCategoryViewController *)nextCataViewController
{
    if (!_nextCataViewController)
    {
        _nextCataViewController = [[NextCategoryViewController alloc] init];
        _nextCataViewController.parentCtrl = self;
        CGRect frame = [[UIScreen mainScreen] bounds];
        float height = frame.size.height;
        if (IOS7_OR_LATER)
        {
            height -= 20 + 44 + 48;
            frame = CGRectMake(320, 64, 228, height);
        }
        else
        {
            height -= 44 + 48;
            frame = CGRectMake(320, 0, 228, height);
        }
        _nextCataViewController.view.frame = frame;
        
        [self.view addSubview:_nextCataViewController.view];
    }
    
    return _nextCataViewController;
}

@end

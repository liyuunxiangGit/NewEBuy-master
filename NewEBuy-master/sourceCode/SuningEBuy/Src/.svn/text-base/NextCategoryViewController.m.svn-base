//
//  NextCategoryViewController.m
//  SuningEBuy
//
//  Created by 周俊杰 on 13-12-24.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NextCategoryViewController.h"
#import "SearchParamDTO.h"
#import "SearchListViewController.h"
#import "FilterRootViewController.h"
#import "FilterNavigationController.h"
#import "JASidePanelController.h"
#import "SNWebViewController.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>

@interface NextCategoryViewController ()
@property (nonatomic , copy) NSString *selectRightRow;
@property (nonatomic , assign) BOOL isSelectRow;
@end

@implementation NextCategoryViewController
@synthesize dto             = _dto;
@synthesize detailTableView = _detailTableView;
@synthesize headCateView = _headCateView;
@synthesize actionDto = _actionDto;

#pragma mark init

- (id)init
{
    self = [super init];
    if (self) {
//        self.hasNav = NO;
    }
    return self;
}

- (void)righBarClick
{
    [self touchActionBnt:nil];
}

- (UITableView *)detailTableView{
	
	if(!_detailTableView){
		
        _detailTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                        style:UITableViewStylePlain];
		_detailTableView.delegate =self;
		_detailTableView.dataSource =self;
		_detailTableView.backgroundColor =[UIColor cell_Back_Color];
        _detailTableView.backgroundView = nil;
        [_detailTableView setExclusiveTouch:YES];
	}
	
	return _detailTableView;
}

-(HeadCategoryView *)headCateView
{
    if (nil == _headCateView)
    {
        _headCateView = [[HeadCategoryView alloc] init];
        [_headCateView addTarget:self action:@selector(touchActionBnt:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_headCateView];
    }
    
    return _headCateView;
}

#pragma mark - Touch Menthod

-(void)touchActionBnt:(id)sender
{
    //[self pushWebWithUrl:@"http://subooksit.cnsuning.com/m/lapp/intact/index.htm?noTitleFlag=1"];
    [self pushWebWithUrl:self.actionDto.usingRel];
}

-(void)pushWebWithUrl:(NSString *)strUrl
{
    if (strUrl.length) {
        
        if ([strUrl isEqualToString:kEBookTradEnrtyHttp])
        {
            strUrl = [kEBookTradEnrtyHttp stringByAppendingString:@"?noTitleFlag=1"];
        }
        
        SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeAdModel attributes:@{@"url": strUrl}];
        [self.parentCtrl.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - View LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //    [self useBottomNavBar];
    
//    self.view.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
	
	[super loadView];
    
    
}

- (void)setDto:(V2FristCategoryDTO *)dto
{
    if (dto == nil)
        return;
    
    if (_dto != dto)
    {
        _dto = dto;
        self.title = self.dto.kindName;
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"show_secondCategory"),self.title];
        
        _detailSelectIndex = 0;
        _secondSelectIndex = -1;
        
        self.isSelectRow = YES;
        
        // Do any additional setup after loading the view.
        
        _categoryList = [[NSMutableArray alloc] init];
        [_categoryList addObjectsFromArray:self.dto.secList];
        
        if (IsArrEmpty(self.dto.secList)) {
            [self presentSheet:L(@"CTNoDataAndTryingToMaintain")];
            
            return;
        }
        
        int k = -1;
        
        for (int i=0; i<[_categoryList count]; i++)
        {
            V2FristCategoryDTO *dto = [_categoryList objectAtIndex:i];
            
            if (NotNilAndNull(dto.usingRel) && ![dto.usingRel isEqualToString:@""])
            {
                k = i;
                break;
            }
        }
        
        if (k != -1)
        {
            //        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:@"活动"];
            
            self.actionDto = [_categoryList objectAtIndex:k];
            
            self.headCateView.frame = CGRectMake(0, 0, 320, 50);
            
            [self.headCateView setDate:self.actionDto];
            
            [_categoryList removeObjectAtIndex:k];
        }
        
        
//        CGRect frame = [self visibleBoundsShowNav:self.hasNav showTabBar:YES];
        CGRect frame = self.view.bounds;
        frame.origin.x = 0;
        frame.size.width = 119;
        
        if (k != -1)
        {
            frame.origin.y = 50;
            frame.size.height -= 50;
        }
        
        self.tableView.frame = frame;
        self.tableView.backgroundColor = RGBCOLOR(242, 242, 242);
        [self.tableView setExclusiveTouch:YES];
        self.tableView.showsVerticalScrollIndicator = NO;
//        self.tableView.layer.borderWidth = 1.0;
//        self.tableView.layer.borderColor = [UIColor light_Gray_Color].CGColor;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:self.tableView];
        
        CGRect detailFrame = frame;
        
        detailFrame.origin.x = frame.size.width;
        detailFrame.size.width = 109;
        
        self.detailTableView.frame = detailFrame;
        self.detailTableView.backgroundColor = RGBACOLOR(220, 220, 220, 1);
//        self.detailTableView.layer.borderWidth = 0.5;
        [self.detailTableView setExclusiveTouch:YES];
//        self.detailTableView.layer.borderColor = RGBCOLOR(220, 220, 220).CGColor;
        self.detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.view addSubview:self.detailTableView];
        
        [self.tableView reloadData];
        [self.detailTableView reloadData];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    
//    self.hasSuspendButton = NO;
}

#pragma mark -
#pragma mark TableView DataSource Method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
	return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView == tableView)
    {
        return 40;
    }
    else
    {
        return 30;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return [_categoryList count];
    }
    V2FristCategoryDTO *dto2 = [_categoryList safeObjectAtIndex:_detailSelectIndex];
    if (IsNilOrNull(dto2))
        return 0;
    return [dto2.thirdList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView)
    {
        static NSString *CellIdentifier = @"Cell";
        CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[CategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.delegate = self;
        }
        cell.cellSeparatorLine.hidden = NO;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.tag = indexPath.row;
        BOOL isSelected = NO;
        if (_detailSelectIndex == indexPath.row)
        {
            isSelected = YES;
        }
        else
        {
            isSelected = NO;
        }
        V2FristCategoryDTO *dto2 = [_categoryList safeObjectAtIndex:indexPath.row];
        
        if(NotNilAndNull(dto2))
            [cell setData:dto2.kindName IsSelect:isSelected];
        
        return cell;
    }
    
    static NSString *detailCellIdentifier = @"detailCellIdentifier";
    CategoryBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:detailCellIdentifier];
    if (cell == nil) {
        cell = [[CategoryBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailCellIdentifier];
        cell.delegate = self;
        cell.backgroundColor = RGBCOLOR(220, 220, 220);
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(1, -1, 186, 42)];
//        view.backgroundColor = [UIColor orange_Light_Color];
//        cell.selectedBackgroundView = view;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tag = indexPath.row;
    BOOL isSecondSelected = NO;
    if (_secondSelectIndex == indexPath.row)
    {
        isSecondSelected = YES;
    }
    else
    {
        isSecondSelected = NO;
    }
    V2FristCategoryDTO *dto2 = [_categoryList safeObjectAtIndex:_detailSelectIndex];
    if (NotNilAndNull(dto2))
    {
        V2FristCategoryDTO *dto3 = [dto2.thirdList safeObjectAtIndex:indexPath.row];
        if (NotNilAndNull(dto3)) {
            [cell setData:dto3.kindName IsSelect:isSecondSelected];
        }
    }
    return cell;
}

#pragma mark -
#pragma mark TableView Delegate Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        if (_detailSelectIndex != indexPath.row)
        {
//            [self flowStat:self.selectRow row:indexPath.row isSave:YES];
            
            self.iSecondCatagorySelectedRow = indexPath.row;
            
            NSString* str = nil;
            
            if (self.iFirstCatatorySelectedRow <= 9)
            {
                if (indexPath.row < 9)
                    str = [NSString stringWithFormat:@"0%d0%d",self.iFirstCatatorySelectedRow, indexPath.row + 1];
                else
                    str = [NSString stringWithFormat:@"0%d%d",self.iFirstCatatorySelectedRow, indexPath.row + 1];
            }
            else
            {
                if (indexPath.row < 9)
                    str = [NSString stringWithFormat:@"%d0%d",self.iFirstCatatorySelectedRow, indexPath.row + 1];
                else
                    str = [NSString stringWithFormat:@"%d%d",self.iFirstCatatorySelectedRow, indexPath.row + 1];
            }
            
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",str], nil]];
            
            _detailSelectIndex = indexPath.row;
            _secondSelectIndex = -1;
            self.isSelectRow = NO;
            [self.tableView reloadData];
            [self.detailTableView reloadData];
        }
        
        [self.tableView reloadData];
        
        //当前选中cell的分割线被选中的背景图盖住了，所以选中行其实不需要隐藏
        NSIndexPath *indexpathAbove = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
        CategoryCell *cellAbove = (CategoryCell *)[tableView cellForRowAtIndexPath:indexpathAbove];
        if (cellAbove)
        {
            cellAbove.cellSeparatorLine.hidden = YES;
        }
        
        NSIndexPath *indexpathBelow = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
        CategoryCell *cellBelow = (CategoryCell *)[tableView cellForRowAtIndexPath:indexpathBelow];
        if (cellBelow)
        {
            cellBelow.cellSeparatorLine.hidden = YES;
        }
    }else{
//        if (self.isSelectRow)
//        {
//             [self flowStat:[NSString stringWithFormat:@"%@01",self.selectRow] row:indexPath.row isSave:NO];
//        }
//        else
//        {
//            [self flowStat:self.selectRightRow row:indexPath.row isSave:NO];
//        }
        NSString* str = nil;
        
        if (self.iFirstCatatorySelectedRow <= 9)
        {
            if (self.iSecondCatagorySelectedRow < 9)
                str = [NSString stringWithFormat:@"0%d0%d",self.iFirstCatatorySelectedRow, self.iSecondCatagorySelectedRow + 1];
            else
                str = [NSString stringWithFormat:@"0%d%d",self.iFirstCatatorySelectedRow, self.iSecondCatagorySelectedRow + 1];
        }
        else
        {
            if (self.iSecondCatagorySelectedRow < 9)
                str = [NSString stringWithFormat:@"%d0%d",self.iFirstCatatorySelectedRow, self.iSecondCatagorySelectedRow + 1];
            else
                str = [NSString stringWithFormat:@"%d%d",self.iFirstCatatorySelectedRow, self.iSecondCatagorySelectedRow + 1];
        }
        
        if (indexPath.row < 9)
        {
            str = [NSString stringWithFormat:@"%@0%d", str, indexPath.row + 1];
        }
        else
        {
            str = [NSString stringWithFormat:@"%@%d", str, indexPath.row + 1];
        }
        
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",str], nil]];
        
        [self touchCategory:indexPath.row];
    }
}
//
//- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (tableView == self.tableView)
//    {
//        NSIndexPath *indexpathAbove = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
//        CategoryCell *cellAbove = (CategoryCell *)[tableView cellForRowAtIndexPath:indexpathAbove];
//        if (cellAbove)
//        {
//            cellAbove.cellSeparatorLine.hidden = NO;
//        }
//        
//        NSIndexPath *indexpathBelow = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
//        CategoryCell *cellBelow = (CategoryCell *)[tableView cellForRowAtIndexPath:indexpathBelow];
//        if (cellBelow)
//        {
//            cellBelow.cellSeparatorLine.hidden = NO;
//        }
//
//    }
//}

-(void)flowStat:(NSString*)aStr row:(NSInteger)aRow isSave:(BOOL)isSave
{
    NSString* str = nil;
    if (aRow < 9)
    {
        str = [NSString stringWithFormat:@"%@0%d",aStr,aRow + 1];
    }
    else
    {
        str = [NSString stringWithFormat:@"%@%d",aStr,aRow + 1];
    }
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",str], nil]];
    if (isSave)
    {
        self.selectRightRow = [NSString stringWithFormat:@"%@",str];
    }
}
#pragma --
#pragma mark -- CategoryBaseCellDelegate

-(void)touchCategory:(int)tag //Type:(CateType)type
{
    
//    if (type == CateFrist)
//    {
//        if (_detailSelectIndex != tag)
//        {
//            _detailSelectIndex = tag;
//            
//            _secondSelectIndex = -1;
//            [self.tableView reloadData];
//            [self.detailTableView reloadData];
//        }
//        
//        return;
//    }
    _secondSelectIndex = tag;
    
    [self.detailTableView reloadData];
    
    V2FristCategoryDTO *dto2 = [_categoryList safeObjectAtIndex:_detailSelectIndex];
    if (IsNilOrNull(dto2)) {
        return;
    }
    V2FristCategoryDTO *dto3 = [dto2.thirdList safeObjectAtIndex:tag];
    
    if (![dto3.usingRel isEqualToString:@""] && NotNilAndNull(dto3.usingRel))
    {
        //跳转web页
        
        [self pushWebWithUrl:dto3.usingRel];
        
        return;
    }
    SearchParamDTO *solrParam;
    if ([dto3.chaKind isEqualToString:@"22001"]) {
        solrParam = [[SearchParamDTO alloc] initWithSearchType:SearchTypeCategory_3
                                                           set:SearchSetBook];
    }else{
        solrParam = [[SearchParamDTO alloc] initWithSearchType:SearchTypeCategory_3
                                                           set:SearchSetMix];
    }
    solrParam.categoryId = dto3.ci;
    solrParam.title = dto2.kindName;
    solrParam.categoryName = dto3.kindName;
    if (!IsStrEmpty(dto3.cf)) {
        NSArray *cfList = [dto3.cf componentsSeparatedByString:@":"];
        if (cfList && [cfList count] >= 2) {
            [solrParam.checkedFilters setObject:[cfList objectAtIndex:1]
                                         forKey:[cfList objectAtIndex:0]];
        }
    }
    SearchListViewController *nextController = [[SearchListViewController alloc] initWithSearchCondition:solrParam];
    nextController.isFirstIn = YES;
    
    //chupeng 修改为新的搜索结果界面
    FilterRootViewController *vRightRoot = [[FilterRootViewController alloc] init];
    vRightRoot.isNeedBackItem = NO;
    vRightRoot.delegate = nextController;
    
//    FilterNavigationController *navRight = [[FilterNavigationController alloc] initWithRootViewController:vRightRoot];
    //    navRight.view.backgroundColor = [UIColor clearColor];
    //    [navRight.navigationBar setBackgroundImage:[UIImage imageNamed:kNavigationBarBackgroundImage] forBarMetrics:UIBarMetricsDefault];
    
    JASidePanelController *jasideController = [[JASidePanelController alloc] init];
    jasideController.shouldDelegateAutorotateToVisiblePanel = NO;
    jasideController.rightGapPercentage = 0.8;
    jasideController.shouldResizeRightPanel = YES;
    jasideController.bounceOnSidePanelOpen = NO;
    jasideController.allowLeftOverpan = NO;
    jasideController.allowRightOverpan = NO;
    jasideController.centerPanel = nextController;
    jasideController.rightPanel = nil;
    jasideController.leftPanel = nil;
    jasideController.hidesBottomBarWhenPushed = YES;
//    [jasideController addObserver:nextController forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:"getstate"];
    [self.parentCtrl.navigationController pushViewController:jasideController animated:YES];
//    [SearchListViewController goToSearchResultWithParamDTO:solrParam fromNav:self.navigationController];
    
}

//修复方法未实行警告
- (void)touchCategory:(int)tag Type:(CateType)type
{
    
}

@end

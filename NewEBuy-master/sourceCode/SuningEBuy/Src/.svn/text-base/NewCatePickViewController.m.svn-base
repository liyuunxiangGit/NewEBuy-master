//
//  NewCatePickViewController.m
//  SuningEBuy
//
//  Created by chupeng on 13-12-13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NewCatePickViewController.h"
#import "FilterRootViewController.h"
#import "FilterPopupViewController.h"
#define SECTION_TEXT_LEFT 25
#define CELL_TEXT_LEFT 35

#define SECTION_TEXT_COLOR RGBCOLOR(0, 0, 0)
#define CELL_TEXT_COLOR RGBCOLOR(0, 0, 0)

#define CELL_BACK_COLOR RGBCOLOR(247, 247, 247)
@implementation SectionState
- (NSString *)description
{
    return [NSString stringWithFormat:@"isFolding %d, isSelected %d", self.bFolding, self.bSelected];
}
@end


@interface NewCatePickViewController ()

@end

@implementation NewCatePickViewController
@synthesize categoryList = _categoryList;
@synthesize selectCateId = _selectCateId;
@synthesize selectedIndex = selectedIndex;

- (id)init
{
    if (self = [super init])
    {
//        if (IOS7_OR_LATER)
//            self.edgesForExtendedLayout = UIRectEdgeBottom;
        
//        self.titleLabel.text = L(@"Category");
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.titleLabel.text = L(@"Category");
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    if (IOS7_OR_LATER)
//        self.tableView.backgroundColor = [UIColor uiviewBackGroundColor];
//    [self.tableView reloadData];
//    [[NSNotificationCenter defaultCenter] postNotificationName:REFRESH_FILTERVIEWCTRL object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tableView.frame = self.view.bounds;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];
    
//    [self titleLabel];
}

//- (UILabel *)titleLabel
//{
//    if (!_titleLabel) {
//        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
//        _titleLabel.numberOfLines = 2;
//        _titleLabel.textAlignment = UITextAlignmentCenter;
//        _titleLabel.backgroundColor = [UIColor clearColor];
//        _titleLabel.textColor = [UIColor colorWithRGBHex:0x313131];
//        _titleLabel.font = [UIFont systemFontOfSize:16];
//        self.navigationItem.titleView = _titleLabel;
//    }
//    return _titleLabel;
//}

- (UIImageView *)checkMarkView
{
    if (!_checkMarkView) {
        _checkMarkView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightIcon"]];
        
    }
    return _checkMarkView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithCateList:(NSArray *)list
{
    self = [super init];
    
    if (self) {
        self.categoryList = list;
//        self.titleLabel.text = L(@"Category");
//        if (IOS7_OR_LATER)
//            self.edgesForExtendedLayout = UIRectEdgeBottom;
        
//        self.pageTitle = @"展示-一级分类-类目";
    }
    return self;
}

- (void)setCategoryList:(NSArray *)categoryList
{
    if (_categoryList != categoryList) {
        _categoryList = categoryList;
        
        self.sectionStateArray = [NSMutableArray arrayWithCapacity:(_categoryList.count + 1)];
        
        for (int i = 0; i < (_categoryList.count + 1); i++) {
            SectionState *state = [[SectionState alloc] init];
            state.bSelected = NO;
            state.bFolding = YES;
            
            [self.sectionStateArray addObject:state];
        }
        selectedIndex = -1;
        _selectCateId = nil;
    }
}

- (void)setSelectCateId:(NSString *)selectCateId
{
    if (_selectCateId != selectCateId)
    {
        _selectCateId = selectCateId;
        
        if (_selectCateId)
        {
            if (self.sectionStateArray && self.categoryList)
            {
                int iFoldUpSection = 0; //如果之前用户已经有选类别，寻找应该展开的section
                
                for (int i = 0; i < self.categoryList.count; i++)
                {
                    SearchCateDTO *cateDTO = (SearchCateDTO *)[self.categoryList objectAtIndex:i];
                    for (int j = 0; j < cateDTO.subCateList.count; j++)
                    {
                        SearchCateDTO *subCateDto = [cateDTO.subCateList objectAtIndex:j];
                        if ([subCateDto.cateId isEqualToString:self.selectCateId])
                        {
                            iFoldUpSection = i + 1;
                            break;
                        }
                    }
                }
                
                if (iFoldUpSection >= 0 && iFoldUpSection < self.sectionStateArray.count)
                {
                    SectionState *foldupSectionstate = [self.sectionStateArray objectAtIndex:iFoldUpSection];
                    foldupSectionstate.bFolding = NO;
                    foldupSectionstate.bSelected = YES;
                    
                    for (SectionState *state in self.sectionStateArray)
                    {
                        if (state != foldupSectionstate)
                        {
                            state.bFolding = !foldupSectionstate.bFolding;
                            state.bSelected = NO;
                        }
                    }
                }
            }
        }
        else
        {
            if (self.sectionStateArray && self.categoryList)
            {
                int iFoldUpSection = 1; //如果之前用户没选类别，展开第一个

                if (iFoldUpSection >= 0 && iFoldUpSection < self.sectionStateArray.count)
                {
                    SectionState *foldupSectionstate = [self.sectionStateArray objectAtIndex:iFoldUpSection];
                    foldupSectionstate.bFolding = NO;
                    foldupSectionstate.bSelected = YES;
                    
                    for (SectionState *state in self.sectionStateArray)
                    {
                        if (state != foldupSectionstate)
                        {
                            state.bFolding = !foldupSectionstate.bFolding;
                            state.bSelected = NO;
                        }
                    }
                }
            }
        }
    }
    else
    {
        if (self.sectionStateArray && self.categoryList)
        {
            int iFoldUpSection = 1; //如果之前用户没选类别，展开第一个
            
            if (iFoldUpSection >= 0 && iFoldUpSection < self.sectionStateArray.count)
            {
                SectionState *foldupSectionstate = [self.sectionStateArray objectAtIndex:iFoldUpSection];
                foldupSectionstate.bFolding = NO;
                foldupSectionstate.bSelected = YES;
                
                for (SectionState *state in self.sectionStateArray)
                {
                    if (state != foldupSectionstate)
                    {
                        state.bFolding = !foldupSectionstate.bFolding;
                        state.bSelected = NO;
                    }
                }
            }
        }
    }
}

#pragma mark - Tableview Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.categoryList.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.categoryList && section > 0) {
        SectionState *state = (SectionState *)[self.sectionStateArray objectAtIndex:section];
        SearchCateDTO *cateDTO = [self.categoryList objectAtIndex:section-1];
        
        if (state.bSelected)
        {
            if (state.bFolding)
            {
                return 0;
            }
            else
            {
                return cateDTO.subCateList.count;
            }
        }
        else
        {
            return 0;
        }
        
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 36;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 36;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:[tableView rectForSection:section]];
    headerView.backgroundColor = CELL_BACK_COLOR;
    
    UIView *vBottomline = [[UIView alloc] initWithFrame:CGRectMake(0, 35.5, 320, 0.5)];
    vBottomline.backgroundColor = [UIColor colorWithRGBHex:0xdcdcdc];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionTapped:)];
    [headerView addGestureRecognizer:tapGes];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SECTION_TEXT_LEFT, 0, 150, 36)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = CELL_TEXT_COLOR;
    label.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:label];
    
    [headerView addSubview:vBottomline];
    
    if (section == 0)
    {
        label.text = L(@"All Categorys");
    }
    else
    {
        SearchCateDTO *cateDTO = [self.categoryList objectAtIndex:section-1];
        NSString *title;
        if (!self.bSearchingCategory)
            title = [NSString stringWithFormat:@"%@(%@)", cateDTO.cateName, cateDTO.count];
        else
            title = [NSString stringWithFormat:@"%@", cateDTO.cateName];
        label.text = title;
    }
    
    if (section == 0 && !self.selectCateId)
    {
        CGRect rc = self.checkMarkView.bounds;
//        self.checkMarkView.frame = CGRectMake(headerView.size.width - 20 - rc.size.width, (36 - 8.5) / 2, rc.size.width, rc.size.height);
        self.checkMarkView.frame = CGRectMake(190, (36 - 8.5) / 2, rc.size.width, rc.size.height);
        [headerView addSubview:self.checkMarkView];
    }
    else if (section != 0)
    {
        UIButton *checkButton = (UIButton *)[headerView viewWithTag:100];
        if (!checkButton)
        {
//            checkButton = [[UIButton alloc] initWithFrame:CGRectMake(headerView.size.width - 20 - 9, 10, 9, 9)];
            checkButton = [[UIButton alloc] initWithFrame:CGRectMake(190, 15, 11, 6)];
            [checkButton setBackgroundImage:[UIImage imageNamed:@"arrow_bottom_gray"] forState:UIControlStateNormal];
            [checkButton setBackgroundImage:[UIImage imageNamed:@"arrow_top_gray"] forState:UIControlStateSelected];
            checkButton.tag = 100;
            [headerView addSubview:checkButton];
        }

        SectionState *sectionState = [self.sectionStateArray objectAtIndex:section];
        if (sectionState.bSelected && !sectionState.bFolding)
        {
            checkButton.selected = YES;
        }
        else
        {
            checkButton.selected = NO;
        }
        
        [checkButton setNeedsDisplay];
    }
    
    

    headerView.tag = 100 + section;
    return headerView;
}

- (void)sectionTapped:(UITapGestureRecognizer *)ges
{
    UIView *v = ges.view;
    int sectionindex = v.tag - 100;
    
    SectionState *sectionState = [self.sectionStateArray objectAtIndex:sectionindex];
    
    if (sectionindex > 0) //全部分类没有折叠概念,直接略过
    {
        if (sectionState.bFolding)
        {
            sectionState.bFolding = NO;
        }
        else
        {
            sectionState.bFolding = YES;
        }
    }

    sectionState.bSelected = YES;
    
    if (sectionindex > 0)
    {
        for (SectionState *state in self.sectionStateArray)
        {
            if (state != sectionState)
            {
                state.bFolding = YES;
                state.bSelected = NO;
            }
        }
    }
        
    if (sectionindex == 0)//点击了全部分类section
    {
        //self.selectedIndex = 0;
        self.selectCateId = nil;
        self.filterPopupViewController.selectCateId = nil;
        self.filterPopupViewController.selectCateName = @"";
        
        [self.tableView reloadData];
        [[NSNotificationCenter defaultCenter] postNotificationName:DIDSELECT_CATA object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:REFRESH_FILTERVIEWCTRL object:nil];
    
        //[self.tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
        if (_delegate && [_delegate respondsToSelector:@selector(catePickDidOk)]) {
            [_delegate catePickDidOk];
//            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        //self.selectedIndex = sectionindex;
        
        [self.tableView reloadData];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:REFRESH_FILTERVIEWCTRL object:nil];
        
        int iRowCount = [self.tableView numberOfRowsInSection:sectionindex];
        if (iRowCount > 0)
        {
//            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:sectionindex];
//            [self.tableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionNone animated:YES];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cateCellIdentifier = @"cateCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cateCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cateCellIdentifier];
        //cell.contentView.backgroundColor = RGBCOLOR(228, 224, 206);
        cell.contentView.backgroundColor = CELL_BACK_COLOR;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CELL_TEXT_LEFT, 8, 150, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:14.0];
        label.textColor = RGBCOLOR(49, 49, 49);
        label.tag = 100;
        
        UIImageView *cellSep = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
        cellSep.frame = CGRectMake(0, 35.5, 320,0.5);
        [cell.contentView addSubview:cellSep];
        [cell.contentView addSubview:label];
        
        UIImageView *checkView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightIcon"]];
        checkView.frame = CGRectMake(190, (36 - 8.5) / 2, 12, 8.5);
        checkView.tag = 101;
        [cell.contentView addSubview:checkView];
    }
    
    SearchCateDTO *cateDTO = [self.categoryList objectAtIndex:indexPath.section-1];
    SearchCateDTO *subcateDTO = [cateDTO.subCateList objectAtIndex:indexPath.row];
    
    if (indexPath.row > [cateDTO.subCateList count]) {
        return cell;
    }
    
    NSString *title;
    if (!self.bSearchingCategory)
        title = [NSString stringWithFormat:@"%@(%@)", subcateDTO.cateName, subcateDTO.count];
    else
        title = [NSString stringWithFormat:@"%@", subcateDTO.cateName];

    UILabel *label = (UILabel *)[cell viewWithTag:100];
    label.text = title;
    
    
    UIImageView *checkView = (UIImageView *)[cell.contentView viewWithTag:101];
    if (checkView)
        checkView.hidden = YES;
//    [self.checkMarkView removeFromSuperview];
    if (self.selectCateId &&
        [self.selectCateId isEqualToString:subcateDTO.cateId]) {
        checkView.hidden = NO;
//        self.checkMarkView.frame = CGRectMake(190, (36 - 8.5) / 2, self.checkMarkView.frame.size.width, self.checkMarkView.frame.size.height);
//        [cell.contentView addSubview:self.checkMarkView];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SearchCateDTO *cateDTO = [self.categoryList objectAtIndex:indexPath.section-1];
    SearchCateDTO *subcateDTO = [cateDTO.subCateList objectAtIndex:indexPath.row];
    
    self.selectCateId = subcateDTO.cateId;
    self.filterPopupViewController.selectCateId = subcateDTO.cateId;
    self.filterPopupViewController.selectCateName = subcateDTO.cateName;
    
    [self.tableView reloadData];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DIDSELECT_CATA object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:REFRESH_FILTERVIEWCTRL object:nil];
    
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(catePickDidOk)]) {
        [_delegate catePickDidOk];
    }
}

@end

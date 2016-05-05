//
//  FilterPopupViewController.m
//  SuningEBuy
//
//  Created by chupeng on 14-8-22.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "FilterPopupViewController.h"

#define TXTCOLOR_SELECTEDITEM  RGBCOLOR(252, 124, 38)
#define TXTCOLOR_BLACK         RGBCOLOR(49, 49, 49)
#define TXTCOLOR_GRAY          RGBCOLOR(49, 49, 49)
#define FONTSIZE_LEFTLABEL     14.0
#define FONTSIZE_RIGHTLABEL    14.0

#define TABLEVIEWWIDTH  230
#define TABLEVIEWHEIGHT 390
#define CHECK_LEFT      190
#define CHECK_RECT      CGRectMake(CHECK_LEFT, 15.5, 12, 9)
#define CHECK_IMAGENAME @"rightIcon"
#define SEPLINE_RECT    CGRectMake(0, 39.5, TABLEVIEWWIDTH, 0.5)
#define SEPLINE_IMGNAME @"line"

#define CELL_BACK_COLOR RGBCOLOR(247, 247, 247)
#define SECTION_BACK_COLOR RGBCOLOR(255, 255, 255)
#define SECTION_TEXT_COLOR RGBCOLOR(36, 36, 36)
#define CELL_TEXT_COLOR    RGBCOLOR(48, 48, 48)
#define SECTION_TEXT_LEFT  10
#define CELL_TEXT_LEFT  25
#define SECTION_FONT 15
#define CELL_FONT 15

@implementation SalesFiltersDto

@end

@interface FilterPopupViewController ()
@end

@implementation FilterPopupViewController

- (void)showOnWindow
{
//    ChooseSearchTypeView *v = [[ChooseSearchTypeView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    [window bringSubviewToFront:self.view];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.arrayItems = [NSMutableArray array];
    
    NSArray *arrTemp = @[L(@"Search_AllGoods"), L(@"Search_AllPromotion"), L(@"Search_Reduce"), L(@"Search_ReturnTicket")];
    
    for (int i = 0; i < 4; i++)
    {
        SalesFiltersDto *dto = [[SalesFiltersDto alloc] init];
        dto.name = [arrTemp objectAtIndex:i];
        [self.arrayItems addObject:dto];
    }
    [[self.arrayItems objectAtIndex:2] setValue:@"zj" forKey:@"value"];
    [[self.arrayItems objectAtIndex:3] setValue:@"fq" forKey:@"value"];

    
    [self.view addSubview:self.headView];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = RGBACOLOR(0, 0, 0, 0.3);
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView) name:REFRESH_FILTERVIEWCTRL object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectCity) name:DIDSELECT_CITY object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectCata) name:DIDSELECT_CATA object:nil];
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(disappear)];
    ges.delegate = self;
    [self.view addGestureRecognizer:ges];

}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint pt = [gestureRecognizer locationInView:self.view];
    if (CGRectContainsPoint(self.tableView.frame, pt))
        return NO;
    return YES;
}

- (void)disappear
{
    [self.view removeFromSuperview];
}

- (void)refreshTableView
{
    [self.tableView reloadData];
    
//    [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
//    if (self.openSectionsFlag & OPEN_CITYS)
//    {
//        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:2];
//        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexpath, nil] withRowAnimation:UITableViewRowAnimationBottom];
//    }
 
}

- (void)didSelectCity
{
    self.openSectionsFlag ^= OPEN_CITYS;
}

- (void)didSelectCata
{
    self.openSectionsFlag ^= OPEN_CATAS;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (IOS7_OR_LATER)
    {
        self.tableView.frame = CGRectMake(90, self.headView.bottom, TABLEVIEWWIDTH, [UIScreen mainScreen].bounds.size.height - self.headView.top - self.headView.height);
    }
    else
    {
        self.tableView.frame = CGRectMake(90, self.headView.bottom, TABLEVIEWWIDTH, [UIScreen mainScreen].bounds.size.height - 20 - self.headView.top - self.headView.height);
    }
}

-(UIView *)headView
{
    if (!_headView)
    {
        if (IOS7_OR_LATER)
        {
            _headView = [[UIView alloc] initWithFrame:CGRectMake(90, 55, TABLEVIEWWIDTH, 49)];
        }
        else
        {
            _headView = [[UIView alloc] initWithFrame:CGRectMake(90, 35, TABLEVIEWWIDTH, 49)];
        }
        
        UIImageView *imgBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 230, 49)];
        imgBack.image = [UIImage imageNamed:@"searchList_FilterViewTopBack"];
        
        [_headView addSubview:imgBack];
        [_headView addSubview:self.labelItemNum];
        [_headView addSubview:self.clearAllBtn];
        
        
    }
    
    return _headView;
}

- (OHAttributedLabel *)labelItemNum
{
    if (!_labelItemNum)
    {
        _labelItemNum = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(10, 23, 150, 20)];

        _labelItemNum.backgroundColor = [UIColor clearColor];
        _labelItemNum.underlineLinks = NO;
        _labelItemNum.automaticallyAddLinksForType = 0;
    }
    
    return _labelItemNum;
}

- (UIButton *)clearAllBtn
{
    if (!_clearAllBtn)
    {
        _clearAllBtn = [[UIButton alloc] initWithFrame:CGRectMake(184, 20, 40, 20)];
        _clearAllBtn.backgroundColor = [UIColor clearColor];
        [_clearAllBtn setTitleColor:RGBCOLOR(251, 128, 52) forState:UIControlStateNormal];
        _clearAllBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_clearAllBtn setTitle:L(@"BTClear") forState:UIControlStateNormal];
        [_clearAllBtn addTarget:self action:@selector(clearAll) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _clearAllBtn;
}

- (void)clearAll
{
    self.selectCateId = nil;
    self.catasCell.cataViewCtrl.selectCateId = nil;
    [self.catasCell.cataViewCtrl.tableView reloadData];
    self.selectCateName = @"";
    self.searchCondition.salesPromotion = nil;
    self.searchCondition.priceString = @"";

    [self.tableView reloadData];
    if (_delegate && [_delegate respondsToSelector:@selector(resetCatesAndFilters)])
    {
        [_delegate resetCatesAndFilters];
    }
}

- (void)setItemNum:(NSInteger)itemNum
{
    _itemNum = itemNum;

    NSString *strNum = [NSString stringWithFormat:@"%d", self.itemNum];
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@", L(@"Search_Search"),strNum,L(@"Piece"),L(@"Search_Goods")];
    NSMutableAttributedString *muteStr = [[NSMutableAttributedString alloc] initWithString:str];
    [muteStr setTextColor:[UIColor colorWithRGBHex:0x313131]];
    [muteStr setTextColor:[UIColor colorWithRGBHex:0xfc7c26] range:[str rangeOfString:strNum]];
    [muteStr setFont:[UIFont systemFontOfSize:14]];
    [muteStr setTextAlignment:kCTTextAlignmentLeft lineBreakMode:kCTLineBreakByWordWrapping];
    self.labelItemNum.attributedText = muteStr;
}

- (void)dealloc
{
    if (_filterList && [_filterList count] > 0) {
        for (SearchFilterDTO *valueDTO in _filterList)
        {
            [valueDTO removeObserver:self forKeyPath:@"currentValue"];
        }
    }
}

- (void)setFilterList:(NSArray *)filterList
{
    if (filterList != _filterList) {
        
        if (_filterList && [_filterList count] > 0) {
            for (SearchFilterDTO *valueDTO in _filterList)
            {
                [valueDTO removeObserver:self forKeyPath:@"currentValue"];
            }
        }
        [self.selectFilterMap removeAllObjects];
        
        _filterList = [filterList mutableCopy];
        
        if (_filterList) {
           
            
            
            for (SearchFilterDTO *valueDTO in _filterList)
            {
                
                if (valueDTO.currentValue) {
                    [self.selectFilterMap setObject:valueDTO.currentValue
                                             forKey:valueDTO.filterKey];
                }
                
                [valueDTO addObserver:self
                           forKeyPath:@"currentValue"
                              options:NSKeyValueObservingOptionNew
                              context:nil];
            }
            
            self.filterWithNoPriceList = [_filterList mutableCopy];
            
            //去除价格，用于分类下面的高筛
//            BOOL bHasPrice = NO;
//            int i = 0;
//            for (; i < _filterWithNoPriceList.count; i++)
//            {
//                SearchFilterDTO *dto = [_filterWithNoPriceList objectAtIndex:i];
//                if ([dto.filterName isEqualToString:@"价格"] || [dto.filterKey isEqualToString:@"price"])
//                {
//                    bHasPrice = YES;
//                    break;
//                }
//            }
//            if (bHasPrice)
//            {
//                [_filterWithNoPriceList removeObjectAtIndex:i];
//            }
        }
        
        [self.tableView reloadData];
    }
}

- (void)setSearchCondition:(SearchParamDTO *)searchCondition
{
    if (_searchCondition != searchCondition)
    {
        _searchCondition = searchCondition;
    }
    
    self.arraySelected = [[_searchCondition.salesPromotion componentsSeparatedByString:@","] mutableCopy];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"currentValue"] &&
        [object isKindOfClass:[SearchFilterDTO class]]) {
        
        SearchFilterDTO *dto = (SearchFilterDTO *)object;
        
        if (dto.currentValue) {
            [self.selectFilterMap setObject:dto.currentValue forKey:dto.filterKey];
        }else{
            [self.selectFilterMap removeObjectForKey:dto.filterKey];
        }
    }
}


- (NSMutableDictionary *)selectFilterMap
{
    if (!_selectFilterMap) {
        _selectFilterMap = [[NSMutableDictionary alloc] init];
    }
    return _selectFilterMap;
}


- (void)pickFinishWithCallBack
{
    if (_delegate && [_delegate respondsToSelector:@selector(filterPickDidOk)]) {
        [_delegate filterPickDidOkWithRefreshCompleteCallBack:^(NSArray *filterList){
            
            self.filterList = [filterList mutableCopy];
            [self.tableView reloadData];
            
        }];
    }
//    [self.tableView reloadData];
}

- (SearchFilterDTO *)getPriceDtoFromFilterList
{
    SearchFilterDTO *dto = nil;
    int i = 0;
    for (; i < _filterList.count; i++)
    {
        dto = [_filterList objectAtIndex:i];
        if ([dto.filterName isEqualToString:L(@"Constant_Price")] || [dto.filterKey isEqualToString:@"price"])
        {
            break;
        }
    }
    
    return dto;
}
#pragma mark - TableView Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    if (self.isKeyWordSearch)
        return 5 + self.filterWithNoPriceList.count;
//    else
//        return 4 + self.filterWithNoPriceList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //城市
    if (section == 2)
    {
        if (self.openSectionsFlag & OPEN_CITYS)
            return 1;
        else
            return 0;
    }
    //自营
    else if (section == 1)
    {
//        if (self.openSectionsFlag & OPEN_SELF_SALE)
//            return 2;
//        else
            return 0;
    }
    //有货
    else if (section == 0)
    {
//        if (self.openSectionsFlag & OPEN_HAVE_PRODUCT)
//            return 2;
//        else
            return 0;
    }
    //促销
    else if (section == 3)
    {
        if (self.openSectionsFlag & OPEN_SALE_PROMOTION)
            return 4;
        else
            return 0;
    }
    //价格
//    else if (section == 4)
//    {
//        if (self.openSectionsFlag & OPEN_PRICE)
//        {
//            SearchFilterDTO *priceDto = [self  getPriceDtoFromFilterList];
//            if (priceDto)
//                return priceDto.valueList.count + 1;
//            else
//                return 0;
//        }
//        else
//            return 0;
//    }
    //分类
    else if (section == 4)
    {
        if (self.openSectionsFlag & OPEN_CATAS)
            return 1;
        else
            return 0;
    }
    else if (section >= 5 && (section < 5 + self.filterWithNoPriceList.count))
    {
        if (self.openSectionsFlag & 1 << section)
        {
            int index = section - 5;
            
            if (index >= 0 && index < self.filterWithNoPriceList.count)
            {
                SearchFilterDTO *dto = (SearchFilterDTO *)[self.filterWithNoPriceList objectAtIndex:index];
                return dto.valueList.count + 1;
            }

        }
        return 0;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //分类搜索进来不展示分类section
    if (!self.isKeyWordSearch && section == 4)
        return 0;
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:[tableView rectForSection:section]];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionTapped:)];
    [headerView addGestureRecognizer:tapGes];
    
    UIView *vBottomline = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, 320, 0.5)];
    vBottomline.backgroundColor = [UIColor colorWithRGBHex:0xdcdcdc];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SECTION_TEXT_LEFT, 0, 75, 36)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = SECTION_TEXT_COLOR;
    label.font = [UIFont systemFontOfSize:SECTION_FONT];
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    
    UILabel *selectedContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(label.right + 10, 0, 90, 36)];
    selectedContentLabel.backgroundColor = [UIColor clearColor];
    selectedContentLabel.textColor = RGBCOLOR(200, 200, 200);
    selectedContentLabel.font = [UIFont systemFontOfSize:13];
    selectedContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    
    if (section == 0 || section == 1)
    {
        UIButton *checkButton = (UIButton *)[headerView viewWithTag:1000];
        if (!checkButton)
        {
            checkButton = [[UIButton alloc] initWithFrame:CGRectMake(190, 13, 14, 14)];
            [checkButton setBackgroundImage:[UIImage imageNamed:@"searchFilter_notCheck"] forState:UIControlStateNormal];
            [checkButton setBackgroundImage:[UIImage imageNamed:@"searchFilter_Check"] forState:UIControlStateSelected];
            checkButton.tag = 2000;
            [headerView addSubview:checkButton];
        }
        if (section == 0)
        {
            if ([self.searchCondition.inventory isEqualToString:@"-1"])
            {
                checkButton.selected = NO;
            }
            else if ([self.searchCondition.inventory isEqualToString:@"1"])
            {
                checkButton.selected = YES;
            }
        }
        else if (section == 1)
        {
            if ([self.searchCondition.shopNum isEqualToString:@"-1"])
            {
                checkButton.selected = NO;
            }
            else if ([self.searchCondition.shopNum isEqualToString:@"1"])
            {
                checkButton.selected = YES;
            }
        }
        [checkButton setNeedsDisplay];
    }
    else if (section >= 2)
    {
        UIButton *checkButton = (UIButton *)[headerView viewWithTag:1000];
        if (!checkButton)
        {
            checkButton = [[UIButton alloc] initWithFrame:CGRectMake(190, 15, 11, 6)];
            [checkButton setBackgroundImage:[UIImage imageNamed:@"arrow_bottom_gray"] forState:UIControlStateNormal];
            [checkButton setBackgroundImage:[UIImage imageNamed:@"arrow_top_gray"] forState:UIControlStateSelected];
            checkButton.tag = 1000;
            [headerView addSubview:checkButton];
        }
        
        if (self.openSectionsFlag & 1 << section)
        {
            checkButton.selected = YES;
        }
        else
        {
            checkButton.selected = NO;
        }
        
        [checkButton setNeedsDisplay];
    }
    
    [headerView addSubview:selectedContentLabel];
    [headerView addSubview:label];
    [headerView addSubview:vBottomline];
    
    if (section == 2)
    {
        label.text = L(@"Search_DeliveryCity");
        
        AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
        NSString *cityName = [dao getCityNameByCityCode:[Config currentConfig].defaultCity];
        selectedContentLabel.text = cityName;
    }
    else if (section == 1)
    {
        label.width = 100;
        label.text = L(@"Search_JustLookSuningSelf");
    }
    else if (section == 0)
    {
        label.width = 100;
        label.text = L(@"Search_JustLookInStockGoods");
    }
    else if (section == 3)
    {
        label.text = L(@"Search_PromotionType");
        if (NotNilAndNull(self.searchCondition.salesPromotion))
        {
            NSArray *arr = [self.searchCondition.salesPromotion componentsSeparatedByString:@","];
            NSString *str = self.searchCondition.salesPromotion;
            if (arr.count == 0)
            {
                selectedContentLabel.text = @"";
            }
            else if (arr.count == 1)
            {
                if ([str isEqualToString:@"zj"])
                {
                    selectedContentLabel.text = L(@"Search_Reduce");
                }
                else if ([str isEqualToString:@"fq"])
                {
                    selectedContentLabel.text = L(@"Search_ReturnTicket");
                }
               
            }
            else if (arr.count == 2)
            {
                selectedContentLabel.text = L(@"Search_AllPromotion");
            }

        }
    }
    else if (section == 4)
    {
        label.text = L(@"Categories");
        selectedContentLabel.text = self.selectCateName;
    }
    else if (section >= 5 && (section < 5 + self.filterWithNoPriceList.count))
    {
        int index = section - 5;
        if (index >= 0 && index < self.filterWithNoPriceList.count)
        {
            SearchFilterDTO *dto = (SearchFilterDTO *)[self.filterWithNoPriceList objectAtIndex:index];
            NSString *strName = dto.filterName;
            if (dto.filterName.length >= 5)
            {
                strName = [strName substringToIndex:4];
                strName = [strName stringByAppendingString:@"..."];
            }
            label.text = strName;
            selectedContentLabel.text = dto.currentValueDesc;
        }
    }

    headerView.tag = 100 + section;
    return headerView;
}

- (void)sectionTapped:(UITapGestureRecognizer *)sender
{
    UIView *v = sender.view;
    
    int selectedSection = v.tag - 100;
    if (selectedSection == 0)
    {
        if ([self.searchCondition.inventory isEqualToString:@"-1"])
        {
            self.searchCondition.inventory = @"1";
            
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:@"831301", nil]];
        }
        else if ([self.searchCondition.inventory isEqualToString:@"1"])
        {
            self.searchCondition.inventory = @"-1";
        }
        
        [self.tableView reloadData];
        [self pickFinishWithCallBack];
        return;
    }
    else if (selectedSection == 1)
    {
        if ([self.searchCondition.shopNum isEqualToString:@"-1"])
        {
            self.searchCondition.shopNum = @"1";
            
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:@"831302", nil]];
        }
        else if ([self.searchCondition.shopNum isEqualToString:@"1"])
        {
            self.searchCondition.shopNum = @"-1";
        }
        
        [self.tableView reloadData];
        [self pickFinishWithCallBack];
        return;
    }
    else if (selectedSection >= 2)
    {
        self.openSectionsFlag ^= (1 << selectedSection);
        
        if (selectedSection == 2)
        {
            if (self.openSectionsFlag & OPEN_CITYS)
            {
//                [self.tableView reloadData];
//                
//                NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:selectedSection];
//                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexpath, nil] withRowAnimation:UITableViewRowAnimationBottom];
            }
            else
            {
//                NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:selectedSection];
//                
//                //直接reloadSection效果不好，section会先收起，cell再消失
//                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexpath, nil] withRowAnimation:UITableViewRowAnimationTop];
//                
//                //此处是为了刷新section的headerView
//                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:selectedSection] withRowAnimation:UITableViewRowAnimationNone];
            }
            
            [self.tableView reloadData];
        }
        else if (selectedSection == 4)
        {
            if (self.openSectionsFlag & OPEN_CATAS)
            {
                if (self.isKeyWordSearch)
                {
                    if (self.searchCondition.searchType == SearchTypeCategory_2 || self.searchCondition.searchType == SearchTypeCategory_3)
                    {
                        self.catasCell.cataViewCtrl.bSearchingCategory = YES;
                    }
                    else
                    {
                        self.catasCell.cataViewCtrl.bSearchingCategory = NO;
                    }
                }
                
                NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:4];
                [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObjects:indexpath, nil] withRowAnimation:UITableViewRowAnimationTop];
                return;
            }
            
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:4];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexpath, nil] withRowAnimation:UITableViewRowAnimationTop];
            
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
            return;
        }
        else  //除了分类和城市，其他的section直接刷新就可以
        {
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:selectedSection] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2)
    {
        return self.citysCell.tableView.contentSize.height;
    }
    else if (indexPath.section == 4)
    {
        return self.catasCell.cataViewCtrl.tableView.contentSize.height;
    }
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    
    //城市
    if (section == 2)
    {
        return [self getCityView:tableView cellForRowAtIndexPath:indexPath];
    }
    //自营
    else if (section == 1)
    {
        //return [self getSelfSaleCell:tableView cellForRowAtIndexPath:indexPath];
    }
    //是否有货
    else if (section == 0)
    {
        //return [self getHaveProductCell:tableView cellForRowAtIndexPath:indexPath];
    }
    //促销
    else if (section == 3)
    {
        return [self getSalePromotionCell:tableView cellForRowAtIndexPath:indexPath];
    }
//    //价格
//    else if (section == 4)
//    {
//        return [self getPriceCell:tableView cellForRowAtIndexPath:indexPath];
//    }
    //分类
    else if (section == 4)
    {
        return [self getCataCell:tableView cellForRowAtIndexPath:indexPath];
    }
    else if (section >= 5 && (section < 5 + self.filterWithNoPriceList.count))
    {
        return [self getFiltersCell:tableView cellForRowAtIndexPath:indexPath];
    }
    
    return [UITableViewCell new];
}

- (UITableViewCell *)getFiltersCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"FilterCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = CELL_BACK_COLOR;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CELL_TEXT_LEFT, 10, TABLEVIEWWIDTH, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = CELL_TEXT_COLOR;
        label.font = [UIFont systemFontOfSize:CELL_FONT];
        label.tag = 100;
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CHECK_RECT];
        img.image = [UIImage imageNamed:CHECK_IMAGENAME];
        img.hidden = YES;
        img.tag = 101;
        
        UIImageView *sepLine = [[UIImageView alloc] initWithFrame:SEPLINE_RECT];
        sepLine.image = [UIImage imageNamed:SEPLINE_IMGNAME];
        
        [cell.contentView addSubview:sepLine];
        [cell.contentView addSubview:label];
        [cell.contentView addSubview:img];
    }
    
    if (indexPath.section >= 5 && (indexPath.section < 5 + self.filterWithNoPriceList.count))
    {
        SearchFilterDTO *parentDto = [self.filterWithNoPriceList objectAtIndex:indexPath.section - 5];
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:100];
        if (label)
        {
            if (indexPath.row == 0)
            {
                label.text = L(@"Constant_All");
            }
            else
            {
                SearchFilterValueDTO *dto = [parentDto.valueList objectAtIndex:indexPath.row  - 1];
                label.text = dto.valueDesc;
            }
        }
        
        UIImageView *img = (UIImageView *)[cell viewWithTag:101];
        if (img)
        {
            img.hidden = YES;
            
            if (indexPath.row == 0)
            {
                if (parentDto.currentValue == nil)
                    img.hidden = NO;
            }
            else
            {
                SearchFilterValueDTO *dto = [parentDto.valueList objectAtIndex:indexPath.row  - 1];
                if (dto.checked)
                    img.hidden = NO;
            }
        }
    }

    return cell;

}

- (CitysFilterTableViewCell *)getCityView:(UITableView *)tableView
 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect rc = [tableView rectForRowAtIndexPath:indexPath];
    self.citysCell.height = rc.size.height;
    self.citysCell.tableView.frame = self.citysCell.bounds;
    return self.citysCell;
}

- (CitysFilterTableViewCell *)citysCell
{
    if (!_citysCell)
    {
        _citysCell = [[CitysFilterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cityCell"];
        _citysCell.filterCtrl = self;
    }
    
    return _citysCell;
}

- (CatasFilterTableViewCell *)getCataCell:(UITableView *)tableView
                    cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect rc = [tableView rectForRowAtIndexPath:indexPath];
    self.catasCell.height = rc.size.height;
    self.catasCell.cataViewCtrl.view.frame = self.catasCell.bounds;
    self.catasCell.cataViewCtrl.tableView.frame = self.catasCell.bounds;
    self.catasCell.cataViewCtrl.delegate = self.delegate;
    self.catasCell.cataViewCtrl.filterPopupViewController = self;
    return self.catasCell;
}

- (CatasFilterTableViewCell *)catasCell
{
    if (!_catasCell)
    {
        _catasCell = [[CatasFilterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"catasCell"];
        [_catasCell refreshWithCataList:self.categoryList];
    }
    
    return _catasCell;
}

//- (UITableViewCell *)getSelfSaleCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *str = @"SelfSaleCell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
//    if (!cell)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.contentView.backgroundColor = CELL_BACK_COLOR;
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CELL_TEXT_LEFT, 10, TABLEVIEWWIDTH, 20)];
//        label.backgroundColor = [UIColor clearColor];
//        label.textColor = CELL_TEXT_COLOR;
//        label.font = [UIFont systemFontOfSize:CELL_FONT];
//        label.tag = 100;
//        
//        UIImageView *img = [[UIImageView alloc] initWithFrame:CHECK_RECT];
//        img.image = [UIImage imageNamed:CHECK_IMAGENAME];
//        img.hidden = YES;
//        img.tag = 101;
//        
//        UIImageView *sepLine = [[UIImageView alloc] initWithFrame:SEPLINE_RECT];
//        sepLine.image = [UIImage imageNamed:SEPLINE_IMGNAME];
//        
//        [cell.contentView addSubview:sepLine];
//        
//        [cell.contentView addSubview:label];
//        [cell.contentView addSubview:img];
//    }
//    UILabel *label = (UILabel *)[cell.contentView viewWithTag:100];
//    if (label)
//    {
//        if (indexPath.row == 0)
//        {
//            label.text = @"所有";
//        }
//        else if (indexPath.row == 1)
//        {
//            label.text = @"选择自营产品";
//        }
//    }
//    
//    UIImageView *img = (UIImageView *)[cell viewWithTag:101];
//    if (img)
//    {
//        img.hidden = YES;
//        
//        if (([self.searchCondition.shopNum isEqualToString:@"-1"] && indexPath.row == 0) || ([self.searchCondition.shopNum isEqualToString:@"1"] && indexPath.row == 1))
//        {
//            img.hidden = NO;
//        }
//    }
//    
//    return cell;
//}
//
//- (UITableViewCell *)getHaveProductCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *str = @"HaveProductCell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
//    if (!cell)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.contentView.backgroundColor = CELL_BACK_COLOR;
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CELL_TEXT_LEFT, 10, TABLEVIEWWIDTH, 20)];
//        label.backgroundColor = [UIColor clearColor];
//        label.textColor = CELL_TEXT_COLOR;
//        label.font = [UIFont systemFontOfSize:CELL_FONT];
//        label.tag = 100;
//        
//        UIImageView *img = [[UIImageView alloc] initWithFrame:CHECK_RECT];
//        img.image = [UIImage imageNamed:CHECK_IMAGENAME];
//        img.hidden = YES;
//        img.tag = 101;
//        
//        UIImageView *sepLine = [[UIImageView alloc] initWithFrame:SEPLINE_RECT];
//        sepLine.image = [UIImage imageNamed:SEPLINE_IMGNAME];
//        
//        [cell.contentView addSubview:sepLine];
//        
//        [cell.contentView addSubview:label];
//        [cell.contentView addSubview:img];
//    }
//    UILabel *label = (UILabel *)[cell.contentView viewWithTag:100];
//    if (label)
//    {
//        if (indexPath.row == 0)
//        {
//            label.text = @"所有";
//        }
//        else if (indexPath.row == 1)
//        {
//            label.text = @"有货";
//        }
//    }
//    
//    UIImageView *img = (UIImageView *)[cell viewWithTag:101];
//    if (img)
//    {
//        img.hidden = YES;
//        
//        if (([self.searchCondition.inventory isEqualToString:@"-1"] && indexPath.row == 0) || ([self.searchCondition.inventory isEqualToString:@"1"] && indexPath.row == 1))
//        {
//            img.hidden = NO;
//        }
//    }
//    
//    return cell;
//}

- (UITableViewCell *)getSalePromotionCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"SalePromotionCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = CELL_BACK_COLOR;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CELL_TEXT_LEFT, 10, TABLEVIEWWIDTH, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = CELL_TEXT_COLOR;
        label.font = [UIFont systemFontOfSize:CELL_FONT];
        label.tag = 100;
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CHECK_RECT];
        img.image = [UIImage imageNamed:CHECK_IMAGENAME];
        img.hidden = YES;
        img.tag = 101;
        
        UIImageView *sepLine = [[UIImageView alloc] initWithFrame:SEPLINE_RECT];
        sepLine.image = [UIImage imageNamed:SEPLINE_IMGNAME];
        
        [cell.contentView addSubview:sepLine];
        
        [cell.contentView addSubview:label];
        [cell.contentView addSubview:img];
    }
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:100];
    if (label)
    {
        if (indexPath.row == 0)
        {
            label.text = L(@"Search_AllMerchandise");
        }
        else if (indexPath.row == 1)
        {
            label.text = L(@"Search_AllPromotion");
        }
        else if (indexPath.row == 2)
        {
            label.text = L(@"Search_Reduce");
        }
//        else if (indexPath.row == 3)
//        {
//            label.text = L(@"Search_GroupPurchase");
//        }
        else if (indexPath.row == 3)
        {
            label.text = L(@"Search_ReturnTicket");
        }
//        else if (indexPath.row == 3)
//        {
//            label.text = L(@"Search_PanicBuying");
//        }
    }
    
    UIImageView *img = (UIImageView *)[cell viewWithTag:101];
    if (img)
    {
        img.hidden = YES;
        
        if (self.arraySelected.count == 2)
        {
            if (indexPath.row == 1)
                img.hidden = NO;
        }
        else if (self.arraySelected.count == 0)
        {
            if (indexPath.row == 0)
                img.hidden = NO;
        }
        else
        {
            NSString *strSelected = [self.arraySelected objectAtIndex:0];
            
            for (SalesFiltersDto *dto in self.arrayItems)
            {
                if ([dto.value isEqualToString:strSelected])
                {
                    int index = [self.arrayItems indexOfObject:dto];
                    if (indexPath.row == index)
                    {
                        img.hidden = NO;
                    }
                }
            }

        }
    }
    
    return cell;
}

//- (UITableViewCell *)getPriceCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *str = @"PriceCell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
//    if (!cell)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        cell.contentView.backgroundColor = CELL_BACK_COLOR;
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CELL_TEXT_LEFT, 10, TABLEVIEWWIDTH, 20)];
//        label.backgroundColor = [UIColor clearColor];
//        label.textColor = CELL_TEXT_COLOR;
//        label.font = [UIFont systemFontOfSize:CELL_FONT];
//        label.tag = 100;
//        
//        UIImageView *img = [[UIImageView alloc] initWithFrame:CHECK_RECT];
//        img.image = [UIImage imageNamed:CHECK_IMAGENAME];
//        img.hidden = YES;
//        img.tag = 101;
//        
//        UIImageView *sepLine = [[UIImageView alloc] initWithFrame:SEPLINE_RECT];
//        sepLine.image = [UIImage imageNamed:SEPLINE_IMGNAME];
//        
//        [cell.contentView addSubview:sepLine];
//        
//        [cell.contentView addSubview:label];
//        [cell.contentView addSubview:img];
//    }
//    UILabel *label = (UILabel *)[cell.contentView viewWithTag:100];
//    
//    SearchFilterDTO *priceDto = [self getPriceDtoFromFilterList];
//    
//    if (label)
//    {
//        if (indexPath.row == 0)
//        {
//            label.text = @"所有";
//        }
//        else
//        {
//            if (priceDto && priceDto.valueList && priceDto.valueList.count > 0)
//            {
//                SearchFilterValueDTO *subPriceDto = (SearchFilterValueDTO *)[priceDto.valueList objectAtIndex:indexPath.row - 1];
//                label.text = subPriceDto.valueDesc;
//            }
//        }
//    }
//    
//    UIImageView *img = (UIImageView *)[cell viewWithTag:101];
//    if (img)
//    {
//        img.hidden = YES;
//        
//        if (indexPath.row == 0)
//        {
//            if (priceDto && priceDto.currentValue == nil)
//            {
//                img.hidden = NO;
//            }
//        }
//        else
//        {
//            if (priceDto && priceDto.valueList && priceDto.valueList.count > 0)
//            {
//                SearchFilterValueDTO *subPriceDto = (SearchFilterValueDTO *)[priceDto.valueList objectAtIndex:indexPath.row  - 1];
//                if (subPriceDto.checked)
//                    img.hidden = NO;
//            }
//        }
//    }
//    
//    return cell;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1)//自营
    {
//        [self didSelectSelfSaleCell:indexPath];
    }
    else if (indexPath.section == 0) //有货
    {
//        [self didSelectHaveProductCell:indexPath];
    }
    else if (indexPath.section == 3) //促销
    {
        [self didSelectSalePromotionCell:indexPath];
    }
//    else if (indexPath.section == 4)
//    {
//        [self didSelectPriceCell:indexPath];
//    }
    else if (indexPath.section >= 5 && (indexPath.section < 5 + self.filterWithNoPriceList.count))
    {
        [self didSelectFiltersCell:indexPath];
    }
    
    self.openSectionsFlag ^= 1 << indexPath.section;
    [self.tableView reloadData];
}

- (void)didSelectFiltersCell:(NSIndexPath *)indexPath
{
    if (indexPath.section - 5 >= self.filterWithNoPriceList.count)
        return;
    
    SearchFilterDTO *parentDto = [self.filterWithNoPriceList objectAtIndex:indexPath.section - 5];
    
    if (indexPath.row == 0)
    {
        [parentDto setSelectAll];
    }
    else
    {
        [parentDto setSelectValueAtIndex:indexPath.row - 1];
    }
    
    [self pickFinishWithCallBack];
}

//- (void)didSelectPriceCell:(NSIndexPath *)indexPath
//{
//    SearchFilterDTO *priceDto = [self getPriceDtoFromFilterList];
//    if (indexPath.row == 0)
//    {
//        [priceDto setSelectAll];
//    }
//    else
//    {
//        [priceDto setSelectValueAtIndex:indexPath.row - 1];
//    }
//    
//    [self pickFinishWithCallBack];
//}

//- (void)didSelectSelfSaleCell:(NSIndexPath *)indexPath
//{
//    if (indexPath.row == 0) //所有
//    {
//        self.searchCondition.shopNum = @"-1";
//    }
//    else if (indexPath.row == 1) //自营
//    {
//        self.searchCondition.shopNum = @"1";
//    }
//    
//    [self pickFinishWithCallBack];
//}
//
//- (void)didSelectHaveProductCell:(NSIndexPath *)indexPath
//{
//    if (indexPath.row == 0) //所有
//    {
//        self.searchCondition.inventory = @"-1";
//    }
//    else if (indexPath.row == 1)
//    {
//        self.searchCondition.inventory = @"1";
//    }
//    
//    [self pickFinishWithCallBack];
//}

- (void)didSelectSalePromotionCell:(NSIndexPath *)indexPath
{
    //选中全部
    if (indexPath.row == 0) {
        self.searchCondition.salesPromotion = nil;
    }
    //选择全部促销
    else if (indexPath.row == 1)
    {
        self.searchCondition.salesPromotion = @"zj,fq";
    }
    else
    {
        SalesFiltersDto *dto = [self.arrayItems objectAtIndex:indexPath.row];
        
        self.searchCondition.salesPromotion = dto.value;
    }
    
     self.arraySelected = [[_searchCondition.salesPromotion componentsSeparatedByString:@","] mutableCopy];
    [self pickFinishWithCallBack];
}
@end

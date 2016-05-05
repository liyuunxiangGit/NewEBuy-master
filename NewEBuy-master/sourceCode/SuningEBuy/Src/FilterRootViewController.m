//
//  FilterRootViewController.m
//  SuningEBuy
//
//  Created by chupeng on 13-12-13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "FilterRootViewController.h"
#import "SNFilterPickCell.h"
#import "FilterPickSecondViewController.h"
#import "SearchListService.h"
#import "NewCatePickViewController.h"
#import "ProvincePickViewController.h"
#import "AddressInfoDAO.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>

#define TXTCOLOR_SELECTEDITEM  RGBCOLOR(252, 124, 38)
//#define TXTCOLOR_BLACK         RGBCOLOR(52, 52, 52)
//#define TXTCOLOR_GRAY          RGBCOLOR(67, 67, 67)

#define TXTCOLOR_BLACK         RGBCOLOR(49, 49, 49)
#define TXTCOLOR_GRAY          RGBCOLOR(49, 49, 49)

//#define FONTSIZE_LEFTLABEL     17.0
//#define FONTSIZE_RIGHTLABEL    14.0

#define FONTSIZE_LEFTLABEL     14.0
#define FONTSIZE_RIGHTLABEL    14.0

@implementation UISegmentEffectView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.grayBackImgView];
        [self addSubview:self.orangeBackImgView];
        [self addSubview:self.ballImgView];
        self.orangeBackImgView.alpha = 0;
        self.userInteractionEnabled = NO;
    }
    
    return self;
}

- (void)setBSelected:(BOOL)bSelected
{
    if (bSelected)
    {
        [UIView animateWithDuration:0.15 animations:^{
            self.ballImgView.frame = CGRectMake(20, 0, 31, 31);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                self.orangeBackImgView.alpha = 1;
            }];
        }];
    }
    else
    {
        [UIView animateWithDuration:0.15 animations:^{
            self.ballImgView.frame = CGRectMake(0, 0, 31, 31);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                self.orangeBackImgView.alpha = 0;
            }];
        }];
    }
}

- (UIImageView *)grayBackImgView
{
    if (!_grayBackImgView)
    {
        _grayBackImgView = [[UIImageView alloc] initWithFrame:self.bounds];
        _grayBackImgView.image = [UIImage streImageNamed:@"Segment_NormalBack"];
    }
    return _grayBackImgView;
}

- (UIImageView *)orangeBackImgView
{
    if (!_orangeBackImgView)
    {
        _orangeBackImgView = [[UIImageView alloc] initWithFrame:self.bounds];
        _orangeBackImgView.image = [UIImage streImageNamed:@"Segment_HotBack"];
    }
    return _orangeBackImgView;
}

- (UIImageView*)ballImgView
{
    if (!_ballImgView)
    {
        _ballImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 31, 31)];
        _ballImgView.image = [UIImage streImageNamed:@"Segment_Ball"];
    }
    
    return _ballImgView;
}
@end


@interface FilterRootViewController ()
@property (nonatomic, strong) UISwitch *searchHasStockSwitch;

@property (nonatomic, strong) UIView   *btnsView;//底部两个按钮的视图
@property (nonatomic, strong) UIButton *resetBtn;//重置btn
@property (nonatomic, strong) UIButton *okBtn;   //确定btn
@property (nonatomic, strong) UIButton                            *switchBtn;
@property (nonatomic, strong) UIButton                            *radiusBtn;
@property (nonatomic, strong) UISegmentEffectView  *switchBtnEffect;
@property (nonatomic, strong) UISegmentEffectView  *radiusBtnEffect;
@end

@implementation FilterRootViewController
@synthesize delegate = _delegate;
@synthesize filterList = _filterList;
@synthesize selectFilterMap = _selectFilterMap;
@synthesize switchBtn=_switchBtn;
@synthesize categoryList = _categoryList;
@synthesize selectCateId = _selectCateId;

- (void)dealloc
{
    self.filterList = nil;
    TT_RELEASE_SAFELY(_selectFilterMap);
    TT_RELEASE_SAFELY(_searchHasStockSwitch);
    TT_RELEASE_SAFELY(_searchCondition);
    TT_RELEASE_SAFELY(_switchBtn);
    TT_RELEASE_SAFELY(_categoryList);
    TT_RELEASE_SAFELY(_selectCateId);
    
}

- (id)init
{
    if (self = [super init]) {
        if (IOS7_OR_LATER)
            self.edgesForExtendedLayout = UIRectEdgeBottom;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide) name:UIKeyboardWillHideNotification object:nil];
    }
    
    return self;
}

- (void)keyboardHide
{
//    [self validatePriceStrAndSearch];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //CGRect rc = self.view.frame;
    
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor = RGBCOLOR(241, 241, 241);
    
    if (IOS7_OR_LATER)
        self.tableView.backgroundColor = RGBCOLOR(241, 241, 241);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (UITableView *)tableView{
	
	if(!_tableView){
		
		_tableView = [TPKeyboardAvoidingTableView tableView];
		
		_tableView.delegate =self;
		
		_tableView.dataSource =self;
    }
	
	return _tableView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *strNum = [NSString stringWithFormat:@"%d", self.itemNum];
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@", L(@"Search_Search"),strNum,L(@"Piece"),L(@"Search_Goods")];
    NSMutableAttributedString *muteStr = [[NSMutableAttributedString alloc] initWithString:str];
    [muteStr setTextColor:[UIColor colorWithRGBHex:0x313131]];
    [muteStr setTextColor:[UIColor colorWithRGBHex:0xfc7c26] range:[str rangeOfString:strNum]];
    [muteStr setFont:[UIFont systemFontOfSize:16]];
    [muteStr setTextAlignment:kCTTextAlignmentCenter lineBreakMode:kCTLineBreakByWordWrapping];
    self.titleLabel.attributedText = muteStr;
    
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.btnsView];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, self.btnsView.height, 0);
    [self.tableView reloadData];
    
    NSLog(@"%@", NSStringFromCGRect(self.view.frame));
}

- (OHAttributedLabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(0, 11, 200, 20)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.underlineLinks = NO;
        _titleLabel.automaticallyAddLinksForType = 0;
        self.navigationItem.titleView = _titleLabel;
    }
    return _titleLabel;
}

- (void)setItemNum:(NSInteger)itemNum
{
    _itemNum = itemNum;
    NSString *strNum = [NSString stringWithFormat:@"%d", self.itemNum];
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@", L(@"Search_Search"),strNum,L(@"Piece"),L(@"Search_Goods")];
    NSMutableAttributedString *muteStr = [[NSMutableAttributedString alloc] initWithString:str];
    [muteStr setTextColor:[UIColor colorWithRGBHex:0x313131]];
    [muteStr setTextColor:[UIColor colorWithRGBHex:0xfc7c26] range:[str rangeOfString:strNum]];
    [muteStr setFont:[UIFont systemFontOfSize:16]];
    [muteStr setTextAlignment:kCTTextAlignmentCenter lineBreakMode:kCTLineBreakByWordWrapping];
    self.titleLabel.attributedText = muteStr;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - 高级筛选项相关

- (UIView *)btnsView
{
    if (!_btnsView)
    {
        _btnsView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 45, self.view.bounds.size.width, 45)];
        _btnsView.backgroundColor = [UIColor whiteColor];
//        UIImageView *backImgView = [[UIImageView alloc] initWithFrame:_btnsView.bounds];
//        backImgView.image = [UIImage imageNamed:@"search_filterRoot_bottomViewBack"];
        
//        [_btnsView addSubview:backImgView];
        [_btnsView addSubview:self.okBtn];
        self.okBtn.frame = CGRectMake(_btnsView.frame.size.width - 10 - 218 / 2, 5, self.okBtn.size.width, self.okBtn.size.height);
        [_btnsView addSubview:self.resetBtn];
    }
    return _btnsView;
}

- (UIButton *)okBtn
{
    if (!_okBtn)
    {
        _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _okBtn.frame = CGRectMake(10, 5, 218 / 2, 35);
        [_okBtn setBackgroundImage:[UIImage streImageNamed:@"button_orange_normal"] forState:UIControlStateNormal];
        [_okBtn setBackgroundImage:[UIImage streImageNamed:@"button_orange_click"] forState:UIControlStateHighlighted];
//        [_okBtn setBackgroundImage:[UIImage streImageNamed:@"search_filterRoot_okBtn"] forState:UIControlStateNormal];
        [_okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_okBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [_okBtn setTitle:L(@"Ok") forState:UIControlStateNormal];
        [_okBtn setTitle:L(@"Ok") forState:UIControlStateHighlighted];
        [_okBtn addTarget:self action:@selector(filteOk:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okBtn;
}

- (void)filteOk:(id)sender
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"831101"], nil]];
    if (_delegate && [_delegate respondsToSelector:@selector(allFilteOk)])
    {
        [_delegate allFilteOk];
    }
}

- (UIButton *)resetBtn
{
    if (!_resetBtn)
    {
        _resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _resetBtn.frame = CGRectMake(10, 5, 218 / 2, 35);
        [_resetBtn setBackgroundImage:[UIImage streImageNamed:@"button_white_normal"] forState:UIControlStateNormal];
        [_resetBtn setBackgroundImage:[UIImage streImageNamed:@"button_white_clicked"] forState:UIControlStateHighlighted];
//        [_resetBtn setBackgroundImage:[UIImage streImageNamed:@"search_filterRoot_resetBtn"] forState:UIControlStateNormal];
        [_resetBtn setTitleColor:RGBCOLOR(118, 83, 20) forState:UIControlStateNormal];
        [_resetBtn setTitleColor:RGBCOLOR(118, 83, 20) forState:UIControlStateHighlighted];
        [_resetBtn setTitle:L(@"Constant_Clean") forState:UIControlStateNormal];
        [_resetBtn setTitle:L(@"Constant_Clean") forState:UIControlStateHighlighted];
        [_resetBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [_resetBtn addTarget:self action:@selector(resetFilter:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetBtn;
}

- (void)resetFilter:(id)sender
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"831201"], nil]];
    self.selectCateId = nil;
    self.radiusBtn.selected = NO;
    [self.radiusBtn setNeedsDisplay];
    self.switchBtn.selected = YES;
    [self.switchBtn setNeedsDisplay];
    
    self.searchCondition.salesPromotion = nil;
    self.searchCondition.priceString = @"";
    self.inputPrice1.text = @"";
    self.inputPrice2.text = @"";
    
    if (_switchBtnEffect)
    {
        [_switchBtnEffect setBSelected:YES];
    }
    if (_radiusBtnEffect)
    {
        [_radiusBtnEffect setBSelected:NO];
    }
    
    [self.tableView reloadData];
    if (_delegate && [_delegate respondsToSelector:@selector(resetCatesAndFilters)])
    {
        [_delegate resetCatesAndFilters];
    }
}

- (void)resetFilters
{
    self.selectCateId = nil;
    self.radiusBtn.selected = NO;
    [self.radiusBtn setNeedsDisplay];
    self.switchBtn.selected = YES;
    [self.switchBtn setNeedsDisplay];
    
    self.searchCondition.salesPromotion = nil;
    self.searchCondition.priceString = @"";
    self.inputPrice1.text = @"";
    self.inputPrice2.text = @"";
    
    if (_switchBtnEffect)
    {
        [_switchBtnEffect setBSelected:YES];
    }
    if (_radiusBtnEffect)
    {
        [_radiusBtnEffect setBSelected:NO];
    }
    
    [self.tableView reloadData];

}

- (NSMutableDictionary *)selectFilterMap
{
    if (!_selectFilterMap) {
        _selectFilterMap = [[NSMutableDictionary alloc] init];
    }
    return _selectFilterMap;
}

- (void)setSearchHasStockOn:(id)sender
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"830701"], nil]];
    if (![self.searchCondition.inventory isEqualToString:@"1"]) {
        self.searchCondition.inventory = @"1";
    }else{
        self.searchCondition.inventory = @"-1";
    }
    
    [self pickFinishWithCallBack];
}

- (void)setSearchShopNum:(id)sender
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"830601"], nil]];
    if (![self.searchCondition.shopNum isEqualToString:@"1"]&&![self.searchCondition.shopNum isEqualToString:@""]) {
        self.searchCondition.shopNum = @"1";
    }
    else
    {
        self.searchCondition.shopNum = @"-1";
    }
    
    [self pickFinishWithCallBack];
    
}

- (BOOL)isSearchHasStockOn
{
    if ([self.searchCondition.inventory isEqualToString:@"1"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (UISwitch *)searchHasStockSwitch
{
    if (!_searchHasStockSwitch) {
        _searchHasStockSwitch = [[UISwitch alloc] init];
        _searchHasStockSwitch.on = [self isSearchHasStockOn];
        [_searchHasStockSwitch addTarget:self
                                  action:@selector(setSearchHasStockOn:)
                        forControlEvents:UIControlEventValueChanged];
    }
    return _searchHasStockSwitch;
}

- (UIButton *)switchBtn
{
    if (!_switchBtn) {
        _switchBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
        
//        [_switchBtn setBackgroundImage:[UIImage imageNamed:@"search_switch_off.png"] forState:UIControlStateNormal];
//        
//        [_switchBtn setBackgroundImage:[UIImage imageNamed:@"search_switch_on.png"] forState:UIControlStateSelected];
        
        [_switchBtn addTarget:self action:@selector(switchBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        _switchBtn.selected = YES;
        if (!_switchBtnEffect)
        {
            _switchBtnEffect = [[UISegmentEffectView alloc] initWithFrame:_switchBtn.bounds];
            [_switchBtnEffect setBSelected:YES];
            [_switchBtn addSubview:_switchBtnEffect];
            
        }
    }
    return _switchBtn;
}

- (UIButton *)radiusBtn
{
    if (!_radiusBtn) {
        _radiusBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
        
//        [_radiusBtn setBackgroundImage:[UIImage imageNamed:@"search_switch_off.png"] forState:UIControlStateNormal];
//        
//        [_radiusBtn setBackgroundImage:[UIImage imageNamed:@"search_switch_on.png"] forState:UIControlStateSelected];
        
        [_radiusBtn addTarget:self action:@selector(radiusBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
        
        if (!_radiusBtnEffect)
        {
            _radiusBtnEffect = [[UISegmentEffectView alloc] initWithFrame:_radiusBtn.bounds];
            [_radiusBtn addSubview:_radiusBtnEffect];
        }
    }
    return _radiusBtn;
}

- (void)switchBtnClicked:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    btn.selected = !btn.selected;
    if (_switchBtnEffect)
    {
        [_switchBtnEffect setBSelected:btn.selected];
    }
    
    [self performSelector:@selector(setSearchHasStockOn:) withObject:nil afterDelay:0.3];
}

- (void)radiusBtnCliked:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    btn.selected = !btn.selected;
    if (_radiusBtnEffect) {
        [_radiusBtnEffect setBSelected:btn.selected];
    }
 
    [self performSelector:@selector(setSearchShopNum:) withObject:nil afterDelay:0.3];
}

- (void)resetSwitchBtns
{
    self.switchBtn.selected = YES;
    self.radiusBtn.selected = NO;
    [self.switchBtn setNeedsDisplay];
    [self.radiusBtn setNeedsDisplay];
    
    if (_switchBtnEffect)
    {
        [_switchBtnEffect setBSelected:YES];
    }
    if (_radiusBtnEffect)
    {
        [_radiusBtnEffect setBSelected:NO];
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
            //使用价格区间，隐藏服务器返回的价格筛选项 by chupeng 2014-5-28
            BOOL bHasPrice = NO;
            int i = 0;
            for (; i < _filterList.count; i++)
            {
                SearchFilterDTO *dto = [_filterList objectAtIndex:i];
                if ([dto.filterName isEqualToString:L(@"Constant_Price")] || [dto.filterKey isEqualToString:@"price"])
                {
                    bHasPrice = YES;
                    break;
                }
            }
            if (bHasPrice)
            {
                [_filterList removeObjectAtIndex:i];
            }
            
            
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
        }
    }
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

//- (id)initWithFitlerList:(NSArray *)filList
//{
////    self = [super init];
////    
////    if (self) {
////        self.filterList = filList;
////        self.title = L(@"Filter");
////    }
////    return self;
//}

- (void)pickFinish
{
    if (_delegate && [_delegate respondsToSelector:@selector(filterPickDidOk)]) {
        [_delegate filterPickDidOk];
    }
}

- (void)pickFinishWithCallBack
{
    //[self displayOverFlowActivityView];
    if (_delegate && [_delegate respondsToSelector:@selector(filterPickDidOk)]) {
        [_delegate filterPickDidOkWithRefreshCompleteCallBack:^(NSArray *filterList){
            
            //[self removeOverFlowActivityView];
            self.filterList = [filterList mutableCopy];
            [self.tableView reloadData];
            
        }];
    }
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark Table View Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section == 0) //选择城市cell
    {
        return 1;
    }
    else if (section == 1) // 两个“只看”cell, 促销， 价格区间
    {
        return 4;
    }
    else if (section == 2) //全部分类cell
    {
        return 1;
    }
    else if (section == 3) //高级筛选项cells
    {
        if (self.searchCondition.set == SearchSetBook)
        {
            return [_filterList count];
        }
        else
        {
            return [_filterList count];
        }
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    
    if (section == 0) //选择城市cell
    {
        static NSString *stringForCityCell = @"stringForCityCell";
        SNFilterPickCell *cell = [tableView dequeueReusableCellWithIdentifier:stringForCityCell];
        if (!cell)
        {
            cell = [[SNFilterPickCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringForCityCell];
            cell.textLabel.font = [UIFont systemFontOfSize:FONTSIZE_LEFTLABEL];
            cell.textLabel.textColor = TXTCOLOR_BLACK;
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.accessoryLabel.textColor = TXTCOLOR_SELECTEDITEM;
            cell.accessoryLabel.font = [UIFont systemFontOfSize:FONTSIZE_RIGHTLABEL];
            
            

        }
        
        UIImageView *cellSep = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
        cellSep.frame = CGRectMake(0, 39.5, 320,0.5);
        [cell.contentView addSubview:cellSep];
        cell.textLabel.text = L(@"Search_DeliveryCity");
        
        AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
        [dao getCityNameByCityCode:[Config currentConfig].defaultCity];
        cell.accessoryLabel.text = [dao getCityNameByCityCode:[Config currentConfig].defaultCity];
        
        UIImageView *vArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right_gray"]];
        cell.accessoryView = vArrow;
        return cell;
    }
    else if (section == 1)      // 两个“只看”cell, 促销， 价格区间
    {
        static NSString *topTwoCells = @"topTwoCells";
        
        SNFilterPickCell *cell =
        (SNFilterPickCell *)[tableView dequeueReusableCellWithIdentifier:topTwoCells];
        if (cell == nil) {
            cell = [[SNFilterPickCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:topTwoCells];
            cell.textLabel.font = [UIFont systemFontOfSize:FONTSIZE_LEFTLABEL];
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
            cell.textLabel.textColor = TXTCOLOR_BLACK;
            
            cell.accessoryLabel.textColor = TXTCOLOR_SELECTEDITEM;
            cell.accessoryLabel.font = [UIFont systemFontOfSize:FONTSIZE_RIGHTLABEL];
        }
        
//        for (UIView * v in cell.contentView.subviews)
//        {
//            [v removeFromSuperview];
//        }
        
        UIImageView *cellSep = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
        cellSep.frame = CGRectMake(0, 39.5, 320,0.5);
        [cell.contentView addSubview:cellSep];
        cell.accessoryView = nil;
        
        if (indexPath.row == 0 && self.searchCondition.set != SearchSetBook)
        {
            cell.textLabel.text = L(@"Search_JustLookInStockGoods");
            cell.accessoryLabel.text=nil;
            cell.accessoryView = self.switchBtn;
        }
        else if (indexPath.row == 1)
        {
            cell.textLabel.text = L(@"Search_JustLookSuningSelf");
            cell.accessoryLabel.text=nil;
            cell.accessoryView = self.radiusBtn;
        }
        else if (indexPath.row == 2)
        {
            cell.textLabel.text = L(@"Search_PromotionGoods");
            
            NSArray *arr = [self.searchCondition.salesPromotion componentsSeparatedByString:@","];
            NSString *str = self.searchCondition.salesPromotion;
            if (arr.count == 0)
            {
                cell.accessoryLabel.text = L(@"Search_PleaseSelect");
            }
            else if (arr.count == 1)
            {
                if ([str isEqualToString:@"zj"])
                {
                    cell.accessoryLabel.text = L(@"Search_Reduce");
                }
                if ([str isEqualToString:@"tg"])
                {
                    cell.accessoryLabel.text = L(@"Search_GroupPurchase");
                }
                if ([str isEqualToString:@"fq"])
                {
                    cell.accessoryLabel.text = L(@"Search_ReturnTicket");
                }
                if ([str isEqualToString:@"qg"])
                {
                    cell.accessoryLabel.text = L(@"Search_PanicBuying");
                }
            }
            else if (arr.count == 4)
            {
                cell.accessoryLabel.text = L(@"All");
            }
            
            UIImageView *vArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right_gray"]];
            cell.accessoryView = vArrow;
        }
        else if (indexPath.row == 3)
        {
            cell.textLabel.text = L(@"Constant_Price");
            cell.accessoryLabel.text = nil;
            
            UIImageView *v = [[UIImageView alloc] initWithFrame:CGRectMake(150, 19.5, 10, 0.5)];
            v.backgroundColor = RGBCOLOR(219, 219, 219);
            [cell.contentView addSubview:self.inputPrice1];
            [cell.contentView addSubview:self.inputPrice2];
            [cell.contentView addSubview:v];
        }
        return cell;
    }
    else if (section == 2) //分类cell
    {
        static NSString *stringForAllCatos = @"stringForAllCatos";
        
        SNFilterPickCell *cell = [tableView dequeueReusableCellWithIdentifier:stringForAllCatos];
        if (!cell)
        {
            cell = [[SNFilterPickCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringForAllCatos];
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:FONTSIZE_LEFTLABEL];
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
            cell.textLabel.textColor = TXTCOLOR_GRAY;
            cell.accessoryLabel.textColor = TXTCOLOR_SELECTEDITEM;
            cell.accessoryLabel.font = [UIFont systemFontOfSize:FONTSIZE_RIGHTLABEL];
        }
        
        UIImageView *cellSep = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
        cellSep.frame = CGRectMake(0, 39.5, 320,0.5);
        [cell.contentView addSubview:cellSep];
        
        if (self.isKeyWordSearch)
        {
            if (!self.selectCateId)
            {
                cell.textLabel.text = L(@"Categories");
                cell.textLabel.textColor = TXTCOLOR_BLACK;
                cell.accessoryLabel.text = L(@"All");
            }
            else
            {
                cell.textLabel.text = L(@"Categories");
                cell.textLabel.textColor = TXTCOLOR_SELECTEDITEM;
                cell.accessoryLabel.text = self.selectCateName;
            }
        }
        else
        {
            cell.textLabel.text = L(@"Categories");
            cell.textLabel.textColor = TXTCOLOR_BLACK;
            cell.accessoryLabel.text = self.searchCondition.title;
        }
        
        UIImageView *vArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right_gray"]];
        cell.accessoryView = vArrow;
        return cell;
    }
    else if (section == 3) //高级筛选项cells
    {
        static NSString *filterCellIdentifier = @"filterCellIdentifier";
        
        SNFilterPickCell *cell =
        (SNFilterPickCell *)[tableView dequeueReusableCellWithIdentifier:filterCellIdentifier];
        if (cell == nil) {
            cell = [[SNFilterPickCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:filterCellIdentifier];
            cell.textLabel.font = [UIFont systemFontOfSize:FONTSIZE_LEFTLABEL];
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
            cell.textLabel.textColor = TXTCOLOR_GRAY;
            cell.accessoryLabel.textColor = TXTCOLOR_SELECTEDITEM;
            cell.accessoryLabel.font = [UIFont systemFontOfSize:FONTSIZE_RIGHTLABEL];
        }
        UIImageView *cellSep = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
        cellSep.frame = CGRectMake(0, 39.5, 320,0.5);
        [cell.contentView addSubview:cellSep];
        //cell.accessoryView = nil;
        NSInteger index = indexPath.row;

        SearchFilterDTO *filter = [self.filterList objectAtIndex:index];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.textLabel.text = filter.filterName;
        if (filter.currentValue && filter.currentValueDesc) {
            cell.accessoryLabel.text = filter.currentValueDesc;
        }else{
            cell.accessoryLabel.text = nil;
        }
        
        UIImageView *vArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right_gray"]];
        cell.accessoryView = vArrow;
        return cell;
    }
    
    return nil;
}

- (CustomKeyboardNumberPadReturnTextField *)inputPrice1
{
    if (!_inputPrice1)
    {
        _inputPrice1 = [[CustomKeyboardNumberPadReturnTextField alloc] initWithFrame:CGRectMake(65, 5, 80, 30)];
        _inputPrice1.borderRect = CGRectMake(0, 0, 80, 30);
        _inputPrice1.editingRect = CGRectMake(5, 0, 60, 30);
        //_inputPrice2.textRect = CGRectMake(10, 0, 40, 30);
        _inputPrice1.leftViewRect = CGRectMake(0, 0, 5, 30);
        _inputPrice1.placeholderRect = CGRectMake(5, 0, 60, 30);
        _inputPrice1.clearButtonRect = CGRectMake(60, 0, 15, 30);
        _inputPrice1.backgroundColor = [UIColor whiteColor];
        _inputPrice1.doneButtonDelegate = self;
        _inputPrice1.delegate = self;
        _inputPrice1.keyboardType = UIKeyboardTypeNumberPad;
        _inputPrice1.borderStyle = UITextBorderStyleNone;
        _inputPrice1.layer.borderWidth = 0.5;
        _inputPrice1.layer.borderColor = RGBCOLOR(224, 224, 224).CGColor;
        _inputPrice1.font = [UIFont systemFontOfSize:11];
        _inputPrice1.placeholder = L(@"Search_LowestPrice");
        _inputPrice1.tag = 1001;
    }

    return _inputPrice1;
}

- (CustomKeyboardNumberPadReturnTextField *)inputPrice2
{
    if (!_inputPrice2)
    {
        _inputPrice2 = [[CustomKeyboardNumberPadReturnTextField alloc] initWithFrame:CGRectMake(165, 5, 80, 30)];
        _inputPrice2.borderRect = CGRectMake(0, 0, 80, 30);
        _inputPrice2.editingRect = CGRectMake(5, 0, 60, 30);
        //_inputPrice2.textRect = CGRectMake(10, 0, 40, 30);
        _inputPrice2.leftViewRect = CGRectMake(0, 0, 5, 30);
        _inputPrice2.placeholderRect = CGRectMake(5, 0, 60, 30);
        _inputPrice2.clearButtonRect = CGRectMake(60, 0, 15, 30);
        _inputPrice2.clearButtonMode = UITextFieldViewModeWhileEditing;
        _inputPrice2.backgroundColor = [UIColor whiteColor];
        _inputPrice2.doneButtonDelegate = self;
        _inputPrice2.delegate = self;
        _inputPrice2.keyboardType = UIKeyboardTypeNumberPad;
        _inputPrice2.returnKeyType = UIReturnKeyDone;
        _inputPrice2.borderStyle = UITextBorderStyleNone;
        _inputPrice1.layer.borderWidth = 0.5;
        _inputPrice1.layer.borderColor = RGBCOLOR(224, 224, 224).CGColor;
        _inputPrice2.font = [UIFont systemFontOfSize:11];
        _inputPrice2.placeholder = L(@"Search_HighestPrice");
        _inputPrice2.tag = 1002;
    }
    
    return _inputPrice2;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self validatePriceStrAndSearch];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length >= 10 && range.location >= 10)
    {
        return NO;
    }
    if (textField.text.length + string.length - range.length > 10) {
        return NO;
    }
    return YES;
}

- (void)doneTapped:(id)sender
{
    [self.inputPrice1 resignFirstResponder];
    [self.inputPrice2 resignFirstResponder];
    [self validatePriceStrAndSearch];
}

- (void)validatePriceStrAndSearch
{
    NSString *strPrice1 = self.inputPrice1.text;
    NSString *strPrice2 = self.inputPrice2.text;
    if (!IsStrEmpty(strPrice1))
    {
        int dPrice1 = [strPrice1 intValue];
        if (dPrice1 < 0)
            return;
        if (!IsStrEmpty(strPrice2))
        {
            int dPrice2 = [strPrice2 intValue];
            if (dPrice1 >= dPrice2)
            {
                self.inputPrice1.text = strPrice2;
                self.inputPrice2.text = strPrice1;
                strPrice1 = self.inputPrice1.text;
                strPrice2 = self.inputPrice2.text;
            }
            self.searchCondition.priceString = [NSString stringWithFormat:@"%@-%@", strPrice1, strPrice2];
            [self pickFinishWithCallBack];
        }
        else
        {
            self.searchCondition.priceString = [NSString stringWithFormat:@"%@--1", strPrice1];
            [self pickFinishWithCallBack];
        }
    }
    else
    {
        if (!IsStrEmpty(strPrice2))
        {
            self.searchCondition.priceString = [NSString stringWithFormat:@"-1-%@", strPrice2];
            [self pickFinishWithCallBack];
        }
        else
        {
            //用户清空价格区间前进行过价格区间搜索，在清空后点完成时，重新进行一次无价格搜索
            
            //之前价格区间为空，不操作
            if (IsStrEmpty(self.searchCondition.priceString))
                return;
            else
            {
                //之前区间不为空，清空了控件点完成，重新搜索
                self.searchCondition.priceString = @"";
                [self pickFinishWithCallBack];
            }
        }
    }
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    if (textField == self.inputPrice1)
//    {
//        [self.inputPrice1 resignFirstResponder];
//        [self validatePriceStrAndSearch];
//        
//    }
//    else if (textField == self.inputPrice2)
//    {
//        [self.inputPrice2 resignFirstResponder];
//        [self validatePriceStrAndSearch];
//    }
//    return YES;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger section = indexPath.section;

    if (section == 0) //进入城市选择
    {
        ProvincePickViewController *nextController = [[ProvincePickViewController alloc] init];
        [self .navigationController pushViewController:nextController animated:YES];
    }
    else if (section == 1)
    {
        if (indexPath.row == 2) //促销筛选
        {
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"83080%d",section], nil]];
            FilterPickForSalesPromotion * v = [[FilterPickForSalesPromotion alloc] init];
            v.searchCondition = self.searchCondition;
            v.selectFilterBlock = ^{
                [self.navigationController popViewControllerAnimated:YES];
                [self pickFinishWithCallBack];
            };
            [self.navigationController pushViewController:v animated:YES];
        }
    }
    else if (section == 2)//分类cell
    {
        if (self.isKeyWordSearch)
        {
            if (indexPath.row == 0)
            {
                [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"831001"], nil]];
                NewCatePickViewController *v = [[NewCatePickViewController alloc] initWithCateList:self.categoryList];
                v.delegate = self.delegate;
                v.selectCateId = self.selectCateId;
//                v.filterRootViewController = self;
                if (self.searchCondition.searchType == SearchTypeCategory_2 || self.searchCondition.searchType == SearchTypeCategory_3)
                    v.bSearchingCategory = YES;
                else
                    v.bSearchingCategory = NO;
                [self.navigationController pushViewController:v animated:YES];
            }
        }
        else
        {
            [self.navigationController.parentViewController.navigationController popViewControllerAnimated:YES];
        }
    }
    else if (section == 3)//筛选cells
    {
        UITableViewCell *firstCell = [tableView cellForRowAtIndexPath:indexPath];
        firstCell.accessoryView = nil;
        NSInteger index = indexPath.row;
        
        SearchFilterDTO *filterCurr = [self.filterList objectAtIndex:index];
        FilterPickSecondViewController *nextController =
        [[FilterPickSecondViewController alloc] initWithFitler:filterCurr];
        nextController.delegate = self.delegate;
        
        nextController.selectFilterBlock = ^{
            [self.navigationController popViewControllerAnimated:YES];
            [self pickFinishWithCallBack];
        };
        
        [self.navigationController pushViewController:nextController animated:YES];
        TT_RELEASE_SAFELY(nextController);
    }
}
@end

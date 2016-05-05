//
//  FilterPopupViewController.h
//  SuningEBuy
//
//  Created by chupeng on 14-8-22.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchParamDTO.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"
#import "AddressInfoDAO.h"
#import "SearchFilterDTO.h"
#import "SearchFilterDelegate.h"
#import "CitysFilterTableViewCell.h"
#import "CatasFilterTableViewCell.h"
#import "SearchFilterValueDTO.h"

@interface SalesFiltersDto : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *value;
@end

typedef enum : NSUInteger {
    OPEN_HAVE_PRODUCT = 1 << 0,  //有货
    OPEN_SELF_SALE = 1 << 1,     //自营
    OPEN_CITYS = 1 << 2,              //城市
    OPEN_SALE_PROMOTION = 1 << 3, //促销
//    OPEN_PRICE = 1 << 4,          //价格
    OPEN_CATAS = 1 << 4,          //分类
} OPENFLAG;

@interface FilterPopupViewController : CommonViewController<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
{
}
@property (nonatomic, assign) id<SearchFilterDelegate> delegate;

//数据信息
@property (nonatomic, assign) BOOL isKeyWordSearch;
@property (nonatomic, assign) NSInteger itemNum; //商品数量
@property (nonatomic, strong) NSMutableArray *filterList;
@property (nonatomic, strong) NSMutableArray *filterWithNoPriceList; //去掉价格的高筛项
@property (nonatomic, strong) NSArray   *categoryList;
@property (nonatomic, strong) NSMutableDictionary *selectFilterMap; //记录被选择的高筛
@property (nonatomic, strong) SearchParamDTO *searchCondition;
@property (nonatomic, strong) CitysFilterTableViewCell *citysCell;
@property (nonatomic, strong) CatasFilterTableViewCell *catasCell;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) OHAttributedLabel *labelItemNum;
@property (nonatomic, strong) UIButton *clearAllBtn;


//section被点击时，记录section展开的状态
@property (nonatomic, assign) unsigned long long openSectionsFlag;

//促销
@property (nonatomic, strong) NSMutableArray *arraySelected;
@property (nonatomic, strong) NSMutableArray *arrayItems;

//分类
@property (nonatomic, copy) NSString  *selectCateId;
@property (nonatomic, copy) NSString  *selectCateName;


- (void)showOnWindow;
@end

//
//  ShopSearchListViewController.h
//  SuningEBuy
//
//  Created by chupeng on 14-7-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SearchListViewController.h"
#import "ShopSearchListService.h"
#import "SearchNavigationBar.h"
#import "ShopSearchListCell.h"
#import "ShopSearchSegmentView.h"
#import "AssociationalAndHistoryWordDisplayController.h"
#import "SolrSearchHistoryDAO.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"
#import "SNWebViewController.h"

@interface ShopSearchListViewController : CommonViewController<ShopSearchListServiceDelegate, ShopSearchSegmentViewDelegate, AssociationalAndHistoryWordDisplayDelegate, SearchNavigationBarDelegate>
{
    SearchResultViewType _footViewType;
    BOOL isNoResult;
    CGPoint ptLastOffset;
}

@property (nonatomic, strong) ShopSearchListService *shopSearchListService;
@property (nonatomic, strong) ShopSearchListParamDTO *shopSearchCondition;
@property (nonatomic, strong) SearchNavigationBar *customNavigationBar;
@property (nonatomic, strong) UIToolbar *statusbarBack;
@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) ShopSearchSegmentView *segmentView;
@property (nonatomic, strong) AssociationalAndHistoryWordDisplayController *keywordDisplayController;
@property (nonatomic, strong) SNReaderController *readerController;


+ (void)gotoShopSearchWithKeyWord:(NSString *)keyword fromNav:(UINavigationController *)nav;
- (id)initWithSearchCondition:(ShopSearchListParamDTO *)condition;



@end

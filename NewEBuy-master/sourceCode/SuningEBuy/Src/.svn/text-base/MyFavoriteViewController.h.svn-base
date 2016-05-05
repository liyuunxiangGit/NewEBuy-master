//
//  MyFavoriteViewController.h
//  SuningEBuy
//
//  Created by huangtf on 12-8-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PageRefreshTableViewController.h"
#import "MyFavoriteService.h"
#import "ShopCartV2Service.h"
#import "ProductDetailService.h"


@interface MyFavoriteViewController : PageRefreshTableViewController <MyFavoriteServiceDelegate,ShopCartV2ServiceDelegate,ProductDetailServiceDelegate,UIGestureRecognizerDelegate>
{	
	BOOL                isBookMarkLoaded;
	
	NSMutableArray      *_bookmarkList;
    
    NSIndexPath         *_deletedIndexPath;
    
    MyFavoriteService   *_myFavoriteService;
    
    DataProductBasic    *_productDetailDto;
}
@property (nonatomic, strong) UISwipeGestureRecognizer  *swipeRight;


@property (nonatomic, assign) BOOL                      isBookMarkLoaded;
@property (nonatomic, strong) NSMutableArray            *bookmarkList;
// 将要被删除的书签索引
@property (nonatomic, strong) NSIndexPath               *deletedIndexPath;
@property (nonatomic) MyFavoriteService         *myFavoriteService;

@property (nonatomic, strong) ShopCartV2Service         *cartService;
/*service*/
@property (nonatomic, strong) ProductDetailService      *detailService;

@end

//
//  HotelListViewController.h
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-2.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "PageRefreshTableViewController.h"
#import "HotelOrderBaseViewController.h"
#import "HotelListHttpRequest.h"
#import "HotelDataSourceDTO.h"
#import "QueryHotelDTO.h"
#import "SearchHotelService.h"
#import "HotelListSegment.h"
@interface HotelListViewController : HotelOrderBaseViewController<HotelListHttpRequestDelegate,HotelSearchServiceDelegate,HotelListSegmentDelegate>

{
@private
    //是否为加载更多
    BOOL        isLoadMore;
    
    NSInteger   currentPage;
    
    NSInteger   totalPage;
    
    BOOL        isLastPage;
    
    BOOL        isHttpRequestOk;

}

@property (nonatomic, strong) HotelListSegment* hotelListSegment;
@property (nonatomic, strong) NSMutableArray                    *hotelList;
@property (nonatomic, strong) NSMutableArray             *searchData;
@property (nonatomic, strong) HotelListHttpRequest       *hotelListHttpRequest;      
@property (nonatomic, copy)   NSString                   *sortType;
@property (nonatomic, copy)   NSString                   *sort;
@property (nonatomic, copy)   NSString                   *snStar;


@property (nonatomic, copy)   NSString                   *hotelName;

@property (nonatomic, copy)   HotelDataSourceDTO         *dataSource;

@property (nonatomic, strong) UILabel                    *emptyDataLabel;

@property (nonatomic, strong) QueryHotelDTO              *queryHotelDto;

@property (nonatomic, strong) SearchHotelService         *searchHotelService;

- (void)initDataSource;
- (id)initWithSearchData:(NSMutableArray *)searchData;


//封装传入参数
- (NSMutableDictionary *)packagePostDataDic;

//加载更多
- (BOOL)hasMore;
- (void)loadMoreData;
- (void)startMoreCellAnimation:(BOOL)animating;


//- (NSString *)calculateLeaveTime:(NSString *)arriveTime date:(NSString *)date;


@end

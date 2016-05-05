//
//  SearchHotelService.m
//  SuningEBuy
//
//  Created by admin on 12-10-9.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SearchHotelService.h"

@implementation SearchHotelService
@synthesize pageCount = _pageCount;
@synthesize delegate = _delegate;
@synthesize hotelList = _hotelList;

-(void)dealloc
{
    TT_RELEASE_SAFELY(_pageCount);
    TT_RELEASE_SAFELY(_hotelList);
}

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(queryHotelMsg);
}

-(void)beginSearchHotelHttpRequest:(QueryHotelDTO *)dto
{
    NSDictionary *postDataDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 dto.cityName?dto.cityName:@"",kHttpRequestCityName,
                                 dto.hotelAroundId?dto.hotelAroundId:@"",kHttpRequestHotelAroundId,
                                 dto.hotelName?dto.hotelName:@"",kHttpRequestHotelName,
                                 dto.startDate?dto.startDate:@"",kHttpRequestStartDate,
                                 dto.endDate?dto.endDate:@"",kHttpRequestEndDate,
                                 dto.priceArea?dto.priceArea:@"",kHttpRequestPriceArea,
                                 dto.snStar?dto.snStar:@"",kHttpRequestStarGrade,
                                 dto.sortType?dto.sortType:@"",kHttpRequestSorttype,
                                 dto.sort?dto.sort:@"",kHttpRequestSort,
                                 dto.currentPage?dto.currentPage:@"",kHttpRequestPageNum,
                                 nil];    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostHotelOrderForHttp, KHTTPRequestSearchHotelList];    
    HTTPMSG_RELEASE_SAFELY(queryHotelMsg);    
    queryHotelMsg = [[HttpMessage alloc] initWithDelegate:self
                                                   requestUrl:url
                                                  postDataDic:postDataDic
                                                      cmdCode:CC_SearchHotel];
	
	TT_RELEASE_SAFELY(postDataDic);    
    [self.httpMsgCtrl sendHttpMsg:queryHotelMsg];
}


- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    switch (receiveMsg.cmdCode) {
        case CC_SearchHotel:
        {
            [self getHotelListFinish:NO];
            break;
        }
        default:
            break;
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems;
    NSString     *errorCode = receiveMsg.errorCode;
    if (!items) {
        self.errorMsg = kHttpResponseJSONValueFailError;
    }
    switch (receiveMsg.cmdCode) {
        case CC_SearchHotel:
        {
            if (!items) {
                [self getHotelListFinish:NO];
            }else if (!NotNilAndNull(errorCode) || [errorCode isEqualToString:@""]){
                [self parseHotelList:items];
            }else{
                self.errorMsg = L(@"Get_Address_List_Fail");
                [self getHotelListFinish:NO];
            }
            break;
        }
        default:
            break;
    }
}

- (void)parseHotelList:(NSDictionary *)items
{    
    @autoreleasepool {
                
        if (items) 
        {  
            self.pageCount = [items objectForKey:@"pageCount"];
            
            NSMutableArray *list = [[NSMutableArray alloc] init];
            self.hotelList = list;
            if ([items objectForKey:@"docs"] != nil) {
                
                NSMutableArray *tempArray = [items objectForKey:@"docs"];
                
                if (!IsNilOrNull(tempArray)) {
                    
                    if ([tempArray count] > 0) {
                        
                        for (int i=0 ; i<[tempArray count]; i++) {
                            
                            NSDictionary *tempDic = [tempArray objectAtIndex:i];
                            
                            if (!IsNilOrNull(tempDic)) {
                                
                                HotelListDTO *dto = [[HotelListDTO alloc]init];
                                
                                [dto encodeFromDictionary:tempDic];
                                
                                [list addObject:dto];
                                
                                TT_RELEASE_SAFELY(dto);
                            }
                        }
                        
                    }
                }
            }
            
            [self getHotelListFinish:YES];
            TT_RELEASE_SAFELY(list);
        }
        
    }
}


- (void)getHotelListFinish:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(getHotelListService:Result:errorMsg:)]) {
        [_delegate getHotelListService:self Result:isSuccess errorMsg:self.errorMsg];
    }
}


@end

//
//  HotelLocationService.m
//  SuningEBuy
//
//  Created by admin on 12-10-9.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "HotelLocationService.h"
#import "HotelBusinessCircleDTO.h"
#import "HotelSARDTO.h"
@implementation HotelLocationService
@synthesize businessCircleList = _businessCircleList;
@synthesize SARList = _SARList;
@synthesize delegate = _delegate;

-(void)dealloc
{
    TT_RELEASE_SAFELY(_businessCircleList);
    TT_RELEASE_SAFELY(_SARList);    
}

-(void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(locationMsg);
}

-(NSMutableArray *)businessCircleList
{
    if(nil == _businessCircleList)
    {
        _businessCircleList = [[NSMutableArray alloc] init];
    }
    return _businessCircleList;
}

-(NSMutableArray *)SARList
{
    if(nil == _SARList)
    {
        _SARList = [[NSMutableArray alloc] init];
    }
    return _SARList;
}

-(void)beginLocationHttpRequest:(NSString *)cityName
{
    NSDictionary *postDic = [[NSDictionary alloc] initWithObjectsAndKeys:cityName,@"cityName", nil];//请求参数
    HTTPMSG_RELEASE_SAFELY(locationMsg);
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostHotelOrderForHttp,@"retrieveLandMark.htm"];
    locationMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDic cmdCode:CC_HotelLocation];
    [self.httpMsgCtrl sendHttpMsg:locationMsg];
    TT_RELEASE_SAFELY(postDic);
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    switch (receiveMsg.cmdCode) {
        case CC_HotelLocation:
        {
            [self getHotelLocaionListFinish:NO];
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
        case CC_HotelLocation:
        {
            if (!items) {
                [self getHotelLocaionListFinish:NO];
            }else if (!NotNilAndNull(errorCode) || [errorCode isEqualToString:@""]){
                [self parseHoteLocaionlList:items];
            }else{
                self.errorMsg = L(@"Get_Address_List_Fail");
                [self getHotelLocaionListFinish:NO];
            }
            break;
        }
        default:
            break;
    }
}

- (void)parseHoteLocaionlList:(NSDictionary*)items{
    @autoreleasepool 
    {
        //商圈
        NSArray *businessCircleListTemp = [items objectForKey: @"commerceList"];
        if(businessCircleListTemp && [businessCircleListTemp count]>0){
            
            //增加“不限”位置选项
            HotelBusinessCircleDTO *hotelBusinessCircleDTO = [[HotelBusinessCircleDTO alloc] init];
            hotelBusinessCircleDTO.locationId=L(@"BTIrrestriction");
            hotelBusinessCircleDTO.locationName=L(@"BTIrrestriction");
            hotelBusinessCircleDTO.loactionType=L(@"BTIrrestriction");
            
            //定义一个临时可变数组
            NSMutableArray *tempList = [[NSMutableArray alloc]init]; 
            
            [tempList addObject:hotelBusinessCircleDTO];
            
            for (NSDictionary *dic in businessCircleListTemp) {
                
                if ([dic isKindOfClass:[NSDictionary class]])
                {
                    HotelBusinessCircleDTO *dto = [[HotelBusinessCircleDTO alloc] init];
                    
                    [dto encodeFromDictionary:dic];
                    
                    [tempList addObject:dto];
                    
                    //TT_RELEASE_SAFELY(dto);
                }
                
            }
            
            [self.businessCircleList addObjectsFromArray:tempList]; 
            DLog(@"%d", [self.businessCircleList count]);
            
        }
        //行政区
        NSArray *SARListTemp = [items objectForKey: @"districtList"];
        if(SARListTemp && [SARListTemp count]>0){
            
            //增加“不限”位置选项
            HotelSARDTO *dtoNO = [[HotelSARDTO alloc] init];
            dtoNO.locationId=L(@"BTIrrestriction");
            dtoNO.locationName=L(@"BTIrrestriction");
            dtoNO.loactionType=L(@"BTIrrestriction");
            
            
            NSMutableArray *tempList = [[NSMutableArray alloc]init]; 
            
            [tempList addObject:dtoNO];
            
            for (NSDictionary *dic in SARListTemp) {
                
                if ([dic isKindOfClass:[NSDictionary class]])
                {
                    HotelSARDTO *dto = [[HotelSARDTO alloc] init];
                    
                    [dto encodeFromDictionary:dic];
                    
                    [tempList addObject:dto];
                    
                    //                    TT_RELEASE_SAFELY(dto);
                }
            }
            
            [self.SARList addObjectsFromArray:tempList]; 
            DLog(@"%d", [self.SARList count]);
            
        }
        
//        [self performSelectorOnMainThread:@selector(updateTableView) withObject:nil waitUntilDone:NO];
        [self getHotelLocaionListFinish:YES];
    }
}

- (void)getHotelLocaionListFinish:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(getHotelLocationListService:Result:errorMsg:)]) {
        [_delegate getHotelLocationListService:self Result:isSuccess errorMsg:self.errorMsg];
    }
}
@end

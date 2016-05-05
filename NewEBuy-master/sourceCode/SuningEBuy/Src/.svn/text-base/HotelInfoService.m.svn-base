//
//  HotelInfoService.m
//  SuningEBuy
//
//  Created by admin on 12-10-10.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "HotelInfoService.h"
#import "HotelIntroduceDTO.h"
#import "HotelDetalRoomTypeDTO.h"

@implementation HotelInfoService
@synthesize delegate = _delegate;
@synthesize parseDto = _parseDto;
@synthesize itemListArr = _itemListArr;

-(void)dealloc
{
    TT_RELEASE_SAFELY(_parseDto);
    TT_RELEASE_SAFELY(_itemListArr);
}

-(void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(detailMsg);
    HTTPMSG_RELEASE_SAFELY(roomTypeMsg);
}

-(HotelIntroduceDTO *)parseDto
{
    if (nil == _parseDto) 
    {
        _parseDto = [[HotelIntroduceDTO alloc] init];
    }
    return _parseDto;
}

-(NSMutableArray *)itemListArr
{
    if(nil == _itemListArr)
    {
        _itemListArr = [[NSMutableArray alloc] init];
    }
    return _itemListArr;

}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    switch (receiveMsg.cmdCode) {
        case CC_HotelDetail:
        {
            [self getHotelDetailFinish:NO];
            break;
        }
        case CC_HotelRoomType:
        {
            [self getHotelRoomTypeFinish:NO];
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
        case CC_HotelDetail:
        {
            if (!items) {
                [self getHotelDetailFinish:NO];
            }else if (!NotNilAndNull(errorCode) || [errorCode isEqualToString:@""]){
                [self parseHotelDetail:items];
            }else{
                self.errorMsg = L(@"Get_Address_List_Fail");
                [self getHotelDetailFinish:NO];
            }
            break;
        }
        case CC_HotelRoomType:
        {
            NSString *resultCode = EncodeStringFromDic(items, @"resultCode");
            if (!items) {
                [self getHotelRoomTypeFinish:NO];
            }else if ([resultCode isEqualToString:@"0"]){
                [self parseHotelRomeType:items];
            }else{
                NSString *resultMsg = EncodeStringFromDic(items, @"resultMessage");
                self.errorMsg = resultMsg?resultMsg:L(@"Get_Address_List_Fail");
                [self getHotelRoomTypeFinish:NO];
            }
            break;
        }
        default:
            break;
    }
}


-(void)beginHotelDetail:(NSString*)hotelId startDate:(NSString *)startDate endDate:(NSString *)endDate
{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostHotelOrderForHttp,KHotelInfoDetail];

    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:hotelId forKey:@"hotelId"];
    [postDataDic setObject:startDate forKey:@"checkInDate"];
    [postDataDic setObject:endDate forKey:@"checkOutDate"];
    HTTPMSG_RELEASE_SAFELY(detailMsg);
    detailMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_HotelDetail];
    TT_RELEASE_SAFELY(postDataDic);
    [self.httpMsgCtrl sendHttpMsg:detailMsg];   
    
}

- (void)parseHotelDetail:(NSDictionary *)items
{
    if (IsNilOrNull(items))
    {
        return;
    }
    
    NSDictionary *hotelInfoDic = [items objectForKey:@"hotelInfo"];
    
    if (hotelInfoDic ==nil) {
        return;
    }
    
    HotelIntroduceDTO *tempDto = [[HotelIntroduceDTO alloc] init];
    
    [tempDto encodeFromDictionary:hotelInfoDic];
    
    self.parseDto = tempDto;
    
//    self.parseDto.imageUrl = self.postDto.productImg;
//    self.parseDto.starLevel = self.postDto.starGrade;
    
    
    [self getHotelDetailFinish:YES];

}

- (void)getHotelDetailFinish:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(getHotelDetailService:Result:errorMsg:)]) {
        [_delegate getHotelDetailService:self Result:isSuccess errorMsg:self.errorMsg];
    }
}


- (void)beginRoomType:(NSString *)hotelId startDate:(NSString *)startDate endDate:(NSString *)endDate
{
   
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:hotelId forKey:@"hotelId"];
    [postDataDic setObject:startDate forKey:@"checkInDate"];
    [postDataDic setObject:endDate forKey:@"checkOutDate"];
    
    HTTPMSG_RELEASE_SAFELY(roomTypeMsg);
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostHotelOrderForHttp,KHotelInfoRatePlans];
    
    roomTypeMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_HotelRoomType];
    TT_RELEASE_SAFELY(postDataDic);
    [self.httpMsgCtrl sendHttpMsg:roomTypeMsg];
    
}

- (void)getHotelRoomTypeFinish:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(getHotelRoomTypeService:Result:errorMsg:)]) {
        [_delegate getHotelRoomTypeService:self Result:isSuccess errorMsg:self.errorMsg];
    }

}

- (void)parseHotelRomeType:(NSDictionary *)items
{
    if (IsNilOrNull(items))
    {
        return;
    }
    
    NSNumber *status =  [items objectForKey:@"resultCode"];
    if ((status !=nil) && ([[status stringValue] isEqualToString:@"1"] ==YES)) {
        //[self presentCustomDlg:[items objectForKey:@"resultMessage"]];
        //[self presentCustomDlg:L(@"load_failed")];
        [self getHotelRoomTypeFinish:NO];
        return;
        
    }
    
    
    NSDictionary *hotelDic = [items objectForKey:@"hotel"]; 
    
    NSMutableArray *itemArray = [hotelDic objectForKey:@"YlRooms"]; 
    
//    if ([itemArray count] <=0) {
//        
//        [self presentCustomDlg:L(@"tempNotHasRoom")];
//        
//        [self performSelectorOnMainThread:@selector(refreshTableView) withObject:nil waitUntilDone:YES];
//        
//        return;
//    }
    
    for (NSDictionary *tempDic in itemArray) {
        
        NSMutableArray *roomTypeArray = [tempDic objectForKey:@"ratePlans"]; 
        
        NSString *roomTypeName = [tempDic objectForKey:@"roomTypeName"];
        
        NSString *roomTypeDesc =  [tempDic objectForKey:@"bedDescription"];
        
        NSString *areas = [tempDic objectForKey:@"area"];
        
        NSString *floors = [tempDic objectForKey:@"floor"];
        
        for (NSDictionary *roomTypeDic in roomTypeArray) {
            {
                HotelDetalRoomTypeDTO *dto = [[HotelDetalRoomTypeDTO alloc]init];
                
                [dto encodeFromDictionary:roomTypeDic];
                
                if (NotNilAndNull(roomTypeName)) {
                    dto.name = roomTypeName;
                }
                
                if (NotNilAndNull(roomTypeDesc)) {
                    dto.discribe = roomTypeDesc;
                }
                
                if (NotNilAndNull(areas)) {
                    dto.area = areas;
                }
                
                if (NotNilAndNull(floors)) {
                    dto.floor = floors;
                }
                
                [self.itemListArr addObject: dto];
                
                
            }    
            
        }
        
    }  
    [self getHotelRoomTypeFinish:YES];
}

@end



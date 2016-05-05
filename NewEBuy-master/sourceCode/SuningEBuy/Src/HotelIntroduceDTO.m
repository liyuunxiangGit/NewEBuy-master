//
//  HotelIntroduceDTO.m
//  SuningEBuy
//
//  Created by robin wang on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HotelIntroduceDTO.h"

@implementation HotelIntroduceDTO

@synthesize name = _name;

@synthesize imageUrl = _imageUrl;

@synthesize address = _address;

@synthesize starLevel = _starLevel;

@synthesize content = _content;

@synthesize photoCount = _photoCount;

@synthesize imageUrlList = _imageUrlList;

@synthesize serviceItemList = _serviceItemList;

@synthesize uid= _uid;

@synthesize ccAccepted = _ccAccepted;

@synthesize introduce= _introduce;

- (void)dealloc {
    TT_RELEASE_SAFELY(_name);
    TT_RELEASE_SAFELY(_imageUrl);
    TT_RELEASE_SAFELY(_address);
    TT_RELEASE_SAFELY(_starLevel);
    TT_RELEASE_SAFELY(_content);
    
    TT_RELEASE_SAFELY(_photoCount);

    TT_RELEASE_SAFELY(_imageUrlList);
    
    TT_RELEASE_SAFELY(_uid);
    
    TT_RELEASE_SAFELY(_introduce);
    
    TT_RELEASE_SAFELY(_serviceItemList);
    
    TT_RELEASE_SAFELY(_ccAccepted);

}

//接口返回id有空格，去除空格
- (NSString *)trimString:(NSString *)beforeString{
    
//        NSString *contentString = [[tempDto.parameterContents stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] replacedWhiteSpacsByString:@""];
    
    NSString *endString = [[beforeString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] replacedWhiteSpacsByString:@""];
    return endString;
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (IsNilOrNull(dic)) {
        return;
    }
    
    _imageUrlList = [[NSMutableArray alloc] init];
    
    _serviceItemList = [[NSMutableArray alloc] init];
    
    NSString *__uid = [dic objectForKey:@"hotelId"];
    NSString *__name = [dic objectForKey:@"name"];

    NSString *__address = [dic objectForKey:@"address"];

    NSString *__content = [dic objectForKey:@"cardType"];
    
    NSString *__desc = [dic objectForKey:@"introEditor"];
    
    NSString *__star = [dic objectForKey:@"star"];
    
//    NSString *introEditor = [dic objectForKey:@"introEditor"];
//    if ((__desc !=nil) && (introEditor !=nil)) {
//        
//        __desc = [__desc stringByAppendingString:introEditor];
//    }
    
    NSString *__ccAccepted = [dic objectForKey:@"ccAccepted"];
    
    if (NotNilAndNull(__uid))   self.uid = __uid;
    if (NotNilAndNull(__name))   self.name = __name;

    if (NotNilAndNull(__address))   self.address = __address;
 
    if (NotNilAndNull(__content))   self.content = __content;
    if (NotNilAndNull(__desc))   self.introduce = __desc;
    
    if (NotNilAndNull(__ccAccepted))   self.ccAccepted = __ccAccepted;
    
    if (NotNilAndNull(__star)) {
        self.starLevel = __star;
    }
    
    NSArray *tempImageArr = [dic objectForKey:@"YlImages"];
    if (tempImageArr !=nil) {
        
        for (int  i = 0 ; i < [tempImageArr count]/3;i ++ ) {
         
            NSDictionary *imageUrlTemp  = [tempImageArr objectAtIndex:i];
            
            NSString *afterUrl = [imageUrlTemp objectForKey:@"localImageUrl"];
            
            NSString *title = [imageUrlTemp objectForKey:@"title"];
            
            if (NotNilAndNull(afterUrl) && ![afterUrl isEqualToString:@""]) {
                                
                NSString *sss = [self.uid substringWithRange:NSMakeRange(0, 2)];
                
                NSString *imageUrl = [NSString stringWithFormat:@"%@/%@/%@/",kHostHotelImageForHttp,sss,self.uid];
                
                NSString *fullImageUrl = [imageUrl stringByAppendingString:afterUrl];
                
                MyPhoto *photo = [[MyPhoto alloc] initWithImageURL:[NSURL URLWithString:fullImageUrl] name:title];
                
                [self.imageUrlList addObject: photo];
                
            }
        }

    }
    
    
    //酒店服务  hotel Service
    NSArray *YlGeneralAmentities = [dic objectForKey:@"YlGeneralAmentities"];
    NSDictionary *hotelService = nil;
    if ([YlGeneralAmentities count] > 0) hotelService = [YlGeneralAmentities objectAtIndex:0];
    if (hotelService !=nil) {
        
        NSString *infoTemp = [hotelService objectForKey:@"overview"];
        
        if ((infoTemp !=nil)  && ([infoTemp length] > 2)) {
            
            HotelDetailImageListDTO *tempDTO = [[HotelDetailImageListDTO alloc] init];
            
            tempDTO.title = L(@"BTHotelServe");
            
            tempDTO.info = [self trimString:[hotelService objectForKey:@"overview"]];
            
            [self.serviceItemList addObject: tempDTO];
            
        }
        
    }
    
    //酒店餐厅设施
    NSArray *YlDiningAmentities = [dic objectForKey:@"YlDiningAmentities"];
    NSDictionary *YlDiningDic = nil;
    if ([YlDiningAmentities count] > 0) YlDiningDic = [YlDiningAmentities objectAtIndex:0];
    if (YlDiningDic !=nil) {
        
        NSString *infoTemp = [YlDiningDic objectForKey:@"overview"];
        
        if ((infoTemp !=nil)  && ([infoTemp length] > 2)) {
            
            HotelDetailImageListDTO *tempDTO = [[HotelDetailImageListDTO alloc] init];
            
            tempDTO.title = L(@"BTHotelRestaurantFacility");
            
            tempDTO.info = [self trimString:[YlDiningDic objectForKey:@"overview"]];
            
            [self.serviceItemList addObject: tempDTO];
            
        }
        
    }

    //酒店休闲设施
    NSArray *YlRecreationAmentites = [dic objectForKey:@"YlRecreationAmentites"];
    NSDictionary *YlRecreationDic = nil;
    if ([YlRecreationAmentites count] > 0) YlRecreationDic = [YlRecreationAmentites objectAtIndex:0];
    if (YlRecreationDic !=nil) {
        
        NSString *infoTemp = [YlRecreationDic objectForKey:@"overview"];
        
        if ((infoTemp !=nil)  && ([infoTemp length] > 2)) {
            
            HotelDetailImageListDTO *tempDTO = [[HotelDetailImageListDTO alloc] init];
            
            tempDTO.title = L(@"BTHotelLeisureFacility");
            
            tempDTO.info = [self trimString:[YlRecreationDic objectForKey:@"overview"]];
            
            [self.serviceItemList addObject: tempDTO];
            
        }
        
    }

    //酒店会议设施
    NSArray *YlConferenceAmentities = [dic objectForKey:@"YlConferenceAmentities"];
    NSDictionary *YlConferenceDic = nil;
    if ([YlConferenceAmentities count] > 0) YlConferenceDic = [YlConferenceAmentities objectAtIndex:0];
    if (YlConferenceDic !=nil) {
        
        NSString *infoTemp = [YlConferenceDic objectForKey:@"overview"];
        
        if ((infoTemp !=nil)  && ([infoTemp length] > 2)) {
            
            HotelDetailImageListDTO *tempDTO = [[HotelDetailImageListDTO alloc] init];
            
            tempDTO.title = L(@"BTHotelMeetingFacility");
            
            tempDTO.info = [self trimString:[YlConferenceDic objectForKey:@"overview"]] ;
            
            [self.serviceItemList addObject: tempDTO];
            
        }
        
    }

    if (self.ccAccepted !=nil) {
        
        HotelDetailImageListDTO *tempDTO = [[HotelDetailImageListDTO alloc] init];
        
        tempDTO.title = L(@"BTUnionPayBankCard");
        
        tempDTO.info =  [self trimString:self.ccAccepted];
        
        [self.serviceItemList addObject: tempDTO];
        

    }
    
    

}


@end

//
//  HotelListHttpRequest.m
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-3.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import "HotelListHttpRequest.h"
#import "HotelOrder.h"

@implementation HotelListHttpRequest

@synthesize delegate = _delegate;


- (id)init {
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

- (void)dealloc {
    
    HTTP_RELEASE_SAFELY(searchHotelASIHTTPRequest);
    
}

- (void)searchHotelHttpRequest:(NSMutableDictionary *)postDataDic{

    HTTP_RELEASE_SAFELY(searchHotelASIHTTPRequest);

    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostHotelOrderForHttp, KHTTPRequestSearchHotelList];

//    NSString *url = @"http://10.21.145.120:8080/hotel-pay-web/hotelTerminal/fnd/searchHotel.htm";
    searchHotelASIHTTPRequest = [Http sendHttpRequest:@"send http request"
                                                  URL:url
                                           UrlParaDic:postDataDic
                                             Delegate:self
                                       SucessCallback:@selector(requestOK:)
                                         FailCallback:@selector(requestFail:)];
    
		
	if(!searchHotelASIHTTPRequest){
        
		return;
	}
}

- (void)requestOK:(ASIFormDataRequest *)request{
    
    NSString *responseString = [request responseString];
    
    NSDictionary *item = [responseString JSONValue2];
    
    [self performSelectorOnMainThread:@selector(parseBoardingPersonList:) withObject:item waitUntilDone:NO];
    
}

- (void)parseBoardingPersonList:(NSDictionary *)items
{    
    @autoreleasepool {
        
        DLog(@"BoardingPersionListViewController request back is :%@", [items description]);
        
        if (items) 
        {          
            NSMutableArray *list = [[NSMutableArray alloc] init];

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
            
            [self httpRequestResult:list pageCount:[items objectForKey:@"pageCount"] withResult:[items objectForKey:@"isSuccess"] errorDesc:[items objectForKey:@"errorDesc"]];        
            TT_RELEASE_SAFELY(list);
        }
        
    }
}

- (void)requestFail:(ASIFormDataRequest *)request{
    
    NSString *responseString = [request responseString];
    
    NSDictionary *item = [responseString JSONValue2];

    DLog(@"BoardingPersionListViewController request back is :%@", [request responseString]);
    [self httpRequestResult:nil pageCount:@"" withResult:[item objectForKey:@"isSuccess"] errorDesc:[item objectForKey:@"errorDesc"]]; 
}


- (void)httpRequestResult:(NSArray *)list pageCount:(NSString *)pageCount withResult:(NSString *)successResult errorDesc:(NSString *)errorDesc{
    
    if ([_delegate conformsToProtocol:@protocol(HotelListHttpRequestDelegate)]) {
        if ([_delegate respondsToSelector:@selector(httpRequestCompleted:pageCount:withResult:errorDesc:)]) {
            [_delegate httpRequestCompleted:list pageCount:pageCount withResult:successResult errorDesc:errorDesc];
        }
    }
    
}

@end

//
//  UserDiscountService.m
//  SuningEBuy
//
//  Created by shasha on 12-9-28.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "UserDiscountService.h"
#import "UserCenter.h"
@interface UserDiscountService () 

- (void)didGetUserDiscountInfoFinished:(BOOL)isSuccess;

@end
@implementation UserDiscountService
@synthesize userDiscountInfoDTO = _userDiscountInfoDTO;
@synthesize delegate = _delegate;

- (void)dealloc {
    
    _delegate = nil;
    
    TT_RELEASE_SAFELY(_userDiscountInfoDTO);
    
}

- (id)init {
    
    self = [super init];
    
    if (self) {
        
    }
    return self;
}


-(void)httpMsgRelease{
    
    HTTPMSG_RELEASE_SAFELY(userDiscountHttpMsg);
}


-(void)didGetUserDiscountInfoFinished:(BOOL)isSuccess{
    
    
    if (self.userDiscountInfoDTO != nil&&[UserCenter defaultCenter].userInfoDTO != nil) {
        
        [UserCenter defaultCenter].userInfoDTO.yifubaoBalance = self.userDiscountInfoDTO.advance; 
        
        [UserCenter defaultCenter].userDiscountInfoDTO = self.userDiscountInfoDTO;
        
    }
    
    if (isSuccess) {
        
        if ([self.delegate respondsToSelector:@selector(didGetUserDiscountCompleted:errorMsg:)]) {
            
            [self.delegate didGetUserDiscountCompleted:YES errorMsg:nil];
            
        }else{
            
            [self.delegate didGetUserDiscountCompleted:NO errorMsg:self.errorMsg];
            
        }
        
    }
    
}

#pragma mark - 
#pragma mark - send http request for getting whole Information

//优惠券整体信息查询接口返回的值

- (void)beginGetUserDiscountInfo{
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];	
    
    //NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,@"MySuningIndexAjaxView"];
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,@"SNiPhoneMySuningIndexAjaxView"];
    //NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,@"SNMobileAchievementInquireViewpp"];
    HTTPMSG_RELEASE_SAFELY(userDiscountHttpMsg);
    
    userDiscountHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                     requestUrl:url
                                                    postDataDic:postDataDic
                                                        cmdCode:CC_DisCountInfo];
    
    TT_RELEASE_SAFELY(postDataDic);
    userDiscountHttpMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:userDiscountHttpMsg];
    
}

-(void)receiveDidFailed:(HttpMessage *)receiveMsg{
    
    [super receiveDidFailed:receiveMsg];
    
    [self didGetUserDiscountInfoFinished:NO];
    
}

-(void)receiveDidFinished:(HttpMessage *)receiveMsg{
    
    NSDictionary *items = receiveMsg.jasonItems;
    if (items == nil) {
        
        self.errorMsg = kHttpResponseJSONValueFailError;
        
        [self didGetUserDiscountInfoFinished:NO];
        
    }else{
        
        UserDiscountInfoDTO *dto = [[UserDiscountInfoDTO alloc] init];
        [dto encodeFromDictionary:items];
        self.userDiscountInfoDTO = dto;
        [self didGetUserDiscountInfoFinished:YES];
        
    }
    
}

-(UserDiscountInfoDTO *)userDiscountInfoDTO{
    
    if (!_userDiscountInfoDTO) {
        
        _userDiscountInfoDTO = [[UserDiscountInfoDTO alloc] init];
        
    }
    
    return _userDiscountInfoDTO;
}
@end

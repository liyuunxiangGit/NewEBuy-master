//
//  CShopReturnApplicationService.m
//  SuningEBuy
//
//  Created by 荀晓冬 on 13-12-14.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CShopReturnApplicationService.h"

@implementation CShopReturnApplicationService
@synthesize delegate = _delegate;

@synthesize returnGoodsPrepareDto = _returnGoodsPrepareDto;

@synthesize reasonList = _reasonList;

- (id)init {
    self = [super init];
    if (self) {
        
        if (!_returnGoodsPrepareDto) {
            
            _returnGoodsPrepareDto = [[ReturnGoodsPrepareDTO alloc]init];
        }
        
        if (!_reasonList) {
            
            _reasonList = [[NSMutableArray alloc]init];
        }
    }
    return self;
}

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_returnGoodsPrepareDto);
    
    TT_RELEASE_SAFELY(_reasonList);
    
}

- (void)httpMsgRelease{
    
  
    
    HTTPMSG_RELEASE_SAFELY(_returnCShopGoodsApplicationHttpMsg);
    
    HTTPMSG_RELEASE_SAFELY(_returnCShopGoodsSubmitHttpMsg);
}

//- (void)CShopBeginSendReturnGoodsApplicationHttpRequest:(ReturnGoodsListDTO *) dto
- (void)CShopBeginSendReturnGoodsApplicationHttpRequest:(MemberOrderDetailsDTO *) dto

{
    NSString  *urlC = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,[@"SNiPhoneCshopReturnOrderValidate" passport]];
    
    NSMutableDictionary  *postDataDic = [[NSMutableDictionary alloc]init];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    [postDataDic setObject:@"th" forKey:@"type"];
    
    
    [postDataDic setObject:dto.orderId?dto.orderId:@"" forKey:@"orderId"];
    
//    [postDataDic setObject:dto.orderItemsId?dto.orderItemsId:@"" forKey:@"orderItemsId"];
    [postDataDic setObject:dto.orderItemId?dto.orderItemId:@"" forKey:@"orderItemsId"];

    HTTPMSG_RELEASE_SAFELY(_returnCShopGoodsApplicationHttpMsg);
    
    _returnCShopGoodsApplicationHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:urlC postDataDic:postDataDic cmdCode:CC_ReturnCShopGoodsApplication];
    
    [self.httpMsgCtrl sendHttpMsg:_returnCShopGoodsApplicationHttpMsg];
    
    
}

- (void)CShopBeginSendReturnGoodsSubmitHttpRequest:(ReturnGoodsPrepareDTO *)dto
                                       reasonName:(NSString *)reasonName
                                         reasonDes:(NSString *)reasonDes
                                          reasonId:(NSString *)reasonId
{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,[@"SNiPhoneCshopReturnOrderSubmit" passport]];
    
    NSMutableDictionary  *postDic = [[NSMutableDictionary alloc]init];
    
    [postDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    [postDic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];
    
    [postDic setObject:dto.orderId?dto.orderId:@"" forKey:@"orderId"];                              //订单号
    [postDic setObject:dto.orderItemsId?dto.orderItemsId:@"" forKey:@"orderItemsId"];                    //订单行项目号
    [postDic setObject:reasonName?reasonName:@""  forKey:@"thyy"];                                        //退货原因描述
    [postDic setObject:reasonId?reasonId:@""  forKey:@"thxqh"];                                          //退货原因id
    [postDic setObject:reasonDes?reasonDes:@"" forKey:@"reason"];
    
    /* deprecated by liukun
    //当returnType为4的时候 tkbs（退款标识）传2,其他情况直接传过去
    if ([dto.returnFlag isEqualToString:@"4"]) {
        
        [postDic setObject:@"2" forKey:@"tkbs"];
        
    }else{
        
        [postDic setObject:IsStrEmpty(dto.returnFlag)?@"":dto.returnFlag forKey:@"tkbs"];
    }
    */
    [postDic setObject:IsStrEmpty(dto.returnFlag)?@"":dto.returnFlag forKey:@"tkbs"];
    
    HTTPMSG_RELEASE_SAFELY(_returnCShopGoodsSubmitHttpMsg);
    
    _returnCShopGoodsSubmitHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:postDic cmdCode:CC_ReturnCShopGoodsconfirm];
    
    TT_RELEASE_SAFELY(postDic);
    
    [self.httpMsgCtrl sendHttpMsg:_returnCShopGoodsSubmitHttpMsg];
    
}
- (void)receiveDidFailed:(HttpMessage *)receiveMsg{
    
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_ReturnCShopGoodsApplication) {
        
        [self returnGoodsApplicationOK:NO];
    }
    else if(receiveMsg.cmdCode == CC_ReturnCShopGoodsconfirm){
        
        [self returnGoodsSubmitOK:NO];
    }
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg{
    
    if ( receiveMsg.cmdCode == CC_ReturnCShopGoodsApplication) {
        
        NSDictionary *items = receiveMsg.jasonItems;
        
//        NSString *responseString = receiveMsg.responseString;
//        responseString = [responseString stringByReplacingOccurrencesOfString:@",\n}" withString:@"}"];
//        NSDictionary *items = [responseString JSONValue2];
        
        NSString *result = [items objectForKey:@"isSuccess"];
        if (items) {
            
            if ([result isEqualToString:@"1"])
            {
                
                [self returnGoodsApplicationRequestOK:items];
                
            }else{
                
                self.reasonList = nil;
                
                [self.returnGoodsPrepareDto encodeFromDictionary:items];
                
                [self returnGoodsApplicationOK:YES];
            }
        }else{
            [self returnGoodsApplicationOK:NO];
        }
    }
    else if(receiveMsg.cmdCode == CC_ReturnCShopGoodsconfirm)
    {
        NSDictionary *items = receiveMsg.jasonItems;
        
        NSString *isSuccess = [items objectForKey:@"msg"];
        
        if ([isSuccess isEqualToString:@"isSuccess"]) {
            [self returnGoodsSubmitOK:YES];
        }
        else{
            self.errorMsg = L(@"isFail");
            [self returnGoodsSubmitOK:NO];
        }
        
        
    }
}

- (void)returnGoodsApplicationRequestOK:(NSDictionary *)items{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        @autoreleasepool {
            
            [self.returnGoodsPrepareDto encodeFromDictionary:items];
            
            NSArray *tempList =  [items objectForKey:@"returnResons"];
            
            if (tempList && [tempList count]>0) {
                
                if (_reasonList == nil) {
                    
                    _reasonList = [[NSMutableArray alloc]initWithCapacity:([tempList count]*2)];
                    
                }else{
                    
                    [_reasonList removeAllObjects];
                }
                
                for (NSDictionary *dic in tempList) {
                    
                    NSString *reasonId = [dic  objectForKey:@"resonId"] == nil?@"":[dic  objectForKey:@"resonId"];
                    
                    NSString *reasonName = [dic  objectForKey:@"resonName"] == nil?@"":[dic  objectForKey:@"resonName"] ;
                    
                    [_reasonList addObject:reasonId];
                    
                    [_reasonList addObject:reasonName];
                    
                    //245
//                    NSString *appraisalFlag = [dic  objectForKey:@"appraisalFlag"] == nil?@"":[dic  objectForKey:@"appraisalFlag"] ;
//                    [_reasonList addObject:appraisalFlag];
                    
                }
                
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self returnGoodsApplicationOK:YES];
            
        });
        
    });
    
}

- (void)returnGoodsApplicationOK:(BOOL)isScuess{
    
    if (isScuess == NO) {
        
        if (_delegate && [_delegate respondsToSelector:@selector(CShopReturnGoodsApplicationRequestCompletedWithResult:reasonList:returnGoodsPreparedDto:errorMsg:)]) {
            
            [_delegate  CShopReturnGoodsApplicationRequestCompletedWithResult:NO reasonList:nil returnGoodsPreparedDto:nil errorMsg:self.errorMsg];
        }
    }else{
        
        if (_delegate && [_delegate respondsToSelector:@selector(CShopReturnGoodsApplicationRequestCompletedWithResult:reasonList:returnGoodsPreparedDto:errorMsg:)]) {
            
            [_delegate  CShopReturnGoodsApplicationRequestCompletedWithResult:YES reasonList:self.reasonList   returnGoodsPreparedDto:self.returnGoodsPrepareDto errorMsg:self.errorMsg];
        }
    }
}


- (void)returnGoodsSubmitOK:(BOOL)isSuccess{
    
    if (isSuccess == YES) {
        
        if (_delegate && [_delegate respondsToSelector:@selector(CshoopRetunGoodsSubmitRequestCompletedWithResult:errorMsg:)]) {
            
            [_delegate CshoopRetunGoodsSubmitRequestCompletedWithResult:YES errorMsg:nil];
            
        }
    }
    else{
        
        if (_delegate && [_delegate respondsToSelector:@selector(CshoopRetunGoodsSubmitRequestCompletedWithResult:errorMsg:)]) {
            
            [_delegate CshoopRetunGoodsSubmitRequestCompletedWithResult:NO errorMsg:self.errorMsg];
            
        }
    }
}



@end

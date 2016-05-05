//
//  ReturnGoodsApplicationService.m
//  SuningEBuy
//
//  Created by 漫 王 on 12-10-8.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ReturnGoodsApplicationService.h"


@implementation ReturnGoodsApplicationService

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

    HTTPMSG_RELEASE_SAFELY(_returnGoodsApplicationHttpMsg);
    HTTPMSG_RELEASE_SAFELY(_returnGoodsSubmitHttpMsg);
}


//- (void)beginSendReturnGoodsApplicationHttpRequest:(ReturnGoodsListDTO *) dto{
- (void)beginSendReturnGoodsApplicationHttpRequest:(MemberOrderDetailsDTO *) dto{

    NSString  *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,[@"SNRetWorkOrderTypeChange" passport]];
    
    NSMutableDictionary  *postDataDic = [[NSMutableDictionary alloc]init];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    [postDataDic setObject:@"th" forKey:@"type"];
    
//    [postDataDic setObject:dto.deliveryStatus?dto.deliveryStatus:@"" forKey:@"deliveryStatus"];
    [postDataDic setObject:@"" forKey:@"deliveryStatus"];

    [postDataDic setObject:dto.orderId?dto.orderId:@"" forKey:@"orderId"];
    
//    [postDataDic setObject:dto.orderItemsId?dto.orderItemsId:@"" forKey:@"orderItemsId"];
    [postDataDic setObject:dto.orderItemId?dto.orderItemId:@"" forKey:@"orderItemsId"];
    [postDataDic setObject:dto.cShopName?dto.cShopName:@"" forKey:@"saleStore"];

//    [postDataDic setObject:dto.saleHall?dto.saleHall:@"" forKey:@"saleStore"];

//    [postDataDic setObject:dto.partNumber?dto.partNumber:@"" forKey:@"partNumber"];
    [postDataDic setObject:dto.productCode?dto.productCode:@"" forKey:@"partNumber"];
    [postDataDic setObject:dto.quantityInIntValue?dto.quantityInIntValue:@"" forKey:@"saleOrder"];

//    [postDataDic setObject:dto.salNum?dto.salNum:@"" forKey:@"saleOrder"];
    
    //支持在线客服退货
    [postDataDic setObject:@"mobile2" forKey:@"fromChannel"];

    
    HTTPMSG_RELEASE_SAFELY(_returnGoodsApplicationHttpMsg);
    
        _returnGoodsApplicationHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_ReturnGoodsApplication];
    

    [self.httpMsgCtrl sendHttpMsg:_returnGoodsApplicationHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}

- (void)beginSendReturnPartGoodsSubmitHttpRequest:(ReturnGoodsPrepareDTO *)dto  checkUpDate:(NSString *)checkUpDate reasonDes:(NSString *)reasonDes reasonId:(NSString *)reasonId noReasonReturnDto:(NoReasonReturnDTO *)noReasonDto
{
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,[@"SNMobileRetCashOnDelivery" passport]];
    
    NSMutableDictionary  *postDic = [[NSMutableDictionary alloc]init];
    
    [postDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    [postDic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];
    
    [postDic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];     //10051
    [postDic setObject:dto.orderId forKey:@"orderId"];                              //订单号
    [postDic setObject:dto.orderItemsId forKey:@"orderItemsId"];                    //订单行项目号
    [postDic setObject:reasonDes  forKey:@"thyy"];                                        //退货原因描述
    [postDic setObject:reasonId  forKey:@"thxqh"];                                          //退货原因id
    
    /*  deprecated by liukun
     //当returnType为4的时候 tkbs（退款标识）传2,其他情况直接传过去
     if ([dto.returnFlag isEqualToString:@"4"]) {
     
     [postDic setObject:@"2" forKey:@"tkbs"];
     
     }else{
     
     [postDic setObject:dto.returnFlag forKey:@"tkbs"];
     }
     */
    [postDic setObject:IsStrEmpty(dto.returnFlag)?@"":dto.returnFlag forKey:@"tkbs"];
    
    
    [postDic setObject:dto.appraisal forKey:@"appraiser"];                          //鉴定方
    
    [postDic setObject:dto.factoryContect forKey:@"factoryContect"];                //联系电话
    [postDic setObject:dto.heyueji forKey:@"heyueji"];                              //合约机
    [postDic setObject:dto.powerFlag forKey:@"powerFlag"];                          //节能补贴标识
    
    [postDic setObject:noReasonDto.realname forKey:@"realname"]; //联系人
    [postDic setObject:noReasonDto.mobilePhone forKey:@"mobilePhone"]; //联系人
    [postDic setObject:noReasonDto.retDate forKey:@"retDate"]; //取件日期
    [postDic setObject:noReasonDto.freightLog forKey:@"freightLog"]; //取件费
    [postDic setObject:noReasonDto.placerAddressDetail forKey:@"placerAddressDetail"]; //详细地址
    
    [postDic setObject:IsStrEmpty(noReasonDto.retQuantity)?@"":noReasonDto.retQuantity forKey:@"retQuantity"];//退货数量，不传默认是所有数量
    [postDic setObject:IsStrEmpty(noReasonDto.picId)?@"":noReasonDto.picId forKey:@"picId"];//鉴定图片id
    [postDic setObject:IsStrEmpty(noReasonDto.apprType)?@"":noReasonDto.apprType forKey:@"apprType"];//鉴定方式
    [postDic setObject:IsStrEmpty(noReasonDto.apprAddress)?@"":noReasonDto.apprAddress forKey:@"apprAddress"];//鉴定地址
    [postDic setObject:IsStrEmpty(noReasonDto.apprTele)?@"":noReasonDto.apprTele forKey:@"apprTele"];//网点鉴定电话
    [postDic setObject:IsStrEmpty(noReasonDto.mfrsTelnum)?@"":noReasonDto.mfrsTelnum forKey:@"mfrsTelnum"];//厂家鉴定电话
    
    if (checkUpDate) {
        
        [postDic setObject:checkUpDate forKey:@"checkupDate"];                  //鉴定日期，用户在一个范围内选择，配送
        
    }
    else
    {
        [postDic setObject:dto.minDeliverDate forKey:@"apprDate"];     //上门鉴定日期
    }
    
    
    HTTPMSG_RELEASE_SAFELY(_returnGoodsSubmitHttpMsg);
    
    _returnGoodsSubmitHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:postDic cmdCode:CC_ReturnGoodsSubmit];
    
    TT_RELEASE_SAFELY(postDic);
    
    [self.httpMsgCtrl sendHttpMsg:_returnGoodsSubmitHttpMsg];
}

- (void)beginSendReturnGoodsSubmitHttpRequest:(ReturnGoodsPrepareDTO *)dto  checkUpDate:(NSString *)checkUpDate reasonDes:(NSString *)reasonDes reasonId:(NSString *)reasonId noReasonReturnDto:(NoReasonReturnDTO *)noReasonDto{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,[@"SNMobileRetCashOnDelivery" passport]];
    
    NSMutableDictionary  *postDic = [[NSMutableDictionary alloc]init];
    
    [postDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    [postDic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];
    
    [postDic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];     //10051
    [postDic setObject:dto.orderId forKey:@"orderId"];                              //订单号
    [postDic setObject:dto.orderItemsId forKey:@"orderItemsId"];                    //订单行项目号
    [postDic setObject:reasonDes  forKey:@"thyy"];                                        //退货原因描述
    [postDic setObject:reasonId  forKey:@"thxqh"];                                          //退货原因id
    
    /*  deprecated by liukun
    //当returnType为4的时候 tkbs（退款标识）传2,其他情况直接传过去
    if ([dto.returnFlag isEqualToString:@"4"]) {
        
        [postDic setObject:@"2" forKey:@"tkbs"]; 
        
    }else{
        
        [postDic setObject:dto.returnFlag forKey:@"tkbs"];
    }
    */
    [postDic setObject:IsStrEmpty(dto.returnFlag)?@"":dto.returnFlag forKey:@"tkbs"];

    
    [postDic setObject:dto.appraisal forKey:@"appraiser"];                          //鉴定方
    
    [postDic setObject:dto.factoryContect forKey:@"factoryContect"];                //联系电话
    [postDic setObject:dto.heyueji forKey:@"heyueji"];                              //合约机
    [postDic setObject:dto.powerFlag forKey:@"powerFlag"];                          //节能补贴标识
    
    [postDic setObject:noReasonDto.realname forKey:@"realname"]; //联系人
    [postDic setObject:noReasonDto.mobilePhone forKey:@"mobilePhone"]; //联系人
    [postDic setObject:noReasonDto.retDate forKey:@"retDate"]; //取件日期
    [postDic setObject:noReasonDto.freightLog forKey:@"freightLog"]; //取件费
    [postDic setObject:noReasonDto.placerAddressDetail forKey:@"placerAddressDetail"]; //详细地址
    
    if (checkUpDate) {
        
        [postDic setObject:checkUpDate forKey:@"checkupDate"];                  //鉴定日期，用户在一个范围内选择                                     
        
    }
    
    HTTPMSG_RELEASE_SAFELY(_returnGoodsSubmitHttpMsg);
    
    _returnGoodsSubmitHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:postDic cmdCode:CC_ReturnGoodsSubmit];
    
    TT_RELEASE_SAFELY(postDic);
    
    [self.httpMsgCtrl sendHttpMsg:_returnGoodsSubmitHttpMsg];
    
}




- (void)receiveDidFailed:(HttpMessage *)receiveMsg{
    
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_ReturnGoodsApplication ) {
        
        [self returnGoodsApplicationOK:NO];
    }
    else if(receiveMsg.cmdCode == CC_ReturnGoodsSubmit ){
        
        [self returnGoodsSubmitOK:NO];
    }
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg{
   
    if (receiveMsg.cmdCode == CC_ReturnGoodsApplication ) {
        
        NSDictionary *items = receiveMsg.jasonItems;
        
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
    else if(receiveMsg.cmdCode == CC_ReturnGoodsSubmit )
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
            
            NSArray *tempList = EncodeArrayFromDic(items, @"returnResons");
            
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
        
        if (_delegate && [_delegate respondsToSelector:@selector(returnGoodsApplicationRequestCompletedWithResult:reasonList:returnGoodsPreparedDto:errorMsg:)]) {
            
            [_delegate  returnGoodsApplicationRequestCompletedWithResult:NO reasonList:nil returnGoodsPreparedDto:nil errorMsg:self.errorMsg];
        }
    }else{
        
        if (_delegate && [_delegate respondsToSelector:@selector(returnGoodsApplicationRequestCompletedWithResult:reasonList:returnGoodsPreparedDto:errorMsg:)]) {
            
            [_delegate  returnGoodsApplicationRequestCompletedWithResult:YES reasonList:self.reasonList   returnGoodsPreparedDto:self.returnGoodsPrepareDto errorMsg:self.errorMsg];
        }
    }
}


- (void)returnGoodsSubmitOK:(BOOL)isSuccess{
    
    if (isSuccess == YES) {
        
        if (_delegate && [_delegate respondsToSelector:@selector(retunGoodsSubmitRequestCompletedWithResult:errorMsg:)]) {
            
            [_delegate retunGoodsSubmitRequestCompletedWithResult:YES errorMsg:nil];
            
        }
    }
    else{
        
        if (_delegate && [_delegate respondsToSelector:@selector(retunGoodsSubmitRequestCompletedWithResult:errorMsg:)]) {
            
            [_delegate retunGoodsSubmitRequestCompletedWithResult:NO errorMsg:self.errorMsg];
            
        }
    }
}

@end

//
//  CouponService.m
//  SuningEBuy
//
//  Created by 周俊杰 on 14-3-14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CouponService.h"

@interface CouponService ()

@property (nonatomic,strong) HttpMessage *httpMsg;


@end


@implementation CouponService

- (void)dealloc{

    _delegate = nil;

}

- (void)couponQueryWithSubmitLotteryDto:(SubmitLotteryDto *)lotteryDto
{
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:@1 forKey:@"json"];
    
    [postDataDic setObject:lotteryDto.gid forKey:@"gid"];
    
    [postDataDic setObject:lotteryDto.productMoney forKey:@"money"];
    
    [postDataDic setObject:[NSString stringWithFormat:@"%d",[lotteryDto.productMoney intValue]/2] forKey:@"tnum"];
    

    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostLotteryTicketForHttps,@"trade/mobileQueryCoupon.go"];

    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    _httpMsg =  [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_CouponQuery];
    
    TT_RELEASE_SAFELY(postDataDic);
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];

}


- (void)fetchUserDetailInfo {
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:@1 forKey:@"json"];

    [postDataDic setObject:@1 forKey:@"flag"];

    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostLotteryTicketForHttps,@"user/queryMobile5.go"];

    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    _httpMsg =  [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_CouponUserQuery];
    
    TT_RELEASE_SAFELY(postDataDic);
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];
}//领奖人信息

- (void)checkCouponWithSubmitLotteryDto:(SubmitLotteryDto *)lotteryDto couponCode:(NSString *)code
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:@1 forKey:@"json"];
    
    [postDataDic setObject:lotteryDto.gid forKey:@"gid"];
    
    [postDataDic setObject:lotteryDto.productMoney forKey:@"money"];
    
    [postDataDic setObject:[NSString stringWithFormat:@"%d",[lotteryDto.productMoney intValue]/2] forKey:@"tnum"];
    
    [postDataDic setObject:code forKey:@"coupons"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostLotteryTicketForHttps,@"trade/mobileCheckCoupon.go"];
    
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    _httpMsg =  [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_CheckCoupon];
    
    TT_RELEASE_SAFELY(postDataDic);
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];
}//用券检查

- (void)payRemainMenoyWith:(LotteryDealsDto *)dealDto
{

    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:@1 forKey:@"json"];
    
    [postDataDic setObject:dealDto.buyid forKey:@"bid"];
    
    [postDataDic setObject:@10 forKey:@"gflag"];
    
    [postDataDic setObject:@2 forKey:@"source"];
    
    [postDataDic setObject:@2 forKey:@"payMethod"];

    [postDataDic setObject:kURLSchemeSuningEBuy forKey:@"returnUrl"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostLotteryTicketForHttps,@"trade/getMobilepayUrl.go"];
    
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    _httpMsg =  [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_PayRemainMoney];
    
    TT_RELEASE_SAFELY(postDataDic);
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];

}//支付余额

- (void)cancelCoupon:(LotteryDealsDto *)dealDto
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:@1 forKey:@"json"];
    
    [postDataDic setObject:dealDto.buyid forKey:@"bid"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostLotteryTicketForHttps,@"trade/mobileReleaseCoupon.go"];
    
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
   _httpMsg =  [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_CancelCoupon];
    
    TT_RELEASE_SAFELY(postDataDic);
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];
}//取消用劵

#pragma mark - HTTPRequest Delegate Methods

- (void)receiveDidFailed:(HttpMessage *)receiveMsg{
    
    [super receiveDidFailed:receiveMsg];
    
//    [self getCategoryDidFinished:NO];
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    if (receiveMsg.jasonItems == nil) {
        
        self.errorMsg = kHttpResponseJSONValueFailError;
        
//        [self getCategoryDidFinished:NO];
        
    }else{

        switch (receiveMsg.cmdCode) {
            case CC_CouponQuery:
            {
                NSInteger errorCode = [receiveMsg.jasonItems[kHttpResponseCode] integerValue];
                
                NSMutableArray  *couponsListData = [[NSMutableArray alloc] initWithCapacity:1];
                if (errorCode == 0)
                {
                    id obj = [receiveMsg.jasonItems objectForKey:@"row"];
                    
                    if ([obj isKindOfClass:[NSDictionary class]])   //只有1张用券
                    {
                        CouponModel *model =[[CouponModel alloc]init];
                        [model setAttributes:obj];
                        [couponsListData addObject:model];
                        TT_RELEASE_SAFELY(model);
                        
                    }else{
                        for (NSDictionary *dic in obj){
                            CouponModel *model =[[CouponModel alloc]init];
                            [model setAttributes:dic];
                            [couponsListData addObject:model];
                            TT_RELEASE_SAFELY(model);
                            
                        }
                    }
                }
                if ([_delegate respondsToSelector:@selector(couponQueryFinished:withInfoArray:)]) {
                    [_delegate couponQueryFinished:self withInfoArray:couponsListData];
                    TT_RELEASE_SAFELY(couponsListData);
                }
                
            }
                break;
            case CC_CouponUserQuery:{
                NSInteger errorCode = [receiveMsg.jasonItems[kHttpResponseCode] integerValue];
                
                if (errorCode == 0)
                {
                    NSDictionary *dic = [[receiveMsg.jasonItems objectForKey:@"rows"] objectForKey:@"row"];
                    ConfirmBetInfoModel *betInfoModel = [[ConfirmBetInfoModel alloc]init];
                    [betInfoModel setAttributes:dic];
                    if ([_delegate respondsToSelector:@selector(couponUserQueryFinished:withUserInfo:)]) {
                        [_delegate couponUserQueryFinished:self withUserInfo:betInfoModel];
                    }
                }
            }
                break;
                case CC_CheckCoupon:
            {
                NSInteger errorCode = [receiveMsg.jasonItems[kHttpResponseCode] integerValue];
                NSString *errorMsg = receiveMsg.jasonItems[kHttpResponseDesc];
                
                NSMutableArray  *couponsListData = [[NSMutableArray alloc]initWithCapacity:1];
                if (errorCode == 0)
                {
                    id obj = [receiveMsg.jasonItems objectForKey:@"row"];
                    
                    if ([obj isKindOfClass:[NSDictionary class]])   //只有1张用券
                    {
                        CouponModel *model =[[CouponModel alloc]init];
                        [model setAttributes:obj];
                        model.remarked = YES;
                        [couponsListData addObject:model];
                        
                    }else
                    {
                        for (NSDictionary *dic in obj)
                        {
                            CouponModel *model =[[CouponModel alloc]init];
                            [model setAttributes:dic];
                            model.remarked = YES;
                            [couponsListData addObject:model];
                        }
                    }
                }
                
                if ([_delegate respondsToSelector:@selector(couponCheckFinished:withInfoArray:errCode:errStr:)]) {
                    [_delegate couponCheckFinished:self withInfoArray:couponsListData errCode:errorCode errStr:errorMsg];
                }
            }
                break;
                case CC_PayRemainMoney:
            {
                NSInteger errorCode = [receiveMsg.jasonItems[kHttpResponseCode] integerValue];
                NSString *payUrlString = nil;
                if (errorCode == 0) {
                    NSDictionary *rowDic = [receiveMsg.jasonItems objectForKey:@"result"];
                    payUrlString =[rowDic objectForKey:@"@eppUrl"];
                }
                if ([_delegate respondsToSelector:@selector(goToPayUrl:payUrl:)]) {
                    [_delegate goToPayUrl:self payUrl:payUrlString];
                }
            }
                break;
                case CC_CancelCoupon:
            {
                NSInteger errorCode = [receiveMsg.jasonItems[kHttpResponseCode] integerValue];
                if ([_delegate respondsToSelector:@selector(cancelCouponSuccess:success:)]) {
                    [_delegate cancelCouponSuccess:self success:!errorCode];
                }
            }
                break;
            default:
                break;
        }
    }
}

@end

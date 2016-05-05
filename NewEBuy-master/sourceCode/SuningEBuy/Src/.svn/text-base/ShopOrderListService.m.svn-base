//
//  ShopOrderListService.m
//  SuningEBuy
//
//  Created by xmy on 24/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ShopOrderListService.h"
#import "ShopOrderListDto.h"
#import "PasswdUtil.h"
#import "SNSwitch.h"
@implementation ShopOrderListService

- (id)init {
    self = [super init];
    if (self) {
        
        _shopOrderList = [[NSMutableArray alloc]init];
        
        _page = [[NSMutableArray alloc]init];
        
    }
    
    return self;
}


- (void)httpMsgRelease{
    
    HTTPMSG_RELEASE_SAFELY(_ShopOrderListMsg);
    
}
- (void)sendShoporderListRequest:(NSString*)currentPage
                        WithTime:(NSString*)time
                       WithCustNum:(NSString*)token
                     orderStatus:(NSString*)orderStatus
{
    NSString *url = nil;
    
    // 门店订单 接口 变更 ，2014/09/23 xzoscar
    url = [KNewHomeAPIURL stringByAppendingString:@"myorder/private/queryOrderList.html"];
    
//    if([SNSwitch isPassportLogin]) {
//        url = [NSString stringWithFormat:@"%@/%@",kHostSuningWebMobileShopList,@"order/private/queryOrderListNew.do"];
//    }
//    else{
//        url = [NSString stringWithFormat:@"%@/%@",kHostSuningWebMobileShopList,@"order/queryOrderList.do"];
//    }
    

    //全部订单查询门店订单
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc]init];
    

    if([SNSwitch isPassportLogin])
    {
        // 走passport 不需要传custNum

    }
    else
    {
        //会员编号
        NSString *encodeStr = [PasswdUtil encryptString:token
                                                 forKey:@"SNMTLogon"
                                                   salt:@"sn201209"];
        
        [postDataDic setObject:encodeStr forKey:@"custNum"];
    }
    //系统来源，如1：客户端，2：B2C
    [postDataDic setObject:@"1" forKey:@"orderSourceSystem"];

/*    日期范围 oneWeek:近一周的订单；
        oneMonth:近一月的订单；
        halfYear:最近半年的订单;
        all:以往所有订单
    --以订单时间对应的日期（yyyy-mm-dd）为判断依据*/
//    [postDataDic setObject:time?time:@"" forKey:@"selectDate"];
    [postDataDic setObject:time?time:@"" forKey:@"selectDate"];


    //查询订单行状态 判断订单行状态，A：已支付的订单;B：退货处理中;C：退货完成;D：退款成功;ALL：所有状态 --查询满足上述状态的订单头，和该订单头所有订单行信息
    [postDataDic setObject:orderStatus?orderStatus:@"ALL" forKey:@"queryOrderItemStatus"];

    //分销渠道 10渠道;30渠道;40渠道;50渠道;60渠道;ALL所有渠道
    [postDataDic setObject:@"10" forKey:@"distChannel"];

    //商品名称
    [postDataDic setObject:@"" forKey:@"commodityName"];

/*    queryOrderId查询订单号
    10渠道POS订单号，如D00001234
        50渠道传B2C订单号，如：7004347526
        --根据传入的渠道，50查询的是订单头的源订单号（即B2C订单号，非行号)；其他渠道(10、30、40、60)查询的是POS订单号(即行号)；
        如果传入渠道为ALL，则两个字段都要查*/
    [postDataDic setObject:@"" forKey:@"queryOrderId"];
    
    //每页记录数
    [postDataDic setObject:@"10" forKey:@"perPageRecordNumber"];
    
    //当前页号
    [postDataDic setObject:currentPage?currentPage:@"" forKey:@"currentPageNumber"];

    //参照工作表-OMSCQ目录：交易码列
    [postDataDic setObject:@"" forKey:@"transCode"];
    //交易发起时间字符串，yyyy-MM-dd HH:mm:ss.SSS
    [postDataDic setObject:@"" forKey:@"tranDttm"];
    //记录在源系统创建的时间，如果源系统没有对应的时间字段，使用系统时间
    [postDataDic setObject:@"" forKey:@"createdDttm"];
    //记录在源系统修改的时间，如果源系统没有对应的时间字段，使用系统时间
    [postDataDic setObject:@"" forKey:@"updatedDttm"];
    
    HTTPMSG_RELEASE_SAFELY(_ShopOrderListMsg);
    
    _ShopOrderListMsg = [[HttpMessage alloc]initWithDelegate:self
                                                  requestUrl:url
                                                 postDataDic:postDataDic
                                                     cmdCode:CC_ShopOrderList];
    
    
    [self.httpMsgCtrl sendHttpMsg:_ShopOrderListMsg];
}

#pragma mark -
#pragma mark http message delegate

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
//    self.errorMsg = receiveMsg.errorCode;
    
    [self getShopOrderListData:NO];
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems;
    
    if (!items) {
        self.errorMsg = kHttpResponseJSONValueFailError;
        [self getShopOrderListData:NO];
        return;
    }else {// {{{
           // 门店订单 数据结构 改变，2014/09/23 xzoscar modify
            NSDictionary *list = EncodeDicFromDic(items,@"data");
        
            //分页信息
            NSInteger totalPage = [[list objectForKey:@"totalPage"]integerValue];
            NSInteger currentPage = [[list objectForKey:@"currentPageNumber"]integerValue];
            
            if (totalPage == currentPage) {
                self.isLastPage = YES;
            }else{
                self.isLastPage = NO;
            }
            
            NSArray	*orderLists =[list objectForKey:@"orderList"];
            
            if(IsArrEmpty(orderLists)) {
                self.errorMsg = L(@"NoStoreOrderData");
                [self getShopOrderListData:YES];
                return;
            }
        
            if (orderLists !=nil && [orderLists count]>0) {
                
                NSMutableArray *retArray = [[NSMutableArray alloc] init];
                
                for(NSDictionary *dic in orderLists){
                    
                    ShopOrderListDto *dto = [[ShopOrderListDto alloc] init];
                    
                    [dto encodeFromDictionary:dic];
                    
                    [retArray addObject:dto];
                    
                }
                
                self.shopOrderList = retArray;
                
                [self getShopOrderListData:YES];
        }
    }// }}}
}

- (void)getShopOrderListData:(BOOL)isSuccess
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(getShopOrderList:errorCode:WithService:)])
    {
        [self.delegate getShopOrderList:isSuccess errorCode:self.errorMsg WithService:self];
        
    }
    
}
//
//-(NSMutableArray *)shopOrderList
//{
//    if (!_shopOrderList) {
//        
//        _shopOrderList = [[NSMutableArray alloc]init];
//        
//    }
//    return _shopOrderList;
//}


@end

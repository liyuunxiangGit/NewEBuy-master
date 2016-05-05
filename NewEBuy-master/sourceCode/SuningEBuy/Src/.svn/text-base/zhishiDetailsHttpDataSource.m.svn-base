//
//  zhishiDetailsHttpDataSource.m
//  SuningEBuy
//
//  Created by xy ma on 12-2-22.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "zhishiDetailsHttpDataSource.h"

@implementation zhishiDetailsHttpDataSource

/*
 {
 "imageList": [
 "http://zhishi.suning.com/zhishitang_docs/articles/images/urphotos/zst_199621120110112205420.jpg",
 "http://zhishi.suning.com/zhishitang_docs/articles/images/urphotos/zst_784559620110112205834.jpg",
 "http://zhishi.suning.com/zhishitang_docs/articles/images/urphotos/zst_341066820110112205951.jpg",
 "http://zhishi.suning.com/zhishitang_docs/articles/images/urphotos/zst_549857820110112210051.jpg"
 ],
 "errCode": "0",
 "articleList": [
 {
 "content": "商品链接：http://www.suning.cn/webapp/wcs/stores/servlet/prd_10052_10051_-7__160627_1.html\n订单号：4716628\n订单日期：2010年12月25日\n\n易购分享：苏宁网上的价格很给力，如果你抽到100的圣诞优惠券，你再充值5000可以获得100的返券。这样你可以省下200元，原价2158将降为1958。这和实体店的卖价2200差距实在太大了。但是我看了下，大部分人都是抽到的80的圣诞优惠券。另外，如果你不想充值太多，想刚好抵扣你买的C6-00的价格，那么你充2000也将有40的返券。这样你也可以省下80+40=120，算下来也就是2158-120=2038，这样你的易购账户充的2000也刚好用完，你再自己在线支付38元即可。而2038的价格和店面卖的2200左右的价格相比仍然是相当给力。但是苏宁的送货那是相当不给力，12/25晚下单，直到1/9才短信通知可以取手机，1/10晚自己门店自提取货，终于拿到手。再说下用了2天的感觉，由于以前也是用的诺基亚塞班的系统，用起来上手还是比较快。500万的摄像头，加4倍自动变焦，再加LED闪光没得话说。但是处理器就略显不足，反应速度和1GHZ的比起来是有差距，但是还是够用。2G的标配卡在删除一些不必要的软件再自己装了些飞信、qq、MSN、UC、大智慧等等软件的情况下只剩400M左右的空间。建议打算买的人再另外买张8G的卡。3.2的电阻屏还不错，虽然不能和电容屏相比，够用就行。最后，C6拿在手上的感觉很好，够分量，这点对男士来说比较重要，总不希望拿在手上像没东西一样吧。最后总评，总的来说还算比较实惠，特别是在2000左右的价格。一句话:2000左右的价格值得出手。\n下面是实物图：\n发票为C6拍的\n\n手机实物图为诺基亚老手机200W拍的（颜色有失真）：",
 "createTime": "2012-02-06 15:48:24",
 "title": "测试正常",
 "nickName": "100666",
 "qaType": 0,
 "answerType": 0,
 "articleId": 23157,
 "authorId": 33000311612
 },
 {
 "content": "高低杠",
 "createTime": "2012-02-15 09:48:03",
 "title": "",
 "nickName": null,
 "qaType": 1,
 "answerType": 0,
 "articleId": 23164,
 "authorId": 33012344785
 },
 {
 "content": "213",
 "createTime": "2012-02-17 20:50:17",
 "title": "",
 "nickName": null,
 "qaType": 1,
 "answerType": 0,
 "articleId": 23171,
 "authorId": 30051056377
 }
 ]
 }
 */
//获取晒单数据
+ (NSMutableArray *)parseZhishiDetailsList:(NSDictionary*)items{
    if(!items || (NSNull *)items == [NSNull null]){
        
        return nil;
    }
    
    if([[items objectForKey:kZhishiErrCode] isEqualToString:@"0"])
        
    {
        NSArray *itemArr = [items objectForKey:@"articleList"];
        
        if (itemArr != nil && [itemArr count]>0){
            
            NSMutableArray *array = [[NSMutableArray alloc] init];
            
            for (NSDictionary *dic in itemArr)
            {
                DisProductDetailsDTO *dto = [[DisProductDetailsDTO alloc] init];
                
                [dto encodeFromDictionary:dic];
                
                int qaTypeInDTOInt = [dto.qaType intValue];
                
                //晒单类型，qaType为0是晒单，其余均是回复
                if(qaTypeInDTOInt == 0)
                {                    
                    [array addObject:dto];
                    
                    
                    return array;

                }                
            }
            //TT_RELEASE_SAFELY(array);
        }
        
    }
    return nil;
}

//获取回复的list
+ (NSMutableArray *)parseZhishiReplyList:(NSDictionary*)items{
    if(!items || (NSNull *)items == [NSNull null]){
        
        return nil;
    }
    
    if([[items objectForKey:kZhishiErrCode] isEqualToString:@"0"])
        
    {
        NSArray *itemArr = [items objectForKey:@"articleList"];
        
        if (itemArr != nil && [itemArr count]>0){
            
            NSMutableArray *array = [[NSMutableArray alloc] init];
            
            for (NSDictionary *dic in itemArr)
            {
                DisProductDetailsDTO *dto = [[DisProductDetailsDTO alloc] init];
                
                [dto encodeFromDictionary:dic];
                
                //晒单类型，qaType为0是晒单，其余均是回复
                if([dto.qaType intValue] == 0)
                {
                    DLog(@"do not  add  !");
                }else
                {
                    [array addObject:dto];
                }
                
            }
            
            if ([array count]>0){
                
                return array;
            }else{
                
                TT_RELEASE_SAFELY(array);
            }
        }
        
    }
    return nil;
}


+ (NSMutableArray *)parsezhishiImageList:(NSDictionary*)items{
    if(!items || (NSNull *)items == [NSNull null]){
        
        return nil;
    }
    
    if([[items objectForKey:kZhishiErrCode] isEqualToString:@"0"])
        
    {
        NSArray *itemArr = [items objectForKey:@"imageList"];
        
        if (itemArr != nil && [itemArr count]>0){
            
            NSMutableArray *array = [[NSMutableArray alloc] init];
            
            for (int i =0; i<[itemArr count]; i++) 
            {
                ProductDisImgeDTO *dto = [[ProductDisImgeDTO alloc] init];
                
                [dto encodeFromNSString:[itemArr objectAtIndex:i]];
                
                if ([dto.productDisImageClickURL isEqualToString:@""])  
                {
                    DLog(@"no image !");
                }else
                {
                    [array addObject:dto];
                }
                
            }
            
            if ([array count]>0){
                
                return array;
            }else{
                
                TT_RELEASE_SAFELY(array);
            }
        }
        
    }
    return nil;
}
@end

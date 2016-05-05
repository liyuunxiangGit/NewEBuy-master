//
//  ShopCartAddItemTask.m
//  SuningEBuy
//
//  Created by liukun on 14-6-24.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ShopCartAddItemTask.h"

@implementation ShopCartAddItemTask

- (instancetype)initWithProduct:(DataProductBasic *)product delegate:(id<BBTaskDelegate>)delegate
{
    self = [super init];
    
    if (self) {
        
        self.delegate = delegate;
        
        NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
        [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
        
        //普通商品数据请求
        //数量为1
        if (product.quantity < 1) {
            product.quantity = 1;
        }
        
        [postDataDic setValue:product.productId forKey:@"catEntryId_1"];
        [postDataDic setValue:__INT(product.quantity) forKey:@"quantity"];
        
        //抢购
        if (product.quickbuyId.trim.length > 0)
        {
            [postDataDic setValue:self.user.userId forKey:@"rushMemberId"];
            [postDataDic setValue:product.quickbuyId forKey:@"rushActId"];
            [postDataDic setValue:product.cityCode forKey:@"rushCityId"];
            [postDataDic setValue:@"rush" forKey:@"promotionType"];
            [postDataDic setValue:product.rushProcessId?product.rushProcessId:@"" forKey:@"procId"];
        }
        
        //单价团
        if (product.danjiaGroupId.trim.length > 0)
        {
            [postDataDic setValue:@"simpleGroup" forKey:@"promotionType"];
        }
        
        //大聚惠
        if (product.isJuhui) {
            [postDataDic setValue:@"4" forKey:@"priceType"];
            [postDataDic setValue:product.activityId forKey:@"promotionActiveId"];
        }
        //小套餐
        if (product.packageType == PackageTypeSmall)
        {
            [postDataDic setValue:@"1" forKey:@"isKitWare"];
            [postDataDic setValue:product.productCode forKey:@"configurationId_1"];
        }
        //配件套餐
        else if (product.packageType == PackageTypeAccessory)
        {
            NSArray *accessoryList = product.allAccessoryProductList;
            if ([accessoryList count] > 0)
            {
                int i = 1;
                NSString *key = nil;
                for (DataProductBasic *dto in accessoryList)
                {
                    //被选中
                    if (dto.isAccessorySelect) {
                        key = [NSString stringWithFormat:@"massocceceId_%d", i];
                        [postDataDic setValue:dto.masocceceId forKey:key];
                        i++;
                    }
                }
            }
        }
        //暂不支持x元n件
        else if (product.packageType == PackageTypeXn)
        {
            
        }
        
        //C店商品
        if (product.isCShop)
        {
            [postDataDic setObject:product.shopCode forKey:@"supplierCode"];
        }
        else
        {
            //苏宁自营商品传空
            [postDataDic setObject:@"" forKey:@"supplierCode"];
        }
        
        //engine
        self.attributes = postDataDic;
    }
    
    return self;
}

- (void)executeOperation
{
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttp, @"SNMobileAddShoppingCart"];
    
    HTTPMSG_RELEASE_SAFELY(_httpMessage);
    
    _httpMessage = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:self.attributes cmdCode:CC_CheckProductToShopCart];
    
    [self.httpMsgCtrl sendHttpMsg:_httpMessage];
}

#pragma mark - call back

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    if (receiveMsg.cmdCode == CC_CheckProductToShopCart)
    {
        NSDictionary *items = receiveMsg.jasonItems;
        if (!items)
        {
            [self failWithError:kDataTaskInvalidJSONError];
        }
        else
        {
            NSString *isSuccess = EncodeStringFromDic(items, @"isSuccess");
            if ([isSuccess isEqualToString:@"1"])
            {
                [self markAsFinished];
            }
            else
            {
                NSString *error = EncodeStringFromDic(items, @"errorMessage");
                if ([error hasPrefix:@"CMN"]) {
                    error = L(@"ShopCart_Add_Error_CheckFail");
                }
                if (error.trim.length == 0) {
                    error = L(@"ShopCart_Add_Error_CheckFail");
                }
                [self failWithError:TaskError(1, error)];
            }
        }
    }
}

@end

//
//  ReturnGoodsPrepareDTO.m
//  SuningEBuy
//
//  Created by david david on 12-8-8.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "ReturnGoodsPrepareDTO.h"

@implementation ReturnGoodsPrepareDTO

@synthesize orderId = _orderId;
@synthesize orderItemsId = _orderItemsId;
@synthesize productName = _productName;
@synthesize quantityValue = _quantityValue;
@synthesize deliveryDate = _deliveryDate;
@synthesize policyDesc = _policyDesc;
@synthesize channel = _channel;
@synthesize eppActiveFlag = _eppActiveFlag;
@synthesize returnType = _returnType;
@synthesize appraisal = _appraisal;
@synthesize factoryContect = _factoryContect;
@synthesize heyueji = _heyueji;
@synthesize powerFlag = _powerFlag;
@synthesize text = _text;
@synthesize errorCode = _errorCode;

@synthesize returncard = _returncard;
@synthesize returnFlag = _returnFlag;
@synthesize returnYfbAmount = _returnYfbAmount;
@synthesize returnYhkAmount = _returnYhkAmount;
@synthesize payFlag = _payFlag;
@synthesize currentDay = _currentDay;
@synthesize zstatus1 = _zstatus1;

- (void)dealloc {

    TT_RELEASE_SAFELY(_zstatus1);
    TT_RELEASE_SAFELY(_returnYhkAmount);
    TT_RELEASE_SAFELY(_returnYfbAmount);
    TT_RELEASE_SAFELY(_returnFlag);
    TT_RELEASE_SAFELY(_returncard);
    TT_RELEASE_SAFELY(_payFlag);
    
    TT_RELEASE_SAFELY(_errorCode);
    TT_RELEASE_SAFELY(_text);
    TT_RELEASE_SAFELY(_orderId);
    TT_RELEASE_SAFELY(_orderItemsId);
    TT_RELEASE_SAFELY(_productName);
    TT_RELEASE_SAFELY(_productCode);
    TT_RELEASE_SAFELY(_quantityValue);
    TT_RELEASE_SAFELY(_deliveryDate);
    TT_RELEASE_SAFELY(_policyDesc);
    TT_RELEASE_SAFELY(_channel);
    TT_RELEASE_SAFELY(_eppActiveFlag);
    TT_RELEASE_SAFELY(_returnType);
    TT_RELEASE_SAFELY(_appraisal);
    TT_RELEASE_SAFELY(_factoryContect);
    TT_RELEASE_SAFELY(_heyueji);
    TT_RELEASE_SAFELY(_powerFlag);
    TT_RELEASE_SAFELY(_currentDay);
    //245
    TT_RELEASE_SAFELY(_permitRetStatus);
    TT_RELEASE_SAFELY(_permitRetNum);
    TT_RELEASE_SAFELY(_apprFlag);
    TT_RELEASE_SAFELY(_apprType);
    TT_RELEASE_SAFELY(_apprAddress);
    TT_RELEASE_SAFELY(_telnum);
}

-(void)encodeFromDictionary:(NSDictionary *)dic{

    
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }

//    self.orderId = [dic objectForKey:@"orderId"]==nil?@"":[dic objectForKey:@"orderId"];
//    
//    self.orderItemsId = [dic objectForKey:@"orderItemsId"]==nil?@"":[dic objectForKey:@"orderItemsId"];
//
//    self.productName = [dic objectForKey:@"productName"]==nil?@"":[dic objectForKey:@"productName"];
    if(NotNilAndNull([dic objectForKey:@"orderId"])){
        self.orderId=[dic objectForKey:@"orderId"];
    }
    if(NotNilAndNull([dic objectForKey:@"orderItemsId"] )){
        self.orderItemsId=[dic objectForKey:@"orderItemsId"] ;
    }
    if(NotNilAndNull([dic objectForKey:@"productName"])){
        self.productName=[dic objectForKey:@"productName"];
    }
    if(NotNilAndNull([dic objectForKey:@"productCode"])){
        self.productCode=[dic objectForKey:@"productCode"];
    }
    
    self.vendorCShopName = EncodeStringFromDic(dic, @"vendorCShopName");
    self.vendorCode = EncodeStringFromDic(dic, @"vendorCode");
//
//    self.quantityValue = [dic objectForKey:@"quantityValue"]==nil?@"":[dic objectForKey:@"quantityValue"];
//
//    self.deliveryDate = [dic objectForKey:@"deliveryDate"]==nil?@"":[dic objectForKey:@"deliveryDate"];
//    
//    self.policyDesc = [dic objectForKey:@"policyDesc"]==nil?@"":[dic objectForKey:@"policyDesc"];
    if(NotNilAndNull( [dic objectForKey:@"quantityValue"])){
        self.quantityValue= [dic objectForKey:@"quantityValue"];
    }
    if(NotNilAndNull([dic objectForKey:@"deliveryDate"])){
        self.deliveryDate=[dic objectForKey:@"deliveryDate"];
    }
    if(NotNilAndNull( [dic objectForKey:@"policyDesc"])){
        self.policyDesc= [dic objectForKey:@"policyDesc"];
    }
//    
//    self.channel = [dic objectForKey:@"channel"]==nil?@"":[dic objectForKey:@"channel"];
//
//    self.eppActiveFlag = [dic objectForKey:@"eppActiveFlag"]==nil?@"":[dic objectForKey:@"eppActiveFlag"];
//    
//    self.returnType = [dic objectForKey:@"returnType"]==nil?@"":[dic objectForKey:@"returnType"];
    if(NotNilAndNull( [dic objectForKey:@"channel"])){
        self.channel= [dic objectForKey:@"channel"];
        self.vendorCShopName = self.channel;
    }
    if(NotNilAndNull([dic objectForKey:@"eppActiveFlag"])){
        self.eppActiveFlag=[dic objectForKey:@"eppActiveFlag"];
    }
    if(NotNilAndNull([dic objectForKey:@"returnType"])){
        self.returnType=[dic objectForKey:@"returnType"];
    }
    
//    
//    self.appraisal = [dic objectForKey:@"appraisal"]==nil?@"":[dic objectForKey:@"appraisal"];
//    
//    self.factoryContect = [dic objectForKey:@"factoryContect"]==nil?@"":[dic objectForKey:@"factoryContect"];
//    
//    self.heyueji = [dic objectForKey:@"heyueji"]==nil?@"":[dic objectForKey:@"heyueji"];
//    
//    self.powerFlag = [dic objectForKey:@"powerFlag"]==nil?@"":[dic objectForKey:@"powerFlag"];
    if(NotNilAndNull( [dic objectForKey:@"appraisal"])){
        self.appraisal= [dic objectForKey:@"appraisal"];
    }
    if(NotNilAndNull([dic objectForKey:@"factoryContect"])){
        self.factoryContect=[dic objectForKey:@"factoryContect"];
        
    }
    if(NotNilAndNull([dic objectForKey:@"heyueji"])){
        self.heyueji=[dic objectForKey:@"heyueji"];
    }
    if(NotNilAndNull( [dic objectForKey:@"powerFlag"])){
        self.powerFlag= [dic objectForKey:@"powerFlag"];
    }
//
//    self.text = [dic objectForKey:@"text"]==nil?@"":[dic objectForKey:@"text"];
//
//    self.errorCode = [dic objectForKey:@"errorCode"]==nil?@"":[dic objectForKey:@"errorCode"];
//
//    self.returnYfbAmount = [dic objectForKey:@"returnYfbAmout"]==nil?@"":[dic objectForKey:@"returnYfbAmout"];
//
//    self.returnYhkAmount = [dic objectForKey:@"returnYhkAmout"]==nil?@"":[dic objectForKey:@"returnYhkAmout"];
    if(NotNilAndNull([dic objectForKey:@"text"])){
        self.text=[dic objectForKey:@"text"];
    }
    if(NotNilAndNull([dic objectForKey:@"errorCode"])){
        self.errorCode=[dic objectForKey:@"errorCode"];
    }
    if(NotNilAndNull([dic objectForKey:@"returnYfbAmout"])){
        self.returnYfbAmount=[dic objectForKey:@"returnYfbAmout"];
    }
    if(NotNilAndNull([dic objectForKey:@"returnYhkAmout"])){
        self.returnYhkAmount=[dic objectForKey:@"returnYhkAmout"];
        
    }
//
//    self.returnFlag = [dic objectForKey:@"returnFlag"]==nil?@"":[dic objectForKey:@"returnFlag"];
//
//    self.returncard = [dic objectForKey:@"returncard"]==nil?@"":[dic objectForKey:@"returncard"];
//
//    self.payFlag = [dic objectForKey:@"payFlag"]==nil?@"":[dic objectForKey:@"payFlag"];
//    
//    self.currentDay = [dic objectForKey:@"currentDay"]==nil?@"":[dic objectForKey:@"currentDay"];
//
//    self.zstatus1 = [dic objectForKey:@"zstatus1"]==nil?@"":[dic objectForKey:@"zstatus1"];
    if(NotNilAndNull([dic objectForKey:@"returnFlag"])){
        self.returnFlag=[dic objectForKey:@"returnFlag"];
    }
    //liukun 修改bug， returncard改为recordcard
    if(NotNilAndNull([dic objectForKey:@"recordcard"])){
        self.returncard=[dic objectForKey:@"recordcard"];
    }
    if (NotNilAndNull([dic objectForKey:@"payFlag"])) {
        self.payFlag = [dic objectForKey:@"payFlag"];
    }
    if(NotNilAndNull([dic objectForKey:@"currentDay"])){
        self.currentDay=[dic objectForKey:@"currentDay"];
    }
    if(NotNilAndNull([dic objectForKey:@"zstatus1"])){
        self.zstatus1=[dic objectForKey:@"zstatus1"];
    }
    if(NotNilAndNull([dic objectForKey:@"payFreeForReturn"])){
        self.payFreeForReturn=[dic objectForKey:@"payFreeForReturn"];
    }
    if (NotNilAndNull([dic objectForKey:@"invoiceIsPrinted"])) {
        self.invoiceIsPrinted = [dic objectForKey:@"invoiceIsPrinted"];
    }
    if(NotNilAndNull([dic objectForKey:@"unreasonableReturnFlag"])){
        self.unreasonableReturnFlag=[dic objectForKey:@"unreasonableReturnFlag"];
    }
    if(NotNilAndNull([dic objectForKey:@"minDeliverDate"])){
        self.minDeliverDate=[dic objectForKey:@"minDeliverDate"];
    }
    if(NotNilAndNull([dic objectForKey:@"maxDeliverDate"])){
        self.maxDeliverDate=[dic objectForKey:@"maxDeliverDate"];
    }
    
    if (NotNilAndNull([dic objectForKey:@"stateName"])) {
        self.province = [dic objectForKey:@"stateName"];
    }
    if(NotNilAndNull([dic objectForKey:@"cityName"])){
        self.city=[dic objectForKey:@"cityName"];
    }
    if(NotNilAndNull([dic objectForKey:@"districtName"])){
        self.area=[dic objectForKey:@"districtName"];
    }
    if(NotNilAndNull([dic objectForKey:@"addr"])){
        self.detailAddress=[dic objectForKey:@"addr"];
    }
    self.needTOOnline = EncodeStringFromDic(dic, @"needTOOnline");
    //245
    if(NotNilAndNull([dic objectForKey:@"permitRetStatus"])){
        self.permitRetStatus=[dic objectForKey:@"permitRetStatus"];
    }
    if(NotNilAndNull([dic objectForKey:@"permitRetNum"])){
        self.permitRetNum=[dic objectForKey:@"permitRetNum"];
    }
    
    if(NotNilAndNull([dic objectForKey:@"apprFlag"])){
        self.apprFlag=[dic objectForKey:@"apprFlag"];
    }
    
    if(NotNilAndNull([dic objectForKey:@"apprType"])){
        self.apprType=[dic objectForKey:@"apprType"];
    }
    if(NotNilAndNull([dic objectForKey:@"apprAddress"])){
        self.apprAddress=[dic objectForKey:@"apprAddress"];
    }
    if(NotNilAndNull([dic objectForKey:@"telnum"])){
        self.telnum=[dic objectForKey:@"telnum"];
    }

}
@end

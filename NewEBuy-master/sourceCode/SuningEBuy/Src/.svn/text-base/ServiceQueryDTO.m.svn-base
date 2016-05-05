//
//  ServiceQueryDTO.m
//  SuningEMall
//
//  Created by wei xie on 12-9-7.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ServiceQueryDTO.h"

@implementation ServiceQueryDTO
@synthesize searchCriteeria = _searchCriteeria;
@synthesize searchKeyWord = _searchKeyWord;
@synthesize productId = _productId;
@synthesize productName = _productName;
@synthesize memberCardNo = _memberCardNo;
@synthesize salNum = _salNum;
@synthesize distributionMode = _distributionMode;
@synthesize quantity = _quantity;
@synthesize saleTime = _saleTime;


-(void)encodeFromDictionary:(NSDictionary *)dic{
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
	
	id          searchCriteeri           =	[dic objectForKey:KHttpRequestSearchCriteria];
	id          searchKeyWor             =	[dic objectForKey:KHttpRequestSearchKeyWord];	
	id          productI                 =	[dic objectForKey:KHttpRequestProductId];
	id          productNam               =	[dic objectForKey:KHttpRequestProductName];
	
	id          memberCardN              =	[dic objectForKey:KHttpRequestMemberCardNo];
    id          salNu                    =	[dic objectForKey:KHttpRequestSalNum];	
    id          distributionMod          =	[dic objectForKey:KHttpRequestDistributionMode];
    id          quantit                  =	[dic objectForKey:KHttpRequestQuantity];
	
    id          saleTim                  =	[dic objectForKey:KHttpRequestSaleTime];
    
    if (NotNilAndNull(searchCriteeri))
    {
		self.searchCriteeria = searchCriteeri;
	}
    
    if (NotNilAndNull(searchKeyWor))
    {
		self.searchKeyWord = searchKeyWor;
	}
    
    if (NotNilAndNull(productI))
    {
		self.productId = productI;
	}
    
    if (NotNilAndNull(productNam))
    {
		self.productName = productNam;
	}
	
    if (NotNilAndNull(memberCardN))
    {
		self.memberCardNo = memberCardN;
	}
	
    if (NotNilAndNull(salNu))
    {
		self.salNum = salNu;
	}
    
    if (NotNilAndNull(distributionMod))
    {
		self.distributionMode = distributionMod;
	}
    
    if (NotNilAndNull(quantit))
    {
		self.quantity = quantit;
	}
	
    
    if (NotNilAndNull(saleTim))
    {
		self.saleTime = saleTim;
	}
}



@end

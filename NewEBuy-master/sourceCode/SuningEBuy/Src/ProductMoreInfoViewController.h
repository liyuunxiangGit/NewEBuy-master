//
//  ProductMoreInfoViewController.h
//  SuningEBuy
//
//  Created by  on 12-9-13.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "DataProductBasic.h"
#import "ProductParamService.h"

@interface ProductMoreInfoViewController : CommonViewController <ProductParamServiceDelegate>
{
    @private
    NSString    *_serviceStr;
    
    BOOL        isParamInfoLoaded;
}

@property (nonatomic, strong) NSArray           *paraList;

@property (nonatomic, strong) DataProductBasic  *productDetailDto;

@property (nonatomic, strong) ProductParamService *service;


- (id)initWithProductDTO:(DataProductBasic *)dto;

@end

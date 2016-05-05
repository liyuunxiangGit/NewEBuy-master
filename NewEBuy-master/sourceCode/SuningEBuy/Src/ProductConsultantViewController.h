//
//  ProductConstantViewController.h
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-24.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "CommonViewController.h"

#import "PageRefreshTableViewController.h"

#import "ProductConsultantService.h"

#import "DataProductBasic.h"


@interface ProductConsultantViewController : PageRefreshTableViewController<ProductConsultantListDelegate>{
    
    NSMutableArray            *_nextPageList;
    
    ProductConsultantService  *service;
  
    BOOL                      isLoadNextPage;   
    
    NSMutableArray            *_consultantList; //商品咨询数据存储列表
    
    DataProductBasic          *_product;
    

}

@property (nonatomic ,strong) NSMutableArray  *nextPageList;

@property (nonatomic, strong)NSMutableArray   *consultantList;

@property (nonatomic ,strong)DataProductBasic *product;

- (id)initWithBasicDTO:(DataProductBasic *)dto;

- (void)updateTable;

- (void)backToProductDetail:(NSString *)message;

@end

//
//  SellerListViewController.h
//  SuningEBuy
//
//  Created by xmy on 12/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "DataProductBasic.h"
#import "SellerInfoService.h"
#import "ProductDetailService.h"
#import "ProductHeadImgCell.h"
#import "ProductShowCell.h"
#import "SellerListDTO.h"

typedef void(^SellerSelectCallBack) (NSString *shopCode);

@interface SellerListViewController : CommonViewController<ProductDetailServiceDelegate,ProductCommandDelegate, SellerInfoServiceDelegate>

@property (nonatomic,retain)ProductDetailService *detailService;
@property (nonatomic, strong)DataProductBasic  *productDTO;
@property (nonatomic, strong)SellerInfoService  *sellerService;
@property (nonatomic, strong) NSArray *shopList;

@property (nonatomic, copy) SellerSelectCallBack selectedBlock;

@end

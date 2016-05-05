//
//  ProductIntoCarViewController.h
//  SuningEBuy
//
//  Created by li xiaokai on 13-7-16.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "ProductDetailService.h"
#import "SelectItemCell.h"
#import "ProductHeadImgCell.h"
#import "ShopCartV2Service.h"
#import "ProductPackageView.h"

typedef void(^ProductClusterChangeBlock)(DataProductBasic *pro);

@interface ProductIntoCarViewController : CommonViewController<ProductDetailServiceDelegate,SelectItemDelegate,ProductCommandDelegate,ShopCartV2ServiceDelegate>{
    
    SEL      loginSel;
}


@property(nonatomic,strong)DataProductBasic *productDto;

@property(nonatomic,strong)ProductDetailService *detailService;

@property(nonatomic,strong)NSString *colorId;

@property(nonatomic,strong)NSString *versionId;

@property(nonatomic,strong)UIImageView *buttomView;

@property (nonatomic, strong) EGOImageView *productImageView; //用于展示动画

@property (nonatomic)NSInteger carType;//1：立即购物 加入购物车2  2：加入购物车 加入购物车1

@property (nonatomic, strong) ShopCartV2Service    *cartService;

@property (nonatomic,strong)UIButton *okBtn;

@property (nonatomic, copy) ProductClusterChangeBlock clusterChangedBlock;
@end

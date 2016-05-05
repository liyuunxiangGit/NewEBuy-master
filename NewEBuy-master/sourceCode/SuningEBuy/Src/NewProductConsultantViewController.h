//
//  NewProductConsultantViewController.h
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-26.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "CommonViewController.h"

#import "PlaceholderTextView.h"

#import "NewProductConsultantService.h"

#import "DataProductBasic.h"

@interface NewProductConsultantViewController : CommonViewController<NewProductConsultantServiceDelegate>
{
    PlaceholderTextView             *_askTextView; //咨询内容
    
    CALayer                         *_askLayer;
    
    NewProductConsultantService     *service;
    
    DataProductBasic                *_product;  //商品信息
    
}

@property (nonatomic ,strong) PlaceholderTextView *askTextView;

@property (nonatomic, strong) CALayer             *askLayer;

@property (nonatomic ,strong)DataProductBasic     *product;

- (id)initWithDTO:(DataProductBasic *)dto;

//返回上级页面
- (void)backToProductConsultant;

@end

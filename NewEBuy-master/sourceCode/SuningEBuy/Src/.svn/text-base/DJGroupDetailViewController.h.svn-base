//
//  DJGroupDetailViewController.h
//  SuningEBuy
//
//  Created by xmy on 26/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "DJGroupListItemDTO.h"
#import "DJGroupDetailDTO.h"
#import "DJGroupDetailService.h"
#import "Calculagraph.h"
#import "DJGroupApplyDTO.h"
#import "DJGroupApplyService.h"

@interface DJGroupDetailViewController : ProductDetailViewController<DJGroupDetailServiceDelegate,DJGroupApplyServiceDelegate>

//@property (nonatomic, strong) ProductDetailService *detailService;

@property (nonatomic, strong) DJGroupDetailService *service;

@property (nonatomic, strong) DJGroupDetailDTO *detailDto;

@property (nonatomic, strong) DJGroupListItemDTO *baseItemDto;

@property (nonatomic, copy) NSString *actId;

@property (nonatomic, copy) NSString *channelId;

/*传入参数DTO*/ /*商品返回详情DTO*/
@property (nonatomic, strong) DataProductBasic  *productBasicDTO;

///*计时器*/
@property (nonatomic, strong) Calculagraph    *calculagraph;

@property (nonatomic, strong) DJGroupApplyService  *groupApplyService;

@property(nonatomic,strong)NSString *stateStr;

@property(nonatomic,strong)NSString *timeStr;


- (id)initWithDto:(DJGroupListItemDTO *)dto;


@end

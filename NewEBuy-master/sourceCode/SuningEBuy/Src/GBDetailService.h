//
//  GBDetailService.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBBaseService.h"
#import "GBGoodsDetailDTO.h"

@protocol GBDetailServiceDelegate;

@interface GBDetailService : GBBaseService
{
    HttpMessage             *gbDetailHttpMsg;
}
/*
 @abstract      获取团购商品详情的方法
 @param         categoryId  频道ID（作为区分团购频道标识） H8004酒店   其他窝窝
 @param         snProId     团购产品ID
 */
@property (nonatomic, weak) id<GBDetailServiceDelegate>       gbDelegate;
@property (nonatomic, strong) GBGoodsDetailDTO                  *gbGoodsDetailDTO;

- (void)beginGetGBGoodsDetail:(NSString *)groupType
                  withSnProId:(NSString *)snProId;

@end


@protocol GBDetailServiceDelegate <NSObject>

@optional
- (void)getGBGoodsDetailComplete:(GBDetailService *)service
                          Result:(BOOL)isSuccess;


@end

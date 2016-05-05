//
//  PurchaseDetailViewController.h
//  SuningEBuy
//
//  Created by xmy on 26/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "PurchaseProductBtnView.h"
#import "PanicPurchaseDTO.h"
#import "PurchaseService.h"
#import "Calculagraph.h"

@interface PurchaseDetailViewController : ProductDetailViewController<PurchaseServiceDelegate>
{
//    BOOL noCalculagraphAtFirst;   //没有带计时器进入

}

@property (nonatomic, strong) PurchaseService *panicService;

/*抢购信息 初始化抢购详情数据*/ 
@property (nonatomic, strong) PanicPurchaseDTO *panicDTO;

/*抢购即时详细信息 */
@property (nonatomic, strong) PanicPurchaseDTO *panicDetailDto;

//抢购渠道，默认为开关接口设置，但是也可以手动设置
@property (nonatomic, assign) PanicChannel       panicChannel;

///*计时器*/
@property (nonatomic, strong) Calculagraph    *calculagraph;

@property (nonatomic) BOOL isLoadPurchase;

//@property (nonatomic, strong) OHAttributedLabel          *timeLbl;

@property(nonatomic,strong)NSString *stateStr;

@property(nonatomic,strong)NSString *timeStr;



- (id)initWithPurchaseDTOandIsSK:(id)purchaseDTO;

@end

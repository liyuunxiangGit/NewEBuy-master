//
//  AllOrderDownSelectViewController.h
//  SuningEBuy
//
//  Created by xmy on 26/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "SNSwitch.h"

typedef enum
{
    eProductOrderList = 0, //商品订单
    eShopOrderList,     //门店订单
    eMobileFeeOrderList,//话费充值
    eCaiPiaoOrderList,  //彩票订单
//    eTuanGouOrderList,  //生活团购
    eWaterOrderList,    //水费缴纳
    eElectricOrderList, //电费缴纳
    eGasOrderList,      //燃气费缴纳
    ePlaneOrderList,    //机票订单
    eHotelOrderList,     //酒店订单
    eManzuoOrderList,     //满座订单
    eReturnGoodsOrderList,  //退货中
    eWaitPingJiaList      //待评价
    
}OrderSelectDownType;


@class AllOrderDownSelectViewController;

@protocol AllOrderDownSelectViewControllerDelegate <NSObject>

- (void)selectedAllOrderStyleOrTime:(NSString*)str WithRow:(NSInteger)row;

-(void)btnsImage;

@end
@interface AllOrderDownSelectViewController : CommonViewController

@property (nonatomic)NSInteger selectRow;
@property (nonatomic, strong)NSArray *selectArr;
@property (nonatomic,assign) id<AllOrderDownSelectViewControllerDelegate> delegate;

@end

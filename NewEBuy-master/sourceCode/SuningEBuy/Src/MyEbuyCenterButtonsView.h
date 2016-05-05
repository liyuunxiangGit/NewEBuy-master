//
//  MyEbuyCenterButtonsView.h
//  SuningEBuy
//
//  Created by shasha on 12-8-30.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyEbuyCenterButtonsViewDelegate;

//typedef enum{
//
//    //我的收藏夹
//    eGoToFavorite,
//    //订单中心
//    eGoToOrderCenter,
//    //评价晒单
//    eGoToEvaluation,
//    //我的易购券
//    eGoToCoupon,
//    //我的商旅
//    eGoToTicketList,
//    //我的一键购
//    eGoToAddressInfo,
//    //退货
//    eGotoReturnGoods,
//    //更多
//    eGoToLotteryTicket
//}
//ACtionType;
typedef enum{
    
    //订单中心
    eGoToOrderCenter,
    //我的易付宝
    eGoToEfubao,
//    //我的云钻
    eGoToIntegral,
    //我的易购券
    eGoToCoupon,
    //电子会员卡
    eGoToMyCard
}
ACtionType;

@interface MyEbuyCenterButtonsView : UIView
{
}

@property (nonatomic, weak) id <MyEbuyCenterButtonsViewDelegate>delegate;

@property (nonatomic)  BOOL isPressed;

@property (nonatomic,strong)UILabel *YuELab;
@property (nonatomic,strong)UILabel *jifengLab;
@property (nonatomic,strong)UILabel *quanLab;

-(void)initBtnAndLblList;


@end
@protocol MyEbuyCenterButtonsViewDelegate <NSObject>

- (void)buttonTappedWithActionType:(ACtionType)type;

@end

//
//  CShopReturngoodsSegementView.h
//  SuningEBuy
//
//  Created by 荀晓冬 on 13-12-18.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CShopReturngoodsSegementViewDelegate;

typedef enum{
    //申请退货
    sortReturnGoods = 1,
    //退货查询
    sortReturnGoodsQuery
    
} ButtonGoods;
@interface CShopReturngoodsSegementView : UIView
{
    id<CShopReturngoodsSegementViewDelegate> __weak _delegate;
}
@property(nonatomic,weak) id<CShopReturngoodsSegementViewDelegate> delegate;


@property(nonatomic,strong) UIButton *returnGoods;
@property(nonatomic,strong) UIButton *returnGoodsQuery;
@property(nonatomic,strong) UIImageView *headBackView;

@end



@protocol CShopReturngoodsSegementViewDelegate <NSObject>

- (void)returnGoodsBtnPressed:(ButtonGoods)btnIndex;

@end
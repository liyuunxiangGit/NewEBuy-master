//
//  CShopReturngoodsSegementView.m
//  SuningEBuy
//
//  Created by 荀晓冬 on 13-12-18.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CShopReturngoodsSegementView.h"
#define kMobileRechargeFrame CGRectMake(0, 0, 160, 35)
#define kWaterElectricityGasFrame CGRectMake(160, 0, 160, 35)


@implementation CShopReturngoodsSegementView

@synthesize returnGoods = _returnGoods;
@synthesize returnGoodsQuery = _returnGoodsQuery;

@synthesize delegate = _delegate;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_returnGoods);
    TT_RELEASE_SAFELY(_returnGoodsQuery);
    
}

-(UIImageView *)headBackView{
    
    if (!_headBackView) {
        
        _headBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
        _headBackView.backgroundColor = [UIColor clearColor];
        _headBackView.userInteractionEnabled = YES;
        _headBackView.image = [UIImage imageNamed:@"search_normal_new.png"];
        
           }
    
    return _headBackView;
}

- (UIButton *)returnGoods
{
    if (!_returnGoods) {
        _returnGoods = [[UIButton alloc] initWithFrame:kMobileRechargeFrame];
       // _returnGoods.backgroundColor = [UIColor redColor];
        [_returnGoods setTitle:L(@"MyEBuy_RequestToReturn") forState:UIControlStateNormal];
        [_returnGoods setBackgroundImage:[UIImage imageNamed:@"search_fouce_left.png"] forState:UIControlStateNormal];
        [_returnGoods addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
        _returnGoods.tag = sortReturnGoods;
    }
    return _returnGoods;
}

- (UIButton *)returnGoodsQuery
{
    if (!_returnGoodsQuery) {
        _returnGoodsQuery = [[UIButton alloc] initWithFrame:kWaterElectricityGasFrame];
       // _returnGoodsQuery.backgroundColor = [UIColor blueColor];
        [_returnGoodsQuery setTitle:L(@"MyEBuy_ReturnOrderQuery") forState:UIControlStateNormal];
        [_returnGoodsQuery setBackgroundImage:[UIImage imageNamed:@"search_fouce_right.png"] forState:UIControlStateNormal];
        [_returnGoodsQuery addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
        _returnGoodsQuery.tag = sortReturnGoodsQuery;
    }
    return _returnGoodsQuery;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headBackView];

        [self addSubview:self.returnGoods];
        [self addSubview:self.returnGoodsQuery];
    }
    return self;
}

- (void)btnPress:(id)sender
{
    UIButton *sortBtn = (UIButton *)sender;
    
    if (sortBtn.tag == sortReturnGoods) {
        [self.returnGoods setBackgroundImage:[UIImage imageNamed:@"search_fouce_left.png"] forState:UIControlStateSelected];
       
        
        [self.delegate returnGoodsBtnPressed:sortReturnGoods];
    }
    else
    {
       
        [self.returnGoodsQuery setBackgroundImage:[UIImage imageNamed:@"search_fouce_right.png"] forState:UIControlStateSelected];
        
        [self.delegate returnGoodsBtnPressed:sortReturnGoodsQuery];
    }
}

@end

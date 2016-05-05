//
//  NProDetailFiveCell.h
//  SuningEBuy
//
//  Created by xmy on 19/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProductBasic.h"
#import "OSGetStatusCommand.h"

@interface NProDetailFiveCell : UITableViewCell

@property (nonatomic, retain)UIImageView *backView;

@property (nonatomic, retain)UILabel *shopNameLbl;//商家

@property (nonatomic, retain)UILabel *shopLbl;//商家满意度
@property (nonatomic, strong) UIImageView   *shopView;
@property (nonatomic, retain)UILabel *shopDetailLbl;//商家满意度

@property (nonatomic, strong) UIImageView   *serviceSatisfyView;
@property (nonatomic, retain)UILabel *serviceSatisfyLbl;//服务满意度
@property (nonatomic, retain)UILabel *serviceSatisfyDetailLbl;

@property (nonatomic, strong) UIImageView   *sellerSpeedView;
@property (nonatomic, retain)UILabel *sellerSpeedLbl;//物流满意度
@property (nonatomic, retain)UILabel *sellerSpeedDetailLbl;

//@property (nonatomic, retain)UILabel *deliverSpeedLbl;//发货及时性
//@property (nonatomic, retain)UILabel *deliverSpeedDetailLbl;

@property (nonatomic, strong) UIImageView   *oneLineView;
@property (nonatomic, strong) UIImageView   *twoLineView;


@property (nonatomic,retain)UIImageView *topLine;

@property (nonatomic, retain)UIImageView *OnlineServiceImage;//在线客服
//@property (nonatomic, retain)UILabel *OnlineServiceLbl;
@property (nonatomic, retain)UIButton *OnlineServiceBtn;

@property (nonatomic, retain)UIButton *GoToShopBtn;//进入店铺
@property (nonatomic, strong) UIImageView   *threeLineView;

@property (nonatomic, strong) UIImageView   *fengelineOne;
@property (nonatomic, strong) UIImageView   *fengelineTwo;

- (void)setNProDetailFiveCellInfo:(DataProductBasic *)shopInfoDto WithChatStatus:(OSShowStatus)status
;

+ (CGFloat)NProDetailFiveCellheight:(DataProductBasic *)shopInfoDto WithChatStatus:(OSShowStatus)status;


@end

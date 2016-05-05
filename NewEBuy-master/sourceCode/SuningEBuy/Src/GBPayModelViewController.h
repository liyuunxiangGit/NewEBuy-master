//
//  GBPayModelViewController.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-2-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBPayService.h"
#import "GBSubmitDTO.h"
#import "UPPayPlugin.h"
#import "OHAttributedLabel.h"
#import "EfubaoAccountService.h"

#import "GBGoodsDetailDTO.h"

@interface GBPayModelViewController : CommonViewController<GBPayServiceDelegate,UPPayPluginDelegate,EfubaoAccountServiceDelegate>

@property (nonatomic, strong) GBPayService              *gbPayService;
@property (nonatomic, strong) GBSubmitDTO               *gbSubmitDto;
@property (nonatomic, strong) UILabel                   *descLabel;
@property (nonatomic, strong) UIImageView               *arrowImage;
@property (nonatomic, strong) OHAttributedLabel         *priceLabel;

@property (nonatomic, assign) BOOL                      isFormOrder;

@end

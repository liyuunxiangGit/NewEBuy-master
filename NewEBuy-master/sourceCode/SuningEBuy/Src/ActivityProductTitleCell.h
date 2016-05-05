//
//  ActivityProductTitleCell.h
//  SuningEBuy
//
//  Created by shasha on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductTitleCell.h"
#import "PurchaseConstant.h"

@interface ActivityProductTitleCell : ProductTitleCell

@property (nonatomic, strong) UIView       *backView;
@property (nonatomic, strong) UIImageView  *leftTopImageView;
@property (nonatomic, strong) UILabel      *descLabel;
@property (nonatomic, assign) BOOL          isEnable;
@property (nonatomic, assign) PurchaseType  purchaseType;   //类型，必须设定
  
- (void)setItem:(DataProductBasic *)productDetail;

+ (CGFloat)height:(DataProductBasic *)productDetail;

@end

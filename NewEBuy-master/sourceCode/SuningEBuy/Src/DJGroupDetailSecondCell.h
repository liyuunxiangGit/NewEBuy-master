//
//  DJGroupDetailSecondCell.h
//  SuningEBuy
//
//  Created by xie wei on 13-7-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJGroupDetailDTO.h"
#import "DataProductBasic.h"
#import "RuleCopyTextView.h"

@interface DJGroupDetailSecondCell : UITableViewCell

@property (nonatomic, strong) UILabel *productName;
@property (nonatomic, strong) RuleCopyTextView *productDes;
@property (nonatomic, strong) UIImageView *accessImg;
@property (nonatomic, strong) UIImageView *desBackImg;
@property (nonatomic, strong) UIButton    *showDetailBtn;


- (void)setItem:(DataProductBasic *)productDetail detailDto:(DJGroupDetailDTO *)detailDto Click:(BOOL)isClick;
+ (CGFloat)height:(DataProductBasic *)productDetail;

@end

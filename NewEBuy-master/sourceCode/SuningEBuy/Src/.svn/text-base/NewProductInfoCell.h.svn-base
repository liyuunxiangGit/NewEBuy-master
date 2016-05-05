//
//  NewProductInfoCell.h
//  SuningEBuy
//
//  Created by li xiaokai on 13-7-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "productInfoDescribeCell.h"
#import "ProductCommandDelegate.h"
#import "RuleCopyTextView.h"
@interface NewProductInfoCell : productInfoDescribeCell


@property (nonatomic, weak)    id <ProductCommandDelegate> delegate;
@property(nonatomic,strong)UIButton         *markBtn;
@property(nonatomic,strong)RuleCopyTextView *ruleTextView;

+(float)cellHeight:(NSString *)string;
+(float)cellHeight:(NSString *)string withExpand:(BOOL)expand;

-(void) setInfoString:(NSString *)aItem;

@end

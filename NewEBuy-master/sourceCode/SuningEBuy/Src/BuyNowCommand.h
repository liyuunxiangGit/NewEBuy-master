//
//  BuyNowCommand.h
//  SuningEBuy
//
//  Created by  liukun on 13-10-18.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "Command.h"
#import "DataProductBasic.h"


@interface BuyNowCommand : Command

@property (nonatomic, strong) DataProductBasic *product;
@property (nonatomic, weak)  CommonViewController *sController;

@end

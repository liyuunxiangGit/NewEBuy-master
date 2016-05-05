//
//  DJGroupDetailFourthCell.h
//  SuningEBuy
//
//  Created by xie wei on 13-7-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductParaDTO.h"

@interface DJGroupDetailFourthCell : UITableViewCell

@property (nonatomic, strong) UILabel *markLbl;

@property (nonatomic, strong) UILabel *infoLbl;


@property (nonatomic, strong) ProductParaDTO  *contendTDO;


- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;


+ (CGFloat)height:(ProductParaDTO *)dto;

+ (CGFloat)getRowHeight:(ProductParaDTO *)tempDto;

@end

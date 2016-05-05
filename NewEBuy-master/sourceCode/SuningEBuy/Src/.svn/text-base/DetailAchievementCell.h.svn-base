//
//  DetailAchievementCell.h
//  SuningEBuy
//
//  Created by lanfeng on 12-3-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AchievementExchangeDTO.h"

@interface DetailAchievementCell : UITableViewCell{

    BOOL    isProductNameEmpty;
}

//商品名称
@property (nonatomic,strong)  UILabel *productNameLabel;
//单据类型
@property (nonatomic,strong)  UILabel *typeLabel;
//单据类型的值
@property (nonatomic,strong)  UILabel *typeValueLabel;
//云钻变化
@property (nonatomic,strong)  UILabel *achievementChangeLabel;
//云钻变化的值
@property (nonatomic,strong)  UILabel *achievementChangeValueLabel;

@property (nonatomic, strong) UIImageView          *timeLine;

@property (nonatomic, strong) UIImageView          *timePoint;

@property (nonatomic,strong)  AchievementExchangeDTO *exchangeDto;

@property (nonatomic)CellPosition    cellP;

- (void)setItem:(AchievementExchangeDTO *)aItem;

+ (CGFloat)height:(AchievementExchangeDTO *)item;


@end

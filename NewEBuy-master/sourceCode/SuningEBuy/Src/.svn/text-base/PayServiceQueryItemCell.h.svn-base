//
//  PayServiceQueryItemCell.h
//  SuningEBuy
//
//  Created by 刘坤 on 11-10-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UITableViewCellEx.h"
#import "PayServiceQueryDTO.h"

@interface PayServiceQueryItemCell : UITableViewCellEx
{
    UILabel *_orderNOTextLabel;
    
    UILabel *_orderNameTextLabel;
    
    UILabel *_companyNameTextLabel;
    
    UILabel *_payAmountLabel;
    UILabel *_payAmountTextLabel;
    
    UILabel *_payTimeTextLabel;
    
    UILabel *_statusNameTextLabel;
    
    PayServiceQueryDTO *_itemDTO;
}

@property (nonatomic, strong) UILabel *orderNOTextLabel;

@property (nonatomic, strong) UILabel *orderNameTextLabel;

@property (nonatomic, strong) UILabel *companyNameTextLabel;

@property (nonatomic, strong) UILabel *payAmountLabel;
@property (nonatomic, strong) UILabel *payAmountTextLabel;

@property (nonatomic, strong) UILabel *payTimeTextLabel;

@property (nonatomic, strong) UILabel *statusNameTextLabel;

@property (nonatomic, strong) PayServiceQueryDTO *itemDTO;

@property (nonatomic, strong) UIImageView *icon;

@property (nonatomic, strong) UIImageView *topLine;

@property (nonatomic, strong) UIImageView *bottomLine;

@property (nonatomic, strong) NSString *typeCode;//区分水电煤账单，01水，02电，03煤

- (void)setItemDTO:(PayServiceQueryDTO *)itemDTO;

+ (CGFloat)height:(PayServiceQueryDTO *)item;


@end

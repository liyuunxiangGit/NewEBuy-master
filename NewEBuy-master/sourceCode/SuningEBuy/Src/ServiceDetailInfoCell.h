//
//  ServiceDetailInfoCell.h
//  SuningEBuy
//
//  Created by wei xie on 12-9-6.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDeliveryAddress  @"deliveryAddress"
#define kDeliveryDate     @"deliveryDate"
#define kDeliverQuantity  @"deliverQuantity"
#define kChangeReturnDoc  @"changeReturnDoc"

@interface ServiceDetailInfoCell : UITableViewCell{
    
}

@property (nonatomic, strong) NSMutableDictionary     *detailInfoDic;

@property (nonatomic, strong) UILabel                 *conLabel;

@property (nonatomic, strong) UILabel                 *saleLabel;

@property (nonatomic, strong) UILabel                 *nameLabel;

@property (nonatomic, strong) UILabel                 *naLabel;

@property (nonatomic, strong) UILabel                 *numLabel;

@property (nonatomic, strong) UILabel                 *numvLabel;

@property (nonatomic, strong) UILabel                 *typeLabel;

@property (nonatomic, strong) UILabel                 *typesLabel;

- (id)initWithReuseIndetifier:(NSString *)reuseIndetifier;

- (void)setDetailInfoCellContent:(NSMutableDictionary *)detailInfoDic;

@end

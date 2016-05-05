//
//  FlightInfoCell.h
//  SuningEBuy
//
//  Created by shasha on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlightListDetailDTO.h"


@interface FlightInfoCell : UITableViewCell
@property(nonatomic,strong)FlightListDetailDTO *item;
@property(nonatomic,strong)EGOImageView     *airportImageView;
@property(nonatomic,strong)UILabel         *airportNameLabel;
@property(nonatomic,strong)UILabel         *startNameLabel;
@property(nonatomic,strong)UILabel         *stopNameLabel;
@property(nonatomic,strong)UILabel         *priceLable;
@property(nonatomic,strong)UILabel         *discountLabel;
@property(nonatomic,strong)UILabel         *ticketLabel;
@property(nonatomic,strong)UILabel         *roomStyleLabel;
@property(nonatomic,assign)BOOL            isExpanded;
@property(nonatomic,strong)UIImageView     *expandIconView;
@property(nonatomic,strong)UIImageView     *lineView;

- (void)setItem:(FlightListDetailDTO *)aItem ;


@end

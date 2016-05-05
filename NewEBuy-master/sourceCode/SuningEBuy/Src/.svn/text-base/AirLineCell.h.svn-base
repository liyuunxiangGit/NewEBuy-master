//
//  AirLineCell.h
//  SuningEBuy
//
//  Created by david on 14-2-16.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFOrderDetailDTO.h"

@protocol AirLineCellDelegate;

@interface AirLineCell : UITableViewCell{
    
    AirlineInfoDTO   *infoDto;
}

@property(nonatomic,weak) id <AirLineCellDelegate>delegate;
    

-(void)refreshCell:(PFOrderDetailDTO *)dto index:(NSInteger)index;

+(CGFloat)height:(PFOrderDetailDTO *)dto;

@end

@protocol AirLineCellDelegate <NSObject>

-(void)airlineCell:(AirLineCell *)cell airlineInfo:(AirlineInfoDTO *)info;

@end
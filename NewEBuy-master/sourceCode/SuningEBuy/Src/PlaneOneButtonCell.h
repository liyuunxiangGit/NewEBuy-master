//
//  PlaneOneButtonCell.h
//  SuningEBuy
//
//  Created by david on 14-2-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    //退改签
    PlaneButtonTypeRefund,
    //取消订单
    PlaneButtonTypeCancel
    
} PlaneButtonType;


@protocol PlaneOneButtonCellDelegate;


@interface PlaneOneButtonCell : UITableViewCell

@property(nonatomic,assign)PlaneButtonType  buttonType;
@property(nonatomic,weak)id<PlaneOneButtonCellDelegate>delegate;

+(CGFloat)height;

-(void)refreshCell:(PlaneButtonType)type;

@end


@protocol PlaneOneButtonCellDelegate <NSObject>

-(void)planeOneButtonCell:(PlaneOneButtonCell *)cell
               buttonType:(PlaneButtonType)type;

@end

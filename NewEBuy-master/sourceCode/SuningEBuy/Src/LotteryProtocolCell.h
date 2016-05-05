//
//  LotteryProtocolCell.h
//  SuningEBuy
//
//  Created by david david on 12-7-9.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LotteryProtocolCellDelegate;


@interface LotteryProtocolCell : UITableViewCell{
    
    id<LotteryProtocolCellDelegate>__weak delegate;
}

@property(nonatomic,strong)     UIImageView     *backgroundImageView;
@property(nonatomic,strong)     UIButton        *checkButton;
@property(nonatomic,strong)     UILabel         *desLbl;
@property(nonatomic,strong)     UILabel         *linkUrlLbl;
@property(nonatomic,assign)     BOOL            isAgreeWithPro;
@property(nonatomic,weak)     id<LotteryProtocolCellDelegate>delegate;
@end


@protocol LotteryProtocolCellDelegate <NSObject>

-(void)returnUserCheck:(BOOL)checked;

-(void)presentModalProtocolView;

@end
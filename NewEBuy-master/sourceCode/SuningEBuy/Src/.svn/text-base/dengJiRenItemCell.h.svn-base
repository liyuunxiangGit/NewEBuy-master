//
//  dengJiRenItemCell.h
//  SuningEBuy
//
//  Created by xy ma on 12-5-11.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UITableViewCellEx.h"
#import "BoardingInfoDTO.h"

@protocol dengJiRenItemCellDelegate;


@interface dengJiRenItemCell : UITableViewCellEx{
    
    id<dengJiRenItemCellDelegate> __weak delegate;
}



@property(nonatomic,strong) BoardingInfoDTO *boardingInfoDto;

@property(nonatomic,strong) UILabel    *dengjirenLbl;
@property(nonatomic,strong) UIView     *whiteBackView;
@property(nonatomic,strong) UIView     *peopleInfoView;
@property(nonatomic,strong) UILabel    *tipLabel;

@property(nonatomic,strong) UIButton   *dengJREditBtn;
@property(nonatomic,weak) id<dengJiRenItemCellDelegate> delegate;
@property(nonatomic,strong) NSMutableArray *personList;
@property(nonatomic,strong) NSArray     *certiList;



-(void) setDengJiRenInfoByArray:(NSMutableArray *)array;

-(void)dengJREditAction:(id)sender;

+(CGFloat)height:(int)count;


@end



@protocol dengJiRenItemCellDelegate <NSObject>

-(void)dengJiRenManagement:(id)sender;

@end

//
//  BoardingPersonCell.h
//  SuningEBuy
//
//  Created by lanfeng on 12-5-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoardingInfoDTO.h"
#import "UITableViewCellEx.h"


@protocol BoardingPersionCellDelegate;

@interface BoardingPersonCell : UITableViewCellEx{
    BOOL            isSelected;
    UIImageView     *_btnImageView;
    UIButton        *_checkBtn;
    UILabel         *_nameLbl;
    UILabel         *_travellerTypeLbl;
    id<BoardingPersionCellDelegate> __weak boardingPersionCellDelegate;

}

@property(nonatomic,strong) UIImageView *btnImageView;
@property(nonatomic,strong) UIButton *checkBtn;
@property(nonatomic,strong) UILabel  *nameLbl;
@property(nonatomic,strong) UILabel  *travellerTypeLbl;
@property (nonatomic, weak) id<BoardingPersionCellDelegate> boardingPersionCellDelegate;

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier;
-(void)setItem:(BoardingInfoDTO *)dto andSelected:(NSString *)selected;

@end


@protocol BoardingPersionCellDelegate <NSObject>

-(void)isSelected:(BOOL)isSelectd andTag:(int)tag;

@end

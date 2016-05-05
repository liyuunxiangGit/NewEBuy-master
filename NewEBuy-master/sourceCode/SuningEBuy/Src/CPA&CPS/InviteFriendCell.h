//
//  InviteFriendCell.h
//  SuningEBuy
//
//  Created by leo on 14-3-7.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InviteFriendView.h"
@interface InviteFriendCell : UITableViewCell

@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UILabel     *iconvalue;
@property (nonatomic,strong)  InviteFriendView * invitefriden;
-(void)setinvitefriendcell:(NSIndexPath *)index;
@end

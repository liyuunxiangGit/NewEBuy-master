//
//  InviteFriendCell.m
//  SuningEBuy
//
//  Created by leo on 14-3-7.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "InviteFriendCell.h"
@implementation InviteFriendCell
{
    NSArray *textarray;
    NSArray *iconarray;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        textarray = [[NSArray alloc] initWithObjects:L(@"CPACPS_DuanxinInvite"),L(@"CPACPS_SinaWeiboInvite"),L(@"CPACPS_WeixinInvite"),L(@"CPACPS_DangmianInvite"),nil];
        iconarray = [[NSArray alloc] initWithObjects:@"messageinvite.png",@"sinainvite.png",@"weixininvite.png",@"inviteface.png",nil];
    }
    return self;
}


-(InviteFriendView *)invitefriden{
    if (!_invitefriden) {
        _invitefriden = [[InviteFriendView alloc] initWithFrame:CGRectMake(10, 5, 300, 70)];
    }
    return _invitefriden;
}

-(UILabel *)iconvalue{
    if (!_iconvalue) {
        _iconvalue = [[UILabel alloc] init];
        _iconvalue.frame = CGRectMake(60, 10, 180, 20);
        _iconvalue.backgroundColor= [UIColor clearColor];
    }
    return _iconvalue;
}


-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.frame = CGRectMake(10, 5, 30, 30);
    }
    return _icon;
}

-(void)setinvitefriendcell:(NSIndexPath *)index{
    if (index.section == 0) {
        [self addSubview:self.invitefriden];
    }
    else if(index.section == 1){
        self.icon.image=[UIImage imageNamed:[iconarray objectAtIndex:index.row]];
        [self addSubview:self.icon];
        self.iconvalue.text=[textarray objectAtIndex:index.row];
        [self addSubview:self.iconvalue];

    }
    else{
        [self addSubview:self.invitefriden];
        _invitefriden.activitybtn.hidden=YES;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  NewInviteFriendCell.m
//  SuningEBuy
//
//  Created by sn－wahaha on 14-9-22.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NewInviteFriendCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation NewInviteFriendCell
{
    NSArray *textarray;
    NSArray *iconarray;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        textarray = [[NSArray alloc] initWithObjects:L(@"Product_SinaWeiBo"),L(@"Product_WeiXinFriends"),L(@"Product_WeiXinFriendsCircle"),L(@"CPACPS_DuanxinInvite"),L(@"CPACPS_DangmianInvite"),L(@"CPACPS_CopyContent"),nil];
        iconarray = [[NSArray alloc] initWithObjects:@"share_xinlangweibo.png",@"share_weixinhaoyou.png",@"share_weixinhaoyouquan.png",@"share_SMS_duanxin.png",@"dangmian_.png",@"fuzhi_.png",nil];
    }
    return self;
}

-(void)setInviteFriendCell:(NSIndexPath *)index{
    if (index.row == 0) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        UILabel *price = (UILabel *)[self viewWithTag:9001];
        UILabel *label = (UILabel *)[self viewWithTag:9000];
        if (!label) {
            label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 30)];
            label.tag = 9000;
            label.backgroundColor = [UIColor clearColor];
            label.text = L(@"CPACPS_3MonthCommission");
            label.font = [UIFont systemFontOfSize:13];
            price = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 300, 50)];
            price.textAlignment = NSTextAlignmentCenter;
            price.textColor = [UIColor redColor];
            price.tag=9001;
            [self addSubview:label];
            [self addSubview:price];
        }
        if ([UserCenter defaultCenter].efubaoStatus == eLoginByPhoneActive || [UserCenter defaultCenter].efubaoStatus == eLoginByEmailActive) {
            label.hidden = NO;
            price.font = [UIFont boldSystemFontOfSize:60];
            price.frame = CGRectMake(10, 60, 300, 50);
            price.text = [NSString stringWithFormat:@"￥%@",_iconvalue?_iconvalue:@"0.00"];
            if([_iconvalue intValue]==0){
                price.text = L(@"CPACPS_NoCommissionNow");
                price.font = [UIFont boldSystemFontOfSize:40];
            }
            price.backgroundColor = [UIColor clearColor];
        }
        else{
            price.text=L(@"CPACPS_ActivateYFBGetCommission");
            label.hidden = NO;
            price.frame = CGRectMake(10, 45, 300, 50);
            price.font = [UIFont boldSystemFontOfSize:20];
        }
    }
    else{
        self.contentView.backgroundColor  =RGBCOLOR(242, 242, 242);
        [self setInviteBtn];
    }
}

-(void)setInviteBtn{
    CGSize size1 =  [_inviteFriendString sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(self.frame.size.width-60, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    UIImageView *imgview  = [[UIImageView alloc] initWithFrame:CGRectMake(12, 20, 15, 15)];
    [imgview setImage:[UIImage imageNamed:@"shijianzou_.png"]];
    [self addSubview:imgview];
    UITextView *textview = (UITextView *)[self viewWithTag:3005];
    if (!textview) {
        textview=[[UITextView alloc] initWithFrame:CGRectMake(35, 10, size1.width+20, size1.height +30)];
        textview.editable = NO;
        textview.tag = 3005;
        textview.scrollEnabled =NO;
        textview.font = [UIFont systemFontOfSize:13];
        textview.backgroundColor = [UIColor clearColor];
        [self addSubview:textview];
    }
    textview.frame =CGRectMake(35, 10, size1.width+20, size1.height +30);
    textview.text = _inviteFriendString;

    UIView *linevie = [[UIView alloc] initWithFrame:CGRectMake(19, 35, 2, size1.height + 52 + 100 +20)];
    linevie.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:linevie];

    
    for (int i = 0; i<6; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:1000+i];
        UILabel  *label = (UILabel *)[self viewWithTag:2000+i];
        if(!btn){
            btn = [[UIButton alloc] init];
            [btn setImage:[UIImage imageNamed:[iconarray objectAtIndex:i]] forState:UIControlStateNormal];
            btn.tag = 1000+i;
            [btn addTarget:self.ower action:@selector(fenXiang:) forControlEvents:UIControlEventTouchUpInside];
            label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:13];
            label.text = [textarray objectAtIndex:i];
            label.tag = 2000 +i;
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor clearColor];
            [self addSubview:btn];
            [self addSubview:label];
        }
        btn.frame =CGRectMake(45+i%3*90, size1.height + 25 +i/3*80 +10 , 50, 50);
        label.frame =CGRectMake(35+i%3*90, size1.height + 75 +i/3*80 +10, 70, 20);
    }
    CGSize size2 =  [_inviteIndex sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(self.frame.size.width-60, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    
    UILabel *inteindex = (UILabel *)[self viewWithTag:2009];
    if (!inteindex) {
        inteindex = [[UILabel alloc] initWithFrame:CGRectMake(40, size1.height + 85 + 100+20 , size2.width, size2.height)];
        inteindex.tag = 2009;
        inteindex.font = [UIFont systemFontOfSize:13];
        inteindex.lineBreakMode = UILineBreakModeWordWrap;
        inteindex.numberOfLines = 0;
        inteindex.backgroundColor = [UIColor clearColor];
        [self addSubview:inteindex];

    }
    inteindex.text = _inviteIndex;
    inteindex.frame =CGRectMake(40, size1.height + 85 + 100+20 , size2.width, size2.height);
//    UIButton *imgbtn = [[UIButton alloc] initWithFrame:CGRectMake(40, size1.height + 85 + 105 +size2.height, 255, 119)];
//    [imgbtn setImage:[UIImage imageNamed:@"baner_xinrenhongbao"] forState:UIControlStateNormal];
//    [imgbtn addTarget:self.ower action:@selector(xinRen) forControlEvents:UIControlEventTouchUpInside];
    UIView *linevie1 = (UIView *)[self viewWithTag:3001];
    if (!linevie1) {
        linevie1= [[UIView alloc] initWithFrame:CGRectMake(19, size1.height + 85 + 115 +20, 2, size2.height +119)];
        linevie1.tag=3001;
        linevie1.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:linevie1];

    }
    linevie1.frame = CGRectMake(19, size1.height + 85 + 115+20, 2, size2.height);
    UIImageView  *imgview1 = (UIImageView *)[self viewWithTag:3000];
    if (!imgview1) {
        imgview1  = [[UIImageView alloc] init];
        imgview1.tag = 3000;
        [imgview1 setImage:[UIImage imageNamed:@"shijianzou_.png"]];
        [self addSubview:imgview1];

    }
    imgview1.frame=CGRectMake(12, size1.height + 85 + 100 +20, 15, 15);
    

//    [self addSubview:imgbtn];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

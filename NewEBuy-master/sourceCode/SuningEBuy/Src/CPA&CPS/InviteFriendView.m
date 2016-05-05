//
//  InviteFriendView.m
//  SuningEBuy
//
//  Created by leo on 14-3-7.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "InviteFriendView.h"

@implementation InviteFriendView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:self.invitetext];
        [self addSubview:self.activitybtn];
        [self addSubview:self.note];
    }
    return self;
}

-(UITextView *)note{
    if (!_note) {
        _note = [[UITextView alloc] initWithFrame:CGRectMake(5, 0, 300, 40)];
        _note.editable = NO;
        _note.scrollEnabled = NO;
    }
    return _note;
}

-(UITextView *)invitetext{
    if (!_invitetext) {
        _invitetext = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, 300, 47)];
        _invitetext.editable = NO;
        _invitetext.scrollEnabled = NO;
        _invitetext.text=@"adsfsadfsdafsafdsaf";
        
    }
    return _invitetext;
}

-(UIButton *)activitybtn{
    if (!_activitybtn) {
        
        _activitybtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 300, 50)];
        
    }
    return _activitybtn;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

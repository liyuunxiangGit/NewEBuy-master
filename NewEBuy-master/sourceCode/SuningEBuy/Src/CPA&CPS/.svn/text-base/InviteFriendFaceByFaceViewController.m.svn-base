//
//  InviteFriendFaceByFaceViewController.m
//  SuningEBuy
//
//  Created by leo on 14-3-12.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "InviteFriendFaceByFaceViewController.h"

@interface InviteFriendFaceByFaceViewController ()
{
}
@end

@implementation InviteFriendFaceByFaceViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)dealloc
{
    TT_RELEASE_SAFELY(_note1);
    TT_RELEASE_SAFELY(_note2);
}

-(UITextView *)note1{
    if (!_note1) {
        _note1 = [[UITextView alloc] initWithFrame:CGRectMake(5, 20, 300, 40)];
        _note1.editable = NO;
        _note1.font = [UIFont systemFontOfSize:14];
        _note1.backgroundColor = [UIColor clearColor];
        _note1.text=L(@"CPACPS_Step1");
        NSURL *photourl = [NSURL URLWithString:_ercodeurl];
        EGOImageView *imgview = [[EGOImageView alloc] initWithFrame:CGRectMake(75, self.note1.bottom+5, 150, 150)];
        imgview.imageURL =photourl;
        [self.view addSubview:imgview];
    }
    return _note1;
}

-(UITextView *)note2{
    if (!_note2) {
        _note2 = [[UITextView alloc] initWithFrame:CGRectMake(10, 220, 300, 60)];
        _note2.editable = NO;
        _note2.font = [UIFont systemFontOfSize:14];
        _note2.backgroundColor = [UIColor clearColor];
        _note2.text=[NSString stringWithFormat:@"%@:%@,%@",L(@"CPACPS_Step2"),[UserCenter defaultCenter].cipher,L(@"CPACPS_YouAndFriendGetAward")];
        UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(22, self.note2.bottom+5, 275, 145)];
        imgview.image = [UIImage imageNamed:@"invitefaceinfo"];
        [self.view addSubview:imgview];
    }
    return _note2;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.note1];
    [self.view addSubview:self.note2];
    self.title =L(@"CPACPS_DangmianInvite");

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

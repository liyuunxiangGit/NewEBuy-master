//
//  VoiceSignLoginViewController.m
//  SuningEBuy
//
//  Created by sn－wahaha on 14-11-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "VoiceSignLoginViewController.h"

@interface VoiceSignLoginViewController ()

@property (nonatomic,strong) UIButton *needLogin;
@property (nonatomic,strong) UIImageView *backImg;
@property (nonatomic,strong) UILabel    *detailText;


@end

@implementation VoiceSignLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=L(@"VoiceSign");
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)init{
    self = [super init];
    if (self) {
        [self needLogin];
        [self backImg];
        [self detailText];
    }
    return self;
}

-(void)sendChouJiangRequest{
    if ([self.ower respondsToSelector:@selector(sendChouJiangRequest)]){
        [self.ower performSelector:@selector(sendChouJiangRequest)];
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if([UserCenter defaultCenter].isLogined){
        [self sendChouJiangRequest];
    }
    else{
        
    }
}

-(UIImageView *)backImg{
    if (!_backImg) {
        _backImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 280, 280)];
        _backImg.image = [UIImage imageNamed:@"pic-ios"];
        [self.view addSubview:_backImg];
    }
    return _backImg;
}
-(UILabel *)detailText{
    if (!_detailText) {
        _detailText = [[UILabel alloc] initWithFrame:CGRectMake(20, self.needLogin.top-60, self.view.width-40, 50)];
        _detailText.lineBreakMode = UILineBreakModeWordWrap;
        _detailText.numberOfLines = 0;
        _detailText.text =L(@"VoiceSign_NeedLoginDetail");
        _detailText.textColor = [UIColor colorWithRed:157./255 green:157/255. blue:157/255. alpha:1];
        _detailText.font = [UIFont systemFontOfSize:13];
        _detailText.textAlignment=NSTextAlignmentCenter;
        [self.view addSubview:_detailText];
    }
    return _detailText;
}

-(UIButton *)needLogin{
    if (!_needLogin) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.height - 30 - 64, self.view.width, 30)];
        label.text =L(@"VoiceSign_NeedLogin");
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithRed:157/255. green:157/255. blue:157/255. alpha:1];
        
        [self.view addSubview:label];

        _needLogin = [[UIButton alloc] init];
        _needLogin.frame = CGRectMake(20, label.top -30, 280, 30);
        [_needLogin addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        _needLogin.backgroundColor = [UIColor colorWithRed:247/255. green:102/255. blue:31/255. alpha:1];
        [_needLogin setTitle:L(@"LoginImmediately") forState:UIControlStateNormal];
        [self.view addSubview:_needLogin];
        
           }
    return _needLogin;
}

-(void)click{
    [self login];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

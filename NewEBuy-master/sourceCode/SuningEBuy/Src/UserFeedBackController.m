//
//  UserFeedBackController.m
//  SuningEBuy
//
//  Created by li xiaokai on 14-1-26.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "UserFeedBackController.h"
#define kAppId @"424598114"

@interface UserFeedBackController ()

@end

@implementation UserFeedBackController

-(UserFeedBackPreViewController *)questionVC{
    
    if (!_questionVC) {
        
        _questionVC = [[UserFeedBackPreViewController alloc] init];
        
        [self.view addSubview:_questionVC.view];
    }
    
    return _questionVC;
}


-(UserFeedBackNewViewController *)tuCaoVC{
    
    if (!_tuCaoVC) {
        
        _tuCaoVC = [[UserFeedBackNewViewController alloc] init];
        
        _tuCaoVC.view.hidden = YES;
        
        [self.view addSubview:_tuCaoVC.view];
    }
    
    return _tuCaoVC;
}
-(UIButton *)tuCaoBtn{
    
    
    if (!_tuCaoBtn) {
        
        _tuCaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
         _tuCaoBtn.backgroundColor = [UIColor whiteColor];
                    
        [_tuCaoBtn setTitle:L(@"UserFeedBack_Complain") forState:UIControlStateNormal];
        
        _tuCaoBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        
        [_tuCaoBtn setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateNormal];
        
        [_tuCaoBtn setTitleColor:[UIColor orange_Light_Color] forState:UIControlStateSelected];
        
        
//        [_tuCaoBtn addTarget:self action:@selector(tuCaoAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_tuCaoBtn];
    }
    
    return _tuCaoBtn;
}

-(UIButton *)questionBtn{
    
    
    if (!_questionBtn) {
        
        _questionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _questionBtn.backgroundColor = [UIColor whiteColor];
        
        [_questionBtn setTitle:L(@"UserFeedBack_Consult") forState:UIControlStateNormal];
        
        _questionBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        
        [_questionBtn setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateNormal];
        
        [_questionBtn setTitleColor:[UIColor orange_Light_Color] forState:UIControlStateSelected];
        
//        [_questionBtn addTarget:self action:@selector(questionAction) forControlEvents:UIControlEventTouchUpInside];
        
        _questionBtn.selected = YES;
        
        [self.view addSubview:_questionBtn];
    }
    
    return _questionBtn;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = L(@"Comment");
        
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
-(void)loadView{
    [super loadView];
    
    self.hasSuspendButton = YES;
}
//-(void)tuCaoAction{
//    
//    self.tuCaoBtn.selected = YES;
//    
//    self.questionBtn.selected = NO;
//    
//    self.tuCaoVC.view.hidden = NO;
//    
//    self.questionVC.view.hidden = YES;
//    
//}
//
//-(void)questionAction{
//    
//    self.tuCaoBtn.selected = NO;
//    
//    self.questionBtn.selected = YES;
//    
//    self.tuCaoVC.view.hidden = YES;
//    
//    self.questionVC.view.hidden = NO;
//    
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
//    self.questionBtn.frame = CGRectMake(0, 0, 160, 40);
//    
//    self.tuCaoBtn.frame = CGRectMake(160, 0, 160, 40);
//    
//    
//    self.questionVC.view.frame = CGRectMake(0, 40, 320, self.view.frame.size.height-40);
//    
//    self.tuCaoVC.view.frame = CGRectMake(0, 40, 320, self.view.frame.size.height-40);
    
    
    UIImageView *v = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-133)/2, 20, 133, 160)];
    v.image = [UIImage imageNamed:@"feedbackgood.png"];
    [self.view addSubview:v];
    
    v = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-133)/2, 190, 133, 160)];
    v.image = [UIImage imageNamed:@"feedbacktucao.png"];
    [self.view addSubview:v];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:self.view];
    
    if (CGRectContainsPoint(CGRectMake(20, 10, 280, 180),location)) {
        //好评

        NSString *str = [NSString stringWithFormat:
                         @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", kAppId];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:str]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
        else
        {
            DLog(@"bu zhichi ");
        }
    }
    else if(CGRectContainsPoint(CGRectMake(20, 200, 280, 200),location)){
     
        
        //吐槽
        
        UserFeedBackNewViewController *tuCaoVC = [[UserFeedBackNewViewController alloc] init];
        
        [self.navigationController pushViewController:tuCaoVC animated:YES];
        
    }
    
}
@end

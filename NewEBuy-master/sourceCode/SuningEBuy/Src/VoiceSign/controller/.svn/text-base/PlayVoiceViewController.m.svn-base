//
//  PlayVoiceViewController.m
//  SuningEBuy
//
//  Created by leo on 14-4-9.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "PlayVoiceViewController.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"
#import "VoiceSignViewController.h"
#import "QYaoYiYaoViewCtrler.h"
#import "VoiceDetailShareViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "VoiceSignDTO.h"
#import "SNSwitch.h"
#import "VoiceSignLoginViewController.h"
#import "RipplesView.h"
static SystemSoundID shake_sound_male_id = 0;
@interface PlayVoiceViewController ()
{
    NSString  *voicecod;
    BOOL      isgetcode;            //是否获取到声波解码
    NSString  *activeid;
    NSString  *activeTypeId;
    ActiveRuleViewController *webview;
}
@property (nonatomic,strong)RipplesView *ripplesV;
@end

@implementation PlayVoiceViewController


- (void)dealloc
{
    _signservice.httpDelegate=nil;
    _circleview=nil;
    _signservice=nil;
    _dvvoice=nil;
    _dvvoice.delegate = nil;
    TT_RELEASE_SAFELY(myTimer);

    
}
- (id)init
{
    self = [super init];
    if (self) {
        self.title=L(@"PageTitlePlayVoice");
        self.hasNav = NO;
        [self setIOS7FullScreenLayout:YES];
        [self getvoicecode];
//        [self.view addSubview:self.loginview];
        self.hidesBottomBarWhenPushed = YES;
        self.pageTitle=L(@"Sound-listen-listen");
        isgetcode =NO;
        _issign = NO;
        // Custom initialization
        NSString *path = [[NSBundle mainBundle] pathForResource:@"voicedecode" ofType:@"wav"];
        if (path) {
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_male_id);
        }

    }
    return self;
}


-(void)refreshnavigation{
    CGRect frame;
    if (IOS7_OR_LATER)
    {
        frame = CGRectMake(0, 0, self.view.frame.size.width, 70);
    }
    else
    {
        frame = CGRectMake(0, -20, self.view.frame.size.width, 70);
    }

    UIView *navigationView = [[UIView alloc]initWithFrame:frame];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 26, 46, 40)];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:[UIImage imageNamed:@"home_button_back_default"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(gotoBack) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:backBtn];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 37,320,20)];
    title.text = L(@"PlayUltrasonic");
    title.textAlignment = NSTextAlignmentCenter;
    title.backgroundColor = [UIColor clearColor];
    title.font = [UIFont boldSystemFontOfSize:17.0];
    title.textColor = [UIColor whiteColor];
    [navigationView addSubview:title];

    [self.view addSubview:navigationView];
    
    UIButton *more = [[UIButton alloc]initWithFrame:CGRectMake(220, 33, 100, 33)];
    more.backgroundColor = [UIColor clearColor];
    more.titleLabel.font = [UIFont systemFontOfSize:15];
    [more setTitleColor:[UIColor colorWithRGBHex:0xfc7c26] forState:UIControlStateNormal];
    [more setTitle:@"活动详情" forState:UIControlStateNormal];
    
    [more addTarget:self action:@selector(activemore) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:more];

    
}

-(void)gotoBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) playSound
{
    AudioServicesPlaySystemSound(shake_sound_male_id);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    if([UserCenter defaultCenter].isLogined == NO){
        self.loginview.hidden = NO;
    }
    else{
        self.loginview.hidden = YES;

    }
    [self refreshnavigation];
    
    [self.dvvoice setmytimernil];
}

-(void)activemore{
    VoiceDetailShareViewController *actweb = [[VoiceDetailShareViewController alloc] init:[SNSwitch soundMonitor] WithShareContentStr:[SNSwitch soundMonitorShareContent]];
//    ActiveRuleViewController *actweb = [[ActiveRuleViewController alloc] init:[SNSwitch soundMonitor]];
    actweb.pageTitle=L(@"Sound-Activation-Detail");
    [self.navigationController pushViewController:actweb animated:NO];
//
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self backView];
    [self.view addSubview:self.ripplesV];
    [self.view addSubview:self.circleview];
    
    //第一次进入的引导页面去掉
//    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
//    NSString *name = [defaults objectForKey:@"isfirstloadplayvoice"];
//    if (!name) {
//        [self.appDelegate.window addSubview:self.backGroundBtn];
//        [defaults setObject:@"0" forKey:@"isfirstloadplayvoice"];
//    }

//    [self.view addSubview:self.circebackview];
    [self.view addSubview:self.circleview];
    [self refreshnavigation];
    [self listenbegin];
    // Do any additional setup after loading the view.
}

-(void)getvoicecode{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"VoiceCodeToStore" ofType:@"plist"];
    self.VoiceCode = [NSDictionary dictionaryWithContentsOfFile:path];
    
}

//返回声波对应门店名称
-(NSString *)storename:(NSString *)voicecd{
    NSDictionary *dic = [self.VoiceCode objectForKey:voicecd];
    if (dic) {
        return nil;
    }
    return [dic objectForKey:@"StoreName"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(DVCircle *)circleview{
    if (!_circleview) {
        _circleview = [[DVCircle alloc] init];
        _circleview.frame = self.circebackview.frame;
        _circleview.owner =self;
        _circleview.backgroundColor = [UIColor clearColor];

    }
    return _circleview;

}


-(RipplesView *)ripplesV{
    if (!_ripplesV) {
        _ripplesV = [[RipplesView alloc] initWithFrame:CGRectMake(0, 100, 320, 400)];
        [self.view addSubview:_ripplesV];
        _ripplesV.innerRadius = 30;
        _ripplesV.speed = 1.5;
        _ripplesV.rippleNumber = 3;
        [_ripplesV startAnimation];
    }
    return _ripplesV;
}

-(UIImageView *)backView{
    if (!_backView) {
        _backView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _backView.image = [UIImage imageNamed:@"sound_bg"];
        [self.view addSubview:_backView];
        
    }
    return _backView;
}

-(UIImageView *)circebackview{
    if (!_circebackview) {
        _circebackview = [[UIImageView alloc] initWithFrame:CGRectMake(-3, 246, 320, 105)];
//        _circebackview.image = [UIImage imageNamed:@"soundsign.png"];
        
    }
    return _circebackview;
}
-(DVVoiceModel *)dvvoice{
    if (!_dvvoice) {
        _dvvoice = [[DVVoiceModel alloc] init];
        _dvvoice.delegate =self;
    }
    return _dvvoice;
}

-(UIView *)loginview{
    if (!_loginview) {
        _loginview = [[UIView alloc] initWithFrame:CGRectMake(0, 80, 320, 40)];
        _loginview.backgroundColor =[UIColor  colorWithRGBHex:0x0d70b1];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
        label.text=L(@"AuAuAuLoginedMoreHappy");
        label.backgroundColor = [UIColor clearColor];
        label.textColor=[UIColor colorWithRGBHex:0xcdebff];
        [_loginview addSubview:label];
        OHAttributedLabel *label2 = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(0, 4, 70, 20)];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:L(@"LoginImmediately")];
        [attStr setTextColor:[UIColor colorWithRGBHex:0xf7b400]];
        [attStr setTextIsUnderlined:YES];
        label2.attributedText = attStr;
        label2.font = [UIFont systemFontOfSize:17];
        [label2 setUserInteractionEnabled:NO];
        [label2 setBackgroundColor:[UIColor clearColor]];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(230, 8, 70, 20)];
        [btn addSubview:label2];
        [btn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [_loginview addSubview:btn];
    }
    return _loginview;
}


-(void)listenbegin{
   
//    if ([UserCenter defaultCenter].isLogined) {
        isgetcode=NO;
        [self.circleview drawLineAnimation];
        [self.dvvoice initwithhomelisen:20];
        if (myTimer) {
            [myTimer invalidate];
            myTimer = nil;
        }
        myTimer = [NSTimer scheduledTimerWithTimeInterval:19.5 target:self selector:@selector(sectimecall) userInfo:nil repeats:NO];
//    }
//    else{
//        [self login];
//    }

//    [self VoiceGetted:@"19"];
}

-(void)sectimecall{
    [self removeOverFlowActivityView];
    
    if (!isgetcode) {
        [self  presentSheet:L(@"DonnotFindMysticalSound")];
            
    }
    [self.circleview resetarclayer];
    
}

-(void)sendChouJiangRequest{
    [self.signservice reqActiveChouJiang:activeTypeId];
}

-(void)needLogin:(NSString *)activetypeid activeid:(NSString *)activeId{
    activeTypeId = [activetypeid copy];
    activeid = activeId;

    if([UserCenter defaultCenter].isLogined){
        [self.signservice reqActiveChouJiang:activeTypeId];
    }
    else{
        
        VoiceSignLoginViewController *voicesignlogin = [[VoiceSignLoginViewController alloc] init];
        voicesignlogin.ower = self;
        [self.navigationController pushViewController:voicesignlogin animated:YES];
    }
}

- (void)VoiceGetted:(NSString *)voicetype{
    [self playSound];
    isgetcode=YES;
    [self displayOverFlowActivityView:L(@"IsLookingForMysticalSound") yOffset: -60];
    voicecod = voicetype;
    
    //242新增跳转四级页面
    if ([SNSwitch isNearbySuningVoiceSignStore]) {
        [self.listService getVoiceCodeActivity:voicetype];
    }
    else{
        //根据声波编码寻找到活动类型
        switch ([voicetype intValue]) {
            case 19:
                [self needLogin:@"e82f605984b14b9bb9065d7f74ec087d" activeid:@"e82f605984b14b9bb9065d7f74ec087d"];   // 2
                break;
            case 20:
                [self needLogin:@"2732a12900944936bbe4ada852f75fd1" activeid:@"2732a12900944936bbe4ada852f75fd1"];  // 3
                break;
            case 21:
                if (_issign) {
                    return;
                }
                [self.signservice reqActiveQuery:@"f48b1f962b9848f6972818f05e165196"];
                activeid=@"f48b1f962b9848f6972818f05e165196";//5
                break;
            default:
                if (_issign) {
                    return;
                }
                [self.signservice reqActiveQuery:@"fbe68e32eed34c5aa8d3a24f57168252"];
                activeid=@"fbe68e32eed34c5aa8d3a24f57168252";// 4
                break;
        }

    }
    //    [self.circleview resetarclayer];

}

-(void)getVoiceCodeActivity:(VoiceActiveDTO *)dto{
    [self removeOverFlowActivityView];
    [self.circleview resetarclayer];
    if (!dto.isActity) {
        [self  presentSheet:L(@"PVActivityEnded")];
        return;
    }
    if (!dto.errmsg && dto.actityType) {
        switch ([dto.actityType intValue]) {
            case 1:       //声波签到
                [self needLogin:dto.activeTypeID activeid:dto.activeTypeID];
                activeid=dto.activeTypeID;
                break;
            case 2:      //摇奖
                [self.signservice reqActiveQuery:dto.activeTypeID];
                activeid=dto.activeTypeID;
                break;
            case 3:{     //四级页面跳转
                [SNRouter handleAdTypeCode:dto.adTypeID adId:dto.adID chanId:nil qiangId:nil
                                onChecking:^(SNRouterObject *obj) {
                                    [self displayOverFlowActivityView];
                                } shouldRoute:^BOOL(SNRouterObject *obj) {
                                    [self removeOverFlowActivityView];
                                    if (obj.errorMsg) {
                                        [self presentSheet:obj.errorMsg];
                                        return NO;
                                    }else{
                                        obj.navController = self.navigationController;
                                        return YES;
                                    }
                                } didRoute:^(SNRouterObject *obj) {
                                    
                                } source:SNRouteSourceSomeCode];
                
                break;
            }
            case 4:
                webview = [[ActiveRuleViewController alloc] init:dto.wapUrl];
                webview.title =@"";
                [self.navigationController pushViewController:webview animated:YES];
                break;
            default:
                break;
            }
        
    }
    else{
        [self  presentSheet:dto.errmsg];
    }
}

- (void)delegate_yaoYiYaoHttpServeResult:(id)object {
    [self removeOverFlowActivityView];
    QHttpObject *obj = object;
    if (nil == obj.errMsg) {
        
        if (obj.cmd == CC_YaoYiYaoActiveQuery) {
            
            QYaoQueryDTO *bean = (QYaoQueryDTO *)obj;
            // 云钻摇易摇
            QYaoYiYaoViewCtrler *ctrler = [[QYaoYiYaoViewCtrler alloc] initXibWithType:1];
            ctrler.activeQueryBean = bean;
            ctrler.activeTypeId = activeid;
            ctrler.ctrlerType   = kQYaoViewCtrlerShengBo;
            [self.navigationController pushViewController:ctrler animated:YES];
        }
        else if (obj.cmd == CC_YaoYiYaoActiveShakeJiang){
            
            QYaoChouJiangDTO *bean = (QYaoChouJiangDTO *)obj;
            VoiceSignViewController *voicesign = [[VoiceSignViewController alloc] initWithdto:[self presevoicedto:bean]];
            [self.navigationController pushViewController:voicesign animated:YES];
        }
    }
    else{
        [self  presentSheet:L(@"DonnotFindMysticalSound")];
        [self.circleview resetarclayer];
    }
}

-(VoiceSignDTO *)presevoicedto:(QYaoChouJiangDTO *)bean{
    VoiceSignDTO *signdto = [[VoiceSignDTO alloc] init];
    signdto.cloudnum = bean.prizeValue;
    signdto.rewardstring = bean.mrakedwords;
    signdto.duihuancode = bean.serialNumber;
    signdto.bannerurl = bean.prizeAdUrl;
    signdto.imgurl =bean.prizePicUrl;
    signdto.shareContent = L(@"OpenPhoneGetGIT");//bean.shareContent;
    signdto.title = bean.activename;
    signdto.prizeTypeName = bean.prizeName;
    if ([bean.resultCode isEqualToString:@"e03"] ||
        [bean.resultCode isEqualToString:@"e04"] ||
        [bean.resultCode isEqualToString:@"e10"]) {         // 已经签到
        signdto.rewardtype = HaveSigned;
        signdto.rewardstring = L(@"OpenPhoneCanGetGIT");
        return signdto;

    }
    else if([bean.resultCode isEqualToString:@""] || IsStrEmpty(bean.resultCode))
    {
        if ([bean.prizeType integerValue]==1) {
            signdto.rewardtype = SignIntegration;
            signdto.rewardstring = L(@"CongratulationGetExclusiveMenmberCloudDiamond");

            return signdto;
            
            
        }
        else if ([bean.prizeType integerValue]==3) {
            signdto.rewardtype = CloudReward;
            signdto.rewardstring = L(@"CongratulationGetSNCloudCoupon");

            
        }
        if (nil != bean.isEntityPrize
            && [bean.isEntityPrize isEqualToString:@"1"])
        {
            signdto.rewardtype = PhysicalReward;
            signdto.rewardstring = L(@"CongratulationGetExchangeCode");
        }
//        }
        return signdto;
    }
    else
    {// 未中奖
        signdto.rewardtype = NoReward;
        signdto.rewardstring = L(@"OpenPhoneCanGetGIT");

        return signdto;
    }
    
    return signdto;
}

-(QYaoHttpService *)signservice{
    if (!_signservice) {
        _signservice = [[QYaoHttpService alloc] init];
        _signservice.httpDelegate =self;
    }
    return _signservice;
}



//- (UIButton *)backGroundBtn
//{
//    if (!_backGroundBtn) {
//        _backGroundBtn = [[UIButton alloc] init];
//        CGRect frame;
//        frame = self.view.bounds;
//        frame.size.height += 64;
//        _backGroundBtn.frame = frame;
//        _backGroundBtn.backgroundColor = [UIColor blackColor];
//        _backGroundBtn.alpha = 0.7;
//        UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 290, 181)];
//        img1.image = [UIImage imageNamed:@"voiceinterduce2.png"];
//        UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(118, frame.size.height-240, 202, 300)];
//        img2.image = [UIImage imageNamed:@"voiceinterduce1.png"];
//        [_backGroundBtn addSubview:img1];
//        [_backGroundBtn addSubview:img2];
//        [_backGroundBtn addTarget:self action:@selector(hidebackview) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _backGroundBtn;
//}

//-(void)hidebackview{
//    [UIView animateWithDuration:0.3 animations:^(void){
//        
//        self.backGroundBtn.hidden = YES;
//        
//    } completion:^(BOOL finished){
//        
//        [self.backGroundBtn removeFromSuperview];
//
//    }];
//}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.circleview resetarclayer];

    
}

- (VoiceCodeActivityService *)listService
{
    if (!_listService) {
        _listService = [[VoiceCodeActivityService alloc]init];
        _listService.voiceActivityDelegate =self;
    }
    return _listService;
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


@end

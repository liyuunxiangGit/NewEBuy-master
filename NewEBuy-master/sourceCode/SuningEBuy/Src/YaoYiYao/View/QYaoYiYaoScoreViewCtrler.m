//
//  QYaoYiYaoScoreViewCtrler.m
//  SuningEBuy
//
//  Created by XZoscar on 14-5-23.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "QYaoYiYaoScoreViewCtrler.h"
#import "QYaoYiYaoViewCtrler.h"
#import "LoginViewController.h"
#import "RegistrationService.h"
#import "UserDiscountService.h"
#import "CardService.h"
#import "QYaoHttpService.h"
#import "SNWebViewController.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>
#import "UIImageView+WebCache.h"


@protocol QYaoYiYaoScoreCellDelegate <NSObject>
@optional
- (void)delegate_YaoYiYaoScoreCell_selected:(QYaoScoreParkItemDTO *)dto;
@end

@interface  QYaoYiYaoScoreBtCell: UITableViewCell
@property (nonatomic,strong) QYaoScoreParkGrpDTO *bean;
@property (nonatomic,weak) id<QYaoYiYaoScoreCellDelegate> delegate;
@end

@implementation QYaoYiYaoScoreBtCell
- (void)dealloc {
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView removeFromSuperview];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)setBean:(QYaoScoreParkGrpDTO *)bean {
    if (_bean != bean) {
        _bean = bean;
        
        //[self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        for (int i = 0;i < _bean.items.count; ++i) {
            
            QYaoScoreParkItemDTO *dto = _bean.items[i];
            EGOImageButton *bt = [[EGOImageButton alloc] initWithFrame:CGRectMake(40.0f+i*64.0f,8.0f,44.0f,44.0f)];
            bt.backgroundColor = [UIColor clearColor];
            bt.imageURL = [NSURL URLWithString:dto.entryPictureUrl];
            [bt addTarget:self action:@selector(on_imagedButton_clicked:) forControlEvents:UIControlEventTouchUpInside];
            bt.tag = i;
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(bt.origin.x-5,
                                                                     bt.origin.y+bt.size.height+2.0f,44.0f+10, 21.0f)];
          
            lbl.adjustsFontSizeToFitWidth = YES;
            lbl.textColor = [UIColor darkTextColor];
            lbl.font = [UIFont systemFontOfSize:14.0f];
            lbl.textAlignment = NSTextAlignmentCenter;
            lbl.backgroundColor = [UIColor clearColor];
            lbl.text = dto.title;
            [self addSubview:lbl];
            [self addSubview:bt];
        }
    }
}

- (void)on_imagedButton_clicked:(EGOImageButton *)sender {
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"51020%d",sender.tag + 1], nil]];
    if (nil != _delegate && [_delegate respondsToSelector:@selector(delegate_YaoYiYaoScoreCell_selected:)]) {
        [_delegate delegate_YaoYiYaoScoreCell_selected:_bean.items[sender.tag]];
    }
}

@end

@interface  QYaoYiYaoScoreCell: UITableViewCell
@property (nonatomic,strong) QYaoScoreParkGrpDTO *bean;
@property (nonatomic,weak) id<QYaoYiYaoScoreCellDelegate> delegate;
@property (nonatomic,assign)int section;
@property (nonatomic,strong) EGOImageButton *picViewButton;
@end

@implementation QYaoYiYaoScoreCell
- (void)dealloc {
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView removeFromSuperview];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGSize f = self.frame.size;
        
        self.picViewButton = [[EGOImageButton alloc] initWithFrame:CGRectMake(.0f,.0f,f.width,f.height)];
        _picViewButton.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
         [_picViewButton addTarget:self action:@selector(on_imagedButton_clicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_picViewButton];
    }
    
    return self;
}

- (void)setBean:(QYaoScoreParkGrpDTO *)bean {
    if (_bean != bean) {
        _bean = bean;
        
        if (_bean.items.count > 0) {
            QYaoScoreParkItemDTO *dto = _bean.items[0];
            _picViewButton.imageURL = [NSURL URLWithString:dto.entryPictureUrl];
        }
    }
}

- (void)on_imagedButton_clicked:(EGOImageButton *)sender {
    
    NSLog(@"%d",self.section);
    int tempIndex = 0;
    if (self.section == 1)
    {
        tempIndex = 3;
    }
    else if (self.section == 2)
    {
        tempIndex = 4;
    }
    else if (self.section == 3)
    {
        tempIndex = 5;
    }
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"510%d01",tempIndex], nil]];
    if (nil != _delegate && [_delegate respondsToSelector:@selector(delegate_YaoYiYaoScoreCell_selected:)]) {
        [_delegate delegate_YaoYiYaoScoreCell_selected:_bean.items[sender.tag]];
    }
}

@end


@interface QYaoYiYaoScoreViewCtrler () <UITableViewDelegate,UITableViewDataSource,
        RegistrationServiceDelegate,UserDiscountServiceDelegate,QYaoHttpServiceDelegate,
cardServiceDelegate,QYaoYiYaoViewCtrlerDelegate,QYaoYiYaoScoreCellDelegate> {
    @private
    BOOL _isLoginOkAutoSign; // 是否是登录成功后自动签到 defaut NO
}

@property (nonatomic,strong) IBOutlet UITableView *tableView0;
@property (nonatomic,strong) IBOutlet UIImageView *portraitView;
@property (nonatomic,strong) IBOutlet UILabel     *myScoreLabel,*nickNameLabel;
@property (nonatomic,strong) IBOutlet UILabel     *qiandaoDescLabel,*qiandaoDescLabel2;
@property (nonatomic,strong) IBOutlet UIButton    *qiandaoButton;
@property (nonatomic,strong) NSArray              *dataArr;

@property (nonatomic,strong) RegistrationService  *registService;
@property (nonatomic,strong) UserDiscountService  *userInfoService;
@property (nonatomic,strong) CardService          *cardInfoService;
@property (nonatomic,strong) QYaoHttpService      *yaoHttpService;

@property (nonatomic, strong) CheckInDTO          *checkInDto;

@end


@implementation QYaoYiYaoScoreViewCtrler

- (void)dealloc {
    _registService.delegate      = nil;
    _userInfoService.delegate    = nil;
    _cardInfoService.delegate    = nil;
    _yaoHttpService.httpDelegate = nil;
}

- (instancetype)init
{
    return [self initWithNibName:@"QYaoYiYaoScoreViewCtrler" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
        self.pageTitle = @"云钻乐园-首页云钻乐园-领云钻";
        if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self setTitle:L(@"MemberWorld")];
   
    self.myScoreLabel.text      = nil;
    [self.qiandaoDescLabel setText:L(@"PhoneSignIn")];
    self.qiandaoDescLabel2.text = nil;
    [self.nickNameLabel setText:L(@"HiWelcomeToSNEbuy")];
    
    // 获取头像、云钻
    [self getUserInformationAndUpdateUI];
    
//    2014/09/01 签到入口 需求要求 去掉
//    if ([UserCenter defaultCenter].isLogined) {
//        // 签到准备，获取连续签到几天
//        [self goToPrepareQianDao];
//    }
    
    // 获取云钻乐园服务items
    [self.yaoHttpService reqGetScoreParkItems];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getUserInformationAndUpdateUI];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(.0f,.0f,tableView.frame.size.width,44.0f)];
    view.backgroundColor = [UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0f];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(9.0f,18.0f,view.frame.size.width-18.0f,22.0f)];
    //label.backgroundColor = [UIColor colorWithRGBHex:0xf2f2f2];
    label.font      = [UIFont systemFontOfSize:14.0f];
    label.textColor =[UIColor dark_Gray_Color];
    label.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    label.backgroundColor = [UIColor clearColor];
    
    QYaoScoreParkGrpDTO *dto = _dataArr[section];
    label.text = dto.title;
    
    [view addSubview:label];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     QYaoScoreParkGrpDTO *dto = _dataArr[indexPath.section];
     if (dto.grpType == 1) { // 一排 最多4个按钮)
         return 88.0f;
     }else {
         return 125.0f;
     }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYaoScoreParkGrpDTO *dto = _dataArr[indexPath.section];
    
    if (dto.grpType == 1) { // 一排 最多4个按钮
        static NSString *identify1 = @"yaoyiyao_score_identify_1";
        QYaoYiYaoScoreBtCell *cell = (QYaoYiYaoScoreBtCell *)[tableView dequeueReusableCellWithIdentifier:identify1];
        if (nil == cell) {
           cell = [[QYaoYiYaoScoreBtCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                      reuseIdentifier:identify1];
          cell.delegate = self;
        }
        
        cell.bean = dto;
        
        return cell;
        
    }else { // 图片
        static NSString *identify2 = @"yaoyiyao_score_identify_2";
        QYaoYiYaoScoreCell *cell = (QYaoYiYaoScoreCell *)[tableView dequeueReusableCellWithIdentifier:identify2];
        if (nil == cell) {
            cell = [[QYaoYiYaoScoreCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                       reuseIdentifier:identify2];
            cell.delegate = self;
        }
        cell.section = indexPath.section;
        cell.bean = dto;
        return cell;
    }
}

- (IBAction)on_qianDaoButon_clicked {
    // 切换到 云宝箱 需要先登录
     [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"510101"], nil]];
    if (![[UserCenter defaultCenter] isLogined]) {
        // 未登录
        LoginViewController *ctrler = [[LoginViewController alloc] init];
        ctrler.loginDelegate            = self;
        ctrler.loginDidOkSelector       = @selector(loginSuccess);
        ctrler.loginDidCancelSelector   = @selector(loginCancel);
        AuthManagerNavViewController *navCtrler = [[AuthManagerNavViewController alloc] initWithRootViewController:ctrler];
        [self presentModalViewController:navCtrler animated:YES];
    }else {
        // 已登录 调用签到接口
        if (nil != _checkInDto) {
            RegistrationDetailBaseDTO *detailBaseDto = [[RegistrationDetailBaseDTO alloc] init];
            detailBaseDto.userId = [UserCenter defaultCenter].userInfoDTO.userId;
            detailBaseDto.checkType = @"0";
            detailBaseDto.distance = @"0";
            detailBaseDto.latitudeAndLongitude = @"0_0";
            detailBaseDto.checkCodeId = self.checkInDto.checkType;
            detailBaseDto.storeId = @"";
            detailBaseDto.custNum = [UserCenter defaultCenter].userInfoDTO.custNum;
            [self.registService beginSendRegistrationDetailRequest:detailBaseDto];
            [self displayOverFlowActivityView];
        }else {
            [self presentSheet:L(@"SignInFailTryLater")];
        }
    }
}

- (void)getUserInformationAndUpdateUI {
    
    if ([UserCenter defaultCenter].isLogined) {
        UserDiscountInfoDTO *accBean = [UserCenter defaultCenter].userDiscountInfoDTO;
        UserInfoDTO         *usrBean = [UserCenter defaultCenter].userInfoDTO;
        
        _nickNameLabel.text = (nil != usrBean.nickName) ? usrBean.nickName : usrBean.userName;
        if (_nickNameLabel.text.length == 0) {
            _nickNameLabel.text = IsStrEmpty(usrBean.logonId)?@"":usrBean.logonId;
        }
        
        // 获取头像
        [self displayOverFlowActivityView];
        [self.cardInfoService beginGetCardInfo:usrBean.custNum WithName:nil];
        
        if (nil != accBean.achievement) {
            _myScoreLabel.text  = [NSString stringWithFormat:@"%@%@",L(@"MyCloudDiamond:"),accBean.achievement];
        }
        
        // 获取云钻
        [self.userInfoService beginGetUserDiscountInfo];
    }
}

- (RegistrationService *)registService
{
    if (nil == _registService) {
        _registService = [[RegistrationService alloc] init];
        _registService.delegate = self;
    }
    return _registService;
}

- (UserDiscountService *)userInfoService {
    if (nil == _userInfoService) {
        _userInfoService = [[UserDiscountService alloc] init];
        _userInfoService.delegate = self;
    }
    
    return _userInfoService;
}

- (CardService *)cardInfoService {
    if (nil == _cardInfoService) {
        _cardInfoService = [[CardService alloc] init];
        _cardInfoService.delegate = self;
    }
    return _cardInfoService;
}

- (QYaoHttpService *)yaoHttpService {
    if (nil == _yaoHttpService) {
        _yaoHttpService = [[QYaoHttpService alloc] init];
        _yaoHttpService.httpDelegate = self;
    }
    
    return _yaoHttpService;
}

// @selector of LoginViewController
// update current view state

- (void)goToPrepareQianDao {
    
    // 登录成功 自动再去签到
    NSString *userId = [UserCenter defaultCenter].userInfoDTO.userId;
    if (nil != userId) {
        _qiandaoButton.userInteractionEnabled = NO;
        [self displayOverFlowActivityView];
        [[self registService] beginSendRegistrationPrepareRequest:userId];
    }
}

- (void)loginSuccess {
    
    // 在viewWillAppear中会调用
    // 登录成功获取个人信息并展现
    
    if (nil != _checkInDto) {
        [self on_qianDaoButon_clicked];
    }else {
        
        if (nil != [UserCenter defaultCenter].userInfoDTO.userId) {
            _isLoginOkAutoSign = YES;
            [self goToPrepareQianDao];
        }
    }
}

- (void)loginCancel {
}

- (void)delegate_YaoYiYaoViewCtrler_loginSuccess {
    [self getUserInformationAndUpdateUI];
}

#pragma mark - RegistrationService Delegate Method

-(void)didSendRegistrationPrepareRequestComplete:(RegistrationService *)service Result:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    _qiandaoButton.userInteractionEnabled = YES;
    if (isSuccess) {
        
        self.checkInDto = service.checkInDto;
        if (_checkInDto.checkCount.intValue > 0) {
             UIColor *color  = [UIColor colorWithRed:252.f/255.0f green:124.0f/255.0f blue:38.0f/255.0f alpha:1.0f];
            _qiandaoDescLabel.attributedText = [self fixedFormartAttributedString:L(@"SignedInContinuous"):_checkInDto.checkCount:L(@"Day"):color];
        }
        
        NSString *score = [_checkInDto pointInDate:[CIDate dateFromNSDate:[NSDate date]]];
        UIColor *color  = [UIColor colorWithRed:1.0f green:178.0f/255.0f blue:47.0f/255.0f alpha:1.0f];
        _qiandaoDescLabel2.attributedText = [self fixedFormartAttributedString:L(@"TodayCanOwn"):score:L(@"CloudDiamond"):color];
        
        if ([service.registPrepareDto.isCheck isEqualToString:@"1"]) {
            // 今天已牵到过
            [_qiandaoButton setTitle:L(@"IHaveSignedIn") forState:UIControlStateNormal];
             _qiandaoButton.userInteractionEnabled = NO;
            CIDate *date = [CIDate dateFromNSDate:[NSDate date]];
            NSString *score = [_checkInDto pointInDate:date.tomorrow];
            _qiandaoDescLabel2.attributedText = [self fixedFormartAttributedString:L(@"TomorrowCanOwn"):score:L(@"CloudDiamond"):color];
            
        }else {
            if (_isLoginOkAutoSign) {
                // 登录成功 自动签到
                [self on_qianDaoButon_clicked];
            }
        }
        
    }else {
        //[self presentSheet:service.errorMsg?service.errorMsg:L(@"SignInFailTryLater")];
    }
}

- (void)didSendRegistrationDetailRequestComplete:(RegistrationService *)service  Result:(BOOL)isSuccess {
    [self removeOverFlowActivityView];
    _qiandaoButton.userInteractionEnabled = YES;
    if (isSuccess && service.errorMsg.length == 0) {
        // 提示签到成功
        [_qiandaoButton setTitle:L(@"IHaveSignedIn") forState:UIControlStateNormal];
        _qiandaoButton.userInteractionEnabled = NO;
        _checkInDto.checkCount = [NSString stringWithFormat:@"%d",_checkInDto.checkCount.integerValue+1];
        if (_checkInDto.checkCount.intValue > 0) {
            UIColor *color  = [UIColor colorWithRed:252.f/255.0f green:124.0f/255.0f blue:38.0f/255.0f alpha:1.0f];
            _qiandaoDescLabel.attributedText = [self fixedFormartAttributedString:L(@"SignedInContinuous"):_checkInDto.checkCount:L(@"Day"):color];
        }
        
        CIDate *date = [CIDate dateFromNSDate:[NSDate date]];
        NSString *score = [_checkInDto pointInDate:date.tomorrow];
        UIColor *color  = [UIColor colorWithRed:1.0f green:178.0f/255.0f blue:47.0f/255.0f alpha:1.0f];
        _qiandaoDescLabel2.attributedText = [self fixedFormartAttributedString:L(@"TomorrowCanOwn"):score:L(@"CloudDiamond"):color];
        
        // {{{ 2014/08/19 2.4.3v 要求将“云钻”文案修改为“云钻”
        RegistrationDetailDTO *detailDto = service.registDetailDto;
        NSString *description = nil;
        if (![detailDto.largessPoints isEqualToString:@"0"]
            && ![detailDto.couponValue isEqualToString:@"0"]) {
            
            description = [NSString stringWithFormat:L(@"CongratulationSignedInSuccessGet%@CloundDiamond%@Coupon"),detailDto.largessPoints,detailDto.couponValue];
        }
        else if ([detailDto.largessPoints isEqualToString:@"0"]
                 && ![detailDto.couponValue isEqualToString:@"0"]) {
            description = [NSString stringWithFormat:L(@"CongratulationSignedInSuccessGet%@Coupon"), detailDto.couponValue];
        }else {
            description = [NSString stringWithFormat:L(@"CongratulationSignedInSuccessGet%@CloundDiamond"),detailDto.largessPoints];
        }
        if (nil != description) {
            [self presentSheet:L(@"Registration Success") subMessage:description posY:160];
        }
        // }}}
        
        // 获取云钻
        [self.userInfoService beginGetUserDiscountInfo];
        
    }else {
        
        if ([service.registDetailDto.errorCode isEqualToString:@"002"]) {
            [_qiandaoButton setTitle:L(@"IHaveSignedIn") forState:UIControlStateNormal];
            CIDate *date = [CIDate dateFromNSDate:[NSDate date]];
            NSString *score = [_checkInDto pointInDate:date.tomorrow];
            UIColor *color  = [UIColor colorWithRed:1.0f green:178.0f/255.0f blue:47.0f/255.0f alpha:1.0f];
            _qiandaoDescLabel2.attributedText = [self fixedFormartAttributedString:L(@"TomorrowCanOwn"):score:L(@"CloudDiamond"):color];
            [self presentSheet:L(@"TodayHaveSignedIn")];
             _qiandaoButton.userInteractionEnabled = NO;
        }else {
            [self presentSheet:service.errorMsg?service.errorMsg:L(@"SignInFailTryLater")];
             _qiandaoButton.userInteractionEnabled = YES;
        }
        
    }
}

- (NSMutableAttributedString *)fixedFormartAttributedString:(NSString *)text1
                                                           :(NSString *)text2
                                                           :(NSString *)text3
                                                           :(UIColor *)color {
    
    if (!text2) {
        text2 = @"";
    }
    if (!text3) {
        text3 = @"";
    }
    
    NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    [ps setLineBreakMode:NSLineBreakByTruncatingTail];
    NSDictionary *attribs1 = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0f],NSParagraphStyleAttributeName:ps,NSForegroundColorAttributeName:[UIColor blackColor]};
    NSDictionary *attribs2 = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0f],NSParagraphStyleAttributeName:ps,NSForegroundColorAttributeName:(nil == color) ? [UIColor darkTextColor] : color};

    NSMutableAttributedString *attributedText1 =[[NSMutableAttributedString alloc] initWithString:text1
                                                                                       attributes:attribs1];
    NSMutableAttributedString *attributedText2 =[[NSMutableAttributedString alloc] initWithString:text2
                                                                                       attributes:attribs2];
    NSMutableAttributedString *attributedText3 =[[NSMutableAttributedString alloc] initWithString:text3
                                                                                       attributes:attribs1];
    [attributedText1 appendAttributedString:attributedText2];
    [attributedText1 appendAttributedString:attributedText3];
    
    return attributedText1;
}

- (void)didGetUserDiscountCompleted:(BOOL)isSuccess
                           errorMsg:(NSString *)errorMsg {
    if (isSuccess) {
         NSString *_achieve =  [UserCenter defaultCenter].userDiscountInfoDTO.achievement;
        if (nil != _achieve) {
            _myScoreLabel.text  = [NSString stringWithFormat:@"%@%@",L(@"MyCloudDiamond:"),_achieve];
        }
    }
    
    [self removeOverFlowActivityView];
}

-(void)getCardInfoCompletedWithResult:(BOOL)isSuccess infoDto:(CardDTO *)dto errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    
    if (isSuccess) {
        NSString *urlStr = [NSString stringWithFormat:@"%@?version=%@",WBHeadUrlString(dto.sysHeadPicFlag, dto.sysHeadPicNum, CGSizeMake(640, 640),dto.custNum),dto.sysHeadPicNum];
        NSURL *url = [NSURL URLWithString:urlStr];
        if ([url.scheme hasPrefix:@"http"]) {
            [self.portraitView sd_setImageWithURL:url
                                 placeholderImage:[UIImage imageNamed:@"New_UserPhoto"] options:SDWebImageRefreshCached];
        }
    }
}

- (void)delegate_yaoYiYaoHttpServeResult:(id)bean {
    
    if ([bean isKindOfClass:[NSMutableArray class]]) {
        self.dataArr = bean;
        [_tableView0 reloadData];
    }else if ([bean isKindOfClass:[QHttpObject class]]) {
        QHttpObject *obj = bean;
        if (obj.errMsg.length > 0) {
            [self presentSheet:obj.errMsg];
        }
    }
}

- (void)delegate_YaoYiYaoScoreCell_selected:(QYaoScoreParkItemDTO *)dto {
    
    if (nil != dto.pageContentUrl) {
        NSURL *url = [NSURL URLWithString:dto.pageContentUrl];
        if ([url.query isEqualToString:@"adTypeCode=399"]) {
            // 云钻摇易摇
            QYaoYiYaoViewCtrler *ctrler = [[QYaoYiYaoViewCtrler alloc] initXibWithType:1];
            ctrler.delegate             = self;
            [self.navigationController pushViewController:ctrler animated:YES];
        }else {
            if (nil != dto.pageContentUrl
                && dto.pageContentUrl.length > 0) {
                SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeYaoYiYao
                                                                         attributes:@{@"url": dto.pageContentUrl}];
                vc.title = dto.title;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
}

@end

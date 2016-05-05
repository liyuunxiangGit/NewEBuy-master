//
//  BoardingPersonDetailViewController.m
//  SuningEBuy
//
//  Created by david on 14-2-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BoardingPersonDetailViewController.h"
#import "ChooseDate.h"
#import "BoardingPersonUtil.h"
#import "RegexKitLite.h"
#import "PlanTicketSwitch.h"
#import "BoardingPersionListViewController.h"
#import "PersonNameRuleViewController.h"


@interface BoardingPersonDetailViewController ()

@property(nonatomic,strong) PlaneSegement   *segment;
@end

@implementation BoardingPersonDetailViewController

- (id)init
{
    self = [super init];
    
    if (self) {
        
        isAdult = YES;
        
        NSArray *tempArray1 = [[NSArray alloc]initWithObjects:L(@"BTIdentityCard"),L(@"005"),L(@"BTMilitaryCredentials"),L(@"BTGoBackHomeCredentials"),L(@"BTHKMacaoPass"),L(@"BTTaiwanCompatriotCredentials"),L(@"Others"), nil];
        self.certiList = tempArray1;
        TT_RELEASE_SAFELY(tempArray1);
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.hasSuspendButton = YES;

    self.segment.frame = CGRectMake(0, 0, 320, 40);
    
    CGRect frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    
    frame.origin.y += 40;
    
    frame.size.height-=40;
    
    self.groupTableView.frame = frame;
    
    [self.view addSubview:self.groupTableView];
    
}

-(void)viewDidUnload{
    
    [super viewDidUnload];
    
    _segment.delegate = nil;
    self.segment = nil;
    
    _groupTableView.dataSource = nil;
    _groupTableView.delegate = nil;
    self.groupTableView = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (_boardingInfoDto == nil) {

        self.title = L(@"BTNewBordingManage");
        _boardingInfoDto = [[BoardingInfoDTO alloc]init];
        _boardingInfoDto.cardType = @"0";   //默认为身份证
        _boardingInfoDto.travellerType = @"1";//默认为成人
        isAdult = YES;
        
    }else{
        
        self.title = L(@"BTModifyBordingManage");
        if ([_boardingInfoDto.travellerType eq:@"2"]) {
            isAdult = NO;
            [self.segment setCheckedIndex:1];
            
        }else{
            isAdult = YES;
            [self.segment setCheckedIndex:0];
        }
    }
    self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_business"),self.title];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.newBoardingService httpMsgRelease];
    self.newBoardingService.delegate = nil;
    self.newBoardingService = nil;
}

#pragma mark -
#pragma mark 顶部的tab切
-(PlaneSegement *)segment{
    if (!_segment) {
        _segment = [[PlaneSegement alloc]initWithLeftItem:L(@"Adult") rightItem:L(@"BTChild")];
        _segment.delegate = self;
        [self.view addSubview:_segment];
    }
    return _segment;
}

-(void)planeSegement:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
        isAdult = YES;
        
        self.boardingInfoDto.travellerType = @"1";

    }else{
        
        isAdult = NO;
        self.boardingInfoDto.travellerType = @"2";
    }
    
    [self.groupTableView reloadData];
}

#pragma mark -
#pragma mark UITableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (isAdult) {
        return 4;
    }else{
        return 4;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    BoardingItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [[BoardingItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.certiList = self.certiList;
        cell.boardingInfoDto = self.boardingInfoDto;
    }
    
    switch (indexPath.row) {
            
        case 0:{
            [cell refreshCell:CellItemName];
            return cell;
        }
        case 1:{
            [cell refreshCell:CellItemCertificateType];
            return cell;
        }
        case 2:{
            [cell refreshCell:CellITemCertificate];
            return cell;
        }
            
        default:{
            [cell refreshCell:CELlItemBirthday];
            return cell;
        }
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 200;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    CGRect frame = CGRectMake(0, 0, 320, 200);
    BoardingFootView *footView = [[BoardingFootView alloc]initWithFrame:frame];
    [footView.submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [footView.helpBtn addTarget:self action:@selector(helpNameRule) forControlEvents:UIControlEventTouchUpInside];
    return footView;

}


#pragma mark -
#pragma mark 点击确定按钮新增或更新用户姓名
-(void)submitAction{
    
    [self resignTextField];
    
    NSString *errorDesc = [self validateAll];
    
    if (!IsNilOrNull(errorDesc)) {
        
        [self presentSheet:L(errorDesc)];
        
        return;
    }
    
    [self sendBoardingManagementHttpReqeust];
}

-(void)resignTextField{
    
    for (int i = 0; i<5; i++) {
        
        NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:i inSection:0];
        BoardingItemCell *cell = (BoardingItemCell *)[self.groupTableView cellForRowAtIndexPath:indexPath];
        if (cell) {
            [cell resignTextField];
        }
    }
}


#pragma mark -
#pragma mark 帮助页面
-(void)helpNameRule{
    
    self.hidesBottomBarWhenPushed = YES;
    
    PersonNameRuleViewController *controller = [[PersonNameRuleViewController alloc] init];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}


#pragma mark - BoardingManagement HttpReqeust Metnods
#pragma mark   新增、修改登机人信息数据请求方法
-(BoardingService *)newBoardingService
{
    if(!_newBoardingService)
    {
        _newBoardingService = [[BoardingService alloc] init];
        _newBoardingService.delegate = self;
    }
    return _newBoardingService;
}


- (void)sendBoardingManagementHttpReqeust
{
    [self displayOverFlowActivityView:L(@"Loading...") maxShowTime:kPlaneTicketTimeOut];
    
    [self.newBoardingService sendBoardingManagementHttpReqeust:self.boardingInfoDto];
    
}

-(void)getNewBoardingService:(BoardingService *)service Result:(BOOL)isSuccess_ errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    if(YES == isSuccess_)
    {
        self.boardingInfoDto.travellerId = service.travellerId;
        isSuccess = service.isSuccess;
        [self backToBoardingListView];
        
    }
    else
    {
        [self presentSheet:L(errorMsg)];
    }
    
}

-(void)backToBoardingListView{
    if (isSuccess) {
        if ([self.delegate conformsToProtocol:@protocol(BoardingPersonDetailViewControllerDelegate)]) {
            if ([self.delegate respondsToSelector:@selector(modifyBoardingPersonInformation:)]) {
                [self.delegate modifyBoardingPersonInformation:self.boardingInfoDto];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        else{
            BoardingPersionListViewController *listCtrl = [[BoardingPersionListViewController alloc]init];
            listCtrl.delegate = nil;
            [self.navigationController pushViewController:listCtrl animated:YES];
            TT_RELEASE_SAFELY(listCtrl);
        }
    }
}


#pragma mark - Validate Methods
#pragma mark   数据有效性验证方法

- (NSString *)validateAll{
    
    //姓名合法性验证
    NSString *errorMsg = nil;
    
    BOOL isNameValidate  = [BoardingPersonUtil validateBoardingName:self.boardingInfoDto.firstName
                                                              error:&errorMsg];
    if (!isNameValidate) {
        return errorMsg;
    }
    
    if (self.boardingInfoDto.idCode.length == 0) {

        return L(@"BTPleaseInputCredentialsNumber");
    }
    
    if (self.boardingInfoDto.idCode.length >= 40) {
        
        return L(@"BTNumberIsTooLong");
        
    }
    
    if ([self.boardingInfoDto.cardType isEqualToString:@"0"])
    {
        NSString *str = @"^[A-Za-z0-9 ]+$";
        
        if(![self.boardingInfoDto.idCode isMatchedByRegex:str])
        {
            return L(@"Please enter right certificateNum");
        }
        
        BOOL isCardValidate = [BoardingPersonUtil validateIdCode:self.boardingInfoDto.idCode
                                                           error:&errorMsg];
        if (!isCardValidate) {
            return errorMsg;
        }
    }
    
    
    /*
     //身份证号码格式验证
     if ([self.boardingInfoDto.cardType isEqualToString:@"0"]) {
     error = [ValidationService valideIdentifyCard:self.boardingInfoDto.idCode];
     if(error.code == kValidationFail){
     NSString *errorDesc = [error.userInfo objectForKey:kValidationErrorDesc_Key];
     NSString *IdentifyErrorDesc = [NSString stringWithFormat:@"Identify_%@",errorDesc];
     return IdentifyErrorDesc;
     }else {
     
     if([self.boardingInfoDto.travellerType isEqualToString:@"1"])//1类型是成人
     {
     NSString *str = self.boardingInfoDto.idCode;
     
     NSString *idCodeBirth = [str substringWithRange:NSMakeRange(6, 8)];//取身份证上的出生日期
     
     NSDate *birthdayDate = [ChooseDate dateFromString:idCodeBirth withFormatString:@"yyyyMMdd"];
     
     NSDate *today = [NSDate date];
     
     NSDate *birthdayAfterTwelve = [self dateafterMonth:birthdayDate andAfterMonth:12*12];
     
     NSDate *birthdayAfterTwo = [self dateafterMonth:birthdayDate andAfterMonth:12*2];
     
     if ([[birthdayDate laterDate:today]isEqualToDate:birthdayDate]) {
     
     return @"idCode_Error_Check";
     }
     if ([[birthdayAfterTwo laterDate:today]isEqualToDate:birthdayAfterTwo]) {
     
     return @"BirthDate_Error_TooSmall";
     }
     if ([[birthdayAfterTwelve laterDate:today]isEqualToDate:birthdayAfterTwelve]) {
     
     return @"idCode_Birth_TooSmall";
     }
     }
     
     if([self.boardingInfoDto.travellerType isEqualToString:@"2"])//2类型是儿童
     {
     NSString *str = self.boardingInfoDto.idCode;
     
     NSString *idCodeBirth = [str substringWithRange:NSMakeRange(6, 8)];//取身份证上的出生日期
     
     NSDate *birthdayDate = [ChooseDate dateFromString:idCodeBirth withFormatString:@"yyyyMMdd"];
     
     NSDate *today = [NSDate date];
     
     NSDate *birthdayAfterTwelve = [self dateafterMonth:birthdayDate andAfterMonth:12*12];
     
     NSDate *birthdayDat = [ChooseDate dateFromString:self.boardingInfoDto.birthday withFormatString:@"yyyy-MM-dd"];
     
     if (![birthdayDate isEqualToDate:birthdayDat]) {
     return @"idCode_Birth_Error";
     }
     
     if ([[birthdayAfterTwelve earlierDate:today]isEqualToDate:birthdayAfterTwelve]) {
     //"BirthDate_Error_TooBig"="年龄大于12岁，请选择成人登机人";
     return @"BirthDate_Error_TooBig";
     }
     
     }
     }
     }else{
     
     //除了身份证件以外的验证：证件号码为空验证:不包含中文的18位以内的数字或者字母组合
     if (self.boardingInfoDto.idCode == nil || [self.boardingInfoDto.idCode isEmptyOrWhitespace]) {
     return @"Identify_Error_Null";
     }else{            NSString *errorDesc = [self validateCerti:self.boardingInfoDto.idCode];
     if (![errorDesc isEqualToString:@""]) {
     return errorDesc;
     }
     }
     }
     
     */
    
    //生日验证，判断是否为空，且判断小孩是否大于12岁或者尚未出生
    if ([self.boardingInfoDto.travellerType isEqualToString:@"2"]) {
        if (self.boardingInfoDto.birthday == nil || [self.boardingInfoDto.birthday isEmptyOrWhitespace]) {
            //"BirthDate_Error_Null"="出生日期不能为空";
            return @"BirthDate_Error_Null";
        }else{
            NSString *errorDesc = [self validateBirthday:self.boardingInfoDto.birthday];
            if (![errorDesc isEqualToString:@""]) {
                return errorDesc;
            }
        }
    }else if ([self.boardingInfoDto.travellerType isEqualToString:@"1"]) {
        if (self.boardingInfoDto.birthday == nil || [self.boardingInfoDto.birthday isEmptyOrWhitespace]) {
            //"BirthDate_Error_Null"="出生日期不能为空";
            return @"BirthDate_Error_Null";
        }else{
            NSString *errorDesc = [self validateAdultBirthday:self.boardingInfoDto.birthday];
            if (![errorDesc isEqualToString:@""]) {
                return errorDesc;
            }
        }
    }else{
        self.boardingInfoDto.birthday = @"";
    }
    
    return nil;
}


/*  验证除身份证外的其他证件号码
 *  return 空    :验证通过，合法
 *  return 原因  :验证失败
 */
- (NSString *)validateCerti:(NSString *)idCode{
    
    if ([idCode length] > 18 || [idCode length] == 0) {
        return @"Identify_Error_Length";
    }else{
        NSString *certiRegex = @"([a-z,A-Z,0-9]{0,})([\\u4e00-\\u9fa5]{1,}([a-z,A-Z,0-9]{0,}))";
        NSPredicate *certiTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", certiRegex];
        if ([certiTest evaluateWithObject:idCode]) {
            return @"Identify_Error_NotValide";
        }else{
            return @"";
        }
    }
}


/*  验证儿童生日是否为12岁以内或者是否已经出生
 *  return 空    :验证通过，合法
 *  return 原因  :验证失败，年龄不属于儿童范畴
 */
-(NSString *) validateBirthday:(NSString *)birthday
{
    if ([birthday length] > 10) {
        birthday = [birthday substringToIndex:10];
    }
    
    NSDate *birthdayDate = [ChooseDate dateFromString:birthday withFormatString:@"yyyy-M-d"];
    
    NSDate *today = [NSDate date];
    
    
    if ([[birthdayDate laterDate:today]isEqualToDate:birthdayDate]) {
        //"BirthDate_Error_TooLittle"="您的宝贝尚未出生";
        return @"BirthDate_Error_TooLittle";
    }
    
    
    
    NSDate *birthdayAfterTwelve = [self dateafterMonth:birthdayDate andAfterMonth:12*12];
    
    if ([[birthdayAfterTwelve earlierDate:today]isEqualToDate:birthdayAfterTwelve]) {
        //"BirthDate_Error_TooBig"="年龄大于12岁，请选择成人登机人";
        return @"BirthDate_Error_TooBig";
    }
    
    NSDate *dengjiDate = [ChooseDate dateFromString:self.dengjiTime withFormatString:@"yyyy-M-d"];
    
    NSDate *birthdayAfterTwoYear = [self dateafterMonth:birthdayDate andAfterMonth:12*2];
    if([[dengjiDate laterDate:birthdayAfterTwoYear] isEqualToDate:birthdayAfterTwoYear])
    {
        return @"BirthDate_Error_TooSmall";
    }
    else
    {
        return @"";
    }
    
}
//成人必须大于12岁
-(NSString *) validateAdultBirthday:(NSString *)birthday
{
    if ([birthday length] > 10) {
        birthday = [birthday substringToIndex:10];
    }
    
    NSDate *birthdayDate = [ChooseDate dateFromString:birthday withFormatString:@"yyyy-M-d"];
    
    NSDate *today = [NSDate date];
    
    NSDate *birthdayAfterTwelve = [self dateafterMonth:birthdayDate andAfterMonth:12*12];
    
    if (![[birthdayAfterTwelve earlierDate:today]isEqualToDate:birthdayAfterTwelve]) {
        //"BirthDate_Error_TooBig"="年龄小于12岁，请选择儿童登机人";
        return @"idCode_Birth_TooSmall";
    }else{
        return @"";
    }
    
}

- (NSDate *)dateafterMonth:(NSDate *)date andAfterMonth:(int)month
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    return dateAfterMonth;
}

@end

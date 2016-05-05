//
//  BoardingPersionListViewController.m
//  SuningEBuy
//
//  Created by lanfeng on 12-5-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BoardingPersionListViewController.h"
#import "ChooseDate.h"
#import "PlanTicketSwitch.h"

#define TABLE_VIEW_TAG 1213

@interface BoardingPersionListViewController(){

    //是否正在删除
    BOOL            isDeleting;
}

@property (nonatomic,strong) NSMutableArray *actionRowList;//与登机人相对应的登机人是否选中的标志，1标识选中，0标识未选中
@property (nonatomic,strong) UIView         *headView;
@property (nonatomic,strong) UIButton       *addBtn;
@property (nonatomic,strong) UIButton       *deleteBtn;
@property (nonatomic,strong) UIView         *footView;
@property (nonatomic,strong) UIButton       *submitBtn;
@property (nonatomic,strong) UIImageView    *lineImage;

-(void)updateTableView;//刷新tableView
-(BOOL)validateChild:(NSString *)birthday;//验证是否为2－12岁儿童
- (NSDate *)dateafterMonth:(NSDate *)date andAfterMonth:(int)month;//从传入日期往后数获取若干个月后日期

- (void)sendBoardingListHttpReqeust;//获取登机人列表
- (void)sendDeleteBoardingHttpReqeust;//删除登机人信息，可批量删除

@end


@implementation BoardingPersionListViewController

@synthesize personList = _personList;
@synthesize actionRowList = _actionRowList;
@synthesize userChoosePersonList = _userChoosePersonList;
@synthesize headView = _headView;
@synthesize addBtn = _addBtn;
@synthesize deleteBtn = _deleteBtn;
@synthesize lineImage = _lineImage;
@synthesize submitBtn = _submitBtn;
@synthesize footView  = _footView;
@synthesize flightInfoDto = _flightInfoDto;
@synthesize delegate;
@synthesize boardingService = _boardingService;
@synthesize isLoaded;

- (id)init {
    self = [super init];
    if (self) {
        self.title = L(@"BoardingPersonList");
        
        self.pageTitle = L(@"virtual_business_flightPersonList");
        
        NSMutableArray *tempArray1 = [[NSMutableArray alloc]init];
        self.personList = tempArray1;
        TT_RELEASE_SAFELY(tempArray1);
        
        NSMutableArray *tempArray2 = [[NSMutableArray alloc]init];
        self.actionRowList = tempArray2;
        TT_RELEASE_SAFELY(tempArray2);
        
        NSMutableArray *tempArray3 = [[NSMutableArray alloc]init];
        self.userChoosePersonList = tempArray3;
        TT_RELEASE_SAFELY(tempArray3);
        
        isLoaded = NO;
        
        isDeleting = NO;

    }
    return self;
}

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_personList);
    TT_RELEASE_SAFELY(_headView);
    TT_RELEASE_SAFELY(_footView);
    TT_RELEASE_SAFELY(_addBtn);
    TT_RELEASE_SAFELY(_deleteBtn);
    TT_RELEASE_SAFELY(_submitBtn);
    TT_RELEASE_SAFELY(_lineImage);
    TT_RELEASE_SAFELY(_actionRowList);
    TT_RELEASE_SAFELY(_userChoosePersonList);
    TT_RELEASE_SAFELY(_flightInfoDto);
    SERVICE_RELEASE_SAFELY(_boardingService);
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
       
    if (isLoaded == NO) 
    {
        if (self.boardingService.isLoading == NO) {
            [self sendBoardingListHttpReqeust];
        }
        
    }else{
        
        [self updateTableView];
    }
}

-(void)loadView{
    
    [super loadView];

    self.hasSuspendButton = YES;

    CGRect  frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    
    frame.origin.y +=self.headView.height;
    
    frame.size.height-=self.headView.height;
    
	self.tpTableView.frame = frame;
    
	[self.view addSubview:self.tpTableView];
    
    [self.view addSubview:self.headView];

}

#pragma mark - tableView Delegate
- (void)updateTableView{

    [self.tpTableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        
    return [self.personList count];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    static NSString *personInfoCell = @"personInfoCell";
    
    BoardingPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:personInfoCell];
    
    if (cell == nil)
    {
        cell = [[BoardingPersonCell alloc] initWithReuseIdentifier:@"personInfoCell"];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSString *tag = nil;
    if (!IsNilOrNull(self.actionRowList)&&[self.actionRowList count]>=indexPath.row+1) {
        tag = [self.actionRowList objectAtIndex:indexPath.row];
    }else{
        tag = @"0";
    }
            
    [cell setItem:[self.personList objectAtIndex:indexPath.row] andSelected:tag];
    cell.tag = TABLE_VIEW_TAG + indexPath.row;
    cell.boardingPersionCellDelegate = self;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    BoardingPersonDetailViewController *detailCtrl = [[BoardingPersonDetailViewController alloc]init];
    detailCtrl.dengjiTime = self.flightInfoDto.fDate;
    detailCtrl.boardingInfoDto = [self.personList objectAtIndex:indexPath.row];
    detailCtrl.delegate = self;
    [self.navigationController pushViewController:detailCtrl animated:YES];
    TT_RELEASE_SAFELY(detailCtrl);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return self.footView.height;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return self.footView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (IOS7_OR_LATER) {
        return 0.1;
    }else{
        return 0;
    }
}

#pragma mark - action

-(void)addPerson:(id)sender{
    
    if ([self.personList count] == 9) {
        
        [self presentSheet:L(@"Please delete some boarding person information")];        
        return;
    }
    
    BoardingPersonDetailViewController *ctrl = [[BoardingPersonDetailViewController alloc]init];
    ctrl.dengjiTime = self.flightInfoDto.fDate;
    ctrl.delegate = self;
    [self.navigationController pushViewController:ctrl animated:YES];
    TT_RELEASE_SAFELY(ctrl);
}


-(void)deletePersons:(id)sender{
    
    if (!isDeleting) 
    {
        [self sendDeleteBoardingHttpReqeust];

    }
}

-(void)submit:(id)sender{
    
    [self.userChoosePersonList removeAllObjects];//在本次用户选择之前，先清除list
    
    for (int i = 0; i < [self.actionRowList count]; i++) {
        NSString *isSelected = [self.actionRowList objectAtIndex:i];
        if ([isSelected isEqualToString:@"1"]) {
            [self.userChoosePersonList addObject:[self.personList objectAtIndex:i]];
        }
    }
    //用户未选择任何登机人就点击确定，提示用户选择
    if ([self.userChoosePersonList count] == 0) {
        [self presentCustomDlg:L(@"Please Choose Boarding Person")];
        return;
    }else{
        int adultNo = 0;
        int childNo = 0;
        for (int i = 0; i < [self.userChoosePersonList count]; i++) {
            if ([[self.userChoosePersonList objectAtIndex:i]isKindOfClass:[BoardingInfoDTO class]]) {
                BoardingInfoDTO *tempDto = [self.userChoosePersonList objectAtIndex:i];
                if ([tempDto.travellerType isEqualToString:@"1"]) {
                    adultNo++;
                }else{
                    //判断小孩是否为2－12岁的儿童
                    if ([self validateChild:tempDto.birthday]) {
                        childNo++;
                    }else{
                       //"Children_Error_Age"= "儿童必须在2－12岁之间";
                        [self presentSheet:L(@"Children_Error_Age")];
                        return;
                    }
                }
            }
        }  
        
        if (adultNo == 0 && childNo > 0) {
            [self presentSheet:L(@"BTMakeSureOneAdult")];
            return;
        }
    
        if (adultNo*2 < childNo) {
            [self presentSheet:L(@"One adult only could take two Children")];
            return;
        }
    }
    
    //以下代码是将登机人信息添加到订单中
    if ([delegate conformsToProtocol:@protocol(BoardingPersionListViewControllerDelegate)]) {
        if ([delegate respondsToSelector:@selector(returnUserChoosePersonList:)]) {
            [delegate returnUserChoosePersonList:self.userChoosePersonList];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}


-(BOOL)validateChild:(NSString *)birthday{
    
    if (self.flightInfoDto.fDate != nil) {
        
        NSString *formatString = @"yyyy-M-d";
        
        NSDate *fdate = [ChooseDate dateFromString:self.flightInfoDto.fDate withFormatString:formatString];
        
        if ([birthday length]>10) {
            birthday = [birthday substringToIndex:10];//仅仅取年月日
        }
        
        NSDate *nsBirthday = [ChooseDate dateFromString:birthday withFormatString:formatString];
        
        
        if ([[fdate laterDate:nsBirthday] isEqualToDate:fdate]) {
            
            NSDate *dateAfterTwoYear = [self dateafterMonth:nsBirthday andAfterMonth:12*2];
            
            NSDate *dateAfterTwelveYear = [self dateafterMonth:nsBirthday andAfterMonth:12*12];
            
            if ([[dateAfterTwoYear laterDate:fdate]isEqualToDate:dateAfterTwoYear]) {
//                [self.alertView alertMessage:@"登机人不满2岁" posY:100.0];
                return NO;
            }
            
            if ([[dateAfterTwelveYear earlierDate:fdate]isEqualToDate:dateAfterTwelveYear]) {
//                [self.alertView alertMessage:@"登机人超过12岁" posY:100.0];
                return NO;
            }

            
        }else{
//            [self.alertView alertMessage:@"您的baby尚未出生" posY:100.0];
            return NO;
        }
       
    }

    return YES;
}


- (NSDate *)dateafterMonth:(NSDate *)date andAfterMonth:(int)month
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    return dateAfterMonth;
}

#pragma mark - BoardingPersionCellDelegate delegate
-(void)isSelected:(BOOL)isSelectd andTag:(int)tag{
    
    DLog(@"%d", isSelectd);
    DLog(@"%d", tag);
    NSUInteger index = tag - TABLE_VIEW_TAG;
    if (isSelectd) {
        [self.actionRowList replaceObjectAtIndex:index withObject:@"1"];
    }else{
        [self.actionRowList replaceObjectAtIndex:index withObject:@"0"];
    }
    
}

#pragma mark - BoardingPersonDetailViewControllerDelegate
-(void)addBoardingPersonInformation:(BoardingInfoDTO *)dto{
    
    if (dto == nil) {
        return;
    }
    
    [self.personList insertObject:dto atIndex:0];
        
    isLoaded = YES;
    
    [self.actionRowList insertObject:@"0" atIndex:0];
    
    [self.tpTableView reloadData];
}

-(void)modifyBoardingPersonInformation:(BoardingInfoDTO *)dto{
    
    isLoaded = NO;
    [self sendBoardingListHttpReqeust];
    
}

#pragma mark - sendBoardingList HttpRequest Methods
#pragma mark   获取登机人信息列表的数据请求方法
- (void)sendBoardingListHttpReqeust
{
    
    [self displayOverFlowActivityView:L(@"Loading...") maxShowTime:kPlaneTicketTimeOut];
    
    [self.boardingService sendBoardingListHttpReqeust];
               
}
 
-(void)getBoardingListService:(BoardingService *)service Result:(BOOL)isSuccess_ errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    
    if(YES == isSuccess_)
    {        
        [self.personList removeAllObjects];
        [self.personList addObjectsFromArray:service.personList];
        [self filterSelectedBoarding:self.personList];     
        isLoaded  = YES;
    }
    else
    {
        isLoaded = NO;
        [self presentSheet:L(errorMsg)];  
    }

}

-(void)filterSelectedBoarding:(NSMutableArray *)boardingList
{
    [self.actionRowList removeAllObjects];
    //从上一页面传过来用户选择过的登机人列表，进入列表页面默认选中
    for(BoardingInfoDTO *dto in boardingList)
    {
        if ([self.userChoosePersonList count] > 0) {
            BOOL tag = NO;
            for (int i = 0; i < [self.userChoosePersonList count]; i++) {
                BoardingInfoDTO *tempDto = [self.userChoosePersonList objectAtIndex:i];
                NSString *str1 = [NSString stringWithFormat:@"%@",dto.travellerId];
                NSString *str2 = [NSString stringWithFormat:@"%@",tempDto.travellerId];
                
                if ([str1 isEqualToString:str2]) {
                    tag = YES;
                    break;
                }else{
                    tag = NO;
                }
            }
            if (tag) {
                [self.actionRowList addObject:@"1"];
            }else{
                [self.actionRowList addObject:@"0"];
            }
        }else{
            [self.actionRowList addObject:@"0"];
        }        
    }
    [self updateTableView];
    return;
}
#pragma mark - sendDeleteBoarding HttpRequest Methods
#pragma mark   删除登机人信息列表的数据请求方法
- (void)sendDeleteBoardingHttpReqeust
{
    isDeleting = YES;
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    NSString *userId =[UserCenter defaultCenter].userInfoDTO.userId;
    
    int j = 0;//保证travellerId从travellerId0 - travellerId8
    [self.userChoosePersonList removeAllObjects];
    for (int i = 0; i < [self.actionRowList count]; i++) {
        NSString *isSelected = [self.actionRowList objectAtIndex:i];
        if ([isSelected isEqualToString:@"1"]) {
            BoardingInfoDTO *dto = [self.personList objectAtIndex:i];
            NSString *postDateStr = dto.travellerId;
            NSString *travellerIds = [NSString stringWithFormat:@"travellerId%d",j++];
            [postDataDic setObject:postDateStr forKey:travellerIds];
            [self.userChoosePersonList addObject:dto];
        }
    }
    NSString *travellerNumStr = @"";
//    int  travellerNum = [self.userChoosePersonList count];
//    travellerNumStr = [NSString stringWithFormat:@"%d",travellerNum];
    
    //用户未选择任何登机人就点击删除，提示用户选择
    if ([self.userChoosePersonList count] == 0) {
        [self presentCustomDlg:L(@"Please Choose Boarding Person")]; 
        isDeleting = NO;
        TT_RELEASE_SAFELY(postDataDic);
        return;
    }else{
        int  travellerNum = [self.userChoosePersonList count];
        travellerNumStr = [NSString stringWithFormat:@"%d",travellerNum];
    }
    
    
    [postDataDic setObject:userId forKey:@"userId"];
    [postDataDic setObject:travellerNumStr forKey:@"travellerNum"];
    

    [self displayOverFlowActivityView:L(@"Loading...") maxShowTime:kPlaneTicketTimeOut];
    
    [self.boardingService sendDeleteBoardingHttpReqeust:postDataDic];
    
    TT_RELEASE_SAFELY(postDataDic);    
    
}

-(void)getDeleteBoardingService:(BoardingService *)service Result:(BOOL)isSuccess_ errorMsg:(NSString *)errorMsg
{
    isDeleting = NO;
    [self removeOverFlowActivityView];
    if(YES == isSuccess_)
    {      
        NSDictionary *item = service.deleteDic;
        
        DLog(@"BoardingPersionListViewController request back is :%@", [item description]);
        
        if (item) {
            if ([[item objectForKey:@"opResult"] isEqualToString:@"0"]) 
            {                            
                for (int i = 0; i<[self.userChoosePersonList count]; i++) {
                    BoardingInfoDTO *tempDto1 = [self.userChoosePersonList objectAtIndex:i];
                    for (int j = 0; j <[self.personList count]; j++) {
                        BoardingInfoDTO *tempDto2 = [self.personList objectAtIndex:j];
                        if (tempDto1 == tempDto2) {
                            [self.personList removeObjectAtIndex:j];
                            [self.actionRowList removeObjectAtIndex:j];
                            j--;
                        }
                    }
                    [self.userChoosePersonList removeObjectAtIndex:i];
                    i--;
                }
                
                //以下代码删除后的信息告知订单界面，同步更新登机人
                if ([delegate conformsToProtocol:@protocol(BoardingPersionListViewControllerDelegate)]) {
                    if ([delegate respondsToSelector:@selector(returnUserChoosePersonList:)]) {
                        [delegate returnUserChoosePersonList:self.userChoosePersonList];
                    }
                }
            }
        }
        
        BBAlertView *alertView = [[BBAlertView alloc] 
                                  initWithTitle:nil
                                  message:L(@"BTDeletePassengeSuccess")
                                  delegate:self
                                  cancelButtonTitle:L(@"Ok")
                                  otherButtonTitles:nil];
        [alertView show];
        
    }
    else
    {
    
        [self presentSheet:L(errorMsg)];
    }
    
    [self updateTableView];
}


- (void)goToAddPersonPage
{
    BoardingPersonDetailViewController *ctrl = [[BoardingPersonDetailViewController alloc] init];
    ctrl.dengjiTime = self.flightInfoDto.fDate;
    ctrl.delegate = self;
        
    [self.navigationController pushViewController:ctrl animated:YES];
    
    TT_RELEASE_SAFELY(ctrl);
}



#pragma mark - UIView

-(UIView *)headView{
    if (_headView == nil) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
        _headView.backgroundColor = [UIColor clearColor];
        [_headView addSubview:self.addBtn];
        [_headView addSubview:self.deleteBtn];
//        [_headView addSubview:self.lineImage];
    }
    return _headView;
}

-(UIButton *)addBtn{
    if (_addBtn == nil) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.frame = CGRectMake(10, 10, 40, 30);
        [_addBtn setTitleColor:[UIColor orange_Red_Color] forState:UIControlStateNormal];
        [_addBtn setTitle:L(@"AddPersonInfoBtn") forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addPerson:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

-(UIButton *)deleteBtn{
    if (_deleteBtn == nil) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake(270, 10, 40, 30);
        [_deleteBtn setTitleColor:[UIColor orange_Red_Color] forState:UIControlStateNormal];
        [_deleteBtn setTitle:L(@"DeletePersonInfoBtn") forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deletePersons:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

-(UIImageView *)lineImage{
    
    if (!_lineImage) {
        _lineImage = [[UIImageView alloc]init];
        _lineImage.frame = CGRectMake(0, 49, 320, 1);
        UIImage *image = [UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
        _lineImage.image = image;
    }
    return _lineImage;
}


-(UIView *)footView{
    if (_footView == nil) {
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
        _footView.backgroundColor = [UIColor clearColor];
        [_footView addSubview:self.submitBtn];
    }
    return _footView;
    
}
-(UIButton *)submitBtn{
    
    if (_submitBtn == nil) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.frame = CGRectMake(20, 20, 280, 36);
        [_submitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setTitle:L(@"SubmitPersonListBtn") forState:UIControlStateNormal];
        
        UIImage *image = [UIImage imageNamed:@"submit_button_normal.png"];
        [_submitBtn setBackgroundImage:image forState:UIControlStateNormal];
        
        UIImage *image1 = [UIImage imageNamed:@"submit_button_touched.png"];
        [_submitBtn setBackgroundImage:image1 forState:UIControlStateHighlighted];
    
    }
    return _submitBtn;
}



-(BoardingService *)boardingService
{
    if(!_boardingService)
    {
        _boardingService = [[BoardingService alloc] init];
        _boardingService.delegate = self;
    }
    return _boardingService;
}


@end

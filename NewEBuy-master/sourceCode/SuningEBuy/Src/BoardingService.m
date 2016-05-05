//
//  BoardingService.m
//  SuningEBuy
//
//  Created by admin on 12-9-27.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "BoardingService.h"
#import "PlanTicketSwitch.h"

@interface BoardingService ()

- (void)parseBoardingPersonList:(NSDictionary *)items;
- (void)parseBoardingPersonInfo:(NSDictionary *)items;

-(void)getNewBoardingFinish:(BOOL)isSuccess;
-(void)getBoardingListFinish:(BOOL)isSuccess;
-(void)getDeleteBoardingFinish:(BOOL)isSuccess;

@end

@implementation BoardingService

@synthesize delegate = _delegate;
@synthesize travellerId = _travellerId;
@synthesize isSuccess = _isSuccess;

@synthesize personList = _personList;
@synthesize isLoading = _isLoading;

@synthesize  deleteDic = _deleteDic;

-(void)dealloc
{
    _delegate = nil;
    TT_RELEASE_SAFELY(_travellerId);
    TT_RELEASE_SAFELY(_personList);
    TT_RELEASE_SAFELY(_deleteDic);
}

- (id)init {
    self = [super init];
    if (self) {
        _deleteDic = [[NSDictionary alloc] init];
    }
    return self;
}
- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(newBoardingMsg);
    HTTPMSG_RELEASE_SAFELY(boardingListMsg);
    HTTPMSG_RELEASE_SAFELY(deleteBoardingMsg);
}

-(NSMutableArray *)personList
{
    if(nil == _personList)
    {
        _personList = [[NSMutableArray alloc] init];
    }
    return _personList;
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{    
    
    NSDictionary *items = receiveMsg.jasonItems;
        
    switch (receiveMsg.cmdCode) {
        case CC_NewBoarding:
        {
            if (!items)
            {
                self.errorMsg = L(@"load_failed");
                [self getNewBoardingFinish:NO];                
                return;
            }
            else
            {
                [self parseBoardingPersonInfo:items];
            }
        }
            break;
        case CC_BoardingList:
        {
            if (!items)
            {
                self.errorMsg = L(@"load_failed");
                
                [self getBoardingListFinish:NO];
                
                return;
            }
            else
            {
                [self parseBoardingPersonList:items];
            }
        }
            break;    
            
        case CC_DeleteBoarding:
        {
            if (!items)
            {
                self.errorMsg = L(@"load_failed");
                
                [self getDeleteBoardingFinish:NO];                
                return;
            }
            else
            {
                self.deleteDic = items;
                [self getDeleteBoardingFinish:YES];
 
            }
        }
            break;  
        default:
            break;
    }
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    DLog("requestLotteryHallFail == \n%@", receiveMsg.errorCode);    
    
    switch (receiveMsg.cmdCode) {
        case CC_NewBoarding:
        {
            [self getNewBoardingFinish:NO];
           
        }
              break;  
        case CC_BoardingList:
        {
            [self getBoardingListFinish:NO];
        }
            break;
        case CC_DeleteBoarding:
        {
            [self getDeleteBoardingFinish:NO];
        }
            break;
        default:
            break;
    }
}

#pragma mark -登记人添加，修改
- (void)sendBoardingManagementHttpReqeust:(BoardingInfoDTO *)boardingInfoDto
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];    
    
    NSString *userId =[UserCenter defaultCenter].userInfoDTO.userId;
    
    NSString *birthday = boardingInfoDto.birthday == nil?@"":boardingInfoDto.birthday;
    NSString *travellerId = boardingInfoDto.travellerId == nil?@"":boardingInfoDto.travellerId;
    NSString *cardType = boardingInfoDto.cardType == nil?@"":boardingInfoDto.cardType;
    NSString *idCode = boardingInfoDto.idCode == nil?@"":boardingInfoDto.idCode;
    NSString *travellerType = boardingInfoDto.travellerType == nil?@"":boardingInfoDto.travellerType;
    NSString *firstName = boardingInfoDto.firstName == nil?@"":boardingInfoDto.firstName;
    
    [postDataDic setObject:userId forKey:@"userId"];
    [postDataDic setObject:travellerId forKey:@"travellerId"];
    [postDataDic setObject:travellerType forKey:@"travellerType"];
    [postDataDic setObject:firstName forKey:@"firstName"];
    [postDataDic setObject:cardType forKey:@"cardType"];
    [postDataDic setObject:idCode forKey:@"idCode"];
    [postDataDic setObject:birthday forKey:@"birthday"];
    
    HTTPMSG_RELEASE_SAFELY(newBoardingMsg); 
    
    NSString *url = nil;
    if ([PlanTicketSwitch canUserNewServer]) {
        url = [NSString stringWithFormat:@"%@/%@",
               kHostPlaneTicketOctForHttp,KPlaneTicketModifyTraveller];
    }else{
        url = [NSString stringWithFormat:@"%@/%@",
               kHostPlaneTicketForHttp,KPlaneTicketModifyTraveller];
    }
    
    if ([PlanTicketSwitch isEncodeParam]) {
        NSString *str = [url queryStringNoEncodeFromDictionary:postDataDic];
        NSString *encodeStr = [PasswdUtil encryptString:str
                                                 forKey:kPlaneTicketParamEncodeKey
                                                   salt:kPlaneTicketParamEncodeSalt];
        NSDictionary *dic = [NSDictionary dictionaryWithObject:encodeStr forKey:@"data"];
        
        newBoardingMsg = [[HttpMessage alloc] initWithDelegate:self
                                                    requestUrl:url
                                                   postDataDic:dic
                                                       cmdCode:CC_NewBoarding];
    }else{
        newBoardingMsg = [[HttpMessage alloc] initWithDelegate:self
                                                    requestUrl:url
                                                   postDataDic:postDataDic
                                                       cmdCode:CC_NewBoarding];
    }
    
    newBoardingMsg.timeout = kPlaneTicketTimeOut;
    
    [self.httpMsgCtrl sendHttpMsg:newBoardingMsg];   
    
    TT_RELEASE_SAFELY(postDataDic);
    
}

- (void)parseBoardingPersonInfo:(NSDictionary *)items
{
    if ([[items objectForKey:@"opResult"] isEqualToString:@"0"])
    {
        NSString *travellerId = [items objectForKey:@"travellerId"];
        
        self.travellerId = travellerId;
        
        self.isSuccess = YES;
        
        [self getNewBoardingFinish:YES];
        
    }
    else
    {
        self.isSuccess = NO;
        
        NSString *errorMsg = [items objectForKey:@"errorMsg"];
        
        if (IsStrEmpty(errorMsg)) {
            errorMsg = @"BordingManage_Faild";
        }
        
        self.errorMsg = errorMsg;
        
        [self getNewBoardingFinish:NO];
        
    }
}


-(void)getNewBoardingFinish:(BOOL)isSuccess
{
    if(_delegate && [_delegate respondsToSelector:@selector(getNewBoardingService:Result:errorMsg:)])
    {
        [_delegate getNewBoardingService:self Result:isSuccess errorMsg:self.errorMsg];
    }
}

#pragma mark - 登机人列表请求
- (void)sendBoardingListHttpReqeust
{
    self.isLoading = YES;
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    NSString *userId = [UserCenter defaultCenter].userInfoDTO.userId ;
    
    [postDataDic setObject:userId?userId:@"" forKey:@"userId"];
    
    NSString *url = nil;
    if ([PlanTicketSwitch canUserNewServer]) {
        url = [NSString stringWithFormat:@"%@/%@",
               kHostPlaneTicketOctForHttp,KPlaneTicketViewTraveller];
    }else{
        url = [NSString stringWithFormat:@"%@/%@",
               kHostPlaneTicketForHttp,KPlaneTicketViewTraveller];
    }
           
    HTTPMSG_RELEASE_SAFELY(boardingListMsg);
    if ([PlanTicketSwitch isEncodeParam]) {
        NSString *str = [url queryStringNoEncodeFromDictionary:postDataDic];
        NSString *encodeStr = [PasswdUtil encryptString:str
                                                 forKey:kPlaneTicketParamEncodeKey
                                                   salt:kPlaneTicketParamEncodeSalt];
        NSDictionary *dic = [NSDictionary dictionaryWithObject:encodeStr forKey:@"data"];
        
        boardingListMsg = [[HttpMessage alloc] initWithDelegate:self
                                                     requestUrl:url
                                                    postDataDic:dic
                                                        cmdCode:CC_BoardingList];
    }else{
        boardingListMsg = [[HttpMessage alloc] initWithDelegate:self
                                                     requestUrl:url
                                                    postDataDic:postDataDic
                                                        cmdCode:CC_BoardingList];
    }
    boardingListMsg.timeout = kPlaneTicketTimeOut;
    [self.httpMsgCtrl sendHttpMsg:boardingListMsg];
    
    TT_RELEASE_SAFELY(postDataDic);   

}

- (void)parseBoardingPersonList:(NSDictionary *)items
{       
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{   
        @autoreleasepool {
            if (!IsNilOrNull([items objectForKey:@"travellerInfo"])) {
                
                NSMutableArray *tempArray = [items objectForKey:@"travellerInfo"];
                
                if (!IsNilOrNull(tempArray)) {
                    
                    if ([tempArray count] > 0) {
                        
                        [self.personList removeAllObjects];
                        
                        for (int i=0 ; i<[tempArray count]; i++) {
                            
                            NSDictionary *tempDic = [tempArray objectAtIndex:i];
                            
                            if (!IsNilOrNull(tempDic)) {
                                
                                BoardingInfoDTO *dto = [[BoardingInfoDTO alloc]init];
                                
                                [dto encodeFromDictionary:tempDic];
                                
                                [self.personList addObject:dto];
                                
                                TT_RELEASE_SAFELY(dto);
                            }
                        }
                        
                    }
                }
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self getBoardingListFinish:YES];
        });     
    }); 
}


-(void)getBoardingListFinish:(BOOL)isSuccess
{
    if(_delegate && [_delegate respondsToSelector:@selector(getBoardingListService:Result:errorMsg:)])
    {
        [_delegate getBoardingListService:self Result:isSuccess errorMsg:self.errorMsg];
    }
    self.isLoading = NO;
}

#pragma mark -删除登机人
- (void)sendDeleteBoardingHttpReqeust:(NSMutableDictionary *)postDataDic
{
   
    NSString *url = nil;
    if ([PlanTicketSwitch canUserNewServer]) {
        url = [NSString stringWithFormat:@"%@/%@",
               kHostPlaneTicketOctForHttp,KPlaneTicketDeleteTraveller];
    }else{
        url = [NSString stringWithFormat:@"%@/%@",
               kHostPlaneTicketForHttp,KPlaneTicketDeleteTraveller];
    }
        
    HTTPMSG_RELEASE_SAFELY(deleteBoardingMsg);
    
    if ([PlanTicketSwitch isEncodeParam]) {
        NSString *str = [url queryStringNoEncodeFromDictionary:postDataDic];
        NSString *encodeStr = [PasswdUtil encryptString:str
                                                 forKey:kPlaneTicketParamEncodeKey
                                                   salt:kPlaneTicketParamEncodeSalt];
        NSDictionary *dic = [NSDictionary dictionaryWithObject:encodeStr forKey:@"data"];
        
        deleteBoardingMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:dic cmdCode:CC_DeleteBoarding];
    }else{
        deleteBoardingMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_DeleteBoarding];
    }
    
    deleteBoardingMsg.timeout = kPlaneTicketTimeOut;
    
    [self.httpMsgCtrl sendHttpMsg:deleteBoardingMsg];  
   
}

-(void)getDeleteBoardingFinish:(BOOL)isSuccess
{
    if(_delegate && [_delegate respondsToSelector:@selector(getDeleteBoardingService:Result:errorMsg:)])
    {
        [_delegate getDeleteBoardingService:self Result:isSuccess errorMsg:self.errorMsg];
    }
}


@end

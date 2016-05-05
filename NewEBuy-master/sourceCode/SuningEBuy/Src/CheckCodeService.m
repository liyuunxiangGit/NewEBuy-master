//
//  CheckCodeService.m
//  SuningEBuy
//
//  Created by shasha on 12-9-3.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "CheckCodeService.h"

static Calculagraph *eppActiveCodeCalculagraph = nil;

/*********************************************************************/


@interface CheckCodeService()

{
    CheckCodeState      _checkCodeState;
}

- (void)didGetCheckCodeFinished:(BOOL)isSuccess;

@end

@implementation CheckCodeService
@synthesize delegate = _delegate;
@synthesize userCal = _userCal;
@synthesize limitTime = _limitTime;

+ (void)initialize
{
    eppActiveCodeCalculagraph = [[Calculagraph alloc] init];
    eppActiveCodeCalculagraph.timeOut = 60.0f;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(stopCalculagraph)
                                                 name:LOGOUT_OK_NOTIFICATION
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(stopCalculagraph)
                                                 name:LOGIN_OK_MESSAGE
                                               object:nil];
}

+ (void)stopCalculagraph
{
    if (eppActiveCodeCalculagraph.isValidate)
    {
        [eppActiveCodeCalculagraph stop];
    }
}


- (void)stopCalculagraph
{
    if (eppActiveCodeCalculagraph.isValidate)
    {
        [eppActiveCodeCalculagraph stop];
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        [eppActiveCodeCalculagraph addObserver:self
                                    forKeyPath:@"time"
                                       options:NSKeyValueObservingOptionNew
                                       context:NULL];
    }
    return self;
}

- (void)dealloc
{
    [eppActiveCodeCalculagraph removeObserver:self forKeyPath:@"time"];
}

- (BOOL)available
{
    return !eppActiveCodeCalculagraph.isValidate;
}

- (void)httpMsgRelease{
    
    HTTPMSG_RELEASE_SAFELY(checkCodeHttpMsg);
    
}
- (void)didGetCheckCodeFinished:(BOOL)isSuccess
{
    if ([self.delegate respondsToSelector:@selector(didGetCheckCodeComplete:errorDesc:)])
    {
        [self.delegate didGetCheckCodeComplete:isSuccess errorDesc:self.errorMsg];
    }
}


- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    
    [super receiveDidFailed:receiveMsg];
    
    [self didGetCheckCodeFinished:NO];
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{    
    NSDictionary *items = receiveMsg.jasonItems;
    
    if ([[items objectForKey:@"isSuccess"] isEqualToString:@"0"])
    {
        
        NSString *sendCount = [items objectForKey:@"sendCount"];
        
        if (IsStrEmpty(sendCount)) {
            if (IsStrEmpty([items objectForKey:@"errorMessage"])) {
                self.errorMsg = L(@"send Check Fail");
            }else{
                self.errorMsg = [items objectForKey:@"errorMessage"];
            }
        }else{
            if ([sendCount isEqualToString:@"4"]) {
                self.errorMsg = [NSString stringWithFormat:L(@"SorryAuthCodeOut3Times")];
            }
        }

        
        [self didGetCheckCodeFinished:NO];

    }else{
        
        [self didGetCheckCodeFinished:YES];
        
        if (_userCal) {
            [eppActiveCodeCalculagraph start];
        }
    }
    
}

- (void)beginGetCheckCode:(NSString *)phoneNum checkCodeState:(CheckCodeState)checkCodeState
{
    
    if (_userCal && eppActiveCodeCalculagraph.isValidate) {
        return;
    }
    if (self.limitTime == 0) {
        self.limitTime = 60.0f;
    }
    eppActiveCodeCalculagraph.timeOut = self.limitTime;
    
    _checkCodeState = checkCodeState;
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:4];
    //storeId
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];	
    
    //cellPhoneNumber    
    [postDataDic setObject:phoneNum forKey:@"cellphone"];
    
    //action    
    [postDataDic setObject:@"send" forKey:@"action"];    
    
    if (checkCodeState == eEfubaoCheckCode) {
        [postDataDic setObject:@"epp" forKey:@"step"];    
    }else if(checkCodeState == eIntegralCheckCode){
        [postDataDic setObject:@"integral" forKey:@"step"];    
    }else if (checkCodeState == eUserCashCardBind){
        [postDataDic setObject:@"useCashCardBind" forKey:@"step"];
    }else{
        //do noting
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,[@"SNmobileSendActMsgCmd" passport]];
    
    HTTPMSG_RELEASE_SAFELY(checkCodeHttpMsg);
    
    checkCodeHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_CheckCode];
    
    [self.httpMsgCtrl sendHttpMsg:checkCodeHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}

#pragma mark -
#pragma mark kvo

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if (object == eppActiveCodeCalculagraph && [keyPath isEqualToString:@"time"])
    {
        int remainTime = self.limitTime - eppActiveCodeCalculagraph.time;
        
        if ([_delegate respondsToSelector:@selector(eppGetCodeRemainTimeToRetry:checkCodeState:)]) {
            [_delegate eppGetCodeRemainTimeToRetry:remainTime checkCodeState:_checkCodeState];
        }
    }
}

@end

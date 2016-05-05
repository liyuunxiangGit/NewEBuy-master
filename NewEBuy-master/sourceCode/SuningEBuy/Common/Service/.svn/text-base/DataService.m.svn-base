//
//  DataService.m
//  SuningLottery
//
//  Created by wangrui on 7/4/12.
//  Copyright (c) 2012 suning. All rights reserved.
//

#import "DataService.h"
#import "ASIHTTPRequest.h"

@interface DataService()


@end

/*********************************************************************/


@implementation DataService

@synthesize httpMsgCtrl = _httpMsgCtrl;
@synthesize errorMsg = _errorMsg;
@synthesize context = _context;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_errorMsg);
    TT_RELEASE_SAFELY(_context);
    [self httpMsgRelease];
}

- (void)httpMsgRelease
{
    DLog(@"release your httpMssage here \n");
}

- (id)init
{
    if (self = [super init]) 
    {
        
        _httpMsgCtrl = [HttpMsgCtrl shareInstance];
    }
    
    return self;
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    NSString *errorMsg = nil;
    
    if (receiveMsg.error.code == 10021) {
        
        errorMsg = kHttpResponseJSONValueFailError;
        
    }
    else if (receiveMsg.responseStatusCode > 0)
    {
        //有http状态码
        NSString *statusCodeHead = [[NSString stringWithFormat:@"%d",receiveMsg.responseStatusCode] substringWithRange:NSMakeRange(0, 1)];
        if (!IsStrEmpty(statusCodeHead))
        {
            if ([statusCodeHead isEqualToString:@"4"]) {
                errorMsg = [NSString stringWithFormat:@"%@(1,10400)",kServerBusyErrorMsg];
            }else if ([statusCodeHead isEqualToString:@"5"]){
                errorMsg = [NSString stringWithFormat:@"%@(1,10500)",kServerBusyErrorMsg];
            }else{
                errorMsg = [NSString stringWithFormat:@"%@(1,10600)",kServerBusyErrorMsg];
            }
        }else{
            errorMsg = [NSString stringWithFormat:@"%@(1,10600)",kServerBusyErrorMsg];
        }
    }
    else if (receiveMsg.error)
    {
        if (receiveMsg.error.code == ASIRequestTimedOutErrorType)
        {
            errorMsg = kNetSlowErrorMsg;
        }
        else
        {
            errorMsg = kNetUnreachErrorMsg;
        }
    }
    else
    {
        errorMsg = kNetUnreachErrorMsg;
    }
    
    self.errorMsg = errorMsg;
    
    
    DLog(@"\n----The request (cmdCode = %#x) failed\n----ResponseStatusCode: %d \n----error: %@.", receiveMsg.cmdCode,receiveMsg.responseStatusCode,receiveMsg.error);
}

- (NSString *)errorMsgOfASIErrorCode:(int)errorCode
{
    NSString *errorMsg = nil;
    switch (errorCode)
    {
        case ASIConnectionFailureErrorType:
        {
            errorMsg = @"ASI_CONNECTION_FAILURE_ERROR";
            
            break;
        }
        case ASIRequestTimedOutErrorType:
        {
            
            errorMsg = @"ASI_TIME_OUT_ERROR";
            
            break;
        }
        case ASIAuthenticationErrorType:
        {
            errorMsg = @"ASI_AUTH_NEED_ERROR";
            
            break;
        }
        case ASIRequestCancelledErrorType:
        {
            errorMsg = @"ASI_CANCELED_ERROR";
            
            break;
        }
        case ASIUnableToCreateRequestErrorType:
        {
            
            errorMsg = @"ASI_BAD_URL_ERROR";
            
            break;
        }
        case ASIInternalErrorWhileBuildingRequestType:
        {
            errorMsg = @"ASI_PROXY_NEED_ERROR";
            
            break;
        }
        case ASIInternalErrorWhileApplyingCredentialsType:
        {
            errorMsg = @"ASI_RESPONSE_HEADER_ERROR";
            
            break;
        }
        case ASIFileManagementError:
        {
            errorMsg = @"ASI_MOVE_FILE_FAIL_ERROR";
            
            break;
        }
        case ASITooMuchRedirectionErrorType:
        {
            errorMsg = @"ASI_REDIRECT_OUT_LIMIT_ERROR";
            
            break;
        }
        case ASICompressionError:
        {
            errorMsg = @"ASI_COMPRESS_FAIL_ERROR";
            
            break;
        }
        default:
        {
            errorMsg = kHttpResponseJSONValueFailError;
            
            break;
        }
    }
    
    return L(errorMsg);
}

@end

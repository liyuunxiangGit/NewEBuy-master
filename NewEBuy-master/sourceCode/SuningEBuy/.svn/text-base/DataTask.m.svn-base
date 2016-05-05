//
//  DataTask.m
//  SuningEBuy
//
//  Created by liukun on 14-6-24.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataTask.h"

@implementation DataTask

@synthesize httpMsgCtrl = _httpMsgCtrl;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _httpMsgCtrl = [HttpMsgCtrl shareInstance];
    }
    return self;
}

- (void)cancelTask
{
    HTTPMSG_RELEASE_SAFELY(_httpMessage);
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    NSString *errorMsg = nil;
    
    if (receiveMsg.responseStatusCode > 0)
    {
        //有http状态码
        if (receiveMsg.responseStatusCode == 500 ||
            receiveMsg.responseStatusCode == 403 ||
            receiveMsg.responseStatusCode == 404)
        {
            errorMsg = kServerBusyErrorMsg;
        }
        else
        {
            errorMsg = kNetSlowErrorMsg;
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
    
    DLog(@"\n----The request (cmdCode = %#x) failed\n----ResponseStatusCode: %d \n----error: %@.", receiveMsg.cmdCode,receiveMsg.responseStatusCode,receiveMsg.error);
    
    [self failWithError:TaskError(receiveMsg.responseStatusCode, errorMsg)];
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

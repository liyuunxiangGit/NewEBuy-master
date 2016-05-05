//
//  DataTask.h
//  SuningEBuy
//
//  Created by liukun on 14-6-24.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BBTask.h"
#import "HttpMessage.h"

/** errors */
#define TaskError(_code, _desc) [NSError errorWithDomain:@"DataTaskErrorDomain" code:(_code) userInfo:@{NSLocalizedDescriptionKey: (_desc)}]
#define kDataTaskInvalidJSONError      TaskError(1125, kHttpResponseJSONValueFailError)

@interface DataTask : BBTask <HttpResponseDelegate>
{
    HttpMessage         *_httpMessage;
    @private
    HttpMsgCtrl __weak  *_httpMsgCtrl;
}

@property (weak, nonatomic, readonly) HttpMsgCtrl *httpMsgCtrl;

@end

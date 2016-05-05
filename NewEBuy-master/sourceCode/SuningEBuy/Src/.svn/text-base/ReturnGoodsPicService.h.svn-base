//
//  ReturnGoodsPicService.h
//  SuningEBuy
//
//  Created by zl on 14-11-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"
@protocol ReturnGoodsPicServiceDelegate <NSObject>
@optional
- (void)delegate_httpService_result:(NSDictionary *)result
                                 usrInfo:(id)userInfo
                                   error:(NSError *)error
                                     cmd:(E_CMDCODE)cmd;

@end
@interface ReturnGoodsPicService : DataService
@property(nonatomic,strong)id<ReturnGoodsPicServiceDelegate> delegate;
- (void)requestPostPicture:(NSData *)imageData orderId:(NSString*)orderId ownerId:(NSString*)ownerId;
@end

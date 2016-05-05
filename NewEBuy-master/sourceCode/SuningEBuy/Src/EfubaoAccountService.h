//
//  EfubaoAccountService.h
//  SuningEBuy
//
//  Created by shasha on 12-8-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

/*!
 @header   EfubaoAccountService
 @abstract  用于监控易付余额的变动
 @author   莎莎 
 @version  4.3  2012/8/29 Creation 
 */

#import "DataService.h"
@protocol  EfubaoAccountServiceDelegate<NSObject>

@optional

- (void)didGetEfubaoAccountCompleted:(BOOL)isSuccess 
                            errorMsg:(NSString *)errorMsg;


@end

@interface EfubaoAccountService : DataService{
    
    HttpMessage     *efubaoAcountHttpMsg;

}


@property (nonatomic, weak) id  <EfubaoAccountServiceDelegate>delegate;
@property (nonatomic, strong) NSString  *efubaoBalance;
@property (nonatomic, strong) NSString  *eppStatus;

- (void)beginGetEfubaoAccountInfo;

@end

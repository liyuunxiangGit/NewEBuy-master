//
//  CardService.h
//  SuningEBuy
//
//  Created by YANG on 14-3-12.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"
#import "CardDTO.h"

//@interface CardService : DataService
//
//@end

@protocol  cardServiceDelegate;

@interface CardService : DataService
{
    HttpMessage         *cardMsg;
    HttpMessage         *subscribMsg;
}

@property (nonatomic, assign) id<cardServiceDelegate>   delegate;

- (void)beginGetCardInfo:(NSString *)custNum WithName:(NSString*)nickName;

@end

@protocol cardServiceDelegate <NSObject>

- (void)getCardInfoCompletedWithResult:(BOOL)isSuccess
                               infoDto:(CardDTO *)dto
                              errorMsg:(NSString *)errorMsg;
@end

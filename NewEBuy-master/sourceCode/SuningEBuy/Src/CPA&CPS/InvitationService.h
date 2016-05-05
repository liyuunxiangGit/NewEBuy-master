//
//  InvitationService.h
//  SuningEBuy
//
//  Created by leo on 14-3-6.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"
#import <Foundation/Foundation.h>
#import "InvitationDTO.h"
#define kRetrieveParamEncodeSalt  @"sn201209"
#define kkey   @"sn2014"
@class InvitationService;

@protocol InvitationServiceDelegate <NSObject>

@optional
- (void) InvitationServiceComplete:(InvitationDTO *)service isSuccess:(BOOL) isSuccess;
- (void) QueryRewardServiceComplete:(QueryRewardDTO *)service isSuccess:(BOOL) isSuccess;

- (void) GetRedPackServiceEntryComplete:(GetRedPackEntryDTO *)service isSuccess:(BOOL) isSuccess;
- (void) GetRedPackServiceComplete:(NSString *)errmsg isSuccess:(BOOL) isSuccess;

@end

@interface InvitationService : DataService{
    HttpMessage        *informationListHttpMsg;
}

- (void)beginInvitationHttpRequest;

-(void)beginQueryRewardHttpRequest:(NSString *)cipher;

-(void)beginGetRedPackEntryHttpRequest;

-(void)beginGetRedPackHttpRequest:(NSString *)cipher;

@property (nonatomic, weak) id<InvitationServiceDelegate> delegate;

@end




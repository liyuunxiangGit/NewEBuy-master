//
//  CardWbSerVice.h
//  SuningEBuy
//
//  Created by YANG on 14-3-13.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataService.h"
#import "CardDetailBaseDTO.h"

@protocol CardWbSerViceDelegate;

@interface CardWbSerVice : DataService
{
    HttpMessage *delHttpMsg;
    HttpMessage *detailHttpMsg;
    
    HttpMessage *userWbHttpMsg;
    
    HttpMessage *getMoneyHttpMsg;
    
    HttpMessage *remarkHttpMsg;
}

@property (nonatomic, assign) id<CardWbSerViceDelegate> delegate;
@property (nonatomic, strong) NSString  *userMoneyStr;
@property (nonatomic, strong) NSString  *lastTimestamp;


-(void)beginSaveDetailInfo:(CardDetailBaseDTO *)dto;

@end



@protocol CardWbSerViceDelegate <NSObject>

@optional

-(void)delWbComplete:(BOOL)isSuccess ErrorMsg:(NSString*)errorMsg;

-(void)savePersonDetailComplete:(BOOL)isSuccess ErrorMsg:(NSString *)errorMsg;

-(void)userWbComplete:(BOOL)isSuccess ErrorMsg:(NSString*)errorMsg UserWbArray:(NSArray*)list;
@end
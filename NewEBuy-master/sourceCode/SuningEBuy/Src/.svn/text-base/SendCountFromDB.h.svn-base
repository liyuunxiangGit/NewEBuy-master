//
//  SendCountFromDB.h
//  SuningEBuy
//
//  Created by shasha on 12-3-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAO.h"

@interface SendCountFromDB : DAO


/*
 返回值：-1 不存在此电话号码，方法将此电话号码，以及所对应的最近更新的时间存入DB，count设为0。
 
        》=0  存在此号码，并返回今日已经更新过的count，如果今日未更新，set db.date=todayDate 、count=0。如果今日已更新，不做其他的操作直接返回count值。
 */
- (int)getSendCountFromDB:(NSString *)todayDate withPhoneNum:(NSString *)phoneNum;

/*
 删除对应电话号码的记录。
 */
- (void)deleteSendCountFromDB:(NSString *)phoneNum;


/*
 更新对应的电话号码
 */
- (void)updateSendCountToDB:(NSString *)phoneNum date:(NSString *)todayDate count:(int)sendCount;


@end

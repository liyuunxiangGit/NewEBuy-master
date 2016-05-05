//
//  EditNickNameService.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-5-31.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataService.h"

@protocol EditNickNameServiceDelegate;

@interface EditNickNameService : DataService
{
    HttpMessage     *editNickNameMsg;
}

@property (nonatomic, weak) id<EditNickNameServiceDelegate>           delegate;

- (void)beginEditNickNameRequest:(NSString *)nickName;



@end

@protocol EditNickNameServiceDelegate <NSObject>

- (void)didServiceComplete:(BOOL)isSuccess;

@end
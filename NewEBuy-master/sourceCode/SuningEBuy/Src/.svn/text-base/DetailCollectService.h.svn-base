//
//  DetailCollectService.h
//  SuningEBuy
//
//  Created by xmy on 19/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DataService.h"
#import "DataProductBasic.h"

@class DetailCollectService;
@protocol DetailCollectServiceDelegate <NSObject>

- (void)getDetailCollectServiceInfo:(BOOL)isSuccess WithStr:(NSString*)str;

@end

@interface DetailCollectService : DataService
{
    HttpMessage     *getCollectHttpMsg;

}

@property (nonatomic,assign)id<DetailCollectServiceDelegate>delegate;

@property (nonatomic,retain)NSString *bookFlag;

@property (nonatomic)BOOL OnlyGetCollect;

- (void)sendDetailCollectService:(DataProductBasic*)data;

@end

//
//  SNInformationService.h
//  SuningEBuy
//
//  Created by xingxianping on 13-7-12.
//  Copyright (c) 2013年 Suning. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "DataService.h"
#import "BigImageTypeDTO.h"


@class InformationDetailDto;
@protocol InformationServiceDelegate ;

@interface SNInformationService : DataService
{
    HttpMessage        *informationListHttpMsg;
    HttpMessage        *informationDetailHttpMsg;
    
}
@property (nonatomic,weak) id<InformationServiceDelegate> delegate;
@property (nonatomic,strong) InformationDetailDto *detailDto;
@property (nonatomic,strong) NSMutableArray *informationListArray;

@property (nonatomic,assign) NSInteger          totalPage;

- (void)beginInformationListHttpRequest:(NSString *)page;

- (void)beginInformationDetailHttpRequest:(NSString *)infoId;

@end

@protocol InformationServiceDelegate <NSObject>

@optional
- (void) informationServiceComplete:(SNInformationService *)service isSuccess:(BOOL) isSuccess;

@end


@interface InformationDetailDto : BaseHttpDTO
@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *publishTime;

@property (nonatomic,copy) NSString *imgUrl;

@property (nonatomic,copy) NSString *content;

@property (nonatomic,copy) NSString *infoSource;

@property (nonatomic,copy) NSString *url;

@end
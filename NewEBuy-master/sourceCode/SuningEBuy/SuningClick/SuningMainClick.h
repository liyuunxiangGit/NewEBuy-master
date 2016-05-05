//
//  SuningMainClick.h
//  SuningEBuy
//
//  Created by xy ma on 11-12-27.
//  Copyright (c) 2011年 sn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetAllSysInfo.h"
#import "InformetionCollectDTO.h"
#import "InformationCollectDAO.h"
#import "SuningPageObject.h"
#import "UIViewController+SuningClick.h"

@class CommonViewController;

@interface SuningMainClick : NSObject{
    
   
    
}

@property (nonatomic, copy) NSString *currentPageTitle;
@property (nonatomic, copy) NSString *currentPageInTime;
@property (nonatomic, assign) BOOL   isSuningMainClickStart;
@property (nonatomic, strong) SuningPageObject *currentPageObj;

+ (SuningMainClick *)sharedInstance;

+ (void)start;
+ (void)endPage:(NSString*)aName __attribute__((deprecated("废弃方法since 2.4.2")));
+ (void)startPage __attribute__((deprecated("废弃方法since 2.4.2")));
//get user startTime
+ (void)appLaunched;

//get user stoptime and save
+ (void)appTerminated;

//get user registerName and save
- (void)getUserRegisterNameAndSave:(NSString *)registerName;

//get user order and save
- (void)getOrderAndSave:(NSString *)order;

//get searchInformation and save
- (void)getSearchAndSave:(NSArray *)array;

//get pageInformation and save
- (void)getPageAndSave:(NSArray *)array __attribute__((deprecated("废弃方法since 2.4.2")));

//get crashInformation and save
- (void)getCrashAndsave:(NSString *)crashInfo;


- (void)loginInApp;


@end


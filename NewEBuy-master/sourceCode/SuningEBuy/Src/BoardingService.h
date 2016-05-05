//
//  BoardingService.h
//  SuningEBuy
//
//  Created by admin on 12-9-27.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoardingInfoDTO.h"
@class BoardingService;

@protocol BoardingDelegate <NSObject>
@optional

-(void)getNewBoardingService:(BoardingService *)service 
                         Result:(BOOL)isSuccess_
                       errorMsg:(NSString *)errorMsg;
-(void)getBoardingListService:(BoardingService *)service 
                      Result:(BOOL)isSuccess_
                    errorMsg:(NSString *)errorMsg;
-(void)getDeleteBoardingService:(BoardingService *)service 
                       Result:(BOOL)isSuccess_
                     errorMsg:(NSString *)errorMsg;
@end

@interface BoardingService : DataService
{
    HttpMessage *newBoardingMsg;
    HttpMessage *boardingListMsg;
    HttpMessage *deleteBoardingMsg;
}
@property (nonatomic,weak) id<BoardingDelegate> delegate;
@property (nonatomic,strong) NSString *travellerId;
@property (nonatomic,assign) BOOL      isSuccess;

//登机人列表
@property (nonatomic,strong) NSMutableArray *personList;

@property (nonatomic,assign) BOOL   isLoading;

@property (nonatomic,strong) NSDictionary *deleteDic;
/*!
 @method
 @abstract 新增或者秀还登机人信息
 */
- (void)sendBoardingManagementHttpReqeust:(BoardingInfoDTO *)boardingInfoDto;
/*!
 @method
 @abstract 获取登机人列表
 */
- (void)sendBoardingListHttpReqeust;

- (void)sendDeleteBoardingHttpReqeust:(NSMutableDictionary *)postDataDic;
@end

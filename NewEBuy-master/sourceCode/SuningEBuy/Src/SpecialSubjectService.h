//
//  SpecialSubjectService.h
//  SuningEBuy
//
//  Created by  on 12-10-30.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      SpecialSubjectService
 @abstract    获取促销专栏页面
 @author      刘坤
 @version     v1.0  12-10-30
 @discussion  
 */

#import "DataService.h"
#import "SNSpecialSubjectDTO.h"

@protocol SpecialSubjectServiceDelegate <NSObject>

@optional
- (void)getSpecialSubjectsCompletionWithResult:(BOOL)isSuccess 
                                      errorMsg:(NSString *)errorMsg 
                                   subjectList:(NSArray *)list;

@end

//-----------------------------------------------------------

@interface SpecialSubjectService : DataService
{
    HttpMessage     *getSpecialSubjectHttpMsg;
}

@property (nonatomic, weak) id<SpecialSubjectServiceDelegate> delegate;

/*!
 @abstract      开始获取促销专栏列表
 @discussion    
 */
- (void)beginGetSpecialSubjectsRequest:(NSString *)appType withPomAreaId:(NSString *)areaId;

@end

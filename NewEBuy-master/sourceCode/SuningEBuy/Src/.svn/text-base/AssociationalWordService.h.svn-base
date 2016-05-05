//
//  AssociationalWordService.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-22.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      AssociationalWordService
 @abstract    联想词的service
 @author      刘坤
 @version     v2.0  12-10-12
 @discussion  12-10-12新搜索接口更改
 */

#import "DataService.h"

typedef enum{
    AssociationalWordMixType,
    AssociationalWordBookType
}AssociationalWordType;

@protocol AssociationalWordServiceDelegate <NSObject>

/*!
 @abstract      获取联想词完成回调
 @param         isSuccess  是否成功
 @param         errorMsg   错误信息
 */
- (void)getAssociationalWordsCompletedWithResult:(BOOL)isSuccess 
                                        errorMsg:(NSString *)errorMsg;

@end





@interface AssociationalWordService : DataService
{
    @private
    HttpMessage     *associationalHttpMsg;
}

@property (nonatomic, weak) id<AssociationalWordServiceDelegate> delegate;
@property (nonatomic, strong) NSArray *wordList;
@property (nonatomic, strong) NSArray *typesList;//关键词相关的类别

/*!
 @abstract      开始获取联想词
 @param         keyword  需要联想的词汇
 @param         type  是混排搜索还是图书搜索
 */
- (void)beginGetAssociationalWordWithKeyword:(NSString *)keyword 
                       associationalWordType:(AssociationalWordType)type;

@end

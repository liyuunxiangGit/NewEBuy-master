//
//  ISRDataHander.h
//  MSC
//
//  Created by ypzhao on 12-11-19.
//  Copyright (c) 2012年 iflytek. All rights reserved.
//

//#import <Foundation/Foundation.h>

// 云端返回数据解析类
@protocol ISRDataHelper<NSObject>

//解析听写json格式的数据
- (NSString *) getResultFromJson:(NSString*)params;

//解析命令词返回的结果
- (NSString*) getResultFormAsr:(NSString*)params;

//解析语法识别返回的结果
-(NSString *) getResultFromABNFJson:(NSString*)params;

@end

@interface ISRDataHelper : NSObject<ISRDataHelper>

+ (id) shareInstance;

@end

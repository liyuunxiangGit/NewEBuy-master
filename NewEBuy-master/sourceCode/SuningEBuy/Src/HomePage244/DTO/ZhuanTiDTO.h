//
//  ZhuanTiDTO.h
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopADInfoDTO.h"

@interface ZhuanTiDTO : NSObject


//专题名称
@property (nonatomic, copy) NSString  *subjectName;

//模板类型
@property (nonatomic, copy) NSString  *templateID;

//总页数
@property (nonatomic, copy) NSString  *totalPageNum;

//页面顶部的广告
@property (nonatomic, strong) TopADInfoDTO *topAD;


//数据列表
@property (nonatomic, strong) NSMutableArray    *dataArray;
@end

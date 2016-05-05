//
//  SNSpecialSubjectDTO.h
//  SuningEBuy
//
//  Created by 芳奎 赵 on 12-9-17.
//  Copyright (c) 2012年 苏宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpDTO.h"
#import "SNActivityDTO.h"

@interface SNSpecialSubjectDTO : BaseHttpDTO

@property(nonatomic,strong) NSString        *areaId;            //专题id 

@property(nonatomic,strong) NSString        *areaName;          //专题名称

@property(nonatomic,strong) NSString        *areaDisPosition;   //专题位置(按照从上到下，从左到右边顺序排序)

@property(nonatomic,strong) NSString        *areaStyleType;     //专题模板（目前一共有6中模板，每种模板支持拓展）

@property(nonatomic,strong) NSString        *areaBgColor;       //专题标题背景色（目前一共有7种颜色）

@property(nonatomic,strong) NSString        *areaAddRow;        //增加行数（标准模板支持结尾添加行数）

@property(nonatomic,strong) NSMutableArray  *actList;           //活动列表

- (void)encodeWithCoder:(NSCoder *)coder;
- (id)initWithCoder:(NSCoder *)coder;

@end

//
//  InsendTimeDTO.h
//  SuningEBuy
//
//  Created by 孔斌 on 14-11-5.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BaseHttpDTO.h"
#import "ShopCartV2DTO.h"

//送达时间类型
typedef enum : NSUInteger {
    InsendTimeDefault   = 0,    //默认送货时间（只能在当前页面修改，不可拆分）
    InsendTimeTogether  = 1,    //合并送货时间
    InsendTimeSplit     = 2,    //拆分送货时间
} InsendTimeType;

@interface InsendTimeDTO : BaseHttpDTO

//获取配送日期信息标识 :beforeMergeInfo，afterMergeInfo
@property (nonatomic, strong) NSString  *mergeDataOption;

//展示选择合并送达或拆分送达标记   0：不展示  1：所有商品一起送达  2: 最快时间拆分送达
@property (nonatomic, strong) NSString  *mergeDateFlag;

@property (nonatomic, strong) NSString  *orderId;   //订单号

@property (nonatomic, strong) NSMutableArray *afterMergeInfoList;   //合并前信息列表

@property (nonatomic, strong) NSMutableArray *beforeMergeInfoList;  //合并后信息列表

@property (nonatomic, strong) NSArray        *defaultMergeList;

@property (nonatomic, strong) NSArray        *togetherMergeList;

@property (nonatomic, strong) NSArray        *splitMergeList;

@property (nonatomic, assign) InsendTimeType    insendTimeType;

- (void)encodeFromDictionary:(NSDictionary *)dic;

@end

//合并前后数据
@interface MergeDataOptionDTO : BaseHttpDTO

@property (nonatomic, strong) NSMutableArray *dateVoList;   //支持配送时间列表

@property (nonatomic, strong) NSMutableArray *itemsVoList;  //订单行列表

@property (nonatomic, strong) NSString      *defDelDate;    //默认配送日期

@property (nonatomic, strong) NSString      *defDelTime;    //默认配送时间

@property (nonatomic, strong) NSString      *defDelWeek;    //默认配送星期

@property (nonatomic, strong) NSString      *delDateText;   //配送日期描述

@property (nonatomic, strong) NSString      *defDelDateStr; //配送日期+星期+时间

- (void)encodeFromDictionary:(NSDictionary *)dic;

@end

//配送时间数据
@interface DateVoDTO : BaseHttpDTO

@property (nonatomic, strong) NSString      *delDate;       //配送日期

@property (nonatomic, strong) NSString      *delWeek;       //配送星期

@property (nonatomic, strong) NSString      *dateStr;       //配送日期加星期

@property (nonatomic, strong) NSMutableArray *delTimeList;  //配送时间

- (void)encodeFromDictionary:(NSDictionary *)dic;

@end

//商品订单行
@interface ItemsVoDTO : BaseHttpDTO

@property (nonatomic, strong) NSString *orderitemsId;       //订单行ID

@property (nonatomic, strong) NSString *defInstallDate;     //默认安装时间

@property (nonatomic, strong) NSString *itemPrice;          //商品价格

@property (nonatomic, strong) NSString *partNumber;         //商品编码

@property (nonatomic, strong) NSString *productName;        //商品名称

@property (nonatomic, strong) NSString *quantity;           //商品数量

- (void)encodeFromDictionary:(NSDictionary *)dic;

- (ShopCartV2DTO *)transformToShopCartV2DTO;

@end

//商品订单行
@interface InstallDateDTO : BaseHttpDTO

@property (nonatomic, strong) NSString *orderitemsId;       //订单行ID

@property (nonatomic, strong) NSString *defInstallDate;     //默认安装时间

- (void)encodeFromDictionary:(NSDictionary *)dic;

@end

//提交订单所传送货时间
@interface insendTimeSubmitDTO : BaseHttpDTO

@property (nonatomic, strong) NSString  *orderitemsId;

@property (nonatomic, strong) NSString  *delDate;

@property (nonatomic, strong) NSString  *delTime;

@property (nonatomic, strong) NSString  *delInstallDate;

@end

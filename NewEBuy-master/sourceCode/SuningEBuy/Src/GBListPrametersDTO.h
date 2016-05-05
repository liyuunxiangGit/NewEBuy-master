//
//  GBListPrametersDTO.h
//  SuningEBuy
//
//  Created by shasha on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//  3.2	团购商品列表接口 请求参数

#import <Foundation/Foundation.h>

typedef enum{
    eIndex,//序值排序
    ePriceAsc,//价格升序
    ePricrDesc,//价格降序
    eSalesAsc,//销量升序
    eSalesDesc,//销量降序
    eAddedAsc,//上架时间升序
    eAddedDesc,//上架时间降序
    
} GBSortType;//排序类型

@interface GBListPrametersDTO : NSObject

@property (nonatomic, copy) NSString  *cityId;     //城市ID编码
@property (nonatomic, copy) NSString  *categoryId; //频道ID（作为区分团购频道的标识）
@property (nonatomic, copy) NSString  *areaId;     //行政区域Id
@property (nonatomic, copy) NSString  *indexId;    //店铺索引id(搜索创建)
@property (nonatomic, copy) NSString  *keyWord;    //关键字
@property (nonatomic, assign) GBSortType sortType; //排序
@property (nonatomic, copy) NSString  *pageNumber; //查询页数
@property (nonatomic, copy) NSString  *pageSize;   //条数

@end

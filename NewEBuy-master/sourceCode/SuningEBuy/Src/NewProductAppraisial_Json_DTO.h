//
//  NewProductAppraisial_Json_DTO.h
//  SuningEBuy
//
//  Created by cjw on 14/11/11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//
//直接使用主站的接口
#import "BaseHttpDTO.h"

@interface NewProductAppraisial_Json_DTO : BaseHttpDTO

//@property (nonatomic, strong) NSString *productReviewId;   // 商品评价 ID
@property (nonatomic, strong) NSString *nickname;          // 用户昵称
//@property (nonatomic, strong) NSString *bestTag;           // 是否精华
@property (nonatomic, strong) NSString *score;            // 评价星级
@property (nonatomic, strong) NSString *publishTime;        // 评价时间
//@property (nonatomic, strong) NSString *title;             // 主题，兼容老系统
//@property (nonatomic, strong) NSString *advantage;         // 优点，兼容老系统
//@property (nonatomic, strong) NSString *disadvantage;      // 缺点，兼容老系统
@property (nonatomic, strong) NSString *content;           // 评价内容
@property (nonatomic, strong) NSString *supplierName;      // 供应商名称
//@property (nonatomic, strong) NSString *suplReviewId;      // 追加评价ID
//@property (nonatomic, strong) NSString *suplContent;       // 追加评价内容
//@property (nonatomic, strong) NSString *logonId;           //登录名
//@property (nonatomic, strong) NSString *anonFlag;          //是否匿名
@property (nonatomic, strong) NSMutableArray *images;       // 图片

@end

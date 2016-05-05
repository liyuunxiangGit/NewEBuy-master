//
//  NewProductAppraisalDTO.h
//  SuningEBuy
//
//  Created by 孔斌 on 13-8-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "BaseHttpDTO.h"

@interface NewProductAppraisalDTO : BaseHttpDTO

@property (nonatomic, strong) NSString *productReviewId;   // 商品评价 ID
@property (nonatomic, strong) NSString *nickname;          // 用户昵称
@property (nonatomic, strong) NSString *bestTag;           // 是否精华
@property (nonatomic, strong) NSString *qualityStar;       // 评价星级
@property (nonatomic, strong) NSString *reviewTime;        // 评价时间
@property (nonatomic, strong) NSString *title;             // 主题，兼容老系统
@property (nonatomic, strong) NSString *advantage;         // 优点，兼容老系统
@property (nonatomic, strong) NSString *disadvantage;      // 缺点，兼容老系统
@property (nonatomic, strong) NSString *content;           // 心得
@property (nonatomic, strong) NSString *supplierName;      // 供应商名称
@property (nonatomic, strong) NSString *suplReviewId;      // 追加评价ID
@property (nonatomic, strong) NSString *suplContent;       // 追加评价内容
@property (nonatomic, strong) NSString *logonId;           //登录名
@property (nonatomic, strong) NSString *anonFlag;          //是否匿名


@end

//
//  SNActivityDTO.h
//  SuningEBuy
//
//  Created by 芳奎 赵 on 12-9-17.
//  Copyright (c) 2012年 苏宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpDTO.h"

@interface SNActivityDTO : BaseHttpDTO


@property(nonatomic,strong) NSString  *activityId;
@property(nonatomic,strong) NSString  *actName;
@property(nonatomic,strong) NSString  *actPictureUrl;
@property(nonatomic,strong) NSString  *actPosition;

@property(nonatomic,strong) NSString  *actRule;
@property(nonatomic,strong) NSString  *prdSortType;
@property(nonatomic,strong) NSMutableArray   *productList;

- (void)encodeWithCoder:(NSCoder *)coder;
- (id)initWithCoder:(NSCoder *)coder;

- (void)fixImageUrlWithAreaStyleType:(NSString *)areaStyleType;

@end

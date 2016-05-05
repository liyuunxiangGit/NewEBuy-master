//
//  SNCityFirstLetterDTO.h
//  SuningEBuy
//
//  Created by snping on 14-11-7.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNCityFirstLetterDTO : NSObject

@property (nonatomic,strong)NSString *cityCode;//城市代码
@property (nonatomic,strong)NSString *cityName;//城市中文名称
@property (nonatomic,strong)NSString *cityFullPinyin;//城市全拼
@property (nonatomic,strong)NSString *cityShortPinyin;//城市简拼
@property (nonatomic,strong)NSString *cityFirstLetter;//城市首字母

- (void)parseFromDict:(NSDictionary *)dic;
@end

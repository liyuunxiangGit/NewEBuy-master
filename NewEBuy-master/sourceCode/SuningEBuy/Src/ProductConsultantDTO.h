//
//  ProductConsultantDTO.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-2-27.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductConsultantDTO : NSObject

/*咨询人*/
@property (nonatomic, copy) NSString *consultant;

/*咨询内容*/
@property (nonatomic, copy) NSString *consultantContent;

/*咨询回复*/
@property (nonatomic, copy) NSString *consultantReply;

/*咨询时间*/
@property (nonatomic, copy) NSString *consultantTime;


// 电器咨询
- (void)encodeFromApplianceDictionary:(NSDictionary *)dic;

// 图书咨询
- (void)encodeFromBooksDictionary:(NSDictionary *)dic;

@end

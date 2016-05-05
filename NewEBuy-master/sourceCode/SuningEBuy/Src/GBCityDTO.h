//
//  GBCityDTO.h
//  SuningEBuy
//
//  Created by  liukun on 12-12-28.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBCityDTO : NSObject <NSCoding>
{
    @private
    NSString    *_cityId;
    NSString    *_cityName;
    NSString    *_cityPinYin;
    NSString    *_letter;
}

@property (nonatomic, copy) NSString *cityId;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *cityPinYin;
@property (nonatomic, copy) NSString *letter;


- (void)encodeFromDictionary:(NSDictionary *)dic;

@end

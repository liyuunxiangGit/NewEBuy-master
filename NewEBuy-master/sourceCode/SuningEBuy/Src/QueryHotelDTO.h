//
//  QueryHotelDTO.h
//  SuningEBuy
//
//  Created by admin on 12-10-9.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QueryHotelDTO : BaseHttpDTO
{

}

@property (nonatomic,copy) NSString *cityName;
@property (nonatomic,copy) NSString *hotelAroundId;
@property (nonatomic,copy) NSString *hotelName;
@property (nonatomic,copy) NSString *startDate;
@property (nonatomic,copy) NSString *endDate;
@property (nonatomic,copy) NSString *priceArea;
@property (nonatomic,copy) NSString *snStar;
@property (nonatomic,copy) NSString *sortType;
@property (nonatomic,copy) NSString *sort;
@property (nonatomic,copy) NSString *currentPage;

@end

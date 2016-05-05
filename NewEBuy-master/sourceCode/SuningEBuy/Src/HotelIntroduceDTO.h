//
//  HotelIntroduceDTO.h
//  SuningEBuy
//
//  Created by robin wang on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HotelDetailImageListDTO.h"

#import "MyPhoto.h"

@interface HotelIntroduceDTO : NSObject
{

}

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *name;//酒店名字

@property (nonatomic, strong) NSURL *imageUrl;

@property (nonatomic, copy) NSString *address;//酒店地址

@property (nonatomic, copy) NSString *starLevel;//酒店星级

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *photoCount;

@property (nonatomic, copy) NSString *introduce;//酒店简介详细介绍

@property (nonatomic, copy) NSMutableArray *imageUrlList;

@property (nonatomic, copy) NSMutableArray *serviceItemList;//

@property (nonatomic, copy) NSString *ccAccepted;

- (void)encodeFromDictionary:(NSDictionary *)dic;
@end

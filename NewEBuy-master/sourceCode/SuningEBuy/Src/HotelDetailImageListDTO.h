//
//  HotelDetailImageListDTO.h
//  SuningEBuy
//
//  Created by robin wang on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotelDetailImageListDTO : NSObject
{
    
}


@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSURL *imageUrl;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *info;


- (void)encodeFromDictionary:(NSDictionary *)dic;

@end

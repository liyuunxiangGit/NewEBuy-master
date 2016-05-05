//
//  HomeTopRecommendDTO.h
//  SuningEMall
//
//  Created by Wang Jia on 11-1-9.
//  Copyright 2011 IBM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpDTO.h"

@interface HomeTopRecommendDTO : BaseHttpDTO {
    
	NSString	*_productCode;
	NSString	*_productId;
	NSString	*_productName;
    NSString    *productPrice_;
    NSString    *productDesc_;

}

@property (nonatomic, copy)   NSString	 *productCode;
@property (nonatomic, copy)   NSString   *productId;
@property (nonatomic, copy)   NSString	 *productName;
@property (nonatomic, copy)   NSString   *productPrice;
@property (nonatomic, copy)   NSString   *productDesc;

- (void)encodeWithCoder:(NSCoder *)coder;
- (id)initWithCoder:(NSCoder *)coder;
-(void)encodeFromDictionaryByNew:(NSDictionary *)dic;
@end

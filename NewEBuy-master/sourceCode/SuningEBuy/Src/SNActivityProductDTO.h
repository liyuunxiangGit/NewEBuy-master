//
//  SNActivityProductDTO.h
//  SuningEBuy
//
//  Created by 家兴 王 on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpDTO.h"
#import "DataProductBasic.h"

@interface SNActivityProductDTO : BaseHttpDTO{
    NSString	*_partNumber;
	NSString	*_productId;
	NSString	*_productName;
    NSString    *_productPrice;
    NSString    *_catentryDesc;
    NSString    *_promIcon;
    NSString    *_originalPrice;
    NSString    *_bigBangName;
    
}
@property (nonatomic, copy)   NSString	 *bigBangName;
@property (nonatomic, copy)   NSString	 *partNumber;
@property (nonatomic, copy)   NSString   *productId;
@property (nonatomic, copy)   NSString	 *productName;
@property (nonatomic, copy)   NSString   *productPrice;
@property (nonatomic, copy)   NSString   *catentryDesc;
@property (nonatomic, copy)   NSString   *promIcon;
@property (nonatomic, copy)   NSString   *originalPrice;
@property (nonatomic, copy)   NSString   *vendorCode;

- (DataProductBasic *)transformToProductDTO;

@end

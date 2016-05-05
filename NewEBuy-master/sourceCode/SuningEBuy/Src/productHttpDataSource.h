//
//  productHttpDataSource.h
//  SuningEBuy
//
//  Created by zhaojw on 11-9-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataProductBasic.h"
#import "ProductAppraisalDTO.h"
#import "ProductParaDTO.h"
@interface productHttpDataSource : NSObject {

}
+(DataProductBasic*)parseProductDetailInfo:(NSDictionary*)items;
+(NSMutableArray *)parseProductAppraisalInfo:(NSDictionary *)items;

//+(NSMutableArray *)parseProductAskInfo:(NSDictionary *)items;

+ (NSMutableArray *)parseProductParaInfo:(NSDictionary *)items isBook:(BOOL)isYes;

@end

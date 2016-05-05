//
//  GBCategoryDTO.h
//  SuningEBuy
//
//  Created by shasha on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBCategoryDTO : NSObject

@property (nonatomic, copy) NSString  *goodsCount;
@property (nonatomic, copy) NSString  *categoryName;
@property (nonatomic, copy) NSString  *categoryId;
@property (nonatomic, strong) NSArray *subCategoryList;

- (void)encodeFromDictionary:(NSDictionary *)dic;

@end

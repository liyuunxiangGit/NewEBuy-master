//
//  ProductCategoryDTO.h
//  SuningEMall
//
//  Created by macbook001 on 11-1-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ProductCategoryDTO : NSObject {
	
	NSString *_firstCategoryName;
	NSString *_firstCategoryCode;
	
	NSString *_secondCategoryName;
	NSString *_secondCategoryCode;
	
	NSString *_thirdCategoryName;
	NSString *_thirdCategoryCode;
    
    BOOL     _isBook;

}
@property (nonatomic, copy) NSString *firstCategoryName;
@property (nonatomic, copy) NSString *firstCategoryCode;

@property (nonatomic, copy) NSString *secondCategoryName;
@property (nonatomic, copy) NSString *secondCategoryCode;

@property (nonatomic, copy) NSString *thirdCategoryName;
@property (nonatomic, copy) NSString *thirdCategoryCode;

@property (nonatomic, assign) BOOL   isBook;
@end

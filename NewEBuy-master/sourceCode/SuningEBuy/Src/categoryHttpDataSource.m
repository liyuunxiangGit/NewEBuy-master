//
//  categoryHttpDataSource.m
//  SuningEBuy
//
//  Created by zhaojw on 11-9-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "categoryHttpDataSource.h"

@implementation categoryHttpDataSource

+ (NSMutableArray *)parseFirstCategoryList:(NSDictionary*)items{
	
	if(!items || (NSNull *)items == [NSNull null]){
		
		return nil;
	}

#if kCategoryDebug
	NSArray *firstArray = [items objectForKey:kResponseHomeFirstCategoryRecource];
#else
    NSArray *firstArray = [items objectForKey:kResponseCategoryRecource];
#endif
	if(firstArray != nil && [firstArray count] > 0){
		
		NSMutableArray *array = [[NSMutableArray alloc] init];
		
				
		for(NSDictionary *dic in firstArray){
            
                
            V2FristCategoryDTO *dto = [[V2FristCategoryDTO alloc] init];
            
            [dto encodeFromDictionary:dic];
            
            [array addObject:dto];
            

		}
		
		if([array count]){
			
		    return array;
			
		}
		else{
			
			
			return nil;
		}
	}
	
	
	return nil;
	
	
}

@end

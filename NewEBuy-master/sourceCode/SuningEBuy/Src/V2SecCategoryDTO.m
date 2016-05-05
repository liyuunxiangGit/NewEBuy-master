//
//  V2SecCategoryDTO.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-4-11.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "V2SecCategoryDTO.h"

@implementation V2SecCategoryDTO

@synthesize categoryName = _categoryName;
@synthesize categoryCi = _categoryCi;
@synthesize categoryImageURL = _categoryImageURL;
@synthesize categoryCf = _categoryCf;
@synthesize categoryId = _categoryId;
@synthesize catelogIds = _catelogIds;


-(void)encodeFromDictionary:(NSDictionary *)dic{
	
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
	
	NSString *ci = [dic objectForKey:kHttpResponseHomeSecondCategoryCi];
    
	NSString *name = [dic objectForKey:kHttpResponseHomeSecondCategoryName];
    
    NSString *cf = [dic objectForKey:kHttpResponseHomeSecondCategoryCf];
    
    NSString *ID = [dic objectForKey:kHttpResponseHomeSecondCategoryId];
    
    NSString *ids = [dic objectForKey:kHttpResponseHomeSecondCatelogIds];
    
    NSString *url = [dic objectForKey:kHttpResponseHomeSecondCategoryURL];
    
	if (NotNilAndNull(ci)) {
		self.categoryCi = ci;
	}
	if (NotNilAndNull(name)) {
		self.categoryName = name;
	}
    if (NotNilAndNull(ids)) {
		self.catelogIds = ids;
	}
	if (NotNilAndNull(cf)) {
		self.categoryCf = cf;
	}
    if (NotNilAndNull(ID)) {
		self.categoryId = ID;
	}
	if (NotNilAndNull(url)) {
		self.categoryImageURL = url;
	}
    
    
    //	NSURL *url = [NSURL URLWithString:kCategoryAddressForHttp];
    //	NSString *str = [NSString stringWithFormat:@"/%@_ls.png",self.categoryCode];
    //	self.categoryImageURL = [url URLByAppendingPathComponent:str];
    
}


@end

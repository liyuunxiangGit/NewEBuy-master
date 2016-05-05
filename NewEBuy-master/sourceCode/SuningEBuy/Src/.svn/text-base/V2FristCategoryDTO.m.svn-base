//
//  V2FristCategoryDTO.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-4-8.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "V2FristCategoryDTO.h"


@implementation V2FristCategoryDTO

@synthesize categoryName = _categoryName;
@synthesize categoryCode = _categoryCode;
@synthesize categoryImageURL = _categoryImageURL;
@synthesize categoryDes = _categoryDes;
@synthesize categoryId = _categoryId;
@synthesize catelogIds = _catelogIds;
@synthesize secList = _secList;
@synthesize thirdList = _thirdList;

@synthesize kindId = _kindId;
@synthesize parentId = _parentId;
@synthesize kindName = _kindName;
@synthesize kindDesc = _kindDesc;
@synthesize pictureUrl = _pictureUrl;
@synthesize chaKind = _chaKind;
@synthesize usingRel = _usingRel;
@synthesize ci = _ci;
@synthesize cf = _cf;

-(void)encodeFromDictionary:(NSDictionary *)dic{
	
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
#if kCategoryDebug
	NSString *code = [dic objectForKey:kHttpResponseHomeFirstCategoryCode];
    
	NSString *name = [dic objectForKey:kHttpResponseHomeFirstCategoryName];
    
    NSString *des = [dic objectForKey:kHttpResponseHomeFirstCategoryDes];
    
    NSString *ID = [dic objectForKey:kHttpResponseHomeFirstCategoryId];
    
    NSString *ids = [dic objectForKey:kHttpResponseHomeFirstCatelogIds];
    
    NSString *url = [dic objectForKey:kHttpResponseHomeFirstCategoryURL];
    
    NSArray *array = [dic objectForKey:@"secondCategoryList"];
	if (NotNilAndNull(code)) {
		self.categoryCode = code;
	}
	if (NotNilAndNull(name)) {
		self.categoryName = name;
	}
    if (NotNilAndNull(ids)) {
		self.catelogIds = ids;
	}
	if (NotNilAndNull(des)) {
		self.categoryDes = des;
	}
    if (NotNilAndNull(ID)) {
		self.categoryId = ID;
	}
	if (NotNilAndNull(url)) {
		self.categoryImageURL = url;
	}
    
    if (NotNilAndNull(array)) {
        
        [self.secList removeAllObjects];
        for (NSDictionary *dic in array) {
            
            V2SecCategoryDTO *dto = [[V2SecCategoryDTO alloc] init];
            
            [dto encodeFromDictionary:dic];
            
        
            [_secList addObject:dto];
            
        }
    }
#else
    NSString *tempKindId = [dic objectForKey:kHttpResponseCategoryKindId];
    
    NSString *tempParentId = [dic objectForKey:kHttpResponseCategoryParentId];

	NSString *tempKindName = [dic objectForKey:kHttpResponseCategoryKindName];
    
    NSString *tempKindDesc = [dic objectForKey:kHttpResponseCategoryKindDesc];
    
    NSString *tempPictureUrl = [dic objectForKey:kHttpResponseCategoryPictureUrl];
    
    NSString *tempChaKind = [dic objectForKey:kHttpResponseCategoryChaKind];
    
    NSString *tempRelation = [dic objectForKey:kHttpResponseCategoryRelation];
    
    NSString *tempCi = [dic objectForKey:kHttpResponseCategoryCi];
    
    NSString *tempCf = [dic objectForKey:kHttpResponseCategoryCf];

    NSArray *array = [dic objectForKey:kHttpResponseCategorySecList];

	if (NotNilAndNull(tempKindId)) {
		self.kindId = tempKindId;
	}
	if (NotNilAndNull(tempParentId)) {
		self.parentId = tempParentId;
	}
    if (NotNilAndNull(tempKindName)) {
		self.kindName = tempKindName;
	}
	if (NotNilAndNull(tempKindDesc)) {
		self.kindDesc = tempKindDesc;
	}
    if (NotNilAndNull(tempPictureUrl)) {
		self.pictureUrl = tempPictureUrl;
	}
	if (NotNilAndNull(tempChaKind)) {
		self.chaKind = tempChaKind;
	}
    if (NotNilAndNull(tempRelation)) {
		self.usingRel = tempRelation;
	}
    if (NotNilAndNull(tempCi)) {
		self.ci = tempCi;
	}
	if (NotNilAndNull(tempCf)) {
		self.cf = tempCf;
	}

    if (NotNilAndNull(array)) {
        
        [self.secList removeAllObjects];
        
        for (NSDictionary *dic in array) {
            
            V2FristCategoryDTO *dto = [[V2FristCategoryDTO alloc] init];
            
            [dto encodeFromDictionary:dic];
            
            NSArray *array2 = [dic objectForKey:kHttpResponseCategoryThirdList];

            if (NotNilAndNull(array2)) {
                
                [dto.thirdList removeAllObjects];
                
                for (NSDictionary *dic in array2) {
                    
                    V2FristCategoryDTO *dto2 = [[V2FristCategoryDTO alloc] init];
                    
                    [dto2 encodeFromDictionary:dic];
                    
                    [dto.thirdList addObject:dto2];
                    
                }
            }

            [_secList addObject:dto];
            
        }
    }

#endif

//	NSURL *url = [NSURL URLWithString:kCategoryAddressForHttp];
//	NSString *str = [NSString stringWithFormat:@"/%@_ls.png",self.categoryCode];
//	self.categoryImageURL = [url URLByAppendingPathComponent:str];
    
}

-(NSMutableArray *)secList{
    
    if (!_secList) {
        
        _secList = [[NSMutableArray alloc] initWithCapacity:1];
    }
    
    return _secList;
}

-(NSMutableArray *)thirdList{
    
    if (!_thirdList) {
        
        _thirdList = [[NSMutableArray alloc] initWithCapacity:1];
    }
    
    return _thirdList;
}

@end

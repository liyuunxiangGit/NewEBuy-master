//
//  SNSpecialSubjectDTO.m
//  SuningEBuy
//
//  Created by 芳奎 赵 on 12-9-17.
//  Copyright (c) 2012年 苏宁. All rights reserved.
//

#import "SNSpecialSubjectDTO.h"

@implementation SNSpecialSubjectDTO

@synthesize areaId = _areaId;
@synthesize areaName = _areaName;
@synthesize areaDisPosition = _areaDisPosition;
@synthesize areaStyleType = _areaStyleType;
@synthesize areaBgColor = _areaBgColor;
@synthesize areaAddRow = _areaAddRow;
@synthesize actList = _actList;


- (void)dealloc {
    
    TT_RELEASE_SAFELY(_areaId);
    
    TT_RELEASE_SAFELY(_areaName);
    
    TT_RELEASE_SAFELY(_areaDisPosition);
    
    TT_RELEASE_SAFELY(_areaStyleType);
    
    TT_RELEASE_SAFELY(_areaBgColor);
    
    TT_RELEASE_SAFELY(_areaAddRow);
    
    TT_RELEASE_SAFELY(_actList);
    
}


- (void)encodeFromDictionary:(NSDictionary *)dic{
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
	
    NSString *__areaId = [dic objectForKey:@"areaId"];
    if (NotNilAndNull(__areaId))   self.areaId = __areaId;

    NSString *__areaName = [dic objectForKey:@"areaName"];
    if (NotNilAndNull(__areaName))   self.areaName = __areaName;
    
    NSString *__areaDisPosition = [dic objectForKey:@"areaDisPosition"];
    if (NotNilAndNull(__areaDisPosition))   self.areaDisPosition = __areaDisPosition;
    
    NSString *__areaStyleType = [dic objectForKey:@"areaStyleType"];
    if (NotNilAndNull(__areaStyleType))   self.areaStyleType = __areaStyleType;
    
    NSString *__areaBgColor = [dic objectForKey:@"areaBgColor"];
    if (NotNilAndNull(__areaBgColor))   self.areaBgColor = __areaBgColor;
    
    NSString *__areaAddRow = [dic objectForKey:@"areaAddRow"];
    if (NotNilAndNull(__areaAddRow))   self.areaAddRow = __areaAddRow;

    NSArray *actList = [dic objectForKey:@"actList"];
    
    if (NotNilAndNull(actList) && [actList count] > 0) 
    {
        NSMutableArray *topArray2 = [[NSMutableArray alloc] initWithCapacity:[actList count]];
        
        for(NSDictionary *dic in actList)
        {
            SNActivityDTO *activityDto = [[SNActivityDTO alloc] init];
            
            [activityDto encodeFromDictionary:dic];
            [activityDto fixImageUrlWithAreaStyleType:self.areaStyleType];
            [topArray2 addObject:activityDto];
            
        } 
        self.actList = topArray2;
        
    }
}

- (void)parserAddress:(NSArray *)array{
	if (array == nil) {
		return;
	}
	
	@autoreleasepool {
        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:1];
        for (NSDictionary *dic in array) 
        {
            SNActivityDTO *activityDto = [[SNActivityDTO alloc] init];
            [activityDto encodeFromDictionary:dic];
            
            [tempArray addObject:activityDto];
        }
        self.actList = tempArray;
    }
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.areaId forKey:@"areaId"];
    [coder encodeObject:self.areaName forKey:@"areaName"];
    [coder encodeObject:self.areaDisPosition forKey:@"areaDisPosition"];
    [coder encodeObject:self.areaStyleType forKey:@"areaStyleType"];
    [coder encodeObject:self.areaBgColor forKey:@"areaBgColor"];
    [coder encodeObject:self.areaAddRow forKey:@"areaAddRow"];
    [coder encodeObject:self.actList forKey:@"actList"];
}

- (id)initWithCoder:(NSCoder *)coder
{
    
    if (self = [super init])
    {
        self.areaId = [coder decodeObjectForKey:@"areaId"];
        self.areaName = [coder decodeObjectForKey:@"areaName"];
        self.areaDisPosition = [coder decodeObjectForKey:@"areaDisPosition"];
        self.areaStyleType = [coder decodeObjectForKey:@"areaStyleType"];
        self.areaBgColor = [coder decodeObjectForKey:@"areaBgColor"];
        self.areaAddRow = [coder decodeObjectForKey:@"areaAddRow"];
        self.actList = [coder decodeObjectForKey:@"actList"];
    }
    
    return self;
}

@end

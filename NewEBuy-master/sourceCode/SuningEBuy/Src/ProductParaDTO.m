//
//  ProductParaDTO.m
//  SuningEBuy
//
//  Created by   on 11-11-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ProductParaDTO.h"

@implementation ProductParaContentDTO

@synthesize attrName = _attrName;
@synthesize parametersData = _parametersData;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_attrName);
    TT_RELEASE_SAFELY(_parametersData);
    
}

-(void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSString *cotends = [dic objectForKey:@"attrName"];
    if (!IsStrEmpty(cotends)) {
        self.attrName  = cotends;
    }else{
        self.attrName = @"";
    }
    
    NSArray *array = EncodeArrayFromDic(dic, @"parametersData");
    
    NSMutableArray *list = [[NSMutableArray alloc] initWithCapacity:[array count]];
    for (NSDictionary *data in array) {
        
        ProductParaDTO *dto = [[ProductParaDTO alloc] init];
        [dto encodeFromDictionary:data];
        
        [list addObject:dto];
    }
    self.parametersData = list;
    
}
@end

@implementation ProductParaDTO

@synthesize parameterName = _parameterName;
@synthesize parameterContents = _parameterContents;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_parameterName);
    TT_RELEASE_SAFELY(_parameterContents);
    
}

-(void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }

    NSString *cotends = [dic objectForKey:kHttpResponseParameterContents];
    if (!IsStrEmpty(cotends)) {
        self.parameterContents  = cotends;
    }else{
        self.parameterContents = @"";
    }
    
    
    NSString *names = [dic objectForKey:kHttpResponseParameterName];   
    if (!IsStrEmpty(names)) {
        self.parameterName = names;
    }else{
        self.parameterName = @"";
    }
}
@end

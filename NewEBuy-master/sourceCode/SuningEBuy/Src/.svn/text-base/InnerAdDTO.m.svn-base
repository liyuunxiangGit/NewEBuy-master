//
//  InnerAdDTO.m
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "InnerAdDTO.h"

#define  kHttpResponseInnerAdPartNum              @"partNum"
#define  kHttpResponseInnerAdAdverName            @"adverName"
#define  kHttpResponseInnerAdProductImageURL      @"productImage"
#define  kHttpResponseInnerAdIsInner              @"isInner"
#define  kHttpResponseInnerAdProductCode          @"productCode "

@implementation InnerAdDTO

@synthesize partNum = partNum_;
@synthesize adverName = adverName_;
@synthesize isInner = isInner_;
@synthesize productCode = productCode_;
@synthesize productImageURL = productImageURL_;

-(void)dealloc{

    TT_RELEASE_SAFELY(partNum_);
    TT_RELEASE_SAFELY(adverName_);
    TT_RELEASE_SAFELY(isInner_);
    TT_RELEASE_SAFELY(productCode_);
    TT_RELEASE_SAFELY(productImageURL_);
    
}

-(void)encodeFromDictionary:(NSDictionary *)dic{
    
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
	NSString *aPartNuma  = [dic objectForKey:kHttpResponseInnerAdPartNum];
	NSString *aAdverName    = [dic objectForKey:kHttpResponseInnerAdAdverName];
	NSString *aProductImageURL   = [dic objectForKey:kHttpResponseInnerAdProductImageURL];
	NSString *aIsInner   = [dic objectForKey:kHttpResponseInnerAdIsInner];
	NSString *aProductCode    = [dic objectForKey:kHttpResponseInnerAdProductCode];
	    
	if(NotNilAndNull(aPartNuma)){
		self.partNum = aPartNuma;
	}			
	if (NotNilAndNull(aAdverName)) {
		self.adverName = aAdverName;
	}
    if (NotNilAndNull(aProductImageURL)) {
		self.productImageURL = aProductImageURL;
	}
    if (NotNilAndNull(aIsInner)) {
		self.isInner = aIsInner;
	}
    if (NotNilAndNull(aProductCode)) {
		self.productCode = aProductCode;
	}
 	
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.partNum forKey:@"partNum"];
    [coder encodeObject:self.adverName forKey:@"adverName"];
    [coder encodeObject:self.productImageURL forKey:@"productImageURL"];
    [coder encodeObject:self.isInner forKey:@"isInner"];
    [coder encodeObject:self.productCode forKey:@"productCode"];    
}

- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super init])
    {
        self.partNum = [coder decodeObjectForKey:@"partNum"];
        self.adverName = [coder decodeObjectForKey:@"adverName"];
        self.productImageURL = [coder decodeObjectForKey:@"productImageURL"];
        self.isInner = [coder decodeObjectForKey:@"isInner"];
        self.productCode = [coder decodeObjectForKey:@"productCode"];

    }
    
    return self;
}


@end

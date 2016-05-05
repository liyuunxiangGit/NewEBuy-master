//
//  CompanyDTO.m
//  SuningEBuy
//
//  Created by shasha on 12-5-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CompanyDTO.h" 


@implementation CompanyDTO
@synthesize airCompanyShortName = _airCompanyShortName;
@synthesize airCompanyId = _airCompanyId;

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)dealloc {
    
    TT_RELEASE_SAFELY(_airCompanyId);
    TT_RELEASE_SAFELY(_airCompanyShortName);
    
}
-(void)encodeFromDictionary:(NSDictionary *)dic{
    
    NSString *airCompanyIdStr = [dic objectForKey:@"airCompanyId"];
    NSString *airCompanyShortNameStr = [dic objectForKey:@"airCompanyShortName"];

    
    self.airCompanyId = IsNilOrNull(airCompanyIdStr)?@"":airCompanyIdStr;
    self.airCompanyShortName = IsNilOrNull(airCompanyShortNameStr)?@"":airCompanyShortNameStr;

}

@end

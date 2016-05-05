//
//  HotelDetailImageListDTO.m
//  SuningEBuy
//
//  Created by robin wang on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HotelDetailImageListDTO.h"

@implementation HotelDetailImageListDTO
@synthesize name = _name;

@synthesize imageUrl = _imageUrl;

@synthesize title = _title;

@synthesize info = _info;

- (void)dealloc {
    TT_RELEASE_SAFELY(_name);
    TT_RELEASE_SAFELY(_imageUrl);
    
    TT_RELEASE_SAFELY(_title);
    TT_RELEASE_SAFELY(_info);
      
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (IsNilOrNull(dic)) {
        return;
    }
    
    NSString *__name = [dic objectForKey:@"title"];
    NSString *__imageUrl = [dic objectForKey:@"localImageUrl"];
    
    
    
    if (NotNilAndNull(__name))   self.name = __name;
    if (NotNilAndNull(__imageUrl))   self.imageUrl = [NSURL URLWithString: __imageUrl];
                                                      
}

@end

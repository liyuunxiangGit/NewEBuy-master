//
//  SNActivityDTO.m
//  SuningEBuy
//
//  Created by 芳奎 赵 on 12-9-17.
//  Copyright (c) 2012年 苏宁. All rights reserved.
//

#import "SNActivityDTO.h"

@implementation SNActivityDTO

@synthesize activityId = _activityId;
@synthesize actRule = _actRule;
@synthesize prdSortType = _prdSortType;
@synthesize productList = _productList;
@synthesize actName = _actName;
@synthesize actPictureUrl = _actPictureUrl;
@synthesize actPosition = _actPosition;

-(void)encodeFromDictionary:(NSDictionary *)dic{
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
        
    NSString *activityId = [dic objectForKey:@"activityId"];
    NSString *actRule = [dic objectForKey:@"actRule"];
    NSString *prdSortType = [dic objectForKey:@"prdSortType"];
    
    NSString *actName = [dic objectForKey:@"actName"];
    NSString *actPictureUrl = [[dic objectForKey:@"actPictureUrl"] trim];
    NSString *actPosition = [dic objectForKey:@"actPosition"];
    
    if (NotNilAndNull(activityId))     
        self.activityId = [activityId stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (NotNilAndNull(actRule))     
        self.actRule = [actRule stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (NotNilAndNull(prdSortType))     
        self.prdSortType = [prdSortType stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (NotNilAndNull(actName))     
        self.actName = [actName stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (NotNilAndNull(actPictureUrl))
    {
        self.actPictureUrl = actPictureUrl;
    }
    
    
    if (NotNilAndNull(actPosition))     
        self.actPosition = [actPosition stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (void)fixImageUrlWithAreaStyleType:(NSString *)areaStyleType
{
    if (self.actPictureUrl.length)
    {
        NSArray *tempNew = @[@"7",@"8",@"9",@"11"];
        if ([areaStyleType isValueOf:tempNew])
        {
            NSString *bigImage ;
            if (self.actPictureUrl.length > 8) {
                bigImage = [NSString stringWithFormat:@"%@_234%@",
                            [self.actPictureUrl substringWithRange:NSMakeRange(0, self.actPictureUrl.length - 4)],
                            [self.actPictureUrl substringWithRange:NSMakeRange(self.actPictureUrl.length - 4,4)]];
            }else{
                bigImage = self.actPictureUrl;
            }
            self.actPictureUrl = bigImage;
        }
    }
}

-(void)dealloc
{
    TT_RELEASE_SAFELY(_activityId);
    TT_RELEASE_SAFELY(_actRule);
    TT_RELEASE_SAFELY(_prdSortType);
    TT_RELEASE_SAFELY(_actName);
    TT_RELEASE_SAFELY(_actPictureUrl);
    TT_RELEASE_SAFELY(_actPosition);
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.activityId forKey:@"activityId"];
    [coder encodeObject:self.actRule forKey:@"actRule"];
    [coder encodeObject:self.prdSortType forKey:@"prdSortType"];
    [coder encodeObject:self.actName forKey:@"actName"];
    [coder encodeObject:self.actPictureUrl forKey:@"actPictureUrl"];
    [coder encodeObject:self.actPosition forKey:@"actPosition"];
}

- (id)initWithCoder:(NSCoder *)coder
{
    
    if (self = [super init])
    {
        self.activityId = [coder decodeObjectForKey:@"activityId"];
        self.actRule = [coder decodeObjectForKey:@"actRule"];
        self.prdSortType = [coder decodeObjectForKey:@"prdSortType"];
        self.actName = [coder decodeObjectForKey:@"actName"];
        self.actPictureUrl = [coder decodeObjectForKey:@"actPictureUrl"];
        self.actPosition = [coder decodeObjectForKey:@"actPosition"];
    }
    
    return self;
}


@end

//
//  NBYStickItemDTO.m
//  SuningEBuy
//
//  Created by suning on 14-9-24.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NBYStickItemDTO.h"

@implementation NBYStickItemDTO

- (void)setItem:(NSDictionary *)item {
    _item = item;
    if (nil != _item) {
        
        NSString *commentCnt = EncodeStringFromDic(item,@"commentCount");
        if (nil != commentCnt) {
            self.commentNum = commentCnt.integerValue;
        }
        NSString *dashangCnt = EncodeStringFromDic(item,@"rewardCount");
        if (nil != commentCnt) {
            self.dashangNum = dashangCnt.integerValue;
        }
    }
}

@end

@implementation NBYStickGrpItemDTO

- (id)init {
    if (self = [super init]) {
        self.stickItems = [NSMutableArray array];
    }
    return self;
}

- (NSDictionary *)postion {
    
    return @{@"userLocation":((nil==_userLocation)?@[]:_userLocation),
             @"point":((nil==_point)?@[]:_point),
             @"pointName":((nil==_pointName)?@"":_pointName),
             @"prov":((nil==_prov)?@"":_prov),
             @"city":((nil==_city)?@"":_city),
             @"area":((nil==_area)?@"":_area),
             @"distance":((nil==_distance)?@"0":_distance)};
}

@end

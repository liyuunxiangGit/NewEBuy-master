//
//  GBShopDTO.m
//  SuningEBuy
//
//  Created by 王 漫 on 13-2-28.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBShopDTO.h"

@implementation GBShopDTO
@synthesize name = _name;
@synthesize area = _area;
@synthesize address = _address;
@synthesize tel = _tel;
@synthesize star = _star;
@synthesize telList = _telList;

- (void)encodeFromDictionary:(NSDictionary *)dic{
    if (dic == nil) {
        return;
    }
    self.name = EncodeStringFromDic(dic, @"name");
    self.area = EncodeStringFromDic(dic, @"area");
    self.address = EncodeStringFromDic(dic, @"address");
    self.tel = EncodeStringFromDic(dic, @"tel");
    self.star = EncodeStringFromDic(dic, @"star");
    
//    if (!IsStrEmpty(self.tel)) {
//        
//        NSArray *list = [self.tel componentsSeparatedByString:@","];
//        if (IsArrEmpty(list) && [list count] > 0 ) {
//        }else{
//            NSMutableArray *shopList = [[NSMutableArray alloc] initWithCapacity:[list count]];
//            for (NSString *string in list) {
//                if ([string hasSuffix:@"）"]) {
//                    NSRange range = [string rangeOfString:@"（"];
//                    string = [string substringToIndex:range.location];
//                }
//                [shopList addObject:string];
//            }
//            self.telList = shopList;
//            [shopList release];
//        }
//    }
}
@end

//
//  TravellerInfoDTO.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-5-15.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "TravellerInfoDTO.h"

@implementation TravellerInfoDTO

@synthesize travellerId = _travellerId;
@synthesize userId = _userId;
@synthesize travellerType = _travellerType;
@synthesize firstName = _firstName;
@synthesize cardType = _cardType;
@synthesize idCode = _idCode;

- (void)dealloc {
    TT_RELEASE_SAFELY(_travellerId);
    TT_RELEASE_SAFELY(_userId);
    TT_RELEASE_SAFELY(_travellerType);
    TT_RELEASE_SAFELY(_firstName);
    TT_RELEASE_SAFELY(_cardType);
    TT_RELEASE_SAFELY(_idCode);
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (IsNilOrNull(dic)) {
        return;
    }
    
    NSNumber *__travellerId = [dic objectForKey:@"travellerId"];
    NSString *__userId = [dic objectForKey:@"userId"];
    NSString *__travellerType = [dic objectForKey:@"travellerType"];
    NSString *__firstName = [dic objectForKey:@"firstName"];
    NSString *__cardType = [dic objectForKey:@"cardType"];
    NSString *__idCode = [dic objectForKey:@"idCode"];
    
    if (NotNilAndNull(__travellerId))   self.travellerId = [__travellerId stringValue];
    if (NotNilAndNull(__userId))   self.userId = __userId;
    if (NotNilAndNull(__travellerType))   self.travellerType = __travellerType;
    if (NotNilAndNull(__firstName))   self.firstName = __firstName;
    if (NotNilAndNull(__cardType))   self.cardType = __cardType;
    if (NotNilAndNull(__idCode))   self.idCode = __idCode;
}

@end

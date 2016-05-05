//
//  BoardingInfoDTO.m
//  SuningEBuy
//
//  Created by lanfeng on 12-5-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BoardingInfoDTO.h"

@implementation BoardingInfoDTO

@synthesize travellerId;
@synthesize usersId;
@synthesize travellerType;
@synthesize firstName;
@synthesize lastName;
@synthesize cardType;
@synthesize idCode;
@synthesize birthday;
@synthesize mobile;


- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


-(void)encodeFromDictionary:(NSDictionary *)dic{
    
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    if(NotNilAndNull([dic objectForKey:@"travellerId"])){
        self.travellerId=[dic objectForKey:@"travellerId"];
    }
	if(NotNilAndNull([dic objectForKey:@"usersId"])){
        self.usersId=[dic objectForKey:@"usersId"];
    }
    if(NotNilAndNull([dic objectForKey:@"travellerType"] )){
        self.travellerType=[dic objectForKey:@"travellerType"] ;
    }
    if(NotNilAndNull([dic objectForKey:@"firstName"])){
        self.firstName=[dic objectForKey:@"firstName"];
    }
    if(NotNilAndNull([dic objectForKey:@"lastName"])){
        self.lastName=[dic objectForKey:@"lastName"];
    }
    if(NotNilAndNull([dic objectForKey:@"cardType"])){
        self.cardType=[dic objectForKey:@"cardType"];
    }
    if(NotNilAndNull([dic objectForKey:@"idCode"])){
        self.idCode=[dic objectForKey:@"idCode"];
    }
    if(NotNilAndNull([dic objectForKey:@"birthday"] )){
        self.birthday=[dic objectForKey:@"birthday"] ;
    }
    if([dic objectForKey:@"mobile"] ){
        self.mobile=[dic objectForKey:@"mobile"] ;
        
    }
//	self.travellerId           = [dic objectForKey:@"travellerId"] == nil?@"":[dic objectForKey:@"travellerId"];	
//	self.usersId               = [dic objectForKey:@"travellerId"] == nil?@"":[dic objectForKey:@"usersId"];
//	self.travellerType         = [dic objectForKey:@"travellerType"] == nil?@"":[dic objectForKey:@"travellerType"];
//	self.firstName             = [dic objectForKey:@"firstName"] == nil?@"":[dic objectForKey:@"firstName"];
//	self.lastName              = [dic objectForKey:@"lastName"] == nil?@"":[dic objectForKey:@"lastName"];
//	self.cardType              = [dic objectForKey:@"cardType"] == nil?@"":[dic objectForKey:@"cardType"];
//	self.idCode                = [dic objectForKey:@"idCode"] == nil?@"":[dic objectForKey:@"idCode"];
//	self.birthday              = [dic objectForKey:@"birthday"] == nil?@"":[dic objectForKey:@"birthday"];
//    self.mobile                = [dic objectForKey:@"mobile"] == nil?@"":[dic objectForKey:@"mobile"];

}


- (void)dealloc {
    TT_RELEASE_SAFELY(travellerId);
    TT_RELEASE_SAFELY(usersId);
    TT_RELEASE_SAFELY(travellerId);
    TT_RELEASE_SAFELY(firstName);
    TT_RELEASE_SAFELY(lastName);
    TT_RELEASE_SAFELY(cardType);
    TT_RELEASE_SAFELY(idCode);
    TT_RELEASE_SAFELY(birthday);
    TT_RELEASE_SAFELY(mobile);
}

@end

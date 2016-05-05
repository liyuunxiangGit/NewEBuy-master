//
//  FlightInfoDTO.h
//  SuningEBuy
//
//  Created by shasha on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlightInfoDTO : NSObject <NSCopying>
@property(nonatomic,copy) NSString *guid;
@property(nonatomic,copy) NSString *oa;
@property(nonatomic,copy) NSString *ot;
@property(nonatomic,copy) NSString *aa;
@property(nonatomic,copy) NSString *at;
@property(nonatomic,copy) NSString *fDate;
@property(nonatomic,copy) NSString *fTime;
@property(nonatomic,copy) NSString *aDate;
@property(nonatomic,copy) NSString *aTime;
@property(nonatomic,copy) NSString *fNo;
@property(nonatomic,copy) NSString *craft;
@property(nonatomic,copy) NSString *company;
@property(nonatomic,copy) NSString *aptA;
@property(nonatomic,copy) NSString *aptC;
@property(nonatomic,copy) NSString *aotA;
@property(nonatomic,copy) NSString *aotC;
@property(nonatomic,copy) NSString *stop;
@property(nonatomic,copy) NSString *minPrice;
@property(nonatomic,copy) NSString *minPriceC;
@property(nonatomic,copy) NSString *oaName;
@property(nonatomic,copy) NSString *aaName;
@property(nonatomic,copy) NSString *oaFullName;
@property(nonatomic,copy) NSString *aaFullName;
@property(nonatomic,copy) NSString *companyName;
@property(nonatomic,copy) NSString *comid;
@property(nonatomic,copy) NSString *brandid;
@property(nonatomic,copy) NSString *gdsgroupid;
@property(nonatomic,copy) NSString *size;
@property(nonatomic,copy) NSString *indexf;
@property(nonatomic,copy) NSString *picName;
@property(nonatomic,strong) NSArray  *roomList;

@property(nonatomic,copy) NSString *fareOffId;
@property(nonatomic,copy) NSString *ticketRetId;

-(void)encodeFromDictionary:(NSDictionary *)dic;
@end

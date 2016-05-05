//
//  FlightInfoDTO.m
//  SuningEBuy
//
//  Created by shasha on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FlightInfoDTO.h"
#import "FlightRoomHttpDataSource.h"


@implementation FlightInfoDTO
@synthesize guid = _guid;
@synthesize oa = _oa;
@synthesize ot = _ot;
@synthesize aa = _aa;
@synthesize at = _at;
@synthesize fDate = _fDate;
@synthesize fTime = _fTime;
@synthesize aDate = _aDate;
@synthesize aTime = _aTime;
@synthesize fNo = _fNo;
@synthesize craft = _craft;
@synthesize company = _company;
@synthesize aptA = _aptA;
@synthesize aptC = _aptC;
@synthesize aotA = _aotA;
@synthesize aotC = _aotC;
@synthesize stop = _stop;
@synthesize minPrice = _minPrice;
@synthesize minPriceC = _minPriceC;
@synthesize oaName = _oaName;
@synthesize aaName = _aaName;
@synthesize oaFullName = _oaFullName;
@synthesize aaFullName = _aaFullName;
@synthesize companyName = _companyName;
@synthesize comid = _comid;
@synthesize brandid = _brandid;
@synthesize gdsgroupid = _gdsgroupid;
@synthesize size = _size;
@synthesize indexf = _indexf;
@synthesize picName = _picName;
@synthesize roomList = _roomList;
@synthesize fareOffId = _fareOffId;
@synthesize ticketRetId = _ticketRetId;

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)encodeFromDictionary:(NSDictionary *)dic{

    NSString *oaStr = [dic objectForKey:@"oa"];
    NSString *otStr = [dic objectForKey:@"ot"];
    NSString *aaStr = [dic objectForKey:@"aa"];
    NSString *atStr = [dic objectForKey:@"at"];
    NSString *fDateStr = [dic objectForKey:@"fDate"];
    NSString *fTimeStr = [dic objectForKey:@"fTime"];
    NSString *aDateStr = [dic objectForKey:@"aDate"];
    NSString *aTimeStr = [dic objectForKey:@"aTime"];
    NSString *fNoStr = [dic objectForKey:@"fNo"];
    NSString *craftStr = [dic objectForKey:@"craft"];
    NSString *companyStr = [dic objectForKey:@"company"];
    NSNumber *aptAStr = [dic objectForKey:@"aptA"];
    NSNumber *aptCStr = [dic objectForKey:@"aptC"];
    NSNumber *aotAStr = [dic objectForKey:@"aotA"];
    NSNumber *aotCStr = [dic objectForKey:@"aotC"];
    NSNumber *stopStr = [dic objectForKey:@"stop"];
    NSNumber *minPriceStr = [dic objectForKey:@"minPrice"];
    NSNumber *minPriceCStr = [dic objectForKey:@"minPrice"];
    NSString *oaNameStr = [dic objectForKey:@"oaName"];
    NSString *aaNameStr = [dic objectForKey:@"aaName"];
    NSString *oaFullNameStr = [dic objectForKey:@"oaFullName"];
    NSString *aaFullNameStr = [dic objectForKey:@"aaFullName"];
    NSString *companyNameStr = [dic objectForKey:@"companyName"];
    NSString *comidStr = [dic objectForKey:@"comid"];
    NSString *brandidStr = [dic objectForKey:@"brandid"];
    NSString *gdsgroupidStr = [dic objectForKey:@"gdsgroupid"];
    NSNumber *sizeStr = [dic objectForKey:@"size"];
    NSNumber *indexfStr = [dic objectForKey:@"indexf"];
    NSString *picNameStr = [dic objectForKey:@"picName"];
    NSArray *roomList = [dic objectForKey:@"positionList"];
    
    NSString *__fareOffId = [dic objectForKey:@"fareOffId"];
    NSString *__ticketRetId = [dic objectForKey:@"ticketRetId"];
    
    if (!IsNilOrNull(oaStr)) {
        self.oa = oaStr;
    }else{
        self.oa = @"";
    }
    
    if (!IsNilOrNull(otStr)) {
        self.ot = otStr;
    }else{
    
        self.ot = @"";
    }
    
    if (!IsNilOrNull(aaStr)) {
        self.aa = aaStr;
    }else{

        self.aa = @"";
    }
    
    if (!IsNilOrNull(atStr)) {
        self.at = atStr;
    }else{
    
        self.at = @"";
    }
    
    if (!IsNilOrNull(fDateStr)) {
        self.fDate = fDateStr;
    }else{
    
        self.fDate = @"";
    }
    
    
    if (!IsNilOrNull(fTimeStr)) {
    
        self.fTime = fTimeStr;
        
    }else{
    
        self.fTime = @"";
    }
    
    if (!IsNilOrNull(aDateStr)) {
        
        self.aDate = aDateStr;
        
    }else{
    
        self.aDate = @"";
    }
    
    if (!IsNilOrNull(aTimeStr)) {
        
        self.aTime = aTimeStr;
        
    }else{
    
        self.aTime = @"";
    }
    
    
    if (!IsNilOrNull(fNoStr)) {
        
        self.fNo = fNoStr;
        
    }else{
        
        self.fNo = @"";
        
    }
    
    if (!IsNilOrNull(craftStr)) {
        
        self.craft = craftStr;
        
    } else {
        
        self.craft = @"";
        
    }
    
    
    if (!IsNilOrNull(companyStr)) {
        
        self.company = companyStr;
        
    } else {
        
        self.company = @"";
        
    }

    if (!IsNilOrNull(aptAStr)) {
        
        self.aptA = [aptAStr stringValue];
        
    } else {
        
        self.aptA = @"";
        
    }
    
    if (!IsNilOrNull(aptCStr)) {
        
        self.aptC = [aptCStr stringValue];
        
    } else {
        
        self.aptC = @"";
        
    }
    
    if (!IsNilOrNull(aotAStr)) {
        
        self.aotA = [aotAStr stringValue];
        
    } else {
        
        self.aotA = @"";
        
    }
    
    if (!IsNilOrNull(aotCStr)) {
        
        self.aotC = [aotCStr stringValue];
        
    } else {
        
        self.aotC = @"";
        
    }
    
    if (!IsNilOrNull(stopStr)) {
        
        self.stop = [stopStr stringValue];
        
    } else {
        
        self.stop = @"";
        
    }
    
    if (!IsNilOrNull(minPriceStr)) {
        
        self.minPrice = [minPriceStr stringValue];
        
    } else {
        
        self.minPrice = @"";
        
    }
    
    if (!IsNilOrNull(minPriceCStr)) {
        
        self.minPriceC = [minPriceCStr stringValue];
        
    } else {
        
        self.minPriceC = @"";
        
    }
    
    
    if (!IsNilOrNull(oaNameStr)) {
        self.oaName = oaNameStr;
    }else{
    
        self.oaName = @"";
    }
    
    if (!IsNilOrNull(aaNameStr)) {
        self.aaName = aaNameStr;
    }else{
    
        self.aaName = @"";
    }
    
    if (!IsNilOrNull(oaFullNameStr)) {
        self.oaFullName = oaFullNameStr;
    }else{
    
        self.oaFullName = @"";
    }
    
    
    if (!IsNilOrNull(aaFullNameStr)) {
        self.aaFullName = aaFullNameStr;
    } else {
        self.aaFullName = @"";
    }
    
    if (!IsNilOrNull(companyNameStr)) {
        self.companyName = companyNameStr;
    } else {
        self.companyName = @"";
    }
    
    if (!IsNilOrNull(comidStr)) {
        self.comid = comidStr;
    } else {
        self.comid = @"";
    }
    
    if (!IsNilOrNull(brandidStr)) {
        self.brandid = brandidStr;
    } else {
        self.brandid = @"";
    }
    
    if (!IsNilOrNull(gdsgroupidStr)) {
        self.gdsgroupid = gdsgroupidStr;
    } else {
        self.gdsgroupid = @"";
    }
    
    if (!IsNilOrNull(sizeStr) ) {
        self.size = [sizeStr stringValue];
    } else {
        self.size = @"";
    }
    
    if (!IsNilOrNull(indexfStr)) {
        self.indexf = [indexfStr stringValue];
    } else {
        self.indexf = @"";
    }
    
    if (!IsNilOrNull(picNameStr)) {
        self.picName = picNameStr;
    } else {
        self.picName = @"";
    }
    
    if (NotNilAndNull(roomList) && [roomList count]>0) {
        
        self.roomList = [FlightRoomHttpDataSource  parseFlightRoomList:roomList];
        
    } else {
        
        self.roomList = nil;
        
    }
    
    if (NotNilAndNull(__fareOffId))   self.fareOffId = __fareOffId;
    if (NotNilAndNull(__ticketRetId))   self.ticketRetId = __ticketRetId;
    
}


- (id)copyWithZone:(NSZone *)zone{
    
    FlightInfoDTO *copy = [[[self class] allocWithZone:zone] init];    
    copy.guid = self.guid;
    copy.oa = self.oa;
    copy.ot = self.ot;
    copy.aa = self.aa;
    copy.at = self.at;
    copy.fDate = self.fDate;
    copy.fTime = self.fTime;
    copy.aDate = self.aDate;
    copy.aTime = self.aTime;
    copy.fNo = self.fNo;
    copy.craft = self.craft;
    copy.company = self.company;
    copy.aptA = self.aptA;
    copy.aptC = self.aptC;
    copy.aotA = self.aotA;
    copy.aotC = self.aotC;
    copy.stop = self.stop;
    copy.minPrice = self.minPrice;
    copy.minPriceC = self.minPriceC;
    copy.oaName = self.oaName;
    copy.aaName = self.aaName;
    copy.oaFullName = self.oaFullName;
    copy.aaFullName = self.aaFullName;
    copy.companyName = self.companyName;
    copy.comid = self.comid;
    copy.brandid = self.brandid;
    copy.gdsgroupid = self.gdsgroupid;
    copy.size = self.size;
    copy.indexf = self.indexf;
    copy.picName = self.picName;
    copy->_roomList = [self.roomList copy];
    copy.fareOffId = self.fareOffId;
    copy.ticketRetId = self.ticketRetId;
    return copy;
    

}

- (void)dealloc {
    TT_RELEASE_SAFELY(_guid);
    TT_RELEASE_SAFELY(_oa);
    TT_RELEASE_SAFELY(_ot);
    TT_RELEASE_SAFELY(_aa);
    TT_RELEASE_SAFELY(_at);
    TT_RELEASE_SAFELY(_fDate);
    TT_RELEASE_SAFELY(_fTime);
    TT_RELEASE_SAFELY(_aDate);
    TT_RELEASE_SAFELY(_aTime);   
    TT_RELEASE_SAFELY(_fNo); 
    TT_RELEASE_SAFELY(_craft);  
    TT_RELEASE_SAFELY(_company);
    TT_RELEASE_SAFELY(_aptA);  
    TT_RELEASE_SAFELY(_aptC); 
    TT_RELEASE_SAFELY(_aotA);
    TT_RELEASE_SAFELY(_aotC);
    TT_RELEASE_SAFELY(_stop); 
    TT_RELEASE_SAFELY(_minPrice);
    TT_RELEASE_SAFELY(_minPriceC);
    TT_RELEASE_SAFELY(_oaName); 
    TT_RELEASE_SAFELY(_aaName);
    TT_RELEASE_SAFELY(_oaFullName);  
    TT_RELEASE_SAFELY(_aaFullName);
    TT_RELEASE_SAFELY(_companyName);
    TT_RELEASE_SAFELY(_comid);
    TT_RELEASE_SAFELY(_brandid);
    TT_RELEASE_SAFELY(_gdsgroupid);
    TT_RELEASE_SAFELY(_size);
    TT_RELEASE_SAFELY(_indexf);
    TT_RELEASE_SAFELY(_picName);
    TT_RELEASE_SAFELY(_roomList);
    TT_RELEASE_SAFELY(_ticketRetId);
    TT_RELEASE_SAFELY(_fareOffId);
}
@end

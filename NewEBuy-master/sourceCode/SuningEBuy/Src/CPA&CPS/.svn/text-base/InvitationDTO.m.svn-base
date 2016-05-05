//
//  InvitationDTO.m
//  SuningEBuy
//
//  Created by leo on 14-3-6.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "InvitationDTO.h"

@implementation InvitationDTO

- (void)dealloc
{
    TT_RELEASE_SAFELY(_actTitle);
    TT_RELEASE_SAFELY(_actContent);
    TT_RELEASE_SAFELY(_actRuleURL);
    TT_RELEASE_SAFELY(_smsContent);
    TT_RELEASE_SAFELY(_cipher);
    TT_RELEASE_SAFELY(_qrCodeUrl);
    TT_RELEASE_SAFELY(_rewardRule);
    
}

-(void)encodeFromDictionary:(NSDictionary *)dic{
    if (dic == nil) {
        return;
    }
    
    self.actTitle = EncodeStringFromDic(dic, @"actTitle");
    self.actContent = EncodeStringFromDic(dic, @"actContent");
    self.actRuleURL = EncodeStringFromDic(dic, @"actRuleURL");
    self.smsContent = EncodeStringFromDic(dic, @"smsContent");
    self.cipher = EncodeStringFromDic(dic, @"cipher");
    self.qrCodeUrl = EncodeStringFromDic(dic, @"qrCodeUrl");
    self.rewardRule = EncodeStringFromDic(dic, @"rewardRule");
    self.smsContent = [self cipwithoutchar];
 
}

-(NSString *)cipwithoutchar{
    NSArray *array = [self.smsContent componentsSeparatedByString:@"##"];
    if(array.count==3){
        return [NSString stringWithFormat:@"%@%@%@",[array objectAtIndex:0],[array objectAtIndex:1],[array objectAtIndex:2]];
    }
    return [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
}
@end


@implementation QueryRewardDTO

- (void)dealloc
{
    TT_RELEASE_SAFELY(_totalReward);
    TT_RELEASE_SAFELY(_cpaReward);
    TT_RELEASE_SAFELY(_cpsReward);
    
}


-(void)encodeFromDictionary:(NSDictionary *)dic{
    if (dic == nil) {
        return;
    }
    NSString *total = [self stringtofloat:EncodeStringFromDic(dic, @"totalReward")];//[NSString stringWithFormat:@"%.2f",[EncodeStringFromDic(dic, @"totalReward") floatValue]];
    self.totalReward = total;
    self.cpaReward =[self stringtofloat:EncodeStringFromDic(dic, @"cpaReward")];
    self.cpsReward = [self stringtofloat:EncodeStringFromDic(dic, @"cpsReward")];
    self.bfrLastCpaReward =[self stringtofloat:EncodeStringFromDic(dic, @"bfrLastCpaReward")];
    self.bfrLastCpsReward = [self stringtofloat:EncodeStringFromDic(dic, @"bfrLastCpsReward")];
    self.lastCpaReward =[self stringtofloat:EncodeStringFromDic(dic, @"lastCpaReward")];
    self.lastCpsReward = [self stringtofloat:EncodeStringFromDic(dic, @"lastCpsReward")];
    self.currCpaReward =[self stringtofloat:EncodeStringFromDic(dic, @"currCpaReward")];
    self.currCpsReward = [self stringtofloat:EncodeStringFromDic(dic, @"currCpsReward")];

    self.shareTitle = EncodeStringFromDic(dic, @"shareTitle");
    self.shareContent = EncodeStringFromDic(dic, @"shareContent");
}

-(NSString *)stringtofloat:(NSString *)string
{
    int total = [string floatValue]*100;
    float coun = total*10;
    coun/=1000;
    return [NSString stringWithFormat:@"%.2f",coun];
}
@end


@implementation GetRedPackEntryDTO

- (void)dealloc
{
    TT_RELEASE_SAFELY(_canGetRedPack);
    TT_RELEASE_SAFELY(_ticketRuleUrl);
    TT_RELEASE_SAFELY(_redPackRule);
}

-(void)encodeFromDictionary:(NSDictionary *)dic{
    if (dic == nil) {
        return;
    }
    
    self.canGetRedPack = EncodeStringFromDic(dic, @"canGetRedPack");
    self.ticketRuleUrl = EncodeStringFromDic(dic, @"ticketRuleUrl");
    self.redPackRule = EncodeStringFromDic(dic, @"redPackRule");

}

@end


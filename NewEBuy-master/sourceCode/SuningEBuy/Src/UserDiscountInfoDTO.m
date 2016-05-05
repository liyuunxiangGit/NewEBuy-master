//
//  UserDiscountInfoDTO.m
//  SuningEBuy
//
//  Created by shasha on 12-8-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "UserDiscountInfoDTO.h"

@implementation UserDiscountInfoDTO

@synthesize achievement = _achievement;
@synthesize coupon = _coupon;
@synthesize advance = _advance;
@synthesize advCard = _advCard;
@synthesize unReadMessage = _unReadMessage;
@synthesize achiveFlg = _achiveFlg;
@synthesize electFlg = _electFlg;
@synthesize advanceFlg = _advanceFlg;
@synthesize advCardFlg = _advCardFlg;
- (void)dealloc
{
    TT_RELEASE_SAFELY(_achievement);
    TT_RELEASE_SAFELY(_coupon);
    TT_RELEASE_SAFELY(_advance);
    TT_RELEASE_SAFELY(_advCard);
    TT_RELEASE_SAFELY(_unReadMessage);
    TT_RELEASE_SAFELY(_achiveFlg);
    TT_RELEASE_SAFELY(_electFlg);
    TT_RELEASE_SAFELY(_advanceFlg);
    TT_RELEASE_SAFELY(_advCardFlg);
}

- (void)encodeFromDictionary:(NSDictionary *)dic{


    if (IsNilOrNull(dic)) {
        
        return;
        
    }
    
    NSString *couponStr =  [dic objectForKey:@"snTeck"];
    NSString *achievementStr = [dic objectForKey:@"achive"];
    NSString *advanceStr = [dic objectForKey:@"advance"];
    NSString *advCardStr = [dic objectForKey:@"advCard"];
    

    if (NotNilAndNull(achievementStr)) {
        self.achievement =[NSString stringWithFormat:@"%.2f",[achievementStr floatValue]];
    }else{
        self.achievement = @"0.00";
    }
//    self.achievement = NotNilAndNull(achievementStr)?achievementStr:nil;
    self.coupon = NotNilAndNull(couponStr)?couponStr:nil;
    self.advance = NotNilAndNull(advanceStr)?advanceStr:nil;
    self.advCard = NotNilAndNull(advCardStr)?advCardStr:nil;

/*接口文档预留字段，暂未使用

    NSString *unReadMessageStr =  [dic objectForKey:@"unReadMessage"];
    NSString *achiveFlgStr = [dic objectForKey:@"achiveFlg"];
    NSString *electFlgStr = [dic objectForKey:@"electFlg"];
    NSString *advanceFlgStr = [dic objectForKey:@"advanceFlg"];
    NSString *advCardFlgStr = [dic objectForKey:@"advCardFlg"];
    
    if (NotNilAndNull(achiveFlgStr)&&![achiveFlgStr isEqualToString:@""]&&![achiveFlgStr isEqualToString:@"1"]) {
        
        self.achievement = NotNilAndNull(achievementStr)?achievementStr:nil;
 
    }
    
    if (NotNilAndNull(electFlgStr)&&![electFlgStr isEqualToString:@""]&&![electFlgStr isEqualToString:@"1"]) {
        
        self.coupon = NotNilAndNull(couponStr)?couponStr:nil;
    }
    
    if (NotNilAndNull(advanceFlgStr)&&![advanceFlgStr isEqualToString:@""]&&![advanceFlgStr isEqualToString:@"1"]) {
        
        self.advance = NotNilAndNull(advanceStr)?advanceStr:nil;
    }
    
    if (NotNilAndNull(advCardFlgStr)&&![advCardFlgStr isEqualToString:@""]&&![advCardFlgStr isEqualToString:@"1"]) {
        
        self.advCard = NotNilAndNull(advCardStr)?advCardStr:nil;
    }
    
    self.unReadMessage = NotNilAndNull(unReadMessageStr)?unReadMessageStr:nil;
*/

}
@end

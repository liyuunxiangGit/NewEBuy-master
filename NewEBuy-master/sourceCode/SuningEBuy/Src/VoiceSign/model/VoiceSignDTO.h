//
//  VoiceSignDTO.h
//  SuningEBuy
//
//  Created by leo on 14-4-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum{
    HaveSigned,             //已经签到
    PhysicalReward,         //实物奖励
    CloudReward,            //云券奖励
    NoReward,               //没有奖励
    SignIntegration               //云钻
}RewardType;
@interface VoiceSignDTO : NSObject
@property (nonatomic,strong) NSString *cloudnum;            //云券数量
@property (nonatomic,strong) NSString *rewardstring;            //中奖提示
@property (nonatomic,strong) NSString *duihuancode;             //兑换验证码
@property (nonatomic,strong) NSString *imgurl;                  //banner 跳转url
@property (nonatomic,strong) NSString *bannerurl;                  //banner url
@property (nonatomic,strong) NSString *shareContent;                //分享内容
@property (nonatomic,assign) RewardType rewardtype;
@property (nonatomic,strong) NSString *title;                  //页面标题
@property (nonatomic,strong) NSString *prizeTypeName;                //提示
@end

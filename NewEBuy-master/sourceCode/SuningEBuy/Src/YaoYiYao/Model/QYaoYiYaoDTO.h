//
//  QYaoYiYaoDTO.h
//  SuningEBuy
//
//  Created by XZoscar on 14-4-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    
    kQYaoYiYaoResultStateUnknown,
    
    kQYaoYiYaoResultStateNotBegin       = 1000,
    kQYaoYiYaoResultStateShakeReadyGo,
    kQYaoYiYaoResultStateShakingPrize,
    
    /*
     // 当前没有正在进行的活动
     // 去逛逛 ？
     */
    
    kQYaoYiYaoResultStateNoActive,
    /*
     // 云钻不够
     // (当前活动设置“消耗云钻数量”不为0时，且用户云钻账户小于可以
     // 参加抽奖的云钻数量时，提示用户云钻不足)
     // ->去签到
     */
    kQYaoYiYaoResultStateScoreNotEnough,
    
    /*
     // 活动次数限制，用户次数限制
     // (当用户的参与总次数大于后台设置的活动期间每个用户参数次数限制时;
     // 提示用户“您已超过了活动次数，请下次再参加。”;
     // 点击逛一逛按钮，进入客户端首页。)
     // ->去逛逛
     */
    kQYaoYiYaoResultStateActivityTimesLimited,
    
    /*
     // 未中奖
     // 1、当用户未中奖时，则调取后台的未中奖提示语字段，随机展示一条提示语，
     // 并且展示提升人品按钮（即分享按钮），用户点击后弹出分享给好友对话框，
     // 具体形式参考易购客户端商品详情页的分享功能；
     // 2、分享内容，获取后台“活动分享内容”
     // ->提升人品（即本地分享）
     */
    kQYaoYiYaoResultStateNotWining,
    
    /*
     // 摇得：可克隆云钻
     // 当用户摇到可克隆云钻时，展示摇到的云钻分值，并展示“克隆给朋友”的按钮；
     // 点击“克隆给朋友，跳转至该克隆云钻宝贝克隆页面”。
     // ->克隆给朋友（webView呈现相应可克隆云钻的二维码）
     */
    kQYaoYiYaoResultStateCanCloneScore,
    
    /*
     // 摇得：普通云钻
     // 当用户摇到普通云钻时，展示用户获得云钻“分值”
     // ->分享
     */
    kQYaoYiYaoResultStateWiningNormalScore,
    
    /*
     // 摇得：可克隆云券
     // 当用户摇到可克隆云钻时，展示摇到的云钻分值，并展示“克隆给朋友”的按钮；
     // 点击“克隆给朋友，跳转至该克隆云钻宝贝克隆页面”。
     // ->克隆给朋友（webView呈现相应可克隆云钻的二维码）
     */
    kQYaoYiYaoResultStateCanCloneCloudTicket,
    
    /*
     // 摇得：普通云券
     // 当用户摇到普通云钻时，展示用户获得云钻“分值”
     // ->分享
     */
    kQYaoYiYaoResultStateWiningNormalCloudTicket,
    
    //实物
    kQYaoYiYaoResultStateWiningPhyTicket
    
} kQYaoYiYaoResultStateType;


@interface QHttpObject : NSObject

@property (nonatomic,assign) E_CMDCODE  cmd;

@property (nonatomic,strong) NSString   *errCode,*errMsg;

@property (nonatomic,strong) NSString   *resultCode;
@property (nonatomic,strong) NSString   *resultDesc;

@end


@interface QYaoQueryDTO : QHttpObject

@property (nonatomic,strong) NSString   *activeId;
@property (nonatomic,strong) NSString   *activeRuleUrl;
@property (nonatomic,strong) NSString   *activeMsg;
@property (nonatomic,strong) NSString   *backgroundUrl;


@end


@interface QYaoChouJiangDTO : QHttpObject

@property (nonatomic,assign) kQYaoYiYaoResultStateType stateType;

@property (nonatomic,strong) NSString *prizeId;         // 中奖结果id,宝贝id
@property (nonatomic,strong) NSString *prizeValue;      // 云钻或云券 数字面值
@property (nonatomic,strong) NSString *shareContent;    // 当中 普通云钻或云券时，可分享的内容
@property (nonatomic,strong) NSString *cloneUrl;        // 克隆url,(使用webView load url)
@property (nonatomic,strong) NSString *isEntityPrize;   // 是否是实物奖励 “1”是

/*
 声波 相关字段
*/
@property (nonatomic,strong) NSString *prizeAdUrl;         // 广告位图片
@property (nonatomic,strong) NSString *prizePicUrl;        // 广告位跳转连接
@property (nonatomic,strong) NSString *serialNumber;       // 奖品号
@property (nonatomic,strong) NSString *mrakedwords;        // 中奖、未中奖提示
@property (nonatomic,strong) NSString *prizeType;          // 奖励类型
@property (nonatomic,strong) NSString *activename;         // 页面标题
@property (nonatomic,strong) NSString *prizeTypeName;      // 奖品名称
@property (nonatomic,strong) NSString *prizeName;           // 奖品名称
@property (nonatomic,strong) NSString *isShowNum;           // 是否展示兑换码 1展示 2不展示

@end

@interface QYaoCloneValidateDTO : QHttpObject

@property (nonatomic,strong) NSString *firstCloneMsg;   // cloneMsg

@end

@interface QYaoScoreParkItemDTO : QHttpObject

@property (nonatomic,strong) NSString *title;           //文字标题
@property (nonatomic,strong) NSString *entryPictureUrl; //入口图片url
@property (nonatomic,strong) NSString *pageContentUrl;  //对应页面内容url

@property (nonatomic,strong) NSString *numberId;        //序号 1-4为 功能区1，>4 为功能区2

@end

@interface QYaoScoreParkGrpDTO : NSObject

@property (nonatomic,assign) NSUInteger     grpType; // 1 function button,2 picture
@property (nonatomic,strong) NSString       *sortId;
@property (nonatomic,strong) NSString       *title;
@property (nonatomic,strong) NSMutableArray *items;

@end


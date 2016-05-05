//
//  QYaoYiYaoViewCtrler.h
//  YaoYiYao
//
//  Created by XZoscar on 14-4-1.
//  Copyright (c) 2014年 suning. All rights reserved.
//
//  摇易摇 页面

#import <UIKit/UIKit.h>

#import "CommonViewController.h"
#import "ChooseShareWayView.h"

#import "QYaoYiYaoDTO.h"


typedef enum {
    kQYaoViewCtrlerYaoYiYao = 0, // default,摇易摇抽奖
    kQYaoViewCtrlerShengBo       // 声波抽奖
    
}kQYaoViewCtrlerType;

// @protocol QYaoYiYaoViewCtrler
#pragma mark - @protocol QYaoYYSegmentDelegate

@protocol QYaoYYSegmentDelegate <NSObject>
- (void)delegate_selectedSegment:(NSUInteger)segmentTag;
@end

// @class QYaoYYSegment
#pragma mark - @interface QYaoYYSegment

@interface QYaoYYSegment : UIView

@property (nonatomic,strong) IBOutlet UIButton      *segment0,*segment1;
@property (nonatomic,strong) IBOutlet UIImageView   *animatedLine;
@property (nonatomic,weak)   id <QYaoYYSegmentDelegate> delegate;

+ (QYaoYYSegment *)segment;
- (IBAction)onClickedSegments:(UIButton *)sender;

@end



@class AVAudioPlayer;
@class SNShareKit;
@class RegistrationService,QYaoHttpService;

// @class QYaoYiYaoViewCtrler
#pragma mark - @interface QYaoYiYaoViewCtrler

@protocol QYaoYiYaoViewCtrlerDelegate <NSObject>
@optional
- (void)delegate_YaoYiYaoViewCtrler_loginSuccess;
@end


@interface QYaoYiYaoViewCtrler : CommonViewController <QYaoYYSegmentDelegate,
            ChooseShareWayViewDelegate,UIWebViewDelegate> {
    
    @private
    NSUInteger              __currQueueLedIndex;
                
    BOOL                    __bOnceShakeShakeing; // 一次摇动正在进行 default NO
    
    // http serve
    QYaoHttpService         *__yaoHttpServe;
    //RegistrationService     *__registHttpServe;
}

// assignment before push this controller
@property (nonatomic,assign) kQYaoViewCtrlerType   ctrlerType;
@property (nonatomic,strong) NSString              *activeTypeId; // default "1"(摇易摇)

//
@property (nonatomic,strong) QYaoQueryDTO           *activeQueryBean;
@property (nonatomic,strong) QYaoChouJiangDTO       *activeResultBean;

@property (nonatomic,weak) id<QYaoYiYaoViewCtrlerDelegate> delegate;

// ui
@property (nonatomic,strong) IBOutlet UIButton     *moreRuleButton;

// 1->QViewController_score.xib大促摇易摇xib模版(云钻摇易摇)
// 2->QViewController.xib默认的摇易摇xib模版 (大促摇易摇)
- (id)initXibWithType:(NSUInteger)xibType;

// 摇奖过程，限制用户交互使能
- (void)updateViewUserInteractionEnabled:(BOOL)bEnabled;

- (void)presentLoginViewCtrler;

// 展示查询活动结果
- (void)showQueryActiveResultDesc:(NSString *)description err:(NSString *)errCode;

// 展示摇奖结果
- (void)showShakePrizeResult:(kQYaoYiYaoResultStateType)type desc:(NSString *)description;

@end

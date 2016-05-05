//
//  SevenStarsBottomView.h
//  SuningLottery
//
//  Created by lyywhg on 13-4-7.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SevenStarsChooseView.h"
#import "ComputeLotteryNumber.h"

@protocol SevenStarsBottomViewDelegate;
@interface SevenStarsBottomView : UIView

@property (nonatomic, copy)       NSString           *finalResultStr;//最终选球结果字符串(含分割号，空格)
@property (nonatomic, assign)     NSInteger          mutipleTimes;//倍数
@property (nonatomic, assign)     NSInteger          leftMoney;  //再选择时所剩钱数2000元上线
@property (nonatomic, assign)     NSInteger           periods;   //期数
@property (nonatomic, strong)     UIButton           *resetButton;
@property (nonatomic, strong)     UIButton           *submitButton;
@property (nonatomic, strong)     UILabel            *shakeTips;
@property (nonatomic, strong)     UILabel            *totalCost;
@property (nonatomic, strong)     UIImageView        *backgroundImgView;
@property (nonatomic, strong)     id<SevenStarsBottomViewDelegate>   delegate;

/*  
 *  设置底部信息
 *  包含无数据时的初始信息
 *  参数：选球视图里的选球信息
 */
-(void)setBottomViewInfo:(NSMutableArray *) selectedNumber;
@end

@protocol SevenStarsBottomViewDelegate <NSObject>

//重置选球界面
-(void)resetSevenStarsBallChooseView;

//提交所选信息
-(void)submitSelection:(NSString *) selectionStr;

@end
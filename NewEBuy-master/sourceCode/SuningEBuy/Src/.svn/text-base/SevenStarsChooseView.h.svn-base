//
//  SevenStarsChooseView.h
//  SuningLottery
//
//  Created by lyywhg on 13-4-6.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BallSelectConstant.h"

#define kBallStartTag     100

@protocol SevenStarsChooseViewDelegate;
@interface SevenStarsChooseView : UIScrollView
{
    NSString                *selectedImageName_;    //已选球图片
    
    NSString                *unSelectedImageName_;  //未选球图片
    
    UIColor                 *selectedFontColor_;    //已选字体颜色
    
    UIColor                 *unSelectedFontColor_;  //已选字体颜色
    
    NSMutableArray          *chooseNumberArray_;    //选球所对应的号码（按先后顺序，未排序）
}
@property (nonatomic, assign)   NSInteger   lastSelectedBallTag;    //最后所选球的tag
@property (nonatomic, strong)   NSMutableArray   *chooseNumberArray;
@property (nonatomic, weak)   id<SevenStarsChooseViewDelegate>   sevenStarsdelegate;



/*
 布局整个界面
 */
-(void)setAllBallsView;

/*
 * 清空所有选球
 * 无参数
 */
-(void)resetAllBallsView;

-(void)setBallSheetWith:(NSString *) resultString;
@end

@protocol SevenStarsChooseViewDelegate <NSObject>

-(void)setBottomViewInfo;

-(BOOL)ballSelect:(int) index  ballType:(LotteryBallType) ballType;


-(BOOL)ballUnselect:(int) index ballType:(LotteryBallType) ballType;
@end

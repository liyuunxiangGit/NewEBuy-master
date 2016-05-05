//
//  LotteryFootView.h
//  SuningEBuy
//
//  Created by huangtf on 12-9-12.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComputeLotteryNumber.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"
#import "keyboardNumberPadReturnTextField.h"

@protocol LotteryFootViewDelegate; 


@interface LotteryFootView : UIView<UITextFieldDelegate>
{
    id<LotteryFootViewDelegate>__weak delegate;
    
    NSMutableAttributedString  *mutableString;


}

@property(nonatomic,strong) UIButton *leftButton;
@property(nonatomic,strong) UIButton *rightButton;

@property(nonatomic,strong) UIView   *commonView;
@property(nonatomic,strong) UITextField *multipleTextField;
@property(nonatomic,strong) UILabel  *desLbl;
@property(nonatomic,strong) UILabel  *moneyKeyLbl;
@property(nonatomic,strong) UILabel  *moneyValueLbl;


@property(nonatomic,strong) UIView   *toolInputView;
@property(nonatomic,strong) UIButton *hiddenBtn;

@property(nonatomic,strong) NSMutableArray  *lotteryList;
@property(nonatomic,assign) CGFloat  totalLottery;  //单倍总注数
@property(nonatomic,assign) CGFloat  multiNo;       //倍数
@property(nonatomic,assign) CGFloat  totalMoney;    //单倍总金额
@property(nonatomic,weak) id<LotteryFootViewDelegate>delegate;
@property(nonatomic,copy)   NSString *lotteryName;  //彩票名称

@property(nonatomic,assign) BOOL     isCurrentPage; //用于区别列表页面和支付页面文本输入框发出的不同的UIKeyboardWillShowNotification


@property(nonatomic,strong) OHAttributedLabel   *totalLotteryLbl;
@property(nonatomic,strong) OHAttributedLabel   *totalMoneyLbl;




- (id)initWithFrame:(CGRect)frame andLotteryList:(NSArray *)array 
     andLotteryName:(NSString *)gname 
         andMultiNo:(CGFloat)multiNo;

-(void)compute;

-(void)refreshViewWithList:(NSMutableArray *)list;

-(void)refreshView;

-(NSMutableAttributedString *)mutableString:(NSString *)firstString andSecondString:(NSString *)secString;


@end

@protocol LotteryFootViewDelegate <NSObject>

-(void)returnMultiNoAndTotalLottery:(CGFloat)userChooseMultiNo andTotalLottery:(CGFloat)totalLottery;

-(void)buttonPressWithIndex:(NSInteger)index;

@end
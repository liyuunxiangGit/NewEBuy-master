//
//  LotteryListFootView.m
//  SuningLottery
//
//  Created by yangbo on 4/9/13.
//  Copyright (c) 2013 suning. All rights reserved.
//

#import "LotteryListFootView.h"
#import <QuartzCore/QuartzCore.h>
#define LOTTERY_CHECK_VIEW_HEIGHT 40    //是否追号视图高度

#define LOTTERY_LIST_KEYBOARD_DONE_BTN_TAG  800  //键盘上DONE按钮的tag

@interface LotteryListFootView  ()
{
    UIView      *_bottomView;           //底部视图，显示清空、去付款按钮与期数、倍投和注数label

    UIView      *_middleView;           //显示追号和倍投TextField
    
    UIView      *_topView;              //显示手选和机选号码按钮
    
    UITextField *_periodsTextField;     //追号输入框
    
    UITextField *_multipleTextFiled;    //倍投输入框
    
    UILabel     *_moneyLabel;           //显示投注倍数 追号期数 金额label
    
    UIButton    *_checkBtn;
    
    int         _bets;                  //注数
    
    CGRect      _rect;                  //self的frame
    
    UIButton    *_hiddenKeyboardBtn;
}

@end

@implementation LotteryListFootView
@synthesize multiple = _multiple;
@synthesize periods = _periods;
@synthesize isPeriodStopWhenWin = _isPeriodStopWhenWin;
@synthesize delegate = _delegate;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_bottomView);
    TT_RELEASE_SAFELY(_middleView);
    TT_RELEASE_SAFELY(_topView);
    TT_RELEASE_SAFELY(_periodsTextField);
    TT_RELEASE_SAFELY(_multipleTextFiled);
    TT_RELEASE_SAFELY(_moneyLabel);
    TT_RELEASE_SAFELY(_checkBtn);
    
    if(_hiddenKeyboardBtn.superview)
        [_hiddenKeyboardBtn removeFromSuperview];
    
    TT_RELEASE_SAFELY(_hiddenKeyboardBtn);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (id)initWithYOrigin:(float)originY{
    if(self = [super initWithFrame:CGRectMake(0, originY, LOTTERY_LIST_FOOT_VIEW_WIDTH, LOTTERY_LIST_FOOT_VIEW_HEIGHT)])
    {
        self.backgroundColor = [UIColor clearColor];
        
        _multiple = 1;
        
        _periods = 1;
        
        _isPeriodStopWhenWin = NO;
        
        _rect = self.frame;
        
        [self addTopView];
        
        [self addMiddleView];
        
        [self addBottomView];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardDidShow:)
                                                     name:UIKeyboardDidShowNotification
                                                   object:nil];
      
            
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
      
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        
    }
    return self;
}

#pragma mark Responding to keyboard events
- (void)keyboardDidShow:(NSNotification *)notification
{
    if(![_periodsTextField isFirstResponder] && ![_multipleTextFiled isFirstResponder])
    {
        return;
    }
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2)
    {
        [self addDoneBtnToKeyboard];
    }
}

- (void)keyboardWillShow:(NSNotification *)notification {
    
    if(![_periodsTextField isFirstResponder] && ![_multipleTextFiled isFirstResponder])
    {
        return;
    }
    
    _rect = self.frame;
    
    NSDictionary *userInfo = [notification userInfo];
    
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [self bringSubviewToFront:_middleView];
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    CGRect bRect = self.frame;
    bRect.origin.y -= keyboardRect.size.height - LOTTERY_LIST_FOOT_TOPVIEW_HEIGHT;
    self.frame = bRect;
    
    _middleView.frame = CGRectMake(0, 0, LOTTERY_LIST_FOOT_VIEW_WIDTH, LOTTERY_LIST_FOOT_MIDDLEVIEW_HEIGHT+LOTTERY_CHECK_VIEW_HEIGHT);
    
    [UIView commitAnimations];
    
    if(_hiddenKeyboardBtn == nil)
    {
        _hiddenKeyboardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _hiddenKeyboardBtn.frame = [[UIScreen mainScreen] bounds];
        _hiddenKeyboardBtn.backgroundColor = [UIColor clearColor];
        [_hiddenKeyboardBtn addTarget:self action:@selector(doneBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.superview addSubview:_hiddenKeyboardBtn];
    [self.superview bringSubviewToFront:self];
}
- (void)keyboardWillHide:(NSNotification *)notification {
    
    if(![_periodsTextField isFirstResponder] && ![_multipleTextFiled isFirstResponder])
    {
        return;
    }
    
    NSDictionary* userInfo = [notification userInfo];
  
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
        
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [self bringSubviewToFront:_bottomView];
    self.frame = _rect;
    _middleView.frame = CGRectMake(0, LOTTERY_LIST_FOOT_TOPVIEW_HEIGHT, LOTTERY_LIST_FOOT_VIEW_WIDTH, LOTTERY_LIST_FOOT_MIDDLEVIEW_HEIGHT+LOTTERY_CHECK_VIEW_HEIGHT);
    [UIView commitAnimations];
    
    [_hiddenKeyboardBtn removeFromSuperview];
}

- (void)addDoneBtnToKeyboard
{
    UIView   *keyboard = nil;
    
    if([[[UIApplication sharedApplication] windows] count] < 2)
        return;
    
    UIWindow* keyboardWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    
    for(int i=0; i<[keyboardWindow.subviews count]; i++) {
        
        UIView* view = [keyboardWindow.subviews objectAtIndex:i];
        
        if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2 &&
             [[view description] hasPrefix:@"<UIPeripheralHost"] == YES) ||
            [[view description] hasPrefix:@"<UIKeyboard"] == YES) {
            
            keyboard = view;
            break;
        }
    }
    
    //添加down按钮
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(0, 163, 106, 53);
    doneButton.adjustsImageWhenHighlighted = NO;
    doneButton.tag = LOTTERY_LIST_KEYBOARD_DONE_BTN_TAG;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.0) {
        [doneButton setImage:[UIImage imageNamed:@"DoneUp3.png"] forState:UIControlStateNormal];
        [doneButton setImage:[UIImage imageNamed:@"DoneDown3.png"] forState:UIControlStateHighlighted];
    } else {
        [doneButton setImage:[UIImage imageNamed:@"DoneUp.png"] forState:UIControlStateNormal];
        [doneButton setImage:[UIImage imageNamed:@"DoneDown.png"] forState:UIControlStateHighlighted];
    }
    [doneButton addTarget:self action:@selector(doneBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [keyboard addSubview:doneButton];
}

- (void)doneBtnPressed:(id)sender
{
    if([_multipleTextFiled isFirstResponder])
    {
        [_multipleTextFiled resignFirstResponder];
        
    }else if([_periodsTextField isFirstResponder])
    {
        [_periodsTextField resignFirstResponder];
    }

}

- (void)addTopView
{
    if(_topView == nil)
    {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LOTTERY_LIST_FOOT_VIEW_WIDTH, LOTTERY_LIST_FOOT_TOPVIEW_HEIGHT)];
        _topView.backgroundColor = [UIColor clearColor];
        [self addSubview:_topView];
        
        UIButton *addNumberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addNumberBtn.frame = CGRectMake(20, 20, 120, 36);
        [addNumberBtn setBackgroundImage:[UIImage imageNamed:@"button_orange_normal"] forState:UIControlStateNormal];
        addNumberBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        [addNumberBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addNumberBtn setTitle:L(@"LOAddNumberOfContestent") forState:UIControlStateNormal];
        [addNumberBtn addTarget:self action:@selector(addNumberBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:addNumberBtn];
        
        UIButton *addRandomNumberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addRandomNumberBtn.frame = CGRectMake(LOTTERY_LIST_FOOT_VIEW_WIDTH - 20 - 120, 20, 120, 36);
        [addRandomNumberBtn setBackgroundImage:[UIImage imageNamed:@"button_orange_normal"] forState:UIControlStateNormal];
        addRandomNumberBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        [addRandomNumberBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addRandomNumberBtn setTitle:L(@"LOAddOneMachineLottery") forState:UIControlStateNormal];
        [addRandomNumberBtn addTarget:self action:@selector(randomNumberBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:addRandomNumberBtn];
    }
}

- (void)addMiddleView
{
    if(_middleView == nil)
    {
        _middleView = [[UIView alloc] initWithFrame:CGRectMake(0, LOTTERY_LIST_FOOT_TOPVIEW_HEIGHT, LOTTERY_LIST_FOOT_VIEW_WIDTH, LOTTERY_LIST_FOOT_MIDDLEVIEW_HEIGHT + LOTTERY_CHECK_VIEW_HEIGHT)];
        _middleView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:_middleView];
        
//        UIImageView *addPeriodsImageView = [[UIImageView alloc]init];
//        
//        addPeriodsImageView.frame = CGRectMake(0, 0, LOTTERY_LIST_FOOT_VIEW_WIDTH, LOTTERY_LIST_FOOT_MIDDLEVIEW_HEIGHT);
//        
//        addPeriodsImageView.image = [UIImage imageNamed:@"LotteryList_addPeriods.png"];
        
       // [_middleView addSubview:addPeriodsImageView];
    
     //   TT_RELEASE_SAFELY(addPeriodsImageView);
        
//        UIImageView *stopAddPeriodsImageView = [[UIImageView alloc]init];
//        
//        stopAddPeriodsImageView.frame = CGRectMake(0,  LOTTERY_LIST_FOOT_MIDDLEVIEW_HEIGHT, LOTTERY_LIST_FOOT_VIEW_WIDTH, LOTTERY_CHECK_VIEW_HEIGHT);
//        
//        stopAddPeriodsImageView.image = [UIImage imageNamed:@"LotteryList_stopAddPeriods.png"];
//        
       // [_middleView addSubview:stopAddPeriodsImageView];
        
     //   TT_RELEASE_SAFELY(stopAddPeriodsImageView);

        
        float labelOffsetX = 20;
        
        //追号label
        UILabel *periodLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelOffsetX, 0, (LOTTERY_LIST_FOOT_VIEW_WIDTH - labelOffsetX*2)/2, LOTTERY_LIST_FOOT_MIDDLEVIEW_HEIGHT)];
        periodLabel.backgroundColor = [UIColor clearColor];
        periodLabel.text = L(@"LOzhuiqi");
        [_middleView addSubview:periodLabel];
        
        float textFieldHeight = 21;
        float textFieldOffsetX = 40;
        
        _periodsTextField = [[UITextField alloc] initWithFrame:CGRectMake(textFieldOffsetX, (LOTTERY_LIST_FOOT_MIDDLEVIEW_HEIGHT - textFieldHeight)/2, (LOTTERY_LIST_FOOT_VIEW_WIDTH/2 -textFieldOffsetX*2), textFieldHeight)];
        _periodsTextField.textAlignment = UITextAlignmentCenter;
        _periodsTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _periodsTextField.delegate = self;
        _periodsTextField.keyboardType = UIKeyboardTypeNumberPad;
        _periodsTextField.borderStyle = UITextBorderStyleNone;
        _periodsTextField.textColor = [UIColor blackColor];
        _periodsTextField.layer.borderWidth = 1;
        _periodsTextField.layer.borderColor = RGBCOLOR(236, 236, 236).CGColor;
        //_periodsTextField.background = [UIImage  imageNamed:@"LotteryList_addPeriods_input.png"];
        [_middleView addSubview:_periodsTextField];
        
        //倍投label
        UILabel *multipleLabel = [[UILabel alloc] initWithFrame:CGRectMake(LOTTERY_LIST_FOOT_VIEW_WIDTH/2+labelOffsetX, 0, (LOTTERY_LIST_FOOT_VIEW_WIDTH - labelOffsetX*2)/2, LOTTERY_LIST_FOOT_MIDDLEVIEW_HEIGHT)];
        multipleLabel.backgroundColor = [UIColor clearColor];
        multipleLabel.text = L(@"LOtoubei");
        [_middleView addSubview:multipleLabel];
        
        _multipleTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(LOTTERY_LIST_FOOT_VIEW_WIDTH/2+textFieldOffsetX, (LOTTERY_LIST_FOOT_MIDDLEVIEW_HEIGHT - textFieldHeight)/2, (LOTTERY_LIST_FOOT_VIEW_WIDTH/2 -textFieldOffsetX*2), 21)];
        _multipleTextFiled.textAlignment = UITextAlignmentCenter;
        _multipleTextFiled.delegate = self;
        _multipleTextFiled.borderStyle = UITextBorderStyleNone;
        _multipleTextFiled.keyboardType = UIKeyboardTypeNumberPad;
        _multipleTextFiled.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _multipleTextFiled.textColor = [UIColor blackColor];
        _multipleTextFiled.layer.borderWidth = 1;
        _multipleTextFiled.layer.borderColor = RGBCOLOR(236, 236, 236).CGColor;
        //_multipleTextFiled.background = [UIImage  imageNamed:@"LotteryList_addPeriods_input.png"];
        [_middleView addSubview:_multipleTextFiled];
        
        _checkBtn = [UIButton buttonWithType: UIButtonTypeCustom];
        _checkBtn.frame = CGRectMake(20, 10+LOTTERY_LIST_FOOT_MIDDLEVIEW_HEIGHT, 20, 20);
        if(_isPeriodStopWhenWin)
        {
            _checkBtn.selected = YES;
            
            [_checkBtn setBackgroundImage:[UIImage imageNamed:@"singleCheck_selected"] forState:UIControlStateNormal];
        }
        else
        {
            [_checkBtn setBackgroundImage:[UIImage imageNamed:@"singleCheck_unselect"] forState:UIControlStateNormal];

        }

        [_checkBtn addTarget:self action:@selector(checkButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_middleView addSubview:_checkBtn];
        
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 10+LOTTERY_LIST_FOOT_MIDDLEVIEW_HEIGHT, LOTTERY_LIST_FOOT_VIEW_WIDTH-50*2, 20)];
        tipLabel.backgroundColor = [UIColor clearColor];
        tipLabel.font = [UIFont systemFontOfSize:14];
        tipLabel.text = L(@"LOStopAfterWin");
        [_middleView addSubview:tipLabel];
    }
}

- (void)addBottomView
{
    if(_bottomView == nil)
    {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, LOTTERY_LIST_FOOT_TOPVIEW_HEIGHT+LOTTERY_LIST_FOOT_MIDDLEVIEW_HEIGHT, LOTTERY_LIST_FOOT_VIEW_WIDTH, LOTTERY_LIST_FOOT_BOTTOMVIEW_HEIGHT)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bottomView];
        
        //bg
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ball_select_bottom.png"]];
//        imageView.frame = [_bottomView bounds];
//        [_bottomView addSubview:imageView];
        
        //清除号码按钮
        UIButton *clearBtn = [[UIButton alloc] init];
        [clearBtn addTarget:self action:@selector(clearBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
       // [clearBtn setBackgroundImage:[UIImage imageNamed:@"clean.png"] forState:UIControlStateNormal];
        [clearBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [clearBtn setTitleColor:[UIColor darkGrownColor] forState:UIControlStateNormal];
        [clearBtn setTitle:L(@"Clear") forState:UIControlStateNormal];
        clearBtn.backgroundColor = [UIColor uiviewBackGroundColor];
        clearBtn.frame = CGRectMake(10, 5, 45, 30);
        [_bottomView addSubview:clearBtn];
        
        //确定按钮
        UIButton *doneButton = [[UIButton alloc] init];
        [doneButton addTarget:self action:@selector(gotoPaybtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [doneButton setBackgroundImage:[UIImage imageNamed:@"submit_button_normal"] forState:UIControlStateNormal];
        [doneButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [doneButton setTitle:L(@"Go to pay") forState:UIControlStateNormal];
        //doneButton.backgroundColor = [UIColor uiviewBackGroundColor];
        doneButton.frame = CGRectMake([self bounds].size.width-10-60, 5, 60, 30);
        [_bottomView addSubview:doneButton];
        
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(clearBtn.frame), 0, (LOTTERY_LIST_FOOT_VIEW_WIDTH - CGRectGetMaxX(clearBtn.frame)*2), LOTTERY_LIST_FOOT_BOTTOMVIEW_HEIGHT)];
        _moneyLabel.backgroundColor = [UIColor clearColor];
        _moneyLabel.textColor = [UIColor darkGrownColor];
        _moneyLabel.font = [UIFont systemFontOfSize:14.0f];
        _moneyLabel.textAlignment = UITextAlignmentCenter;
        [_bottomView addSubview:_moneyLabel];
    }
}

//手选按钮事件
- (void)addNumberBtnPressed:(id)sender
{
    [_delegate addNewNumber];
}

//机选按钮事件
- (void)randomNumberBtnPressed:(id)sender
{
    [_delegate addRandomNumber];
}

//是否中奖后停止追号按钮
- (void)checkButtonPressed:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    _isPeriodStopWhenWin = !_isPeriodStopWhenWin;
    if(_isPeriodStopWhenWin)
    {
        _checkBtn.selected = YES;
        
        [_checkBtn setBackgroundImage:[UIImage imageNamed:@"singleCheck_selected"] forState:UIControlStateNormal];
    }
    else
    {
        [_checkBtn setBackgroundImage:[UIImage imageNamed:@"singleCheck_unselect"] forState:UIControlStateNormal];
        
    }
    
    [_delegate isStopBuyWhenWin:_isPeriodStopWhenWin];
}

//清空号码 
- (void)clearBtnPressed:(id)sender
{
    [_delegate clearAllNumbers];
    
//    _bets = 0;
    
    [self updateWithMultiple:_multiple bets:_bets periods:_periods isBuyWhenWin:YES];
}

//去付款按钮
- (void)gotoPaybtnPressed:(id)sender
{
    [_delegate gotoPayForLottery];
}

- (void)updateWithMultiple:(int)multiple bets:(int)bet periods:(int)periods isBuyWhenWin:(BOOL)yesOrNo
{
    _multiple = multiple;
    
    _bets = bet;
    
    _periods = periods;
    
    _isPeriodStopWhenWin = yesOrNo;
    
    _multipleTextFiled.text = [NSString stringWithFormat:@"%d",_multiple];
    
    _periodsTextField.text = [NSString stringWithFormat:@"%d",_periods];
    
    _checkBtn.selected = _isPeriodStopWhenWin;
    
    _moneyLabel.text = [NSString stringWithFormat:L(@"LOCalculateFormula2"), _bets, _multiple, _periods, _bets*_multiple*_periods * 2];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *str = textField.text;
    
    NSString *multiNoString = nil;
    
    if (range.length > 0 && [string isEqualToString:@""])   //删除字符串
    {
        multiNoString = [[str substringToIndex:range.location] stringByAppendingString:[str substringFromIndex:range.location + range.length]];
        
    }else{      //添加字符串
        
        multiNoString = [[[str substringToIndex:range.location] stringByAppendingString:string] stringByAppendingString:[str substringFromIndex:range.location + range.length]];
    }
    
    int number = 0;
    
    if (![multiNoString isEqualToString:@""]) {
        
        number = [multiNoString integerValue];
        
    }
    
    if (number == 0) {
        return YES;
    }
    
    //追号label
    if(textField == _periodsTextField)
    {
        
        if([_delegate isMoneyOverFlowWithMultiple:_multiple andPeriods:(number > 13 ? 13 : number)])
        {
                        
            
//            AlertMessageView *alert = [[AlertMessageView alloc] init];
//            
//            [alert alertMessage:L(@"The single orders bets up to 2000 yuan")];
//            
//            [alert release];
            
            return NO;
        }
        
        //输入的号码大于13 强制设成13
        if(number > 13)
        {
            _periods = 13;
            
            _periodsTextField.text = @"13";
            
            _moneyLabel.text = [NSString stringWithFormat:L(@"LOCalculateFormula2"), _bets, _multiple, _periods, _bets*_multiple*_periods * 2];
            
            [_delegate changeLotteryPeriods:_periods];
            
            return NO;
        }
        
        _periods = number;
        
        _moneyLabel.text = [NSString stringWithFormat:L(@"LOCalculateFormula2"), _bets, _multiple, _periods, _bets*_multiple*_periods * 2];
        
        [_delegate changeLotteryPeriods:_periods];
    }else{
        if([_delegate isMoneyOverFlowWithMultiple:(number > 99 ? 99 : number) andPeriods:_periods])
        {
            
//            AlertMessageView *alert = [[AlertMessageView alloc] init];
//            
//            [alert alertMessage:L(@"The single orders bets up to 2000 yuan")];
//            
//            [alert release];
            
            return NO;
        }
        
        //输入的号码大于99 强制设成99
        if(number > 99)
        {
            _multiple = 99;
            
            _multipleTextFiled.text = @"99";
            
            _moneyLabel.text = [NSString stringWithFormat:L(@"LOCalculateFormula2"), _bets, _multiple, _periods, _bets*_multiple*_periods * 2];
            
            [_delegate changeLotteryMultiple:_multiple];
            
            return NO;
        }
        
        _multiple = number;
        
        _moneyLabel.text = [NSString stringWithFormat:L(@"LOCalculateFormula2"), _bets, _multiple, _periods, _bets*_multiple*_periods * 2];
        
        [_delegate changeLotteryMultiple:_multiple];
    }
    
    return YES;

}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.text length] == 0 || [textField.text integerValue] == 0) {
        if(textField == _periodsTextField)
        {
            [self updateWithMultiple:_multiple bets:_bets periods:1 isBuyWhenWin:_isPeriodStopWhenWin];
            
            [_delegate changeLotteryPeriods:_periods];
        }else if(textField == _multipleTextFiled)
        {
            [self updateWithMultiple:1 bets:_bets periods:_periods isBuyWhenWin:_isPeriodStopWhenWin];
            
            [_delegate changeLotteryMultiple:_multiple];
        }
    }
}

@end

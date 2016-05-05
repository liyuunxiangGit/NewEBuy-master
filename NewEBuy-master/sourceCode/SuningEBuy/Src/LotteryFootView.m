//
//  LotteryFootView.m
//  SuningEBuy
//
//  Created by huangtf on 12-9-12.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "LotteryFootView.h"

#define kLeftButtonNomalImage       @"lottery_left_button.png"
#define kLeftButtonHightlightImage  @"lottery_left_button.png"

#define kRightButtonNomalImage      @"lottery_right_button.png"
#define kRightButtonHightlightImage @"lottery_right_button.png"

#define TOOL_INPUT_VIEW_HEIGHT 244

@implementation LotteryFootView

@synthesize leftButton = _leftButton;
@synthesize rightButton = _rightButton;
@synthesize commonView = _commonView;
@synthesize multipleTextField = _multipleTextField;
@synthesize desLbl = _desLbl;
@synthesize moneyKeyLbl = _moneyKeyLbl;
@synthesize moneyValueLbl = _moneyValueLbl;

@synthesize toolInputView = _toolInputView;
@synthesize hiddenBtn = _hiddenBtn;
@synthesize totalLottery = _totalLottery;
@synthesize lotteryList = _lotteryList;
@synthesize multiNo = _multiNo;
@synthesize totalMoney = totalMoney;
@synthesize isCurrentPage = _isCurrentPage;
@synthesize lotteryName = _lotteryName;
@synthesize delegate;

@synthesize totalLotteryLbl = _totalLotteryLbl;
@synthesize totalMoneyLbl = _totalMoneyLbl;


- (id)initWithFrame:(CGRect)frame andLotteryList:(NSArray *)array 
     andLotteryName:(NSString *)gname
         andMultiNo:(CGFloat)multiNo
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.totalLottery = 0;
        
        self.multiNo = multiNo;
        
        self.lotteryList = [NSMutableArray arrayWithArray:array];
        
        self.lotteryName = gname;
        
        [self compute];
        
        [self addSubview:self.leftButton];
        
        [self addSubview:self.rightButton];
        
        [self addSubview:self.commonView];
        
       
    }
    
    return self;
}

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_leftButton);
    TT_RELEASE_SAFELY(_rightButton);
    TT_RELEASE_SAFELY(_multipleTextField);
    TT_RELEASE_SAFELY(_desLbl);
    TT_RELEASE_SAFELY(_moneyKeyLbl);
    TT_RELEASE_SAFELY(_moneyValueLbl);
    TT_RELEASE_SAFELY(_toolInputView);
    TT_RELEASE_SAFELY(_hiddenBtn);
    TT_RELEASE_SAFELY(_lotteryList);
    TT_RELEASE_SAFELY(_commonView);
    TT_RELEASE_SAFELY(_lotteryName);
    TT_RELEASE_SAFELY(_totalLotteryLbl);
    TT_RELEASE_SAFELY(_totalMoneyLbl);
    TT_RELEASE_SAFELY(mutableString);
    TT_RELEASE_SAFELY(_lotteryName);
    
}


-(void)refreshViewWithList:(NSMutableArray *)list{
    
    self.lotteryList = list;
    
    //gxt modfy
    [self refreshView];
    
}

-(void)refreshView{
    
    [self compute];
    
    NSString *tempString1 = [NSString stringWithFormat:@"%0.f%@",self.totalLottery*self.multiNo,L(@"Note")];
    
    NSString *tempString2 = [NSString stringWithFormat:@"%0.f%@",self.totalLottery*self.multiNo*2,L(@"Constant_RMB")];
    
    self.totalLotteryLbl.attributedText = [self mutableString:L(@"LONoteNumber") andSecondString:tempString1];
    
    self.totalMoneyLbl.attributedText = [self mutableString:L(@"LOCount") andSecondString:tempString2];
    
    if ([delegate conformsToProtocol:@protocol(LotteryFootViewDelegate)]) {
        
        if ([delegate respondsToSelector:@selector(returnMultiNoAndTotalLottery:andTotalLottery:)]) {
            
            [delegate returnMultiNoAndTotalLottery:self.multiNo andTotalLottery:self.totalLottery*self.multiNo];
        }
    }
    
}

-(NSMutableAttributedString *)mutableString:(NSString *)firstString andSecondString:(NSString *)secString{
    
    NSString *totalString = [NSString stringWithFormat:@"%@%@",firstString,secString];
    
    if (mutableString) {
        
        TT_RELEASE_SAFELY(mutableString);
    }
    
    mutableString = [[NSMutableAttributedString alloc]initWithString:totalString];
    
    [mutableString setFont:[UIFont systemFontOfSize:14.0]];
    
    [mutableString setTextColor:[UIColor darkRedColor]];
    
    [mutableString setTextColor: RGBCOLOR(102.0, 51.0, 51.0) range:[totalString rangeOfString:firstString]];
    
    return mutableString;
}



-(UIButton *)leftButton{
    
    if (_leftButton == nil) {
        
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _leftButton.frame = CGRectMake(36, 15, 124, 41);
        
        [_leftButton setTitle:@"" forState:UIControlStateNormal];
        
        [_leftButton setBackgroundImage:[UIImage imageNamed:kLeftButtonHightlightImage] forState:UIControlStateNormal];
        
        [_leftButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _leftButton;
}

-(UIButton *)rightButton{
    
    if (_rightButton == nil) {
        
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _rightButton.frame = CGRectMake(160, 15, 124, 41);
        
        [_rightButton setTitle:@"" forState:UIControlStateNormal];
        
        [_rightButton setBackgroundImage:[UIImage imageNamed:kRightButtonNomalImage] forState:UIControlStateNormal];
        
        [_rightButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _rightButton;
}

#pragma mark - commonView
-(UIView *)commonView{
    
    if (_commonView == nil) {
        
        _commonView = [[UIView alloc]initWithFrame:CGRectMake(0, self.rightButton.bottom+13, 320, 40)];
        
        _commonView.backgroundColor = [UIColor clearColor];
        
        _commonView.tag = 10;
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
        
        imageView.image = [UIImage imageNamed:@"lottery_bottom_image.png"];
        
        [_commonView addSubview:imageView];
        
        TT_RELEASE_SAFELY(imageView);
        
        [_commonView addSubview:self.multipleTextField];
        
        [_commonView addSubview:self.desLbl];
        
        [_commonView addSubview:self.totalLotteryLbl];
        
        [_commonView addSubview:self.totalMoneyLbl];
        
        [self refreshViewWithList:self.lotteryList];
    }
    
    return _commonView;
}

-(UITextField *)multipleTextField{
    
    if (_multipleTextField == nil) {
        
        _multipleTextField = [[keyboardNumberPadReturnTextField alloc]initWithFrame:CGRectMake(10,6,60,25)];
        
        _multipleTextField.text = [NSString stringWithFormat:@"%0.f",self.multiNo];
        
        _multipleTextField.backgroundColor = [UIColor whiteColor];
        
        _multipleTextField.keyboardType = UIKeyboardTypeNumberPad;
        
        _multipleTextField.delegate = self;
                
        _multipleTextField.layer.cornerRadius = 5.0;
        
        _multipleTextField.adjustsFontSizeToFitWidth = YES;
        
        _multipleTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
    }
    
    return _multipleTextField;
}

-(UILabel *)desLbl{
    
    if (_desLbl == nil) {
        
        _desLbl = [[UILabel alloc]init];
        
        _desLbl.text = L(@"LOMagnify");
        
        CGSize size = [_desLbl.text sizeWithFont:[UIFont boldSystemFontOfSize:14.0] constrainedToSize:CGSizeMake(315, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
        
        _desLbl.frame = CGRectMake(self.multipleTextField.right+2,0, size.width, 40);
        
        _desLbl.backgroundColor = [UIColor clearColor];
        
        _desLbl.font = [UIFont boldSystemFontOfSize:14.0];
        
        _desLbl.textColor = RGBCOLOR(102.0, 51.0, 51.0);
        
    }
    
    return _desLbl;
}


- (OHAttributedLabel *)totalLotteryLbl
{
    if (!_totalLotteryLbl)
    {
        _totalLotteryLbl = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(self.desLbl.right+22, 11, 100, 20)];
        
        _totalLotteryLbl.backgroundColor = [UIColor clearColor];
        
        _totalLotteryLbl.numberOfLines = 1;
        
        _totalLotteryLbl.textAlignment = UITextAlignmentCenter;
        
    }
    
    return _totalLotteryLbl;
}


- (OHAttributedLabel *)totalMoneyLbl
{
    if (!_totalMoneyLbl)
    {
        _totalMoneyLbl = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(self.totalLotteryLbl.right+11, 11, 100, 20)];
        
        _totalMoneyLbl.backgroundColor = [UIColor clearColor];
        
        _totalMoneyLbl.numberOfLines = 1;
        
        _totalMoneyLbl.textAlignment = UITextAlignmentCenter;
        
    }
    
    return _totalMoneyLbl;
}


-(UILabel *)moneyKeyLbl{
    
    if (_moneyKeyLbl == nil) {
        
        _moneyKeyLbl = [[UILabel alloc]initWithFrame:CGRectMake(self.desLbl.right+10,0,50,40)];
        
        _moneyKeyLbl.text = L(@"LOCount");
        
        _moneyKeyLbl.backgroundColor = [UIColor clearColor];
        
        _moneyKeyLbl.font = [UIFont systemFontOfSize:14.0];
        
        _moneyKeyLbl.textAlignment = UITextAlignmentLeft;
        
        _moneyKeyLbl.textColor = [UIColor darkRedColor];
        
    }
    
    return _moneyKeyLbl;
}

-(UILabel *)moneyValueLbl{
    
    if (_moneyValueLbl == nil) {
        
        _moneyValueLbl = [[UILabel alloc]initWithFrame:CGRectMake(self.moneyKeyLbl.right,0, 80, 40)];
        
        _moneyValueLbl.text = [NSString stringWithFormat:@"%0.f%@",self.totalMoney*self.multiNo,L(@"Money Unit")];
        
        _moneyValueLbl.backgroundColor = [UIColor clearColor];
        
        _moneyValueLbl.font = [UIFont systemFontOfSize:14.0];
        
        _moneyValueLbl.textAlignment = UITextAlignmentLeft;
        
        _moneyValueLbl.textColor = [UIColor redColor];
        
    }
    
    return _moneyValueLbl;
}


-(UIView *)toolInputView{
    
    if (_toolInputView == nil) {
        
        _toolInputView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,TOOL_INPUT_VIEW_HEIGHT)];
        
        _toolInputView.backgroundColor = [UIColor clearColor];
        
        [_toolInputView addSubview:self.hiddenBtn];
        
    }
    
    return _toolInputView;
}

-(UIButton *)hiddenBtn{
    
    if (_hiddenBtn == nil) {
        
        _hiddenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _hiddenBtn.frame = CGRectMake(0, 0,320, TOOL_INPUT_VIEW_HEIGHT-40);
        
        [_hiddenBtn addTarget:self action:@selector(hiddenKeyBoard) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _hiddenBtn;
}

#pragma mark -给键盘最左下角添加一个done按钮


-(void)doneButton{
    
    [self.multipleTextField resignFirstResponder];
    
    self.multipleTextField.text = [NSString stringWithFormat:@"%0.f",self.multiNo];    //去掉用户输入的无效数字0
    
    [self.commonView removeFromSuperview];
    
    self.commonView.frame = CGRectMake(0, self.rightButton.bottom+13, 320, 40);
    
    [self addSubview:self.commonView];
    
    if ([delegate conformsToProtocol:@protocol(LotteryFootViewDelegate)]) {
        
        if ([delegate respondsToSelector:@selector(returnMultiNoAndTotalLottery:andTotalLottery:)]) {
            
            [delegate returnMultiNoAndTotalLottery:self.multiNo andTotalLottery:self.totalLottery*self.multiNo];
        }
    }
    
}



#pragma mark - action

-(void)buttonPress:(id)sender{
    
    if ([sender isKindOfClass:[UIButton class]]) {
        
        UIButton * button= (UIButton *)sender;
        
        NSInteger tag = 1;
        
        if (button == self.leftButton) {
            
            tag = 0;
        }
        
        if ([delegate conformsToProtocol:@protocol(LotteryFootViewDelegate)]) {
            
            if ([delegate respondsToSelector:@selector(buttonPressWithIndex:)]) {
                
                [delegate buttonPressWithIndex:tag];
            }
        }
    }
    
}

-(void)hiddenKeyBoard{
    
    [self doneButton];
}


-(void)compute{
    
    self.totalLottery = 0;
    
    for (NSString *string in self.lotteryList) {
        
        double temp = 0;
        
        if ([self.lotteryName isEqualToString:L(@"ecolorBall")]) {
            
            temp  = [ComputeLotteryNumber computeLotterySSQNumber:string];
            
        }else if([self.lotteryName isEqualToString:L(@"eBigLottery")]){
            
            temp = [ComputeLotteryNumber computeLotteryDLTNumber:string];
        }
        
        self.totalLottery = self.totalLottery+temp;
    }
    
    self.totalMoney = self.totalLottery*2;
    
}

#pragma mark - UITextFieldDelegate

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *str = textField.text;
    
    NSString *multiNoString = nil;
    
    if (range.length == 1 && [string isEqualToString:@""]) 
    {
        multiNoString = [str substringToIndex:([str length] - 1)];
        
    }else{
        
        multiNoString = [str stringByAppendingString:string];
    }
    
    CGFloat beishu = 1;
    
    if (![multiNoString isEqualToString:@""]) {
        
        beishu = [multiNoString doubleValue];
        
    }
    
    if (beishu > 99|| beishu == 0) {
        
        if ([delegate conformsToProtocol:@protocol(LotteryFootViewDelegate)]) {
            
            if ([delegate respondsToSelector:@selector(returnMultiNoAndTotalLottery:andTotalLottery:)]) {
                
                [delegate returnMultiNoAndTotalLottery:beishu andTotalLottery:beishu*self.totalLottery];
            }
        }
        
        if(beishu == 0)
        {
            textField.text = @"1";
        }
        
        return NO;
    }
    
    if (beishu*self.totalLottery*2 > 2000) {
        
        if ([delegate conformsToProtocol:@protocol(LotteryFootViewDelegate)]) {
            
            if ([delegate respondsToSelector:@selector(returnMultiNoAndTotalLottery:andTotalLottery:)]) {
                
                [delegate returnMultiNoAndTotalLottery:beishu andTotalLottery:beishu*self.totalLottery];
            }
        }
        
        return NO;
    }
    
    self.multiNo = beishu;
    
    [self refreshView];
    
    return YES;
    
}

@end

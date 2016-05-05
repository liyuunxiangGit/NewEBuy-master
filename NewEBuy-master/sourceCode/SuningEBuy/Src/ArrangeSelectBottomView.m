//
//  ArrangeBottomView.m
//  SuningLottery
//
//  Created by yangbo on 4/6/13.
//  Copyright (c) 2013 suning. All rights reserved.
//

#import "ArrangeSelectBottomView.h"

@implementation ArrangeSelectBottomView
@synthesize delegate = _delegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:[self bounds]];
        //if (IOS7_OR_LATER)
        {
            backgroundView.backgroundColor = [UIColor uiviewBackGroundColor];
        }
//        else
//        {
//            UIImage *image = [[UIImage imageNamed:@"ball_select_bottom.png"]stretchableImageWithLeftCapWidth:10 topCapHeight:10];
//            backgroundView.image = image;
//            backgroundView.userInteractionEnabled = YES;
//            backgroundView.backgroundColor = [UIColor clearColor];
//        }
        
        [self addSubview:backgroundView];
        
        //清除号码按钮
        UIButton *clearBtn = [[UIButton alloc] init];
        [clearBtn addTarget:self action:@selector(deleteAll:) forControlEvents:UIControlEventTouchUpInside];
        //if (IOS7_OR_LATER)
        {
            clearBtn.backgroundColor = [UIColor whiteColor];
        }
//        else
//        {
//            [clearBtn setBackgroundImage:[UIImage imageNamed:@"clean.png"] forState:UIControlStateNormal];
//            clearBtn.backgroundColor = [UIColor clearColor];
//        }
        [clearBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [clearBtn setTitleColor:[UIColor darkGrownColor] forState:UIControlStateNormal];
        [clearBtn setTitle:L(@"Clear") forState:UIControlStateNormal];
        
        clearBtn.frame = CGRectMake(10, 6, 45, 30);
        [self addSubview:clearBtn];
        
        //确定按钮
        UIButton *doneButton = [[UIButton alloc] init];
        [doneButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        //if (IOS7_OR_LATER)
        {
            doneButton.backgroundColor = [UIColor colorWithRGBHex:0xfc7c26];
        }
//        else
//        {
//            [doneButton setBackgroundImage:[UIImage imageNamed:@"commit.png"] forState:UIControlStateNormal];
//             doneButton.backgroundColor = [UIColor clearColor];
//        }
        
        [doneButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [doneButton setTitle:L(@"Ok") forState:UIControlStateNormal];
       
        doneButton.frame = CGRectMake([self bounds].size.width-10-45, 6, 45, 30);
        [self addSubview:doneButton];
        
        //号码label
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.textAlignment = UITextAlignmentCenter;
        [_numberLabel setFont:[UIFont systemFontOfSize:12]];
        [_numberLabel setTextColor:[UIColor darkRedColor]];
        _numberLabel.backgroundColor = [UIColor clearColor];
        _numberLabel.frame = CGRectMake(CGRectGetMaxX(clearBtn.frame)+10, 5, CGRectGetMinX(doneButton.frame)-CGRectGetMaxX(clearBtn.frame) - 20, 20);
        [self addSubview:_numberLabel];
        
        //投注金额label
        _moneyLabel = [[UILabel  alloc]init];
        _moneyLabel.backgroundColor = [UIColor clearColor];
        [_moneyLabel setFont:[UIFont boldSystemFontOfSize:12] ] ;
        [_moneyLabel setTextAlignment:UITextAlignmentCenter];
        _moneyLabel.textColor = RGBCOLOR(102.0, 51.0, 51.0);
        _moneyLabel.frame = CGRectMake(CGRectGetMinX(_numberLabel.frame), CGRectGetMaxY(_numberLabel.frame)-5, CGRectGetWidth(_numberLabel.frame), CGRectGetHeight(_numberLabel.frame));
        [self addSubview:_moneyLabel];
        
    }
    return self;
}

- (void)deleteAll:(id)sender
{
    if([_delegate respondsToSelector:@selector(clear)])
    {
        [_delegate clear];
    }
    
}

- (void)submit:(id)sender
{
    if([_delegate respondsToSelector:@selector(submit)])
    {
        [_delegate submit];
    }
}

- (void)setBets:(int)bet
       multiple:(int)multiple
        periods:(int)periods
          price:(int)price
   numberString:(NSString *)number
{
    
    _numberLabel.text =  L(@"Shake machine selection Note");
    
    _moneyLabel.text = [NSString stringWithFormat:L(@"LOCalculateFormula3"),bet,multiple,periods,price*bet*multiple *periods];
    
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_numberLabel);
    TT_RELEASE_SAFELY(_moneyLabel);
    
}
@end

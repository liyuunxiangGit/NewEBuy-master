//
//  SNProtocolView.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-11-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SNProtocolView.h"

@implementation SNProtocolView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(UILabel*)titleLab{
    
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc] init];
        
        _titleLab.frame = CGRectMake(44, 44+22, 320-88, 44);
        
        _titleLab.backgroundColor = [UIColor whiteColor];
        
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.layer.borderColor = [UIColor grayColor].CGColor;
        _titleLab.layer.borderWidth = 0.3;
        
        
        _titleLab.textAlignment = UITextAlignmentCenter;
        
        [self addSubview:_titleLab];
        [_titleLab addSubview:self.deleteBtn];
    }
    
    return _titleLab;
}

-(UITextView*)valueTextView{
    
    //if (!_valueTextView) {
    
    [_valueTextView removeFromSuperview];
        
        _valueTextView = [[UITextView alloc] init];
        
        _valueTextView.frame = CGRectMake(44, 88+22, 320-88, 350);
        
        _valueTextView.backgroundColor = [UIColor whiteColor];
        
        _valueTextView.textColor = [UIColor blackColor];
        
        _valueTextView.editable = NO;
        _valueTextView.layer.borderColor = [UIColor grayColor].CGColor;
        _valueTextView.layer.borderWidth = 0.3;
        
        [self addSubview:_valueTextView];
   // }
    
    return _valueTextView;
}

-(UIButton *)deleteBtn
{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"qiandaoguize-guanbi.png"] forState:UIControlStateNormal];
        
        [_deleteBtn addTarget:self action:@selector(hideProtocol) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.frame = CGRectMake(320-88-40, 0, 40, 40);
        
    }
    return _deleteBtn ;
}



-(void)setPTitle:(NSString *)pTitle{
    
    _pTitle = pTitle;
    
    self.titleLab.text = pTitle;
}

-(void)setPValue:(NSString *)pValue{
    
    _pValue = pValue;
    
    self.valueTextView.text = pValue;
}
-(void)hideProtocol{
    
    self.hidden = YES;
}

-(void)showProtocol{
    
    self.hidden = NO;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self hideProtocol];
}
@end

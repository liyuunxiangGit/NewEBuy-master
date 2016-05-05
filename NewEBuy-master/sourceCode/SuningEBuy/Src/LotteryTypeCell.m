//
//  LotteryTypeCell.m
//  SuningLottery
//
//  Created by lizhen xiao on 12-9-25.
//  Copyright (c) 2012年 suning. All rights reserved.
//

#import "LotteryTypeCell.h"

@implementation LotteryTypeCell

@synthesize doublecolorBotton=_doublecolorBotton;
@synthesize doublecolorlabel=_doublecolorlabel;
@synthesize superLottoButton=_superLottoButton;
@synthesize superLottoLabel=_superLottoLabel;
@synthesize shadowImageView = _shadowImageView;
@synthesize shadowImageView2=_shadowImageView2;
@synthesize delegate;



- (void)dealloc {
    
    
    TT_RELEASE_SAFELY(_doublecolorBotton);
    TT_RELEASE_SAFELY(_doublecolorlabel);
    TT_RELEASE_SAFELY(_superLottoLabel);
    TT_RELEASE_SAFELY(_superLottoButton);
    TT_RELEASE_SAFELY(_shadowImageView);
    TT_RELEASE_SAFELY(_shadowImageView2);
    
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.doublecolorBotton];
        [self.contentView addSubview:self.doublecolorlabel];
        [self.contentView addSubview:self.superLottoLabel];
        [self.contentView addSubview:self.superLottoButton];
        [self.contentView addSubview:self.shadowImageView];
        [self.contentView addSubview:self.shadowImageView2];
    }
    return self;
}

- (void)setView:(NSArray*)flag
{
    NSString *str0 = [flag objectAtIndex:0];
    [_doublecolorBotton setBackgroundImage:[UIImage imageNamed:str0] forState:UIControlStateNormal];
        
    NSString *str1 = [flag objectAtIndex:1];
    
    [_superLottoButton setBackgroundImage:[UIImage imageNamed:str1] forState:UIControlStateNormal];
    
    if ([str1 isEqualToString: @"0.png"]) {
        _shadowImageView2.image=nil;
    }
    
}
-(void)setViewlbl:(NSArray *)lbl{
    
    NSString *str = [lbl objectAtIndex:0];
    _doublecolorlabel.text=str;
    
    NSString *str1 = [lbl objectAtIndex:1];
    _superLottoLabel.text=str1;
    
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
}
-(UIButton *)doublecolorBotton{
    
    if (_doublecolorBotton == nil) 
    {
        
		_doublecolorBotton = [[UIButton alloc] initWithFrame:CGRectMake(50,  20, 55, 55)];
		
		_doublecolorBotton.backgroundColor = [UIColor clearColor];
        
        UIImage *image = [UIImage imageNamed:@"caipiao_01.png"];
        
        _doublecolorBotton.tag = 0;
        
        [_doublecolorBotton setBackgroundImage:image forState:UIControlStateNormal];
//        [_doublecolorBotton addTarget:self action:@selector(doublecolorball:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _doublecolorBotton;
    
    
    
    
}

-(UIImageView *)shadowImageView{

    if (_shadowImageView == nil) 
    {
        
		_shadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50,  73, 55, 5)];
		
		_shadowImageView.backgroundColor = [UIColor clearColor];
        
        UIImage *image = [UIImage imageNamed:@"shadow_image.png"];
        
        _shadowImageView.image = image;
    
        
    }
    return _shadowImageView;
    
}


-(UILabel *)doublecolorlabel{
    
    if (_doublecolorlabel == nil) 
    {
        
		_doublecolorlabel = [[UILabel alloc] initWithFrame:CGRectMake(53,  85, 100, 20)];
		
		_doublecolorlabel.backgroundColor = [UIColor clearColor];
        
        _doublecolorlabel.textColor = [UIColor blackColor];
        
        _doublecolorlabel.textAlignment = UITextAlignmentLeft;
		
		_doublecolorlabel.autoresizingMask = UIViewAutoresizingNone;
        
        _doublecolorlabel.font = [UIFont systemFontOfSize:16.0];
        
        _doublecolorlabel.textColor = [UIColor blackColor];
        
        
    }
    return _doublecolorlabel;
    
}



-(UIButton *)superLottoButton{
    
    if (_superLottoButton == nil) 
    {
        
		_superLottoButton = [[UIButton alloc] initWithFrame:CGRectMake(200,  20, 55, 55)];
		
		_superLottoButton.backgroundColor = [UIColor clearColor];
        
        UIImage *image = [UIImage imageNamed:@"caipiao_50.png"];
        
        _superLottoButton.tag = 1;
        
        [_superLottoButton setBackgroundImage:image forState:UIControlStateNormal];
//        [_superLottoButton addTarget:self action:@selector(doublecolorball:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _superLottoButton;
    
}

-(UIImageView *)shadowImageView2{
    
    if (_shadowImageView2 == nil) 
    {
        
		_shadowImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(200,  73, 55, 5)];
		
		_shadowImageView2.backgroundColor = [UIColor clearColor];
        
        UIImage *image = [UIImage imageNamed:@"shadow_image.png"];
        
        _shadowImageView2.image = image;
        
        
    }
    return _shadowImageView2;
    
}
-(UILabel *)superLottoLabel{
    
    if (_superLottoLabel == nil) 
    {
        
		_superLottoLabel = [[UILabel alloc] initWithFrame:CGRectMake(203,  85, 100, 20)];
		
		_superLottoLabel.backgroundColor = [UIColor clearColor];
        
        _superLottoLabel.textAlignment = UITextAlignmentLeft;
		
		_superLottoLabel.autoresizingMask = UIViewAutoresizingNone;
        
        _superLottoLabel.font = [UIFont systemFontOfSize:16.0];
        
        _superLottoLabel.textColor = [UIColor blackColor];
        
    }
    return _superLottoLabel;
}



-(void)doublecolorball:(id)sender{
    
    UIButton *button = (UIButton *)sender;
    
    if ([delegate respondsToSelector:@selector(ballfromcell:)])
    {
        [delegate ballfromcell:button];
    }

    
}








@end

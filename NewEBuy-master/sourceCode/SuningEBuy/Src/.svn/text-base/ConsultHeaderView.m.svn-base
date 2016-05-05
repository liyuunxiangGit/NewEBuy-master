//
//  ConsultHeaderView.m
//  SuningEBuy
//
//  Created by sn－wahaha on 14-6-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ConsultHeaderView.h"

@implementation ConsultHeaderView

- (id)init:(ConsultListDTO *)dto
{
    
    self = [super init];
    if (self) {
        
        [self setcellinit:dto];
        // Initialization code
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


-(UILabel *)username{
    if (!_username) {
        _username = [[UILabel alloc] init];
        
        _username.textAlignment = UITextAlignmentLeft;
        
        _username.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1];
        
        _username.backgroundColor = [UIColor clearColor];
        
        _username.font = [UIFont boldSystemFontOfSize:12];
        
        _username.lineBreakMode = UILineBreakModeWordWrap;
        
        _username.numberOfLines = 0;
        
    }
    return _username;
}

-(UITextView *)ask{
    if (!_ask) {
        _ask = [[UITextView alloc] init];
        _ask.editable = NO;
        _ask.scrollEnabled = NO;
        _ask.backgroundColor = [UIColor clearColor];
    }
    return _ask;
}


-(UITextView *)answer{
    if (!_answer) {
        _answer = [[UITextView alloc] init];
        _answer.editable = NO;
        _answer.scrollEnabled = NO;
        _answer.backgroundColor = [UIColor clearColor];
    }
    return _answer;
}

-(UILabel *)datetime{
    if (!_datetime) {
        _datetime = [[UILabel alloc] init];
        _datetime.backgroundColor = [UIColor clearColor];
        
        _datetime.font = [UIFont boldSystemFontOfSize:12];
        
        _datetime.lineBreakMode = UILineBreakModeWordWrap;
        
        _datetime.numberOfLines = 0;
    }
    return _datetime;
}

-(UIButton *)manyi{
    if(!_manyi){
        _manyi = [[UIButton alloc] init];
        
        [_manyi addTarget:self.owner action:@selector(sendmanyi:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _manyi;
}

-(UIButton *)unmanyi{
    if (!_unmanyi) {
        _unmanyi = [[UIButton alloc] init];
        [_unmanyi addTarget:self.owner action:@selector(sendunmanyi:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _unmanyi;
}

-(UIImageView *)line{
    if (!_line) {
        _line = [[UIImageView alloc] init];
        _line.image= [UIImage imageNamed:@"notice_cutLine.png"];
        
    }
    return _line;
}

-(UIImageView *)linecell{
    if (!_linecell) {
        _linecell = [[UIImageView alloc] init];
        _linecell.image= [UIImage imageNamed:@"cellCutline.png"];
        
    }
    return _line;
}
-(void)framereset:(ConsultListDTO *)dto{
    CGSize size =  [self sizeofstring:dto.content];
    CGSize answersize = [self sizeofstring:dto.answer];
    self.ask.frame = CGRectMake(30, self.username.bottom+5, 300, MAX(size.height,20));
    self.answer.frame = CGRectMake(30, self.ask.bottom+10, 300, MAX(answersize.height,20));
    self.line.frame = CGRectMake(0, self.answer.bottom+10, 320, 1);
    self.datetime.frame =CGRectMake(250, self.username.top, 70, 30);
    self.manyi.frame = CGRectMake(160, self.line.bottom, 60, 44);
    self.unmanyi.frame = CGRectMake(self.line.right+10, self.line.bottom, 60, 44);
    self.linecell.frame = CGRectMake(self.manyi.right+5, self.manyi.top, 2, 44);
}

-(CGSize)sizeofstring:(NSString *)str{
    CGSize size =  [str sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(300, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    return size;
}

-(void)setcellinit:(ConsultListDTO *)dto{
    [self framereset:dto];
    self.frame = CGRectMake(0, 0, 320, self.unmanyi.bottom+10);
    self.username.text = dto.nickname;
    self.ask.text = dto.content;
    self.answer.text = dto.answer;
    self.datetime.text = dto.createtime;
    NSString *title = [NSString stringWithFormat:@"%@(%@)",L(@"Satisfaction"),dto.usefulcount];
    NSString *title1 = [NSString stringWithFormat:@"%@(%@)",L(@"DisSatisfaction"),dto.unusefulcount];
    [self.manyi setTitle:title forState:UIControlStateNormal];
    [self.unmanyi setTitle:title1 forState:UIControlStateNormal];
    [self addSubview:self.username];
    [self addSubview:self.ask];
    [self addSubview:self.answer];
    [self addSubview:self.datetime];
    [self addSubview:self.manyi];
    [self addSubview:self.unmanyi];
    [self addSubview:self.linecell];
    [self addSubview:self.line];
}

@end

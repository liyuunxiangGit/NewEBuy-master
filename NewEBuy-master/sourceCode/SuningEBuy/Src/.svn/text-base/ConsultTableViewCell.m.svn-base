//
//  ConsultTableViewCell.m
//  SuningEBuy
//
//  Created by sn－wahaha on 14-6-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ConsultTableViewCell.h"
#import "DataValidate.h"

#define tagmanyi 3000
#define tagunmanyi 7000
@implementation ConsultTableViewCell{
    MyConsultDTO *myconcultDTO;
    ConsultListDTO *consultlistDTO;
    BOOL     isclickmanyi;
    NSTimer* myTimer;
  
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:self.username];
        [self addSubview:self.ask];
        [self addSubview:self.answer];
        [self addSubview:self.questiong];
        [self addSubview:self.answerimg];
        [self addSubview:self.datetime];
        [self addSubview:self.manyi];
        [self addSubview:self.unmanyi];
        [self addSubview:self.linecell];
        [self addSubview:self.userview];
        [self addSubview:self.unuserview];
        [self addSubview:self.line];

    }
    return self;
}

- (void)dealloc
{
    _httpsend.delegate = nil;
    SERVICE_RELEASE_SAFELY(_httpsend);
    TT_RELEASE_SAFELY(myTimer);

}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)height:(ConsultListDTO *)consultdto{
    
    if (consultdto == nil)
    {
        return 0.0;
    }
    
    CGSize nameSize = [consultdto.content sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(280, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    
    CGSize descSize = [consultdto.answer sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(280, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    
    return MAX(nameSize.height+10,35) + MAX(descSize.height+10,35) + 20 +50;
}

+ (CGFloat)MyConsultheight:(MyConsultDTO *)consultdto{
    
    if (consultdto == nil)
    {
        return 0.0;
    }
    
    CGSize nameSize = [consultdto.content sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(280, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    
    CGSize descSize = [consultdto.answer sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(280, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    
    CGSize centrynameSize = [consultdto.centryname sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:CGSizeMake(160, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];

    
    return MAX(nameSize.height+10,35) + MAX(descSize.height+10,35) +  MAX(centrynameSize.height,20) +50;
}

-(UILabel *)username{
    if (!_username) {
        _username = [[UILabel alloc] init];
        
        _username.textAlignment = UITextAlignmentLeft;
        
        _username.textColor = [UIColor colorWithRed:68.0/255 green:68.0/255 blue:68.0/255 alpha:1];

        _username.backgroundColor = [UIColor clearColor];
        
        _username.font = [UIFont systemFontOfSize:12];
        
        _username.lineBreakMode = UILineBreakModeWordWrap;
        
        _username.numberOfLines = 0;
        
    }
    return _username;
}

-(UILabel *)ask{
    if (!_ask) {
        _ask = [[UILabel alloc] init];

        [_ask setFont:[UIFont systemFontOfSize:15]];
        
        _ask.backgroundColor = [UIColor clearColor];
        
        _ask.textAlignment = UITextAlignmentLeft;
        
        _ask.numberOfLines = 0;
        
        _ask.textColor = [UIColor colorWithRed:68.0/255 green:68.0/255 blue:68.0/255 alpha:1];
    }
    return _ask;
}


- (ConsultationService *)httpsend
{
    if (!_httpsend) {
        _httpsend = [[ConsultationService alloc] init];
        _httpsend.delegate = self;
    }
    return _httpsend;
}

-(UILabel *)answer{
    if (!_answer) {
        _answer = [[UILabel alloc] init];
       
        _answer.textColor = [UIColor colorWithRed:68.0/255 green:68.0/255 blue:68.0/255 alpha:1];

        [_answer setFont:[UIFont systemFontOfSize:15]];
        
        _answer.textAlignment = UITextAlignmentLeft;
        
        _answer.numberOfLines = 0;
        
        _answer.backgroundColor = [UIColor clearColor];
    }
    return _answer;
}

-(UILabel *)datetime{
    if (!_datetime) {
        _datetime = [[UILabel alloc] init];
        _datetime.backgroundColor = [UIColor clearColor];
        _datetime.textColor = [UIColor colorWithRed:68.0/255 green:68.0/255 blue:68.0/255 alpha:1];

        _datetime.font = [UIFont systemFontOfSize:12];
        
        _datetime.lineBreakMode = UILineBreakModeWordWrap;
        
        _datetime.numberOfLines = 0;
    }
    return _datetime;
}

-(UIButton *)manyi{
    if(!_manyi){
        _manyi = [[UIButton alloc] init];
        [_manyi setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_manyi.titleLabel setFont:[UIFont systemFontOfSize:13.0]];

        [_manyi addTarget:self action:@selector(sendmanyi:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _manyi;
}

-(void)sectimecall{
    if (myTimer) {
        [myTimer invalidate];
        myTimer = nil;
    }
    [_unmanyi setEnabled:YES];
    [_manyi setEnabled:YES];
}

-(void)sendmanyi:(id)sender{
    myTimer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(sectimecall) userInfo:nil repeats:NO];
    if (![UserCenter defaultCenter].isLogined)
    {
        [self.owner performSelector:@selector(sendmanyi:) withObject:sender];
        return;
    }
    
    isclickmanyi = YES;
    UIButton *btn = (UIButton *)sender;
    [btn setEnabled:NO];
    [_unmanyi setEnabled:NO];
    [self.httpsend SendConsultSatisfactionHttpRequest:consultlistDTO.articleId isbook:_isbook isflag:@"true"];
}

-(void)sendunmanyi:(id)sender{
    myTimer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(sectimecall) userInfo:nil repeats:NO];
    
    if (![UserCenter defaultCenter].isLogined)
    {
        [self.owner performSelector:@selector(sendunmanyi:) withObject:sender];
        return;
    }
    
    isclickmanyi = NO;
    UIButton *btn = (UIButton *)sender;
    [btn setEnabled:NO];
    [_unmanyi setEnabled:NO];
    [self.httpsend SendConsultSatisfactionHttpRequest:consultlistDTO.articleId isbook:_isbook isflag:@"false"];
}

-(UIButton *)unmanyi{
    if (!_unmanyi) {
        _unmanyi = [[UIButton alloc] init];
        [_unmanyi setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_unmanyi.titleLabel setFont:[UIFont systemFontOfSize:13.0]];

        [_unmanyi addTarget:self action:@selector(sendunmanyi:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _unmanyi;
}

-(UIImageView *)line{
    if (!_line) {
        _line = [[UIImageView alloc] init];
        _line.image= [UIImage imageNamed:@"notice_cutLine"];
        _line.frame = CGRectMake(0, 0, 320, 1);
    }
    return _line;
}
-(UIButton *)productname{
    if (!_productname) {
        _productname = [[UIButton alloc] init];
//        _productname 
    }
    return _productname;
}
-(UIImageView *)questiong{
    if (!_questiong) {
        _questiong = [[UIImageView alloc] init];
        _questiong.image= [UIImage imageNamed:@"user_icon"];
        
    }
    return _questiong;
}

-(UIImageView *)answerimg{
    if (!_answerimg) {
        _answerimg = [[UIImageView alloc] init];
        _answerimg.image= [UIImage imageNamed:@"news_icon"];
        
    }
    return _answerimg;
}

-(UIImageView *)linecell{
    if (!_linecell) {
        _linecell = [[UIImageView alloc] init];
        _linecell.image= [UIImage imageNamed:@"cellCutline.png"];
        _linecell.frame =CGRectMake(0, 0, 2, 30);
    }
    return _linecell;
}
-(void)framereset:(ConsultListDTO *)dto{
    consultlistDTO = dto;
    CGSize size =  [self sizeofstring:dto.content];
    CGSize answersize = [self sizeofstring:dto.answer];
    self.username.frame = CGRectMake(10, 5, 160, 20);
    self.ask.frame = CGRectMake(30, self.username.bottom, 280, MAX(size.height+10,35));
    self.questiong.frame = CGRectMake(10, self.username.bottom+9, 16, 16);
    if (self.ask.frame.size.height != 35) {
        self.questiong.frame = CGRectMake(10, self.username.bottom+5, 16, 16);
    }
    
    self.answer.frame = CGRectMake(30, self.ask.bottom, 280, MAX(answersize.height+10,35));
    self.answerimg.frame = CGRectMake(10, self.ask.bottom+8, 16, 16);
    if (self.answer.frame.size.height != 35) {
        self.answerimg.frame = CGRectMake(10, self.ask.bottom+4, 16, 16);
    }
    self.datetime.frame =CGRectMake(183, self.username.top, 140, 20);
   
    [self.unmanyi.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [self.manyi.titleLabel setFont:[UIFont systemFontOfSize:13.0]];

    self.manyi.frame = CGRectMake(120+20, self.answer.bottom+12, 80, 25);
    self.unmanyi.frame = CGRectMake(210+20, self.answer.bottom+12, 80, 25);
    self.unuserview.frame = CGRectMake(142, self.answer.bottom+18, 12, 12);
    self.userview.frame = CGRectMake(227, self.answer.bottom+18, 12, 12);
    self.linecell.frame = CGRectMake(self.manyi.right-5,self.unmanyi.top+5, 2, 20);
    self.line.image= [UIImage imageNamed:@"notice_cutLine"];
    self.line.frame = CGRectMake(0, self.manyi.top-4, 320, 1.5);

}

-(CGSize)sizeofstring:(NSString *)str{
    CGSize size =  [str sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(280, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    return size;
}

-(UIImageView *)unuserview{
    if (!_unuserview) {
        _unuserview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"good_icon"]];
    }
    return _unuserview;
}

-(UIImageView *)userview{
    if (!_userview) {
        _userview =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_icon"]];
    }
    return _userview;
}

-(void)myconsultcellframereset:(MyConsultDTO *)dto{
    myconcultDTO = dto;
    CGSize size =  [self sizeofstring:dto.content];
    CGSize answersize = [self sizeofstring:dto.answer];
    CGSize namesize =  [dto.centryname sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(160, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    
    self.username.frame = CGRectMake(10, 5, 160, MAX(namesize.height,20));
    self.ask.frame = CGRectMake(30, self.username.bottom, 280, MAX(size.height+10,35));
    self.questiong.frame = CGRectMake(10, self.username.bottom+9, 16, 16);
    if (self.ask.frame.size.height != 35) {
        self.questiong.frame = CGRectMake(10, self.username.bottom+5, 16, 16);
    }
    
    self.answer.frame = CGRectMake(30, self.ask.bottom, 280, MAX(answersize.height+10,35));
    self.answerimg.frame = CGRectMake(10, self.ask.bottom+8, 16, 16);
    if (self.answer.frame.size.height != 35) {
        self.answerimg.frame = CGRectMake(10, self.ask.bottom+4, 16, 16);
    }
    self.datetime.frame =CGRectMake(183, self.username.top, 140, 20);
    
    [self.unmanyi.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [self.manyi.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    
    self.manyi.frame = CGRectMake(120+20, self.answer.bottom+12, 80, 25);
    self.unmanyi.frame = CGRectMake(210+20, self.answer.bottom+12, 80, 25);
    self.unuserview.frame = CGRectMake(142, self.answer.bottom+18, 12, 12);
    self.userview.frame = CGRectMake(227, self.answer.bottom+18, 12, 12);
    self.linecell.frame = CGRectMake(self.manyi.right-5,self.unmanyi.top+5, 2, 20);
    self.line.frame = CGRectMake(0, self.manyi.top-4, 320, 1.5);
}

-(void)setmyconsultcellinit:(MyConsultDTO *)dto{
    
    [self myconsultcellframereset:dto];
    self.username.text = dto.centryname;
    self.ask.text = dto.content;
    self.answer.text = dto.answer;;
    if (dto.createtime.length>19) {
        NSString *str = [dto.createtime substringToIndex:19];
        dto.createtime =str;
    }
    self.datetime.text = dto.createtime;
    NSString *title = [NSString stringWithFormat:@"%@(%@)",L(@"Satisfaction"),dto.usefulcount];
    NSString *title1 = [NSString stringWithFormat:@"%@(%@)",L(@"DisSatisfaction"),dto.unusefulcount];
    [self.manyi setTitle:title forState:UIControlStateNormal];
    [self.unmanyi setTitle:title1 forState:UIControlStateNormal];
    _manyi.tag = tagmanyi + self.tag - 1000;
    _unmanyi.tag = tagunmanyi + self.tag - 1000;
    [self bringSubviewToFront:self.line];
    if (self.answer.text.length == 0) {
        self.answerimg.hidden = YES;
    }
    else{
        self.answerimg.hidden = NO;
    }

}

-(void)setcellinit:(ConsultListDTO *)dto{
    
    [self framereset:dto];
    self.username.text = dto.nickname;
    self.ask.text = dto.content;
    self.answer.text = dto.answer;;
    if (dto.createtime.length>19) {
        NSString *str = [dto.createtime substringToIndex:19];
        dto.createtime =str;
    }
    self.datetime.text = dto.createtime;
    NSString *title = [NSString stringWithFormat:@"%@(%@)",L(@"Satisfaction"),dto.usefulcount];
    NSString *title1 = [NSString stringWithFormat:@"%@(%@)",L(@"DisSatisfaction"),dto.unusefulcount];
    [self.manyi setTitle:title forState:UIControlStateNormal];
    [self.unmanyi setTitle:title1 forState:UIControlStateNormal];
    _manyi.tag = tagmanyi + self.tag - 1000;
    _unmanyi.tag = tagunmanyi + self.tag - 1000;
    [self bringSubviewToFront:self.linecell];
    [self bringSubviewToFront:self.line];

}

- (void)GetConsultNumDelegate:(BOOL)issuccess error:(NSString *)error ConsultDTO:(ConsultNumDetailsDTO *)dto{
    self.manyi.enabled = YES;
    self.unmanyi.enabled = YES;
    if (issuccess) {
        if (isclickmanyi) {
            consultlistDTO.usefulcount = [NSString stringWithFormat:@"%d",[consultlistDTO.usefulcount intValue]+1];

        }
        else{
            consultlistDTO.unusefulcount = [NSString stringWithFormat:@"%d",[consultlistDTO.unusefulcount intValue]+1];

        }
        NSString *title = [NSString stringWithFormat:@"%@(%@)",L(@"Satisfaction"),consultlistDTO.usefulcount];
        NSString *title1 = [NSString stringWithFormat:@"%@(%@)",L(@"DisSatisfaction"),consultlistDTO.unusefulcount];
        [self.manyi setTitle:title forState:UIControlStateNormal];
        [self.unmanyi setTitle:title1 forState:UIControlStateNormal];
        if (myTimer) {
            self.manyi.enabled = NO;
            self.unmanyi.enabled = NO;
        }
        
    }
    else{

    }
    
}

@end

//
//  NDetailSecondCell.m
//  SuningEBuy
//
//  Created by xmy on 13/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NDetailSecondCell.h"

#define NkDefaulContendFont    12

@implementation NDetailSecondCell

+ (CGFloat)getContentWidth
{
    if (IOS7_OR_LATER)
    {
        return 270;
    }
    else
    {
        return 240;
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (RuleCopyTextView*)sellerPointText
{
    if(!_sellerPointText)
    {
        _sellerPointText = [[RuleCopyTextView alloc] init];
        
        _sellerPointText.frame = CGRectMake(10, 0, 280, 25);
        
        _sellerPointText.backgroundColor = [UIColor clearColor];
        
        _sellerPointText.textColor = [UIColor darkGrayColor];
        
        _sellerPointText.font = [UIFont systemFontOfSize:12];
        
        _sellerPointText.userInteractionEnabled = YES;
        
        _sellerPointText.editable = NO;
        
        _sellerPointText.scrollEnabled = NO;
                
    }
    
    return _sellerPointText;
}

- (UIImageView *)singleLineImg
{
    if (!_singleLineImg) {
        _singleLineImg = [[UIImageView alloc] init];
        
        _singleLineImg.backgroundColor = [UIColor clearColor];
        
        _singleLineImg.image = [UIImage streImageNamed:@"line.png"];
    }
    return _singleLineImg;
}

-(UIButton *)foldBtn{
    
    if (!_foldBtn) {
        
        _foldBtn = [[UIButton alloc] init];
                
        _foldBtn.backgroundColor = [UIColor clearColor];
        
        _foldBtn.selected = NO;
        
        UIImageView *backImageView = [[UIImageView alloc] init];
        
        backImageView.frame = CGRectMake(55, 17, 12, 7);
        
        backImageView.image = [UIImage imageNamed:@"arrow_bottom_gray.png"];
        
        backImageView.userInteractionEnabled = YES;
        
        [_foldBtn addTarget:self action:@selector(foldBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        _foldBtn.frame = CGRectMake(240, 0, 80, 80);
        
        [_foldBtn addSubview:backImageView];
    }
    
    return _foldBtn;
}

- (void)foldBtnAction
{
    DLog(@"foldBtnAction");
       
    if (!self.foldBtn.selected) {
        
        self.foldBtn.selected = !self.foldBtn.selected;
        
        if ([_delegate respondsToSelector:@selector(foldBtnActionDetagete:)]) {
            [self.delegate foldBtnActionDetagete:YES];
        }
        self.foldBtn.hidden = YES;
    }
}


- (void)setNDetailSeconfCellInfo:(DataProductBasic *)dto
{
    
    if (dto == nil)
    {
        return;
    }
    
//    [self.contentView addSubview:self.backView];

    [self.contentView addSubview:self.sellerPointText];
    
    [self.contentView addSubview:self.foldBtn];
    
    [self.contentView addSubview:self.singleLineImg];
    
    self.dataDTO = dto;
    
    self.sellerPointText.text = dto.special;
    
    float  textLblH = [self NCellHeight:dto WithBool:self.foldBtn.selected WithWidth:[NDetailSecondCell getContentWidth]];

    //只有一行按钮隐藏
    if([self isShowMark:dto.special] == YES && self.foldBtn.selected == NO)
    {
        self.foldBtn.hidden = NO;
    }
    else
    {
        self.foldBtn.hidden = YES;
    }

    if(self.foldBtn.selected == YES)
    {
        self.sellerPointText.frame = CGRectMake(12, 5, 290, textLblH);
        
        self.singleLineImg.frame = CGRectMake(0, textLblH - 1, 320, 0.5);
        
    }
    else
    {
        self.sellerPointText.frame = CGRectMake(12, 5, 290, 24);
        
        self.singleLineImg.frame = CGRectMake(0, self.contentView.size.height - 1, 320, 0.5);
    }
    
    
}

-(BOOL)isShowMark:(NSString *)astring{
    
    if (astring == nil) {
        
        return 0;
    }
    
    float defaultHeight = [NDetailSecondCell heightWithDefault:astring];
    
    float alineHeight = [NDetailSecondCell alineHeight];
    
    if (defaultHeight > (1*alineHeight)) {
        
        return YES;
    }
    
    return NO;
}

+ (float)alineHeight{
    
    UIFont *couendFont = [UIFont systemFontOfSize:NkDefaulContendFont];
    CGSize labelsize = [@"1" sizeWithFont:couendFont constrainedToSize:CGSizeMake([NDetailSecondCell getContentWidth], 1000) lineBreakMode:UILineBreakModeTailTruncation];
    
    return  labelsize.height;
}


+(float)heightWithDefault:(NSString *)astring{
    
    UIFont *couendFont = [UIFont systemFontOfSize:NkDefaulContendFont];
    CGSize labelsize = [astring sizeWithFont:couendFont constrainedToSize:CGSizeMake([NDetailSecondCell getContentWidth], 1000) lineBreakMode:UILineBreakModeTailTruncation];
    
    return  labelsize.height;
}


- (CGFloat)NCellHeight:(DataProductBasic *)dto WithBool:(BOOL)isFold WithWidth:(float)width
{
    if(IsStrEmpty(dto.special))
    {
        return 0;
    }
    else
    {
        CGSize size = [dto.special sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        
        if(isFold == YES)
        {
            NSLog(@"size.height = %f",size.height+40);
            return size.height+20;
            
        }
        else
        {
            return 40;
            
        }
        
    }
}

+ (CGFloat)NDetailSecondCellHeight:(DataProductBasic *)dto  WithBool:(BOOL)isFold
{

    if(dto == nil)
    {
        return 0;
    }
    else
    {
        return [[NDetailSecondCell alloc] NCellHeight:dto WithBool:isFold WithWidth:[NDetailSecondCell getContentWidth]];

    }
}

@end

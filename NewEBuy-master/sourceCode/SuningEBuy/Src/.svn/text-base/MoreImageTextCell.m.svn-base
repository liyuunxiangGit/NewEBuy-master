//
//  MoreImageTextCell.m
//  SuningEBuy
//
//  Created by xingxianping on 13-7-22.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "MoreImageTextCell.h"

@implementation MoreImageTextCell
@synthesize bigImage=_bigImage;
@synthesize bigTitle=_bigTitle;
@synthesize titleBg=_titleBg;
@synthesize separatorLine1=_separatorLine1;
@synthesize backBtn1=_backBtn1;

@synthesize title1=_title1;
@synthesize image1=_image1;
@synthesize separatorLine2=_separatorLine2;
@synthesize backBtn2=_backBtn2;

@synthesize title2=_title2;
@synthesize image2=_image2;
@synthesize separatorLine3=_separatorLine3;
@synthesize backBtn3=_backBtn3;

@synthesize title3=_title3;
@synthesize image3=_image3;
@synthesize backBtn4=_backBtn4;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_bigImage);
    TT_RELEASE_SAFELY(_bigTitle);
    TT_RELEASE_SAFELY(_titleBg);
    TT_RELEASE_SAFELY(_separatorLine1);
    
    TT_RELEASE_SAFELY(_title1);
    TT_RELEASE_SAFELY(_image1);
    TT_RELEASE_SAFELY(_separatorLine2);
    
    TT_RELEASE_SAFELY(_title2);
    TT_RELEASE_SAFELY(_image2);
    TT_RELEASE_SAFELY(_separatorLine3);
    
    TT_RELEASE_SAFELY(_title3);
    TT_RELEASE_SAFELY(_image3);
    
}

- (EGOImageView *)bigImage
{
    if (!_bigImage) {
        _bigImage=[[EGOImageView alloc]initWithFrame:CGRectMake(30, 15,260, 140)];
        _bigImage.userInteractionEnabled = YES;
        _bigImage.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:_bigImage];
    }
    return _bigImage;
}

- (UILabel *)bigTitle
{
    if (!_bigTitle) {
        _bigTitle=[[UILabel alloc]initWithFrame:CGRectMake(30,130, 260, 25)];
        _bigTitle.lineBreakMode=UILineBreakModeTailTruncation;
        _bigTitle.numberOfLines=1;
        _bigTitle.backgroundColor=[UIColor clearColor];
        [_bigTitle setTextColor:[UIColor whiteColor]];
        _bigTitle.alpha=1;
        _bigTitle.font=[UIFont systemFontOfSize:12];
        _bigTitle.userInteractionEnabled=YES;
    }
    return _bigTitle;
}

- (UIView *)titleBg
{
    if (!_titleBg) {
        _titleBg=[[UIView alloc]initWithFrame:CGRectMake(30,130, 260, 25)];
        _titleBg.alpha=0.5;
        _titleBg.backgroundColor=[UIColor blackColor];
        _titleBg.userInteractionEnabled=YES;
    }
    return _titleBg;
}

- (UIImageView *)separatorLine1
{
    if (!_separatorLine1) {
        _separatorLine1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 169,320, 1)];
        [_separatorLine1 setImage:[UIImage imageNamed:@"line.png"]];
        [self.contentView addSubview:_separatorLine1];
    }
    return _separatorLine1;
}

- (UIButton *)backBtn1
{
    if (!_backBtn1) {
        _backBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn1.frame=CGRectMake(0, 0, 320, 170);
        [_backBtn1 setBackgroundColor:[UIColor clearColor]];
        _backBtn1.tag =0;
        [_backBtn1 addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn1;
}

- (UILabel *)title1
{
    if (!_title1) {
        _title1=[[UILabel alloc]initWithFrame:CGRectMake(30, 185, 170, 60)];
        _title1.lineBreakMode=UILineBreakModeTailTruncation;
        _title1.numberOfLines=0;
        _title1.backgroundColor=[UIColor clearColor];
        _title1.textColor=[UIColor light_Black_Color];
        _title1.font=[UIFont boldSystemFontOfSize:12];
        _title1.userInteractionEnabled=YES;
        [self.contentView addSubview:_title1];
    }
    return _title1;
}

- (UIButton *)backBtn2
{
    if (!_backBtn2) {
        _backBtn2=[UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn2.frame=CGRectMake(0, 170, 320, 90);
        [_backBtn2 setBackgroundColor:[UIColor clearColor]];
        _backBtn2.tag =1;
        [_backBtn2 addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn2;
}

- (EGOImageView *)image1
{
    if (!_image1) {
        _image1=[[EGOImageView alloc]initWithFrame:CGRectMake(220, 180, 70, 70)];
        _image1.userInteractionEnabled = YES;
        _image1.backgroundColor=[UIColor clearColor];
        _image1.userInteractionEnabled=YES;
        [self.contentView addSubview:_image1];
    }
    return _image1;
}

- (UIImageView *)separatorLine2
{
    if (!_separatorLine2) {
        _separatorLine2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 260, 320, 1)];
        [_separatorLine2 setImage:[UIImage imageNamed:@"line.png"]];
        [self.contentView addSubview:_separatorLine2];
    }
    return _separatorLine2;
}

- (UILabel *)title2
{
    if (!_title2) {
        _title2=[[UILabel alloc]initWithFrame:CGRectMake(30, 275, 170, 60)];
        _title2.lineBreakMode=UILineBreakModeTailTruncation;
        _title2.numberOfLines=0;
        _title2.backgroundColor=[UIColor clearColor];
        _title2.textColor=[UIColor light_Black_Color];
        _title2.font=[UIFont boldSystemFontOfSize:12];
        _title2.userInteractionEnabled=YES;
        [self.contentView addSubview:_title2];
    }
    return _title2;
}

- (EGOImageView *)image2
{
    if (!_image2) {
        _image2=[[EGOImageView alloc]initWithFrame:CGRectMake(220, 270, 70, 70)];
        _image2.userInteractionEnabled = YES;
        _image2.backgroundColor=[UIColor clearColor];
        _image2.userInteractionEnabled=YES;
        [self.contentView addSubview:_image2];
    }
    return _image2;
}

- (UIButton *)backBtn3
{
    if (!_backBtn3) {
        _backBtn3=[UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn3.frame=CGRectMake(0, 260, 320, 90);
        [_backBtn3 setBackgroundColor:[UIColor clearColor]];
        _backBtn3.tag =2;
        [_backBtn3 addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn3;
}

- (UIImageView *)separatorLine3
{
    if (!_separatorLine3) {
        _separatorLine3=[[UIImageView alloc]initWithFrame:CGRectMake(0, 350, 320, 1)];
        [_separatorLine3 setImage:[UIImage imageNamed:@"line.png"]];
        [self.contentView addSubview:_separatorLine3];
    }
    return _separatorLine3;
}

- (UILabel *)title3
{
    if (!_title3) {
        _title3=[[UILabel alloc]initWithFrame:CGRectMake(30, 365, 170, 60)];
        _title3.lineBreakMode=UILineBreakModeTailTruncation;
        _title3.numberOfLines=0;
        _title3.backgroundColor=[UIColor clearColor];
        _title3.textColor=[UIColor light_Black_Color];
        _title3.font=[UIFont boldSystemFontOfSize:12];
        _title3.userInteractionEnabled=YES;
        [self.contentView addSubview:_title3];
    }
    return _title3;
}

- (UIButton *)backBtn4
{
    if (!_backBtn4) {
        _backBtn4=[UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn4.frame=CGRectMake(0, 350, 320, 90);
        [_backBtn4 setBackgroundColor:[UIColor clearColor]];
        _backBtn4.tag =3;
        [_backBtn4 addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn4;
}

- (UIImageView *)separatorLine4
{
    if (!_separatorLine4) {
        _separatorLine4=[[UIImageView alloc]initWithFrame:CGRectMake(0, 439, 320, 1)];
        [_separatorLine4 setImage:[UIImage imageNamed:@"line.png"]];
        [self.contentView addSubview:_separatorLine4];
    }
    return _separatorLine4;
}

- (EGOImageView *)image3
{
    if (!_image3) {
        _image3=[[EGOImageView alloc]initWithFrame:CGRectMake(220, 360, 70, 70)];
        _image3.userInteractionEnabled = YES;
        _image3.backgroundColor=[UIColor clearColor];
        _image3.userInteractionEnabled=YES;
        [self.contentView addSubview:_image3];
    }
    return _image3;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor cellBackViewColor];
        
        [self.separatorLine1 setHeight:1];
        [self.separatorLine2 setHeight:1];
        [self.separatorLine3 setHeight:1];
        [self.separatorLine4 setHeight:1];
        
        [self addSubview:self.titleBg];
        [self addSubview:self.bigTitle];
        
        [self addSubview:self.backBtn1];
        [self addSubview:self.backBtn2];
        [self addSubview:self.backBtn3];
        [self addSubview:self.backBtn4];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(NSArray *)arr
{
    if (!IsArrEmpty(arr)) {
        _dataArr =[NSArray arrayWithArray:arr];
        [self loadData];
    }
}

- (void)loadData
{
    BigImageTypeDTO *item1 =[self.dataArr objectAtIndex:0];
    self.bigImage.imageURL=[NSURL URLWithString:item1.imgUrl];
    self.bigTitle.text=item1.title;
    
    BigImageTypeDTO *item2 =[self.dataArr objectAtIndex:1];
    self.title1.text=item2.title;
    self.image1.imageURL=[NSURL URLWithString:item2.imgUrl];
    
    BigImageTypeDTO *item3 =[self.dataArr objectAtIndex:2];
    self.title2.text=item3.title;
    self.image2.imageURL=[NSURL URLWithString:item3.imgUrl];
    
    BigImageTypeDTO *item4 =[self.dataArr objectAtIndex:3];
    self.title3.text=item4.title;
    self.image3.imageURL=[NSURL URLWithString:item4.imgUrl];
    
}
- (void)buttonTap:(id)sender
{
    UIButton *btn =(UIButton *)sender;
    BigImageTypeDTO *item =[self.dataArr objectAtIndex:btn.tag];
    NSString *size;
    if (btn.tag ==0) {
        size =@"big";
    }
    else
    {
        size =@"small";
    }
    if ([_delegate respondsToSelector:@selector(buttonClicked:andSize:)]) {
        [_delegate buttonClicked:item.infoId andSize:size];
    }
}
@end

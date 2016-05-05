//
//  SNCommentShareImagesView.m
//  SuningEBuy
//
//  Created by Joe on 14-11-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNCommentShareImagesView.h"
#import "UIView+Label.h"

@interface SNCommentShareImagesView ()
{
    UILabel     *_remainCountLable;
    UILabel     *_hintLabel;
    UIView      *_line;
}

@end

@implementation SNCommentShareImagesView

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _imageView = [[SNSInputImagesView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 60)];
        _imageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_imageView];
        
        _remainCountLable = [self labelWithMsg:[NSString stringWithFormat:L(@"CommentShare_PhotoCountHint"),1] color:RGBCOLOR(112, 112, 112) align:NSTextAlignmentLeft fontSize:9];
        _remainCountLable.frame = CGRectMake(15, _imageView.bottom , ApplicationScreenWidth-30 , 10);
        _hintLabel = [self labelWithMsg:L(@"CommentShare_AddPhotoHint") color:RGBCOLOR(112, 112, 112) align:NSTextAlignmentLeft fontSize:9];
        _hintLabel.frame = CGRectMake(15, _remainCountLable.bottom, ApplicationScreenWidth-30, 10);
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(15, _hintLabel.bottom + 15, ApplicationScreenWidth - 15, 1)];
        _line.backgroundColor = [UIColor grayColor];
        [self addSubview:_line];
    }
    return self;
}

-(int)height{
    return _imageView.height + _remainCountLable.height + _hintLabel.height;
}

-(void)reSize{
    [_imageView reOrder];
    _remainCountLable.frame = CGRectMake(15, _imageView.bottom , ApplicationScreenWidth-30 , 10);
    _hintLabel.frame = CGRectMake(15, _remainCountLable.bottom, ApplicationScreenWidth-30, 10);
    _line.frame = CGRectMake(15, _hintLabel.bottom + 15, ApplicationScreenWidth - 15, 1);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.width, _line.bottom);
}

@end


#import "StarChooseBar.h"

@interface SNCommentShareStar (){

}

@end @implementation SNCommentShareStar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _hintLabel = [self labelWithMsg:@"" color:[UIColor blackColor] align:NSTextAlignmentLeft fontSize:13];
        _hintLabel.frame = CGRectMake(0, 0, 70, frame.size.height);
        _star = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(_hintLabel.right, 0, 190, frame.size.height)];
        [self addSubview:_star];
    }
    return self;
}

@end

@interface SNCommentShareSelecter ()
{
    UIImageView *_icon;
}

@end

@implementation SNCommentShareSelecter

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImage *iconImage = [UIImage imageNamed:@"CommentShare_Selecter_UnSeledted"];
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iconImage.size.height, iconImage.size.height)];
        _icon.image = iconImage;
        [self addSubview:_icon];
        
        _hintLable = [self labelWithMsg:@"" color:[UIColor dark_Gray_Color] align:NSTextAlignmentLeft fontSize:13];
        _hintLable.frame = CGRectMake(_icon.right+12, 0, frame.size.width - _icon.right-12, iconImage.size.height);
        
        UITapGestureRecognizer *signalTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        signalTap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:signalTap];
    }
    return self;
}

-(void)tap:(UIGestureRecognizer*)gesture
{
    //评论晒单模块发表时必须选择一个方式，所以不能双击取消。
    if (!self.selected) {
        self.selected = YES;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(tap:)]) {
        [self.delegate tap:self];
    }
}

-(void)setSelected:(BOOL)selected
{
    _selected = selected;
    if (_selected) {
        _icon.image = [UIImage imageNamed:@"CommentShare_Selecter_Seledted"];
    }else{
        _icon.image = [UIImage imageNamed:@"CommentShare_Selecter_UnSeledted"];
    }
}


@end

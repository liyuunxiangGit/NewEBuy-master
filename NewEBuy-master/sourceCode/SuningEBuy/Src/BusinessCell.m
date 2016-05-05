//
//  BusinessCell.m
//  SuningEBuy
//
//  Created by Qin on 14-2-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BusinessCell.h"

@implementation BusinessCell

@synthesize titleLbl=_titleLbl;
@synthesize topLineImgView=_topLineImgView;
@synthesize bottomLineImgView=_bottomLineImgView;
@synthesize arrowImgView=_arrowImgView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.topLineImgView];
        [self.contentView addSubview:self.titleLbl];
        [self.contentView addSubview:self.bottomLineImgView];
        [self.contentView addSubview:self.arrowImgView];
    }
    return self;
}
-(UIImageView*)topLineImgView
{
    if (_topLineImgView==nil) {
        _topLineImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        UIImage* img=[UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
        [_topLineImgView setImage:img];
        
    }
    return _topLineImgView;
}
-(UILabel*)titleLbl
{
    if (_titleLbl==nil) {
        _titleLbl=[[UILabel alloc] initWithFrame:CGRectMake(15, 11, 275, 22)];
        _titleLbl.textColor=[UIColor light_Black_Color];
        _titleLbl.backgroundColor=[UIColor clearColor];
        _titleLbl.font = [UIFont boldSystemFontOfSize:17.0];;
    }
    return _titleLbl;
}
-(UIImageView*)arrowImgView
{
    if (_arrowImgView==nil) {
        _arrowImgView=[[UIImageView alloc] initWithFrame:CGRectMake(298, 17, 6, 11)];
        UIImage* img=[UIImage newImageFromResource:@"arrow_right_gray@2x.png"];
        [_arrowImgView setImage:img];
    }
    return _arrowImgView;
}
-(UIImageView*)bottomLineImgView
{
    if (_bottomLineImgView==nil) {
        _bottomLineImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 43, 320, 1)];
        UIImage* img=[UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
        [_bottomLineImgView setImage:img];
    }
    return _bottomLineImgView;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

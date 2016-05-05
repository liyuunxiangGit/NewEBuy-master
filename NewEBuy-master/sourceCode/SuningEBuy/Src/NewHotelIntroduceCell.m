//
//  NewHotelIntroduceCell.m
//  SuningEBuy
//
//  Created by Qin on 14-2-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NewHotelIntroduceCell.h"

#define defautFont [UIFont systemFontOfSize:15.0]

#define Label_Height 20
#define ContentLabel_Width 290
#define Max_Height 10000000


@implementation NewHotelIntroduceCell
@synthesize lineImageView=_lineImageView;
@synthesize contentLabel=_contentLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UIImageView*)lineImageView
{
    if (_lineImageView==nil) {
        _lineImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        UIImage* img=[UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
        [_lineImageView setImage:img];
        TT_RELEASE_SAFELY(img);
        
        
    }
    return _lineImageView;
}
-(UILabel*)contentLabel{
    
    if (_contentLabel==nil) {
        _contentLabel=[[UILabel alloc] initWithFrame:CGRectMake(15,10,290, Label_Height)];
        _contentLabel.backgroundColor=[UIColor clearColor];
        _contentLabel.textColor=[UIColor light_Black_Color];
        _contentLabel.font=defautFont;
        _contentLabel.numberOfLines=0;
        
    }
    return _contentLabel;
}

+(float)labelHeight:(NSString*)string{
    CGSize size=[string sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(ContentLabel_Width,Max_Height) lineBreakMode:UILineBreakModeCharacterWrap];
    if (size.height<20) {
        return 20;
    }
    return size.height;
}
+(float)cellHeightWithContentString:(NSString*)string{
    return [self labelHeight:string]+30;
}
-(void)setCellWithContentString:(NSString*)string
{
    [self.contentView addSubview:self.lineImageView];
    [self.contentView addSubview:self.contentLabel];
    
    CGRect frame=self.contentLabel.frame;
    frame.size.height=[NewHotelIntroduceCell labelHeight:string];
    self.contentLabel.frame=frame;
    self.contentLabel.text=string;
}
@end

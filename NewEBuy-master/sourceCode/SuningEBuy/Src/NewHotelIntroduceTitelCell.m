//
//  NewHotelIntroduceTitelCell.m
//  SuningEBuy
//
//  Created by Qin on 14-2-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NewHotelIntroduceTitelCell.h"
#define Label_Width 220

@implementation NewHotelIntroduceTitelCell

@synthesize nameLabel=_nameLabel;
@synthesize addressLabel=_addressLabel;
@synthesize starView=_starView;
@synthesize lineImageView=_lineImageView;
@synthesize productImageView=_productImageView;

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
-(UILabel*)nameLabel{
    if (_nameLabel==nil) {
        _nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(_productImageView.right+10,0,Label_Width, 25)];
        _nameLabel.backgroundColor=[UIColor clearColor];
        _nameLabel.textColor=[UIColor light_Black_Color];
        _nameLabel.font=[UIFont systemFontOfSize:15];
        _nameLabel.numberOfLines=0;
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}
-(UILabel*)addressLabel{
    if (_addressLabel==nil) {
        _addressLabel=[[UILabel alloc] initWithFrame:CGRectMake(_productImageView.right+10,5,Label_Width, 25)];
        _addressLabel.backgroundColor=[UIColor clearColor];
        _addressLabel.textColor=[UIColor dark_Gray_Color];
        _addressLabel.font=[UIFont systemFontOfSize:13];
        _addressLabel.numberOfLines=0;
        [self.contentView addSubview:_addressLabel];
    }
    return _addressLabel;
}
-(HotelStarView*)starView{
    if (!_starView) {
        
        _starView = [[HotelStarView alloc] init];
        
        _starView.backgroundColor = [UIColor clearColor];
        
        _starView.frame = CGRectMake(15, 58, 80, 20);
        
        [self.contentView addSubview:_starView];
    }
    return _starView;

}
-(UIImageView*)lineImageView
{
    if (_lineImageView==nil) {
        _lineImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        UIImage* img=[UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
        [_lineImageView setImage:img];
        TT_RELEASE_SAFELY(img);
        
//        [self.contentView addSubview:_lineImageView];
    }
    return _lineImageView;
}
-(EGOImageView *) productImageView{
	
	if (!_productImageView) {
		
		_productImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(10, 5, 65, 65)];
		
		_productImageView.backgroundColor =[UIColor clearColor];
        
        _productImageView.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
		
		[self addSubview:_productImageView];
		
	}
	
	return _productImageView;
}
+(float)cellHeightWithDto:(HotelIntroduceDTO*)dto
{
    return [self nameLabelHeightWithString:dto.name]+[self addressLabelHeightWithString:dto.address]+36;
}
+(float)addressLabelHeightWithString:(NSString*)string{
    CGSize size=[string sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(Label_Width,50) lineBreakMode:UILineBreakModeCharacterWrap];
    if (size.height<20) {
        return 20;
    }
    return size.height;
}
+(float)nameLabelHeightWithString:(NSString*)string{
    CGSize size=[string sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(Label_Width,50) lineBreakMode:UILineBreakModeCharacterWrap];
    if (size.height<20) {
        return 20;
    }
    return size.height;
}
-(void)setCellWithDto:(HotelIntroduceDTO*)dto{

    if (dto) {
        self.productImageView.imageURL=dto.imageUrl;
        
        self.nameLabel.text=dto.name;
        self.addressLabel.text=dto.address;
        [self.starView setStarsImages:dto.starLevel];
        
        CGRect nameLabelFrame=self.nameLabel.frame;
        nameLabelFrame.size.height=[NewHotelIntroduceTitelCell nameLabelHeightWithString:dto.address];
        self.nameLabel.frame=nameLabelFrame;
        
        CGRect addressLblFrame=self.addressLabel.frame;
        addressLblFrame.origin.y=self.nameLabel.bottom;
        addressLblFrame.size.height=[NewHotelIntroduceTitelCell addressLabelHeightWithString:dto.address];
        self.addressLabel.frame=addressLblFrame;
        
        CGRect starViewFrame=self.starView.frame;
        starViewFrame.origin.y=self.addressLabel.bottom+3;
        self.starView.frame=starViewFrame;
        self.starView.left=self.productImageView.right+10;
        [self.starView setStarsImages:dto.starLevel];
        
//        self.lineImageView.top=self.starView.bottom+3;
    }
    return;
}
@end

//
//  HotelIntroduceTitelCell.m
//  SuningEBuy
//
//  Created by robin wang on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HotelIntroduceTitelCell.h"

@implementation HotelIntroduceTitelCell

@synthesize productImageView = _productImageView;

@synthesize numberLbl = _numberLbl;

@synthesize addressLbl = _addressLbl;

@synthesize starLevelLbl = _starLevelLbl;

@synthesize starView = _starView;

@synthesize merchItemDTO = _merchItemDTO;

//@synthesize changeEventSegment = _changeEventSegment;

@synthesize lineImageView=_lineImageView;

@synthesize leftBtn=_leftBtn;

@synthesize centerBtn=_centerBtn;

@synthesize rightBtn=_rightBtn;
- (void)dealloc
{
    TT_RELEASE_SAFELY(_productImageView);
    
    TT_RELEASE_SAFELY(_numberLbl);
    
    TT_RELEASE_SAFELY(_addressLbl);
    
    TT_RELEASE_SAFELY(_starLevelLbl);
    
    TT_RELEASE_SAFELY(_starView);
    
    TT_RELEASE_SAFELY(_merchItemDTO);
    
    TT_RELEASE_SAFELY(_lineImageView);
    

    TT_RELEASE_SAFELY(_leftBtn);
    
    TT_RELEASE_SAFELY(_centerBtn);
    TT_RELEASE_SAFELY(_rightBtn);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.productImageView.tag = 23;
        self.numberLbl.text = @"";
        self.addressLbl.text = @"";
        
        self.starView.tag = 23;
        
    }
    return self;
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

- (UILabel *)numberLbl
{
    if (_numberLbl == nil) 
    {
        UIFont *font = [UIFont systemFontOfSize:15];
        
		_numberLbl = [[UILabel alloc] initWithFrame:CGRectMake(_productImageView.right+10, 5, 220, 25)];
		
		_numberLbl.backgroundColor = [UIColor clearColor];
		
		_numberLbl.font = font;
        
        _numberLbl.numberOfLines = 0;
		
		_numberLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self addSubview:_numberLbl];

    }
    return _numberLbl;
}

- (UILabel *)addressLbl
{
    if (_addressLbl == nil) 
    {
        
        UIFont *font = [UIFont systemFontOfSize:13];
		
		_addressLbl = [[UILabel alloc] initWithFrame:CGRectMake(_productImageView.right+10, _numberLbl.bottom, 230,25)];
		
		_addressLbl.backgroundColor = [UIColor clearColor];
		
		_addressLbl.font = font;
        
        _addressLbl.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        
        _addressLbl.numberOfLines = 0;
		
		_addressLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self addSubview:_addressLbl];
  
    }
    
    return _addressLbl;
}

-(HotelStarView *)starView
{
    if (_starView == nil) {
        
        _starView = [[HotelStarView alloc] initWithFrame:CGRectMake(_productImageView.right+10, _addressLbl.bottom+10, 80, 20)];
        
        _starView.backgroundColor = [UIColor clearColor];
        
        _starView.userInteractionEnabled = NO;
        
        [self addSubview: _starView];
    }
    
    return _starView;
}

//- (UISegmentedControl *)changeEventSegment{
//    
//    if (_changeEventSegment == nil) {
//        
//        _changeEventSegment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:L(@"hotelIntroduce"),L(@"facilityService"),L(@"photoes"), nil]];
//        
//        _changeEventSegment.segmentedControlStyle = UISegmentedControlStylePlain;
//        
//        _changeEventSegment.tintColor =  RGBCOLOR(63, 175, 1800);
//        
//        _changeEventSegment.backgroundColor = [UIColor clearColor];
//        
//        _changeEventSegment.frame = CGRectMake(10, _starView.bottom, 300, 30);
//        
//        //[_changeEventSegment addTarget:self action:@selector(selectChageRange:) forControlEvents:UIControlEventValueChanged];
//        
//        _changeEventSegment.multipleTouchEnabled=NO;
//        
//        _changeEventSegment.momentary = NO; 
//        
//        [self addSubview: _changeEventSegment];
//        
//    }
//    return _changeEventSegment;
//}
-(UIImageView*)lineImageView
{
    if (_lineImageView==nil) {
        _lineImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        UIImage* img=[UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
        [_lineImageView setImage:img];
        TT_RELEASE_SAFELY(img);
        
        [self addSubview:_lineImageView];
    }
    return _lineImageView;
}
-(UIButton*)leftBtn{
    
    if (_leftBtn==nil) {
        _leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setFrame:CGRectMake(20, 18, 80, 30)];
        [_leftBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        [_leftBtn setTitle:L(@"hotelIntroduce") forState:UIControlStateNormal];
        [_leftBtn setTitle:L(@"hotelIntroduce") forState:UIControlStateSelected];
        
        [_leftBtn setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor light_Black_Color] forState:UIControlStateSelected];
        
        UIImage* normalImg=[UIImage newImageFromResource:@"button_white_normal@2x.png"];
        [_leftBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
        TT_RELEASE_SAFELY(normalImg);
        
        UIImage* selectedImage=[UIImage newImageFromResource:@"button_white_clicked@2x.png"];
        [_leftBtn setBackgroundImage:selectedImage forState:UIControlStateSelected];
        TT_RELEASE_SAFELY(selectedImage);
        
        [self addSubview:_leftBtn];
        
    }
    return _leftBtn;
}
-(UIButton*)centerBtn{
    
    if (_centerBtn==nil) {
        _centerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_centerBtn setFrame:CGRectMake(120, 18, 80, 30)];
        [_centerBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        [_centerBtn setTitle:L(@"facilityService") forState:UIControlStateNormal];
        [_centerBtn setTitle:L(@"facilityService") forState:UIControlStateSelected];
        
        [_centerBtn setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateNormal];
        [_centerBtn setTitleColor:[UIColor light_Black_Color] forState:UIControlStateSelected];
        
        UIImage* normalImg=[UIImage newImageFromResource:@"button_white_normal@2x.png"];
        [_centerBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
        TT_RELEASE_SAFELY(normalImg);
        
        UIImage* selectedImage=[UIImage newImageFromResource:@"button_white_clicked@2x.png"];
        [_centerBtn setBackgroundImage:selectedImage forState:UIControlStateSelected];
        TT_RELEASE_SAFELY(selectedImage);
        
        [self addSubview:_centerBtn];
        
        
    }
    return _centerBtn;
}

-(UIButton*)rightBtn{
    
    if (_rightBtn==nil) {
        _rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setFrame:CGRectMake(220, 18, 80, 30)];
        [_rightBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        [_rightBtn setTitle:L(@"BTAdministrativeRegion") forState:UIControlStateNormal];
        [_rightBtn setTitle:L(@"BTAdministrativeRegion") forState:UIControlStateSelected];
        
        [_rightBtn setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor light_Black_Color] forState:UIControlStateSelected];
        
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"button_white_normal@2x"] forState:UIControlStateNormal];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"button_white_clicked@2x"] forState:UIControlStateSelected];
        [self addSubview:_rightBtn];
        
        
        
    }
    return _rightBtn;
}
- (void)setMerchItemDTO:(HotelIntroduceDTO *)merchItemDTO
{
//    if (merchItemDTO != _merchItemDTO) 
//    {
//        TT_RELEASE_SAFELY(_merchItemDTO);
//        
        _merchItemDTO = merchItemDTO;
        
        self.productImageView.imageURL = _merchItemDTO.imageUrl;
        
        self.numberLbl.text = _merchItemDTO.name;
    CGSize nameSize = [ _merchItemDTO.name sizeWithFont:self.numberLbl.font constrainedToSize:CGSizeMake(self.numberLbl.frame.size.width, 50) lineBreakMode:UILineBreakModeCharacterWrap];
    CGRect nameFrame = self.numberLbl.frame;
    nameFrame.size.height = nameSize.height;
    self.numberLbl.frame = nameFrame;
    self.numberLbl.text = _merchItemDTO.name;
    
    self.addressLbl.top = self.numberLbl.bottom+3;
    
    CGSize infoSize = [ _merchItemDTO.address sizeWithFont:self.addressLbl.font constrainedToSize:CGSizeMake(self.addressLbl.frame.size.width, 40) lineBreakMode:UILineBreakModeCharacterWrap];
    CGRect frame = self.addressLbl.frame;
    frame.size.height = infoSize.height;
    self.addressLbl.frame = frame;
    self.addressLbl.text = _merchItemDTO.address;
    
    self.starView.top = self.addressLbl.bottom+5;
    self.starView.left=self.productImageView.right+10;
    [self.starView setStarsImages:_merchItemDTO.starLevel];
    
    self.leftBtn.top=self.starView.bottom;
    self.centerBtn.top=self.leftBtn.top;
    self.rightBtn.top=self.leftBtn.top;
    
//    self.changeEventSegment.top = self.starView.bottom;
//    self.changeEventSegment.tag = 23;
    
//    self.lineImageView.top=self.changeEventSegment.bottom+4;
    
    self.height = self.leftBtn.bottom+5;
    
    

}

@end
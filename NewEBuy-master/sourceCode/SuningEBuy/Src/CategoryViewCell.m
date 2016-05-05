//
//  CategoryViewCell.m
//  SuningEBuy
//
//  Created by 周俊杰 on 13-12-23.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#define FrontWidth                 93
#define LabelWidth                 190

#import "CategoryViewCell.h"

@implementation CategoryViewCell
@synthesize kindNameLbl       = _kindNameLbl;
@synthesize kindDesLbl        = _kindDesLbl;
@synthesize menuImageView     = _menuImageView;
@synthesize item              = _item;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    
//        self.backgroundColor = [UIColor colorWithHexString:@"0xf2f2f2"];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.cellSeparatorLine = [[UIImageView alloc]initWithFrame:CGRectMake(0,76,320,1)];
        self.cellSeparatorLine.backgroundColor = [UIColor colorWithRGBHex:0xdcdcdc];
        [self.contentView addSubview:self.cellSeparatorLine];
        
        self.verticalLine.hidden = YES;
        self.leftArrow.hidden = YES;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

- (void)dealloc{
	
	TT_RELEASE_SAFELY(_kindNameLbl);
    
    TT_RELEASE_SAFELY(_kindDesLbl);

    TT_RELEASE_SAFELY(_menuImageView);

    TT_RELEASE_SAFELY(_item);

}

- (void)setItem:(V2FristCategoryDTO *)aItem{
	
	if (aItem != _item) {
		_item = aItem;
		
		self.kindNameLbl.text = _item.kindName;
        self.kindDesLbl.text = _item.kindDesc;
        
        [self.menuImageView setImageURL:[NSURL URLWithString:NotNilAndNull(aItem.pictureUrl)?aItem.pictureUrl:@""]];
	}
}

#pragma mark - 
#pragma mark get Method

- (UILabel *)kindNameLbl{
	
	if (!_kindNameLbl) {
		
		UIFont *font = [UIFont boldSystemFontOfSize:17];
		
//		CGSize size = [@"a" sizeWithFont:font];
		
		_kindNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(FrontWidth, 19,LabelWidth, 20)];
        
		_kindNameLbl.backgroundColor = [UIColor clearColor];
        
        _kindNameLbl.textColor = [UIColor colorWithRGBHex:0x313131];
		
        _kindNameLbl.font = font;
        
		_kindNameLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_kindNameLbl];
	}
	return _kindNameLbl;
}

-(UILabel *)kindDesLbl{
	
	if (!_kindDesLbl) {
        
        UIFont *font = [UIFont boldSystemFontOfSize:13];
        
//		CGSize size = [@"a" sizeWithFont:font];
		
		_kindDesLbl = [[UILabel alloc] initWithFrame:CGRectMake(FrontWidth,43,LabelWidth,15)];
        
        _kindDesLbl.textColor = [UIColor dark_Gray_Color];
		
        _kindDesLbl.backgroundColor = [UIColor clearColor];
		
		_kindDesLbl.font = font;
        
		_kindDesLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_kindDesLbl];
	}

	return _kindDesLbl;
}

- (EGOImageView *)menuImageView{
	
	if (!_menuImageView) {
		
		_menuImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(14, 6, 63, 63)];
		
		_menuImageView.backgroundColor =[UIColor clearColor];
		
		[self.contentView addSubview:_menuImageView];
	}
	
	return _menuImageView;
}

- (UIImageView *)leftArrow
{
    if (!_leftArrow)
    {
        _leftArrow = [[UIImageView alloc] initWithFrame:CGRectMake(91.5 - 9, 6, 9, 65)];
        _leftArrow.image = [UIImage imageNamed:@"AllCata_LeftArrow.png"];
        
        [self.contentView addSubview:_leftArrow];
    }
    
    return _leftArrow;
}

- (UIImageView *)verticalLine
{
    if (!_verticalLine)
    {
        _verticalLine = [[UIImageView alloc] initWithFrame:CGRectMake(91, 0, 0.5, 77)];
        _verticalLine.backgroundColor = RGBCOLOR(220, 220, 220);
        
        [self.contentView addSubview:_verticalLine];
    }
    
    return _verticalLine;
}

@end

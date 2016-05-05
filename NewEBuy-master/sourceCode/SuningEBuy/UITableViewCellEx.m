//
//  UITableViewCellEx.m
//  SuningEBuy
//
//  Created by zhaojw on 11-9-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UITableViewCellEx.h"

#define  IMAGE_DEFAULT_SIZE_WIDTH    64
#define  IMAGE_DEFAULT_SIZE_HEIGHT   64

@implementation UITableViewCellEx


@synthesize iconImageView = _iconImageView;

@synthesize titleLbl = _titleLbl;

@synthesize subtitleLbl = _subtitleLbl;



- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier{
	
	if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuseIdentifier]) {
		
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		self.autoresizesSubviews = YES;
		
		if (IOS7_OR_LATER) {
            self.backgroundColor =[UIColor cellBackViewColor];
        }
        else
        {
            UIView *back = [UIView new];
            back.backgroundColor =[UIColor cellBackViewColor];
            self.backgroundView = back;
        }
		
	}
	
	return self;
}

-(void)dealloc{
	
	TT_RELEASE_SAFELY(_iconImageView);
	
	TT_RELEASE_SAFELY(_titleLbl);
	
	TT_RELEASE_SAFELY(_subtitleLbl);
	
	
}

- (void)prepareForReuse {
	
    [super prepareForReuse];
    
    [_iconImageView removeFromSuperview];
    
    TT_RELEASE_SAFELY(_iconImageView);
    
}

-(UILabel *) titleLbl{
	
	if (!_titleLbl) {
		
		UIFont *font = [UIFont boldSystemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 100, size.height)];
		
		_titleLbl.backgroundColor = [UIColor clearColor];
		
		_titleLbl.font = font;
		
		_titleLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_titleLbl];
	}
		
	return _titleLbl;
}

-(UILabel *) subtitleLbl{
	
	if (!_subtitleLbl) {
		
		UIFont *font = [UIFont boldSystemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_subtitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 100, size.height)];
		
		_subtitleLbl.backgroundColor = [UIColor clearColor];
		
		_subtitleLbl.font = font;
		
		_subtitleLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_subtitleLbl];
	}
	
	return _subtitleLbl;
}


-(EGOImageView *) iconImageView{
	
	if (!_iconImageView) {
		
		_iconImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(5, 10, IMAGE_DEFAULT_SIZE_WIDTH, IMAGE_DEFAULT_SIZE_WIDTH)];
		
		_iconImageView.backgroundColor =[UIColor clearColor];
		
		[self.contentView addSubview:_iconImageView];
		
	}
	
	return _iconImageView;
}

@end

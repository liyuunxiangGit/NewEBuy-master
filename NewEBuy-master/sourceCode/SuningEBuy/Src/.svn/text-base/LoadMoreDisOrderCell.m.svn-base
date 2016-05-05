//
//  LoadMoreDisOrderCell.m
//  SuningEBuy
//
//  Created by caowei on 12-3-1.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "LoadMoreDisOrderCell.h"



static const CGFloat kMoreButtonMargin = 20;
static const CGFloat kSmallMargin = 10;

@implementation LoadMoreDisOrderCell

@synthesize  activityIndicatorView = _activityIndicatorView;

@synthesize  animating = _animating;

@synthesize  title = _title;


-(void)dealloc{
    
    
    TT_RELEASE_SAFELY(_activityIndicatorView);
    
    TT_RELEASE_SAFELY(_title);
    
}


+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
    
    return  80;
}

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier{
	
	if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuseIdentifier]) {
		
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		self.autoresizesSubviews = YES;
		
		self.contentView.backgroundColor = [UIColor clearColor];
        
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        
        self.textLabel.textColor = [UIColor grayColor];
        
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        _animating = NO;
        
	}
	
	return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
	self.textLabel.text = L(self.title);
    
    self.textLabel.frame = CGRectMake(kMoreButtonMargin, self.textLabel.top,
                                      self.contentView.width - (kMoreButtonMargin + kSmallMargin),
                                      self.textLabel.height);
    self.textLabel.textAlignment = UITextAlignmentCenter;
    
    self.activityIndicatorView.left = self.textLabel.width/2-50;  
    
    self.activityIndicatorView.top =  self.textLabel.top;  
	
    
}


- (UIActivityIndicatorView*)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
                                  UIActivityIndicatorViewStyleGray];
        [self.contentView addSubview:_activityIndicatorView];
    }
    return _activityIndicatorView;
}

- (void)setAnimating:(BOOL)animating {
    _animating = animating;
    
    if (_animating) {
        [self.activityIndicatorView startAnimating];
    } else {
        [_activityIndicatorView stopAnimating];
    }
    [self setNeedsLayout];
}

@end
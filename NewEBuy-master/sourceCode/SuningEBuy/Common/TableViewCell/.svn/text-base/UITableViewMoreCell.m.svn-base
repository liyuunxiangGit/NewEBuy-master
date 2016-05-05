//
//  UITableViewMoreCell.m
//  SuningEBuy
//
//  Created by zhaojw on 10/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UITableViewMoreCell.h"

static const CGFloat kMoreButtonMargin = 26;
static const CGFloat kSmallMargin = 21;

@implementation UITableViewMoreCell

@synthesize  activityIndicatorView = _activityIndicatorView;

@synthesize  animating = _animating;

@synthesize  title = _title;


-(void)dealloc{
    
    
    TT_RELEASE_SAFELY(_activityIndicatorView);
    
    TT_RELEASE_SAFELY(_title);
    
}


+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
    
    return  48;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
    if (self = [super initWithStyle:style reuseIdentifier:identifier]) {
        
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        
        self.textLabel.textColor = [UIColor lightGrayColor];
        
      // self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //UIView *backgroundView = [[UIView alloc] initWithFrame:self.frame];
        
        //self.backgroundView = backgroundView;
        
       // TT_RELEASE_SAFELY(backgroundView);
        
        _animating = NO;
        
        _activityIndicatorView = nil;
        
//        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    }
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// UIView

- (void)layoutSubviews {
        
	self.textLabel.text = L(self.title);
    
    self.textLabel.frame = CGRectMake(kMoreButtonMargin, self.contentView.top,
                                      self.contentView.width - (kMoreButtonMargin + kSmallMargin),
                                      self.contentView.height);
    self.textLabel.textAlignment = UITextAlignmentCenter;
    
    self.textLabel.backgroundColor = [UIColor clearColor];
    
    self.activityIndicatorView.left = self.textLabel.width/2 - 50;
    self.activityIndicatorView.top =  self.textLabel.height/2 - 10;
 
    [super layoutSubviews];

}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewCell



///////////////////////////////////////////////////////////////////////////////////////////////////
// public

- (UIActivityIndicatorView*)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
                                  UIActivityIndicatorViewStyleGray];
        [self.contentView addSubview:_activityIndicatorView];
    }
    return _activityIndicatorView;
}

- (void)setAnimating:(BOOL)animating {
    if (_animating != animating) {
        _animating = animating;
        
        if (_animating) {
            [self.activityIndicatorView startAnimating];
        } else {
            [_activityIndicatorView stopAnimating];
        }
        [self setNeedsLayout];
    }
}


@end

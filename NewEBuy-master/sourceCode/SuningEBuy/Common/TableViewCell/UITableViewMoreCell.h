//
//  UITableViewMoreCell.h
//  SuningEBuy
//
//  Created by zhaojw on 10/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNUITableViewCell.h"

@interface UITableViewMoreCell : SNUITableViewCell{
    
    UIActivityIndicatorView* _activityIndicatorView;
    
    BOOL _animating;
    
    NSString *_title;
}


@property(nonatomic,strong) UIActivityIndicatorView* activityIndicatorView;

@property(nonatomic,assign) BOOL animating;

@property(nonatomic,strong) NSString *title;


@end

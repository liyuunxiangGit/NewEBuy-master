//
//  LoadMoreDisOrderCell.h
//  SuningEBuy
//
//  Created by caowei on 12-3-1.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadMoreDisOrderCell : UITableViewCell{
    
    UIActivityIndicatorView* _activityIndicatorView;
    
    BOOL _animating;
    
    NSString *_title;
}


@property(nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;

@property(nonatomic,assign) BOOL animating;

@property(nonatomic,strong) NSString *title;

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end

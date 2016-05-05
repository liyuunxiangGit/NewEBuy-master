//
//  IndicatorButton.m
//  SuningEBuy
//
//  Created by shasha on 12-5-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "IndicatorButton.h"


@implementation IndicatorButton
@synthesize indicatorIconView = _indicatorIconView;
@synthesize upIcon = _upIcon;
@synthesize downIcon = _downIcon;
@synthesize selectedBackgroudImage = _selectedBackgroudImage;
@synthesize unselectedBackgroudImage = _unselectedBackgroudImage;
@synthesize isSelected = _isSelected;
@synthesize isIndicatorUp = _isIndicatorUp;

- (id)init {
    self = [super init];
    if (self) {
        
        _isSelected = NO;
        
        _isIndicatorUp = YES;
        
    }
    return self;
}


- (void)dealloc {
    TT_RELEASE_SAFELY(_indicatorIconView);
    TT_RELEASE_SAFELY(_selectedBackgroudImage);
    TT_RELEASE_SAFELY(_unselectedBackgroudImage);
}


-(void)setIsSelected:(BOOL)isSelected{
    
    _isSelected = isSelected;
    
    if (self.isSelected == YES) {
        
        [self setBackgroundImage:self.selectedBackgroudImage forState:UIControlStateNormal];
    }else{
        
        [self setBackgroundImage:self.unselectedBackgroudImage forState:UIControlStateNormal];
    }
    
}

- (void)setIsIndicatorUp:(BOOL)isIndicatorUp{
    
    _isIndicatorUp = isIndicatorUp;
    
    if (self.isIndicatorUp == YES) {
        
        self.indicatorIconView.image = self.upIcon;
        
    }else{
    
        self.indicatorIconView.image = self.downIcon;
    
    }

}




- (UIImageView *)indicatorIconView{

    if (!_indicatorIconView) {
        
        _indicatorIconView = [[UIImageView alloc] init];
        
        _indicatorIconView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_indicatorIconView];
    }
    
    return _indicatorIconView;

}












@end

//
//  NJPageScrollViewCell.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-4-25.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "NJPageScrollViewCell.h"

@implementation NJPageScrollViewCell

@synthesize reuseIdentifier = _reuseIdentifier;

- (void)dealloc {
    TT_RELEASE_SAFELY(_reuseIdentifier);
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super init];
    
    if (self) {
        self.reuseIdentifier = reuseIdentifier;
    }
    return self;
}

- (void)prepareForReuse
{
    
}

@end

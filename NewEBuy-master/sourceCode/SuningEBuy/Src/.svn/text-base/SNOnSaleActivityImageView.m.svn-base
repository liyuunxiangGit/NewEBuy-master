//
//  SNOnSaleActivityImageView.m
//  SuningEBuy
//
//  Created by 芳奎 赵 on 12-9-20.
//  Copyright (c) 2012年 苏宁. All rights reserved.
//

#import "SNOnSaleActivityImageView.h"

@implementation SNOnSaleActivityImageView

@synthesize activityId = _activityId;
@synthesize tagEx = _tagEx;
@synthesize sortType=_sortType;
@synthesize actName = _actName;
//@synthesize delegate = _delegate;

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        self.placeholderImage = [UIImage imageNamed:@"ebuy_default_image_placeholder.png"];
        self.contentMode = UIViewContentModeScaleToFill;
    }
    return self;
}
-(void)dealloc{
    TT_RELEASE_SAFELY(_activityId);
    TT_RELEASE_SAFELY(_tagEx);
    TT_RELEASE_SAFELY(_sortType);
    TT_RELEASE_SAFELY(_actName);
}
@end

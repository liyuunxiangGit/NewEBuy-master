//
//  contractibleImageView.m
//  TCWeiBoSDKDemo
//
//  Created by zzz on 8/28/12.
//  Copyright (c) 2012 bysft. All rights reserved.
//

#import "contractibleImageView.h"

@implementation contractibleImageView
@synthesize deledateBtn;

- (id)init {
    self = [super init];
    if (self) {
        deledateBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [deledateBtn setTitle:@"x" forState:UIControlStateNormal];
        deledateBtn.frame = CGRectMake(0, 0, 10, 10);
        self.userInteractionEnabled = YES;
        [self addSubview:deledateBtn];
    }
    return self;
}

@end

//
//  SNUIActionSheet.m
//  SNFramework
//
//  Created by  liukun on 13-6-18.
//  Copyright (c) 2013年 liukun. All rights reserved.
//

#import "SNUIActionSheet.h"

@implementation SNUIActionSheet

- (void)dealloc
{
    [_completeBlockMap removeAllObjects];
    _completeBlockMap = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setDismissBlock:(SNBasicBlock)block atButtonIndex:(NSInteger)buttonIndex
{
    if (!block) {
        return;
    }
    
    self.delegate = self;
    
    BBBasicBlock _block = [block copy];
    
    if (_completeBlockMap == nil) {
        _completeBlockMap = [[NSMutableDictionary alloc] init];
    }
    
    [_completeBlockMap setObject:_block forKey:[NSString stringWithFormat:@"%d", buttonIndex]];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSString *indexKey = [NSString stringWithFormat:@"%d", buttonIndex];
    
    BBBasicBlock block = [_completeBlockMap objectForKey:indexKey];
    
    if (block) {
        block();
    }
}

@end

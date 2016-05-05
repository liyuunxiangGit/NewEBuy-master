//
//  SNAlertView.m
//  SNFramework
//
//  Created by  liukun on 13-1-15.
//  Copyright (c) 2013年 liukun. All rights reserved.
//

#import "SNUIAlertView.h"

@implementation SNUIAlertView

- (void)dealloc
{
    [_completeBlockMap removeAllObjects];
    _completeBlockMap = nil;
}

+ (void)alertMessage:(NSString *)msg
         cancelTitle:(NSString *)cancelTitle
        confirmTitle:(NSString *)confirmTitle
         cancelBlock:(SNBasicBlock)cancelBlock
        confirmBlock:(SNBasicBlock)confirmBlock
{
    SNUIAlertView *alert = [[SNUIAlertView alloc] initWithTitle:L(@"system-info")
                                                        message:msg
                                                       delegate:nil
                                              cancelButtonTitle:cancelTitle
                                              otherButtonTitles:confirmTitle, nil];
    [alert setCancelBlock:cancelBlock];
    [alert setConfirmBlock:confirmBlock];
    [alert show];
}

+ (void)alertMessage:(NSString *)msg btnTitle:(NSString *)title block:(SNBasicBlock)block
{
    SNUIAlertView *alert = [[SNUIAlertView alloc] initWithTitle:L(@"system-info")
                                                        message:msg
                                                       delegate:nil
                                              cancelButtonTitle:title
                                              otherButtonTitles:nil];
    [alert setCancelBlock:block];
    [alert show];
}


#pragma mark -
#pragma mark block setter

- (void)setCancelBlock:(SNBasicBlock)block
{
    [self setCompleteBlock:block atIndex:0];
}

- (void)setConfirmBlock:(SNBasicBlock)block
{
    [self setCompleteBlock:block atIndex:1];
}

- (void)setCompleteBlock:(SNBasicBlock)block atIndex:(NSInteger)index
{
    if (!block) {
        return;
    }
    
    self.delegate = self;
    
    BBBasicBlock _block = [block copy];
    
    if (_completeBlockMap == nil) {
        _completeBlockMap = [[NSMutableDictionary alloc] init];
    }
    
    [_completeBlockMap setObject:_block forKey:[NSString stringWithFormat:@"%d", index]];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSString *indexKey = [NSString stringWithFormat:@"%d", buttonIndex];
    
    BBBasicBlock block = [_completeBlockMap objectForKey:indexKey];
    
    if (block) {
        block();
    }
}

@end

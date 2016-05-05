//
//  SNUIActionSheet.h
//  SNFramework
//
//  Created by  liukun on 13-6-18.
//  Copyright (c) 2013年 liukun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNUIActionSheet : UIActionSheet <UIActionSheetDelegate>
{
    NSMutableDictionary *_completeBlockMap;
}

- (void)setDismissBlock:(SNBasicBlock)block atButtonIndex:(NSInteger)buttonIndex;

@end

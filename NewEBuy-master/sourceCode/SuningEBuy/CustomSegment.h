//
//  CustomSegment.h
//  suning6iphone
//
//  Created by  liukun on 13-7-23.
//  Copyright (c) 2013年 liukun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomSegment;
@protocol CustomSegmentDelegate <NSObject>

@optional
- (void)segment:(CustomSegment *)segment didSelectAtIndex:(NSInteger)index;

@end

@interface CustomSegment : UIView

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, weak) id<CustomSegmentDelegate> delegate;
@property (nonatomic, strong) NSArray *items; // item of NSString

@end

//
//  NBHomeMenu.h
//  suningNearby
//
//  Created by suning on 14-8-1.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NBHomeMenuDelegate <NSObject>
@optional
- (void)delegate_NBHomeMenu_selected:(NSDictionary *)channel;
@end

@interface NBHomeMenu : UIView

@property (nonatomic,weak) id<NBHomeMenuDelegate> delegate;

@property (nonatomic,strong) NSArray *channels;

@end

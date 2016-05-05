//
//  HDOriginalPhotosViewController.h
//  VenusIphone
//
//  Created by Joe on 14-1-14.
//  Copyright (c) 2014年 hoodinn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDZoomingView.h"

/*
 HDOriginalPhotosViewController *vc = [[HDOriginalPhotosViewController alloc] init];
 vc.imageUrls = photos;
 vc.curImageIndex = selected;
 
 
 [hdGetAppDelegate().tabBarController presentModalViewController:vc animated:YES];
 [vc release];
 
 */

@class HDOriginalPhotosViewController;

@protocol HDOriginalPhotosViewControllerDelegate  <NSObject>

- (void)originalPhotosView:(HDOriginalPhotosViewController *)view popWithPhotoIndex:(int)index;

@end

@interface HDOriginalPhotosViewController : UIViewController <HDZoomingViewDelegate, UIActionSheetDelegate> {
    UIToolbar *_navBar;
    UIStatusBarStyle _previousStatusBarStyle;
    BOOL _controlHidden;
}

@property (nonatomic, retain) NSArray *placeImageUrls;
@property (nonatomic, retain) NSArray *imageUrls;
@property (nonatomic, assign) int      curImageIndex;
@property (nonatomic, assign) BOOL     disableLongPress;
@property (nonatomic, assign) id <HDOriginalPhotosViewControllerDelegate> delegate;

@end
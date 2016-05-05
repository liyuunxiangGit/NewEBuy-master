//
//  HDOriginalPhotoViewController.h
//  VenusIphone
//
//  Created by sumeng on 12-12-19.
//
//

#import <UIKit/UIKit.h>
#import "HDZoomingView.h"
#import "HdMsgBox.h"

@interface HDOriginalPhotoViewController : UIViewController <HDZoomingViewDelegate, UIActionSheetDelegate> {
    UIToolbar *_navBar;
    HDZoomingView *_zoomingView;
    
    UIStatusBarStyle _previousStatusBarStyle;
    BOOL _controlHidden;
}

@property (nonatomic, copy) NSString *imageUrl;

@end

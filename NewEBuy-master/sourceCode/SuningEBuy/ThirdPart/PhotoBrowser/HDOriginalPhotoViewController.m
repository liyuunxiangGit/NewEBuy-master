//
//  HDOriginalPhotoViewController.m
//  VenusIphone
//
//  Created by sumeng on 12-12-19.
//
//

#import "HDOriginalPhotoViewController.h"

@interface HDOriginalPhotoViewController ()

@end

@implementation HDOriginalPhotoViewController

@synthesize imageUrl = _imageUrl;

- (id)init
{
    self = [super init];
    if (self) {
        self.wantsFullScreenLayout = YES;
    }
    return self;
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    [[HdMsgBox sharedInstance] hideHUDInView:self.view];
    if (error) {
        [[HdMsgBox sharedInstance] showHUDTextOnly:@"保存失败，请稍后重试！" duration:1.5 inView:self.view];
    }
    else {
        [[HdMsgBox sharedInstance] showHUDTextOnly:@"保存成功" duration:1.5 inView:self.view];
    }
}

- (void)actuallySavePhoto:(UIImage *)photo {
    if (photo) {
        UIImageWriteToSavedPhotosAlbum(photo, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)savePhoto:(UIImage *)photo {
    if (photo) {
        [[HdMsgBox sharedInstance] showHUDLoadingWithText:@"保存中……" inView:self.view];
        [self performSelector:@selector(actuallySavePhoto:) withObject:photo afterDelay:0];
    }
}

- (void)closeBtnPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)saveBtnPressed:(id)sender {
    [self savePhoto:[_zoomingView getImage]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    _zoomingView = [[HDZoomingView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _zoomingView.tapDelegate = self;
    [_zoomingView setUrl:[NSURL URLWithString:_imageUrl]];
    [self.view addSubview:_zoomingView];
    
    _navBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 40)];
    _navBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _navBar.barStyle = UIBarStyleBlackTranslucent;
    [self.view addSubview:_navBar];
    
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleBordered target:self action:@selector(closeBtnPressed:)];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(saveBtnPressed:)];
    
    [_navBar setItems:[NSArray arrayWithObjects:closeItem, spaceItem, saveItem, nil]];
    
    [saveItem release];
    [spaceItem release];
    [closeItem release];
    
    //_controlHidden = NO;
    [self setControlHidden:YES animated:NO];
}

- (void)viewDidUnload {
    [_navBar release], _navBar = nil;
    [_zoomingView release], _zoomingView = nil;
    [_imageUrl release], _imageUrl = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        _previousStatusBarStyle = [[UIApplication sharedApplication] statusBarStyle];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:animated];
    }
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

- (void)viewWillDisappear:(BOOL)animated {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [[UIApplication sharedApplication] setStatusBarStyle:_previousStatusBarStyle animated:animated];
    }
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_navBar release];
    [_zoomingView release];
    [_imageUrl release];
    [super dealloc];
}

- (void)setControlHidden:(BOOL)hidden animated:(BOOL)animated {
    // Get status bar height if visible
    CGFloat statusBarHeight = 0;
    if (![UIApplication sharedApplication].statusBarHidden) {
        CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
        statusBarHeight = MIN(statusBarFrame.size.height, statusBarFrame.size.width);
    }
    
    // Status Bar
//    [[UIApplication sharedApplication] setStatusBarHidden:hidden withAnimation:animated?UIStatusBarAnimationFade:UIStatusBarAnimationNone];
    
    // Get status bar height if visible
    if (![UIApplication sharedApplication].statusBarHidden) {
        CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
        statusBarHeight = MIN(statusBarFrame.size.height, statusBarFrame.size.width);
    }
    
    // Set navigation bar frame
    CGRect navBarFrame = self.navigationController.navigationBar.frame;
    navBarFrame.origin.y = statusBarHeight;
    self.navigationController.navigationBar.frame = navBarFrame;
	
	// Animate
    if (animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.35];
    }
    
    CGFloat alpha = hidden ? 0 : 1;
	[self.navigationController.navigationBar setAlpha:alpha];
	[_navBar setAlpha:alpha];

	if (animated) {
        [UIView commitAnimations];
    }
}

#pragma mark - Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

#pragma mark - HDZoomingView delegate

- (void)zoomingViewSingleTapDetected:(HDZoomingView *)view {
//    _controlHidden = !_controlHidden;
//    [self setControlHidden:_controlHidden animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)zoomingViewDoubleTapDetected:(HDZoomingView *)view {
    
}

- (void)zoomingViewLongPressedDetected:(HDZoomingView *)view {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@""
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:@"保存"
                                              otherButtonTitles:nil];
    [sheet showInView:self.view];
    [sheet release];
}

#pragma mark - UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        [self savePhoto:[_zoomingView getImage]];
    }
}

@end
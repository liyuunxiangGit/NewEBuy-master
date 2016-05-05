//
//  HDOriginalPhotosViewController.m
//  VenusIphone
//
//  Created by Joe on 14-1-14.
//  Copyright (c) 2014年 hoodinn. All rights reserved.
//

#import "HDOriginalPhotosViewController.h"
#import "HdMsgBox.h"
#import "EGOCache.h"

#define CellInterval 20

//优化先显示小图,加载完再显示大图
inline static NSString* keyURL(NSURL* url, NSString* nameSpace)
{
   	if(nameSpace.length > 0) {
		return [NSString stringWithFormat:@"%@.EGOImage-%u", nameSpace, [[url description] hash]];
	} else {
		return [NSString stringWithFormat:@"EGOImage-%u", [[url description] hash]];
	}
}

@interface HDOriginalPhotosViewController ()<UIScrollViewDelegate>
{
    UIScrollView    *_scrollView;
    UIPageControl   *_pageControl;
    NSMutableArray  *_cellViews;
}

@end

@implementation HDOriginalPhotosViewController

@synthesize imageUrls = _imageUrls;
@synthesize curImageIndex = _curImageIndex;

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
        [[HdMsgBox sharedInstance] showHUDLoadingWithText:@"保存中" inView:self.view];
        [self performSelector:@selector(actuallySavePhoto:) withObject:photo afterDelay:0];
    }
}

- (void)closeBtnPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)saveBtnPressed:(id)sender {
    [self savePhoto:[[_cellViews objectAtIndex:_pageControl.currentPage] getImage]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setNavHidden:YES];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width+CellInterval, self.view.frame.size.height)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    CGSize	contentSize	= _scrollView.frame.size;
	CGFloat pageWidth = contentSize.width;
	contentSize.width = self.imageUrls.count*pageWidth;
	_scrollView.contentSize = contentSize;
	_scrollView.contentOffset = CGPointMake(0, 0);
    
    _cellViews = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < self.imageUrls.count; ++i) {
        [_cellViews addObject:[NSNull null]];
    }
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-30, self.view.frame.size.width, 20)];
    _pageControl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_pageControl];
    [_pageControl setNumberOfPages:self.imageUrls.count];
    _pageControl.currentPage = 0;
    [_pageControl addTarget:self action:@selector(pageControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    _pageControl.hidden = self.imageUrls.count <= 1?YES:NO;
    
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
    
    [self setControlHidden:YES animated:NO];
    [self setCurPage:_curImageIndex];
}

- (void)viewDidUnload {
    [_navBar release], _navBar = nil;
    [_imageUrls release], _imageUrls = nil;
    [super viewDidUnload];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        _previousStatusBarStyle = [[UIApplication sharedApplication] statusBarStyle];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:animated];
    }
    
    if (iOS7) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    
    
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
//
    
    CGSize pagesScrollViewSize = _scrollView.frame.size;
    _scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * _cellViews.count, pagesScrollViewSize.height);
    [self loadVisiblePages];
}

- (void)viewWillDisappear:(BOOL)animated {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [[UIApplication sharedApplication] setStatusBarStyle:_previousStatusBarStyle animated:animated];
    }
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];

    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_scrollView release];
    [_pageControl release];
    [_navBar release];
    [_imageUrls release];
    [super dealloc];
}

-(void)setCurPage:(int)page
{
    CGFloat pageWidth = _scrollView.frame.size.width;
    [_scrollView setContentOffset:CGPointMake(pageWidth*page, 0) animated:NO];
}

- (void)loadVisiblePages {
    CGFloat pageWidth = _scrollView.frame.size.width;
    NSInteger page = (NSInteger)floor((_scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
    _pageControl.currentPage = page;
    
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    for (NSInteger i=0; i<firstPage; i++) {
        [self purgePage:i];
    }
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        [self loadPage:i];
    }
    for (NSInteger i=lastPage+1; i<_cellViews.count; i++) {
        [self purgePage:i];
    }
}

- (void)loadPage:(NSInteger)page {
    if (page < 0 || page >= _cellViews.count) {
        return;
    }
    
    HDZoomingView *pageView = [_cellViews objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {
        
        CGRect frame = self.view.bounds;
        frame.origin.x = (frame.size.width + CellInterval) * page;
        frame.origin.y = 0.0f;
        HDZoomingView *zoomingView = [[HDZoomingView alloc] initWithFrame:frame];
        zoomingView.tag = page;
        zoomingView.tapDelegate = self;
        //先显示小图
        if (![zoomingView getImage]) {
            UIImage *image = [[EGOCache currentCache] imageForKey: keyURL([_placeImageUrls objectAtIndex:page], kEGOCacheNameSpaceDefault)];
            [zoomingView setImage:image];
        }
        NSString *photoAddress = [_imageUrls objectAtIndex:page];
        if ([photoAddress rangeOfString:@"http:"].length != 0) {
            [zoomingView setUrl:[NSURL URLWithString:photoAddress]];
        }else{
            [zoomingView setFilePath:photoAddress];
        }

        [_scrollView addSubview:zoomingView];
        [_cellViews replaceObjectAtIndex:page withObject:zoomingView];
    }
}

- (void)purgePage:(NSInteger)page {
    if (page < 0 || page >= _cellViews.count) {
        return;
    }
    UIView *pageView = [_cellViews objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [_cellViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}


- (void)setControlHidden:(BOOL)hidden animated:(BOOL)animated {
    // Get status bar height if visible
    CGFloat statusBarHeight = 0;
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
    return NO;
}

- (void)pageControlValueChanged:(id)sender {
	[_scrollView scrollRectToVisible:CGRectMake(_pageControl.currentPage * _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self loadVisiblePages];
}

#pragma mark - HDZoomingView delegate

- (void)zoomingViewSingleTapDetected:(HDZoomingView *)view {
    if (self.delegate && [self.delegate respondsToSelector:@selector(originalPhotosView:popWithPhotoIndex:)]) {
        [self.delegate originalPhotosView:self popWithPhotoIndex:_pageControl.currentPage];
    }
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)zoomingViewDoubleTapDetected:(HDZoomingView *)view {
    
}

- (void)zoomingViewLongPressedDetected:(HDZoomingView *)view {
    if (self.disableLongPress) {
        return;
    }
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
        [self savePhoto:[[_cellViews objectAtIndex:_pageControl.currentPage] getImage]];
    }
}

@end

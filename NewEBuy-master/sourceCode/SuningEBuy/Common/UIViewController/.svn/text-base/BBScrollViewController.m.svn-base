//
//  BBScrollViewController.m
//  SuningEBuy
//
//  Created by  liukun on 12-12-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "BBScrollViewController.h"
#import "objc/runtime.h"

@interface BBScrollViewController()

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIView *pageControlBG;

- (void)registKVO;
- (void)unRegistKVO;


@end

/*********************************************************************/

@implementation BBScrollViewController

@synthesize pageControl = _pageControl;
@synthesize pageControlBG = _pageControlBG;
@synthesize scrollView = _scrollView;
@synthesize viewControllers = _viewControllers;
@dynamic currentPage;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_scrollView);
    TT_RELEASE_SAFELY(_pageControl);
    TT_RELEASE_SAFELY(_pageControlBG);
    
    
    [self unRegistKVO];
}

- (id)init
{
    self = [super init];
    if (self) {
        [self registKVO];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    if(!_scrollView){
        _scrollView = [[SNCycleScrollView alloc] init];
        CGRect frame = self.view.bounds;
        frame.origin.x = 0;
        frame.size.height = frame.size.height - 49;
        _scrollView.frame = frame;
		_scrollView.delegate = self;
        _scrollView.dataSource = self;
		_scrollView.scrollView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
		_scrollView.userInteractionEnabled = YES;
        _scrollView.clipsToBounds = YES;
	}
    [self.view addSubview:_scrollView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.view addSubview:self.pageControl];
    [self.view bringSubviewToFront:self.pageControl];
    [self.view insertSubview:self.pageControlBG belowSubview:self.pageControl];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self.viewControllers count] > _scrollView.currentPage)
    {
        id<BBScrollContentApperace> controller = [self.viewControllers objectAtIndex:_scrollView.currentPage];
        [controller viewAppear];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([self.viewControllers count] > _scrollView.currentPage)
    {
        id<BBScrollContentApperace> controller = [self.viewControllers objectAtIndex:_scrollView.currentPage];
        [controller viewDisappear];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark views

- (CGRect)pageControlFrame
{
    CGSize size = [self.pageControl sizeForNumberOfPages:[self.viewControllers count]];
    CGRect appFrame = [UIScreen mainScreen].bounds;
    CGFloat x = (320-size.width)/2;
    CGFloat y = appFrame.size.height - kStatusBarHeight - kUITabBarFrameHeight - 12;
    return CGRectMake(x, y, size.width, 10);
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.frame = [self pageControlFrame];
        self.pageControl.numberOfPages = [self.viewControllers count];
        self.pageControl.currentPage = 0;
    }
    return _pageControl;
    
}

- (UIView *)pageControlBG
{
    if (!_pageControlBG) {
        _pageControlBG = [[UIView alloc] initWithFrame:
                          CGRectMake(_pageControl.left -10,
                                     _pageControl.top,
                                     _pageControl.width+20,
                                     _pageControl.height)];
        _pageControlBG.backgroundColor = [UIColor blackColor];
        _pageControlBG.layer.cornerRadius = 5.0;
        _pageControlBG.alpha = 0.5;
    }
    return _pageControlBG;
}

#pragma mark -
#pragma mark KVO

- (void)registKVO
{
    [self addObserver:self
           forKeyPath:@"viewControllers"
              options:NSKeyValueObservingOptionNew
              context:NULL];
}

- (void)unRegistKVO
{
    [self removeObserver:self
              forKeyPath:@"viewControllers"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"viewControllers"])
    {
        [self reloadViewControllers];
    }
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    [_scrollView scrollToPage:currentPage];
}

#pragma mark -
#pragma mark reload view Controllers

- (void)reloadViewControllers
{
    NSInteger pageCount = [self.viewControllers count];
    
    self.pageControl.numberOfPages = pageCount;
    self.pageControl.frame = [self pageControlFrame];
    self.pageControlBG.frame = CGRectMake(_pageControl.left -10, _pageControl.top, _pageControl.width+20, _pageControl.height);
    [_scrollView reloadData];
}

#pragma mark -
#pragma mark NJPageScrollView Delegate And Datasource

- (id)findControllerOfView:(UIView *)view {
    // convenience function for casting and to "mask" the recursive function
    return [self traverseResponderChainForUIViewController:view];
}

- (id)traverseResponderChainForUIViewController:(id)view
{
    id nextResponder = [view nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [self traverseResponderChainForUIViewController:nextResponder];
    } else {
        return nil;
    }
}

- (NSInteger)numberOfPagesInScrollView:(SNCycleScrollView *)pageScrollView
{
    return [self.viewControllers count];
}

- (UIView *)scrollView:(SNCycleScrollView *)pageScrollView viewAtPage:(NSInteger)page
{    
//    UIView *cell = [[[UIView alloc] init] autorelease];
    UIViewController *controller = [self.viewControllers objectAtIndex:page];
    controller.view.frame = CGRectMake(0, 0, controller.view.width, controller.view.height);
//    if (!IOS5_OR_LATER) {
//        [controller viewWillAppear:NO];
//    }
////    [cell addSubview:controller.view];
//    if (!IOS5_OR_LATER) {
//        [controller viewDidAppear:NO];
//    }
    return controller.view;
}

- (void)scrollView:(SNCycleScrollView *)scrollView scrollFromPage:(NSInteger)oldPage toPage:(NSInteger)page
{
    self.pageControl.currentPage = page;
    
    if ([self.viewControllers count] > oldPage)
    {
        id<BBScrollContentApperace> oldControl = [self.viewControllers objectAtIndex:oldPage];
        [oldControl viewDisappear];
    }
    
    if ([self.viewControllers count] > page)
    {
        id<BBScrollContentApperace> control = [self.viewControllers objectAtIndex:page];
        [control viewAppear];
    }
    
}

@end



/*********************************************************************/


@implementation UIViewController(BBScroll)

@dynamic bbScrollController;

- (void)setBbScrollController:(BBScrollViewController *)bbScrollController
{
    objc_setAssociatedObject(self, "BBScroll", bbScrollController, OBJC_ASSOCIATION_ASSIGN);
}

- (BBScrollViewController *)bbScrollController
{
    return objc_getAssociatedObject(self, "BBScroll");
}

@end

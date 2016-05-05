//
//  DisOrderPhotosViewController.m
//  SuningEBuy
//
//  Created by caowei on 12-2-29.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "DisOrderPhotosViewController.h"
#import "DisOrderPhotoView.h"

@interface DisOrderPhotosViewController()

/*顶部工具栏*/
@property (nonatomic, strong) UIToolbar *topToolBar;

@property (nonatomic, strong) UILabel *titleLabel;

/*底部工具栏*/
@property (nonatomic, strong) UIToolbar *bottomToolBar;

/*ScrollView*/
@property (nonatomic, strong) UIScrollView *scrollView;

/*保存图片url的数组*/
@property (nonatomic, strong) NSArray *imageURLArray;

/*向左*/
@property (nonatomic, strong) UIBarButtonItem *leftArrow;

/*向右*/
@property (nonatomic, strong) UIBarButtonItem *rightArrow;


- (void)setImageViews;

- (void)setBarItemEnable;
@end

/***************************************************************/

@implementation DisOrderPhotosViewController

@synthesize topToolBar = _topToolBar;
@synthesize titleLabel = _titleLabel;
@synthesize bottomToolBar = _bottomToolBar;
@synthesize scrollView = _scrollView;
@synthesize imageURLArray = _imageURLArray;
@synthesize leftArrow = _leftArrow;
@synthesize rightArrow = _rightArrow;

@synthesize currentImagePage = _currentImagePage;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_topToolBar);
    TT_RELEASE_SAFELY(_titleLabel);
    TT_RELEASE_SAFELY(_bottomToolBar);
    TT_RELEASE_SAFELY(_scrollView);
    TT_RELEASE_SAFELY(_imageURLArray);
    TT_RELEASE_SAFELY(_leftArrow);
    TT_RELEASE_SAFELY(_rightArrow);
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
}

- (id)initWithImageUrlArray:(NSArray *)imUrls
{
    self = [super init];
    
    if (self)
    {
        //设置全屏
        [self setWantsFullScreenLayout:YES];
        
        self.imageURLArray = imUrls;
                
        _currentImagePage = 0;
        
        isHiddenToolBarAndStatusBar = NO;
    }
    return self;
}

#pragma mark -
#pragma mark view lifecycle

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = RGBCOLOR(30, 30, 30);
    
    self.view.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    
    [self.view addSubview:self.scrollView];
    
    [self setImageViews];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{

    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
}

- (void)setImageViews
{
    for (int i = 0; i < [self.imageURLArray count]; i++)
    {        
        DisOrderPhotoView *photoView = [[DisOrderPhotoView alloc] initWithFrame:CGRectMake(320*i, 0, self.scrollView.width, self.scrollView.height)];
        
        photoView.tag = 22+i;
        
        photoView.ptDelegate = self;
        
        [self.scrollView addSubview:photoView];
        
        TT_RELEASE_SAFELY(photoView);
    }
    
    [self.scrollView setContentOffset:CGPointMake(320*_currentImagePage, 0)];
    
    [self.view addSubview:self.topToolBar];
    [self.view addSubview:self.bottomToolBar];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%d/%d", _currentImagePage+1, [self.imageURLArray count]];
    
    DisOrderPhotoView *currentView = (DisOrderPhotoView *)[self.scrollView viewWithTag:22+_currentImagePage];
    
    [currentView setImageUrl:[self.imageURLArray objectAtIndex:_currentImagePage]];
    
}
#pragma mark -
#pragma mark Chrome Helpers


- (void)toggleChrome:(BOOL)hide 
{
    /*
     isHiddenToolBarAndStatusBar = hide;
     if (hide) {
     [UIView beginAnimations:nil context:nil];
     [UIView setAnimationDuration:0.2];
     }
     
     
     [[UIApplication sharedApplication] setStatusBarHidden:hide];
     
     self.topToolBar.hidden = hide;
     self.bottomToolBar.hidden = hide;
     
     if (hide) {
     [UIView commitAnimations];
     }
     */
    [UIView animateWithDuration:0.2
                     animations:^{
                         [[UIApplication sharedApplication] setStatusBarHidden:hide];
                         self.topToolBar.hidden = hide;
                         self.bottomToolBar.hidden = hide;
                     } 
                     completion:^(BOOL finished){
                         isHiddenToolBarAndStatusBar = hide;
                         
                     }];
}

- (void)hideChrome 
{
    [self toggleChrome:YES];
}

- (void)showChrome 
{
    [self toggleChrome:NO];
}

#pragma mark -
#pragma mark Photo View Delegate Methods

- (void)singleTouchTheImageView:(DisOrderPhotoView *)photoView
{
    [self toggleChrome:!isHiddenToolBarAndStatusBar];
}


#pragma mark -
#pragma mark View Getters

- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] init];
        
        _scrollView.frame = self.view.bounds;
        
        _scrollView.delegate = self;
        
        _scrollView.pagingEnabled = YES;
        
        _scrollView.backgroundColor = [UIColor clearColor];
                
        if (self.imageURLArray && [self.imageURLArray count] > 0)
        {
            [_scrollView setContentSize:CGSizeMake(self.view.width*[self.imageURLArray count], self.view.height)];
        }
    }
    return _scrollView;
}

- (UIToolbar *)topToolBar
{
    if(!_topToolBar){
        
        _topToolBar = [[UIToolbar alloc] init];
        
        _topToolBar.barStyle = UIBarStyleBlackTranslucent;
        
        [_topToolBar sizeToFit];
        
        _topToolBar.top = self.view.top+20;        
        
        UIBarButtonItem *backButton = 
        [[UIBarButtonItem alloc] initWithTitle:L(@"Back")
                                         style:UIBarButtonItemStyleBordered 
                                        target:self                                                                         
                                        action:@selector(backClick:)];
        
        UIBarButtonItem *titleItem = 
        [[UIBarButtonItem alloc] initWithCustomView:self.titleLabel];
        
        [_topToolBar setItems:[NSArray arrayWithObjects:backButton, titleItem, nil]];
        
        TT_RELEASE_SAFELY(backButton);
        TT_RELEASE_SAFELY(titleItem);
    }
    return _topToolBar;
}

- (UIToolbar *)bottomToolBar
{
    if (!_bottomToolBar)
    {
        _bottomToolBar = [[UIToolbar alloc] init];
        
        _bottomToolBar.barStyle = UIBarStyleBlackTranslucent;
        
        [_bottomToolBar sizeToFit];
        
        _bottomToolBar.bottom = self.view.bottom;  
        
        
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 85, 44)];
        view1.backgroundColor = [UIColor clearColor];
        UIBarButtonItem *flax1 = 
        [[UIBarButtonItem alloc] initWithCustomView:view1];
        TT_RELEASE_SAFELY(view1);
        
        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
        view2.backgroundColor = [UIColor clearColor];
        UIBarButtonItem *flax2 = 
        [[UIBarButtonItem alloc] initWithCustomView:view2];
        TT_RELEASE_SAFELY(view2);
        
        UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 85, 44)];
        view3.backgroundColor = [UIColor clearColor];
        UIBarButtonItem *flax3 = 
        [[UIBarButtonItem alloc] initWithCustomView:view3];
        TT_RELEASE_SAFELY(view3);
        
        [self setBarItemEnable];
        
        [_bottomToolBar setItems:[NSArray arrayWithObjects:flax1, self.leftArrow, flax2, self.rightArrow, flax3, nil]];
        
        TT_RELEASE_SAFELY(flax1);
        TT_RELEASE_SAFELY(flax2);
        TT_RELEASE_SAFELY(flax3);
        
    }
    return _bottomToolBar;
}

- (UIBarButtonItem *)leftArrow
{
    if (!_leftArrow)
    {
        _leftArrow = 
        [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"leftArrow.png"]
                                         style:UIBarButtonItemStylePlain 
                                        target:self
                                        action:@selector(turnLeftPage)];
    }
    return _leftArrow;
}

- (UIBarButtonItem *)rightArrow
{
    if (!_rightArrow)
    {
        _rightArrow = 
        [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"rightArrow.png"]
                                         style:UIBarButtonItemStylePlain 
                                        target:self
                                        action:@selector(turnRightPage)];
        
    }
    return _rightArrow;
}



- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 220, 20)];
        
        _titleLabel.backgroundColor = [UIColor clearColor];
        
        _titleLabel.textColor = [UIColor whiteColor];
        
        _titleLabel.font = [UIFont boldSystemFontOfSize:20];
        
        _titleLabel.textAlignment = UITextAlignmentCenter;
    }
    return _titleLabel;
}

#pragma mark -
#pragma mark Actions

- (void)setBarItemEnable
{
    if (_currentImagePage == 0)
    {
        self.leftArrow.enabled = NO;
    }
    else
    {
        self.leftArrow.enabled = YES;
    }
    
    if (_currentImagePage == [self.imageURLArray count]-1)
    {
        self.rightArrow.enabled = NO;
    }
    else
    {
        self.rightArrow.enabled = YES;
    }
    
}

- (void)scrollToPage:(NSInteger)page
{
    [self.scrollView setContentOffset:CGPointMake(320*page, 0) animated:YES];
}

- (void)backClick:(id)sender
{
    if (!isHiddenToolBarAndStatusBar)
    {
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (void)turnLeftPage
{
    if (_currentImagePage > 0)
    {
        [self scrollToPage:_currentImagePage-1];
        
        [self setBarItemEnable];
    }
}

- (void)turnRightPage
{
    if (_currentImagePage < [self.imageURLArray count]-1)
    {        
        [self scrollToPage:_currentImagePage+1];
        
        [self setBarItemEnable];
    }
}

#pragma mark -
#pragma mark  Scroll View Delegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (!isHiddenToolBarAndStatusBar)
    {
        [self toggleChrome:!isHiddenToolBarAndStatusBar];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.imageURLArray == nil ||[self.imageURLArray count] == 0)
    {
        return;
    }
    
    CGFloat pageWidth = 320;
    
    CGFloat content =  scrollView.contentOffset.x - _currentImagePage * pageWidth;
    
    if ((content / pageWidth == (int)(content / pageWidth)) && content != 0)
    {
        int page = scrollView.contentOffset.x / pageWidth;
        
        if (_currentImagePage != page)
        {
            _currentImagePage = page;
            
            NSURL *imageUrl = [self.imageURLArray objectAtIndex:_currentImagePage];
            
            DisOrderPhotoView *currentView = (DisOrderPhotoView *)[self.scrollView viewWithTag:22+_currentImagePage];
            
            [currentView setImageUrl:imageUrl];
            
            [currentView turnOffZoom];
            
            [self setBarItemEnable];
            
            self.titleLabel.text = [NSString stringWithFormat:@"%d/%d", _currentImagePage+1, [self.imageURLArray count]];
        }        
    }       
}
@end

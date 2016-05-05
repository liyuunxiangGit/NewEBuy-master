//
//  imageScrollView.m
//  SuningEBuy
//
//  Created by 孔斌 on 14-2-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "imageScrollView.h"


@implementation imageScrollView
{
    BOOL tapClicks;
    CGFloat offset;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (NSMutableArray *)imageSourceArr{
    if (!_imageSourceArr) {
        _imageSourceArr = [[NSMutableArray alloc] init];
    }
    return _imageSourceArr;
}

- (UIScrollView *)imageScrollView
{
    if (!_imageScrollView) {
        _imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 80, 320, 320)];
        _imageScrollView.backgroundColor = [UIColor clearColor];
        _imageScrollView.scrollEnabled = YES;
        _imageScrollView.showsVerticalScrollIndicator =NO;
        _imageScrollView.showsHorizontalScrollIndicator =NO;
        _imageScrollView.pagingEnabled = YES;
        _imageScrollView.delegate = self;
        _imageScrollView.clipsToBounds = NO;
//        self.imageScrollView.contentSize = CGSizeMake(320 * self.imageArr.count, 300);
    }
    return _imageScrollView;
}

- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] init];
        _backBtn.frame = self.bounds;
        [_backBtn addTarget:self action:@selector(hiddenBigImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (MyPageControl *)myPageControl
{
    
    if (!_myPageControl) {
        
        _myPageControl = [[MyPageControl alloc] init];
        
        _myPageControl.backgroundColor = [UIColor clearColor];
        
        _myPageControl.frame = CGRectMake(0, 80, self.frame.size.width, 20);
        
        _myPageControl.imageNormal = [UIImage imageNamed:@"productDetail_image_normal.png"];
        
        _myPageControl.imageSelected = [UIImage imageNamed:@"productDetail_image_selected.png"];
        
        _myPageControl.maxPoint = 8;
        
//        [_myPageControl addTarget:self action:@selector(scrollToPage:) forControlEvents:UIControlEventValueChanged];
        
//        self.currentPageNumber = 0;
        
        
        
    }
    return _myPageControl;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)showBigImage
{
    
    [self.imageScrollView removeAllSubviews];
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.backBtn];
    [self insertSubview:self.backBtn atIndex:0];

    self.myPageControl.numberOfPages = [self.imageSourceArr count];
    
//    self.myPageControl.currentPage = self.currentPageNumber;
    
        
    for (int i = 0; i < [self.imageSourceArr count] ; i ++){
        UITapGestureRecognizer *doubleTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        [doubleTap setNumberOfTapsRequired:2];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        [singleTap setNumberOfTapsRequired:1];
        
        UIScrollView *s = [[UIScrollView alloc] initWithFrame:CGRectMake(320*i, 0, 320, 320)];
        s.backgroundColor = [UIColor clearColor];
        s.contentSize = CGSizeMake(320, 320);
        s.showsVerticalScrollIndicator =NO;
        s.showsHorizontalScrollIndicator =NO;
        s.delegate = self;
        s.minimumZoomScale = 1.0;
        s.maximumZoomScale = 2.0;
        s.clipsToBounds = NO;
        //        s.tag = i+1;
        [s setZoomScale:1.0];
        
        EGOImageView *imageview = [[EGOImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
        //        NSString *imageName = [self.imageSourceArr objectAtIndex:i];
        imageview.imageURL = [self.imageSourceArr objectAtIndex:i];
        imageview.userInteractionEnabled = YES;
        imageview.tag = i+1;
        [imageview addGestureRecognizer:doubleTap];
        [imageview addGestureRecognizer:singleTap];
        [s addSubview:imageview];
        [self.imageScrollView addSubview:s];
        tapClicks = NO;
        
    }

    
    [self addSubview:self.imageScrollView];
    
    self.imageScrollView.frame = CGRectMake(0, 0, 320, 320);
    self.imageScrollView.contentSize = CGSizeMake(320 * self.imageSourceArr.count, 320);
    
    self.myPageControl.frame = CGRectMake(0, 14, 320, 20);
    [self addSubview:self.myPageControl];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.backBtn.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
        self.imageScrollView.frame = CGRectMake(0, 80, 320, 320);
        self.myPageControl.frame = CGRectMake(0, 80, 320, 20);
    }];
    
    [self bringSubviewToFront:self.myPageControl];
}

- (void)hiddenBigImage
{
    [UIView animateWithDuration:0.5 animations:^{
        self.backBtn.backgroundColor = RGBACOLOR(0, 0, 0, 0);
        self.imageScrollView.frame = CGRectMake(0, -20, 320, 320);
        self.myPageControl.frame = CGRectMake(0, 14, 320, 20);
    } completion:^(BOOL finished){
        [self removeAllSubviews];
        [self removeFromSuperview];
    }];
}

#pragma mark - ScrollView delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    for (UIView *v in scrollView.subviews){
        return v;
    }
    return nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if(interfaceOrientation ==UIInterfaceOrientationPortrait||interfaceOrientation ==UIInterfaceOrientationPortraitUpsideDown)
    {
        return YES;
    }
    return NO;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == self.imageScrollView){
        CGFloat x = scrollView.contentOffset.x;
        if (x==offset){
            
        }
        else {
            offset = x;
            for (UIScrollView *s in scrollView.subviews){
                if ([s isKindOfClass:[UIScrollView class]]){
                    [s setZoomScale:1.0];
                }
            }
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.frame.size.width;
    
 //   CGFloat content =  scrollView.contentOffset.x - self.currentPageNumber * pageWidth;
    
   // if ((content / pageWidth == (int)(content / pageWidth)) && content != 0)
  //  {
        int page = scrollView.contentOffset.x / pageWidth;
        
        self.myPageControl.currentPage = page;
        
//        if (self.currentPageNumber != page)
//        {
//            self.currentPageNumber = page;
//            
//            if ([self.imagesArr count] > self.currentPageNumber+2)
//            {
//                NSURL *url = [self.imagesArr objectAtIndex:self.currentPageNumber+2];
//                [EGOImageLoader preloadImageURL:url];
//            }
//        }
  //  }
    
}

//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
//    [scrollView setZoomScale:scale+1.0 animated:YES];
//    [scrollView setZoomScale:scale animated:YES];
//}
#pragma mark -
-(void)handleDoubleTap:(UIGestureRecognizer *)gesture{
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(hiddenBigImage)
                                               object:nil];
    float newScale;
    if (!tapClicks) {
        newScale = [(UIScrollView*)gesture.view.superview zoomScale] * 1.5;
    }
    else{
        newScale = [(UIScrollView*)gesture.view.superview zoomScale] * 2/3;
    }
    
    CGRect zoomRect = [self zoomRectForScale:newScale  inView:(UIScrollView*)gesture.view.superview withCenter:[gesture locationInView:gesture.view]];
    [(UIScrollView*)gesture.view.superview zoomToRect:zoomRect animated:YES];
    tapClicks = !tapClicks;
}

-(CGRect)zoomRectForScale:(float)scale inView:(UIScrollView*)scrollView withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    zoomRect.size.height = [scrollView frame].size.height / scale;
    zoomRect.size.width  = [scrollView frame].size.width  / scale;
    
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}

- (void)singleTap:(UIGestureRecognizer *)gesture
{
    [self performSelector:@selector(hiddenBigImage) withObject:Nil afterDelay:0.3];
}

@end

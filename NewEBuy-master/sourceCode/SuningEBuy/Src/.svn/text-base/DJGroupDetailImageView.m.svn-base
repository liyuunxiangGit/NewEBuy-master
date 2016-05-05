//
//  DJGroupDetailImageView.m
//  SuningEBuy
//
//  Created by xie wei on 13-7-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DJGroupDetailImageView.h"
#import "ProductUtil.h"

@interface DJGroupDetailImageView()

@property (nonatomic, strong) DataProductBasic *productDTO;

@property (nonatomic, strong) NSArray *smallImageUrls;

@end


@implementation DJGroupDetailImageView

@synthesize productDTO = _productDTO;
@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;
@synthesize delegate = _delegate;
@synthesize smallImageUrls = _smallImageUrls;
@synthesize item = _item;
@synthesize currentPageNumber = _currentPageNumber;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_productDTO);
    TT_RELEASE_SAFELY(_scrollView);
    TT_RELEASE_SAFELY(_pageControl);
    TT_RELEASE_SAFELY(_smallImageUrls);
    TT_RELEASE_SAFELY(_item);
    
}

#pragma mark - scrollView & delegate

- (UIScrollView *)scrollView{
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.frame = CGRectMake(0, 0, 173, 169);
        _scrollView.backgroundColor = [UIColor clearColor];
        
        _scrollView.pagingEnabled = YES;
        _scrollView.clipsToBounds = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
		_scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

//- (MyPageControl *)pageControl{
//    
//    if (!_pageControl) {
//        
//        _pageControl = [[MyPageControl alloc] init];
//        
//        _pageControl.frame = CGRectMake(0, 110, 140, 20);
//        
//        _pageControl.imageNormal = [UIImage imageNamed:@"DJ_Detail_Image_NoSelectPoint.png"];
//        
//        _pageControl.imageSelected = [UIImage imageNamed:@"DJ_Detail_Image_SelectPoint.png.png"];
//        
//        _pageControl.maxPoint = 8;
//        
//        [_pageControl addTarget:self action:@selector(scrollToPage:) forControlEvents:UIControlEventValueChanged];
//        currentPageNumber = 0;
//        
//        [self addSubview:_pageControl];
//    }
//    return _pageControl;
//}

- (void)scrollToPage:(id)sender
{
    MyPageControl *pageControl = (MyPageControl *)sender;
    NSInteger page = pageControl.currentPage;
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width*page, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = 173;
    
    CGFloat content =  scrollView.contentOffset.x - self.currentPageNumber * pageWidth;
    
    if (content != 0)
    {
        int page = 0;
        if(content>0)
        {
            page = floor(scrollView.contentOffset.x / pageWidth);
        }else{
            
            page = ceil(scrollView.contentOffset.x / pageWidth);
        }
        
        self.pageControl.currentPage = page;
        
        if (self.currentPageNumber != page)
        {
            self.currentPageNumber = page;
        }
    }
}

#pragma mark -
#pragma mark 传入数据

- (void)setItem:(DataProductBasic *)aitem
{
    if (aitem != _item)
    {
        TT_RELEASE_SAFELY(_item);
        
        _item = aitem;
        
        self.productDTO = _item;
        
        //获取小图url列表
        NSArray *smallImagesOrigin = [ProductUtil getImageUrlListWithProduct:_item size:ProductImageSize200x200];
        NSArray *smallImages;
        if (smallImagesOrigin.count >= 9 ) {
            smallImages = [smallImagesOrigin subarrayWithRange:NSMakeRange(0, 8)];
        }
        else
        {
            smallImages = smallImagesOrigin;
        }
        self.smallImageUrls = smallImages;
        
        //设置scrollView的contentSize
        NSUInteger count = [smallImages count];
        if (1 == count) {
            self.scrollView.contentSize = self.scrollView.bounds.size;
        }else {
            self.scrollView.contentSize = CGSizeMake(count*173, 169);
        }
        
        //设置pageControl的页数
        self.pageControl.numberOfPages = [smallImages count];
        self.pageControl.currentPage = self.currentPageNumber;
        
        //绘制图片
        [self initImagesWithArr:self.smallImageUrls];
    }
}

#pragma mark -
#pragma mark initImages with data

- (void)initImagesWithArr:(NSArray *)arr
{
    [self.scrollView removeAllSubviews];
    
    NSInteger positionX = 0;
    
    for (int i = 0; i < [arr count]; i++) {
        NSURL *url = [arr objectAtIndex:i];
        EGOImageViewEx *temimage = [[EGOImageViewEx alloc] init];
        temimage.userInteractionEnabled = YES;
        temimage.exDelegate = self;
        temimage.frame =  CGRectMake(positionX, 0, 173, 169);
       // temimage.contentMode = UIViewContentModeScaleAspectFill;
        temimage.layer.backgroundColor = [UIColor clearColor].CGColor;
        temimage.layer.borderWidth = 0;
        //[temimage.layer  setCornerRadius:8.0];
        [temimage.layer  setMasksToBounds:YES];
        temimage.tag = i;
        temimage.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
        temimage.imageURL = url;
        
        [self.scrollView addSubview:temimage];
        
        positionX += 173;
    }
}

+ (CGFloat)height
{
    return 169;
}

- (void)imageExViewDidOk:(EGOImageViewEx *)imageViewEx
{
    if (_delegate && [_delegate respondsToSelector:@selector(didTouchImageAtIndex:withSmallImages:andBigImages:)])
    {
        NSArray *bigImages = [ProductUtil getImageUrlListWithProduct:self.productDTO size:ProductImageSize800x800];
        
        [self.delegate didTouchImageAtIndex:self.currentPageNumber withSmallImages:self.smallImageUrls andBigImages:bigImages];
    }
}


@end

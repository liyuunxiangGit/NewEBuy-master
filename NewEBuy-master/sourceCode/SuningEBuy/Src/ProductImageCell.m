//
//  ProductImageCell.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-2-10.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ProductImageCell.h"
#import "ProductDetailViewController.h"
#import "UIView+RoundedCorners.h"
#import "ProductDetailService.h"

@implementation ProductDetailImageViewCell

- (void)dealloc
{
    TT_RELEASE_SAFELY(_contentView);
    TT_RELEASE_SAFELY(_imageView);
    TT_RELEASE_SAFELY(_powerFlagLabel);
    TT_RELEASE_SAFELY(_powerFlagImageView);
     touchedBlock = nil;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.frame = CGRectMake(12.5, 10, 150, 150);
        _contentView.layer.cornerRadius = 5.0;
        //[_contentView.layer setShadowOffset:CGSizeMake(-0.25, 0.2)];
        //[_contentView.layer setShadowRadius:2.5];
 //       _contentView.layer.borderColor = [UIColor colorWithWhite:0.1 alpha:0.2].CGColor;
       // _contentView.layer.borderColor =[UIColor clearColor].CGColor;
 //       _contentView.layer.borderWidth = 0.5;
 //       _contentView.layer.backgroundColor = [UIColor clearColor].CGColor;
        //_contentView.layer.cornerRadius = 8.0;
//        [_contentView.layer setShadowColor:[UIColor colorWithWhite:0.4 alpha:1].CGColor];
//        [_contentView.layer setShadowOpacity:0.2];
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (EGOImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[EGOImageView alloc] init];
        _imageView.userInteractionEnabled = YES;
        _imageView.frame =  CGRectMake(0, 0, 202, 170);
        _imageView.contentMode = UIViewContentModeScaleToFill;
        _imageView.backgroundColor = [UIColor whiteColor];
        //_imageView.layer.backgroundColor = [UIColor clearColor].CGColor;
 //       _imageView.layer.borderColor = [UIColor colorWithWhite:0.1 alpha:0.2].CGColor;
 //       _imageView.layer.borderWidth = 0.5;
 //       [_imageView.layer setCornerRadius:8.0];
        _imageView.clipsToBounds = YES;
       // _imageView.layer.cornerRadius = 5.0;
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

- (UIImageView *)powerFlagImageView
{
    if (!_powerFlagImageView)
    {
        _powerFlagImageView =
        [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"product_energy_subsidies.png"]];
        _powerFlagImageView.frame = CGRectMake(100, 0, 50, 50);
    }
    return _powerFlagImageView;
}

- (UILabel *)powerFlagLabel
{
    if (!_powerFlagLabel)
    {
        _powerFlagLabel = [[UILabel alloc] init];
        _powerFlagLabel.frame = CGRectMake(0,25,50,15);
        [_powerFlagLabel setFont:[UIFont boldSystemFontOfSize:10.0]];
        _powerFlagLabel.textAlignment=UITextAlignmentCenter;
        //动态价格
        _powerFlagLabel.textColor= [UIColor whiteColor];
        _powerFlagLabel.backgroundColor=[UIColor clearColor];
    }
    return _powerFlagLabel;
}

- (void)setTouchedBlock:(SNBasicBlock)block
{
    if (block != touchedBlock) {
        touchedBlock = [block copy];
    }
}

- (void)setImageUrl:(NSURL *)imageUrl powerFlag:(NSString *)powerFlgOrAmt atIndex:(NSInteger)index
{
    self.imageView.imageURL = imageUrl;
    
    if (![powerFlgOrAmt isEqualToString:@"false"])
    {
        if (index == 0) {
//            [self.powerFlagImageView addSubview:self.powerFlagLabel];
//            [self.contentView addSubview:self.powerFlagImageView];
//            NSString *title = [powerFlgOrAmt stringByAppendingString:@" 元"];
//            self.powerFlagLabel.text = title;
        }else{
//            [self.powerFlagImageView removeFromSuperview];
//            [self.powerFlagLabel removeFromSuperview];
        }
        
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (touchedBlock) {
        touchedBlock();
    }
}

@end

/*********************************************************************/

////////////////////////////////////////////////////////////////////


//@interface ProductImageCell()
//
//@property (nonatomic, retain) DataProductBasic *productDTO;
//@property (nonatomic, retain) NJPageScrollView *scrollView;
//@property (nonatomic, retain) MyPageControl  *pageControl;
//
//@property (nonatomic, retain) NSArray *smallImageUrls;
//
//
//@end

////////////////////////////////////////////////////////////////////

@implementation ProductImageCell

@synthesize productDTO = _productDTO;
@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;

@synthesize smallImageUrls = _smallImageUrls;

@synthesize item = _item;

@synthesize delegate = _delegate;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_productDTO);
    _scrollView.dataSource = nil;
    TT_RELEASE_SAFELY(_scrollView);
    TT_RELEASE_SAFELY(_pageControl);
    
    TT_RELEASE_SAFELY(_smallImageUrls);
        
    TT_RELEASE_SAFELY(_item);
    
    TT_RELEASE_SAFELY(_scrollTouch);
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.size = CGSizeMake(320, 156);

//        self.size = CGSizeMake(320, 175);
        //传递触摸事件的view
//        SNTouchView *scrollTouch_ = [[SNTouchView alloc] init];        
//        scrollTouch_.frame = CGRectMake(0, 0, 320, self.height);        
//        scrollTouch_.backgroundColor = [UIColor clearColor];        
        self.scrollTouch.receiver = self.scrollView.scrollView;
        
        //TT_RELEASE_SAFELY(scrollTouch_);
        
        [self.contentView addSubview:self.scrollView];
        
        //pageControl
        [self.contentView addSubview:self.pageControl];
        
        self.pageControl.currentPage = 0;
        
        self.backgroundView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark-
#pragma mark scrollView & delegate

-(SNTouchView *)scrollTouch{
    
    
    if (!_scrollTouch) {
        
        _scrollTouch = [[SNTouchView alloc] init];
        _scrollTouch.frame = CGRectMake(0, 0, 320, self.height);
        _scrollTouch.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_scrollTouch];
    }
    
    return _scrollTouch;
}
- (NJPageScrollView *)scrollView
{
    if (nil == _scrollView)
    {
        _scrollView = [[NJPageScrollView alloc]init];

//        _scrollView.frame = CGRectMake(72.5, 1, 156, self.height-5);

        _scrollView.frame = CGRectMake(72.5, 1, 202, self.height-5);
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.scrollView.clipsToBounds = NO;
        _scrollView.scrollView.showsVerticalScrollIndicator = NO;
		_scrollView.scrollView.showsHorizontalScrollIndicator = NO;
		_scrollView.dataSource = self;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (MyPageControl *)pageControl{
    
    if (!_pageControl) {
        
        _pageControl = [[MyPageControl alloc] init];
        
        _pageControl.frame = CGRectMake(0, 160, 320, 20);
                
        _pageControl.imageNormal = [UIImage imageNamed:@"DJ_Detail_Image_NoSelectPoint.png"];
        
        _pageControl.imageSelected = [UIImage imageNamed:@"DJ_Detail_Image_SelectPoint.png.png"];
        
        [_pageControl addTarget:self action:@selector(scrollToPage:) forControlEvents:UIControlEventValueChanged];   
        
        currentPageNumber = 0;
    }
    return _pageControl;
    
}

- (void)scrollToPage:(id)sender
{
    UIPageControl *pageControl = (UIPageControl *)sender;
    NSInteger page = pageControl.currentPage;
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width*page, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = 156.0;//200.0;
    
    CGFloat content =  scrollView.contentOffset.x - currentPageNumber * pageWidth;
    
    if ((content / pageWidth == (int)(content / pageWidth)) && content != 0)
    {
        int page = scrollView.contentOffset.x / pageWidth;
        
        self.pageControl.currentPage = page;
        
        if (currentPageNumber != page)
        {
            currentPageNumber = page;
            
            if ([self.smallImageUrls count] > currentPageNumber+2)
            {
                NSURL *url = [self.smallImageUrls objectAtIndex:currentPageNumber+2];
                SNImageCachePreloadImages(@[url]);
            }
        }        
    }        
    
}

#pragma mark -
#pragma mark 传入数据 

- (void)setItem:(DataProductBasic *)aItem
{
    if (aItem != _item)
    {
        TT_RELEASE_SAFELY(_item);
        
        _item = aItem;
        
        self.productDTO = _item;
        
        //获取小图url列表
        NSArray *smallImages = nil;//[ProductUtil getSmallImageUrlList:_item];
        if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
            //清晰
            
            smallImages = [ProductUtil getImageUrlListWithProduct:_item size:ProductImageSize400x400];
        }
        else{
            //一般
            
            smallImages = [ProductUtil getImageUrlListWithProduct:_item size:ProductImageSize200x200];
            
        }
        self.smallImageUrls = smallImages;
        
        //设置pageControl的页数
        self.pageControl.numberOfPages = [smallImages count];
        self.pageControl.currentPage = currentPageNumber;
        
        //绘制图片
        [self.scrollView reloadData];
    }
}


#pragma mark -
#pragma mark scroll view data source

- (NSInteger)numberOfPagesInPageScrollView:(NJPageScrollView *)pageScrollView
{
    return [self.smallImageUrls count];
}

- (NJPageScrollViewCell *)pageScrollView:(NJPageScrollView *)pageScrollView cellForPage:(NSInteger)page
{
    static NSString *pageIndentifier = @"pageIndentifier";
    ProductDetailImageViewCell *pageCell = (ProductDetailImageViewCell *)[pageScrollView dequeueReusablePageWithIdentifier:pageIndentifier];
    if (pageCell == nil)
    {
        pageCell = [[ProductDetailImageViewCell alloc] initWithReuseIdentifier:pageIndentifier];
        pageCell.frame = self.scrollView.bounds;        
        //修复循环引用
        __weak ProductImageCell *weakSelf = self;
        [pageCell setTouchedBlock:^{
            [weakSelf imageTouched];
        }];
    }
    
    NSURL *url = [self.smallImageUrls objectAtIndex:page];
    [pageCell setImageUrl:url powerFlag:self.item.powerFlgOrAmt atIndex:page];
    return pageCell;
}

- (void)imageTouched
{
    if ([_delegate respondsToSelector:@selector(didTouchImageAtIndex:withSmallImages:andBigImages:)])
    {
        NSArray *bigImages = nil;//[ProductUtil getBigImageUrlList:self.item];
        if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]
            && !self.item.isABook) {
            
                bigImages = [ProductUtil getImageUrlListWithProduct:self.item
                                                               size:ProductImageSize800x800];

        }
        else{
            bigImages = [ProductUtil getImageUrlListWithProduct:self.item
                                                           size:ProductImageSize400x400];
        }
        
        [_delegate didTouchImageAtIndex:currentPageNumber
                        withSmallImages:self.smallImageUrls
                           andBigImages:bigImages];
    }
}

+ (CGFloat)height
{
    return 175;
}


@end

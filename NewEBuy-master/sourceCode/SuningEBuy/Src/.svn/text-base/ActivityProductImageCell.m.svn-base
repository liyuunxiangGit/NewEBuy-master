//
//  ActivityProductImageCell.m
//  SuningEBuy
//
//  Created by shasha on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "ActivityProductImageCell.h"
#import "SNTouchView.h"
#import "ProductDetailService.h"
#import "ProductUtil.h"

@interface ActivityProductImageViewCell : NJPageScrollViewCell
{
    SNBasicBlock touchedBlock;
}

@property (nonatomic, strong) EGOImageView *imageView;
@property (nonatomic, strong) UIImageView *powerFlagImageView;
@property (nonatomic, strong) UILabel *powerFlagLabel;


- (void)setTouchedBlock:(SNBasicBlock)block;

- (void)setImageUrl:(NSURL *)imageUrl powerFlag:(NSString *)powerFlgOrAmt atIndex:(NSInteger)index;

@end

@implementation ActivityProductImageViewCell

- (void)dealloc
{
    TT_RELEASE_SAFELY(_imageView);
    TT_RELEASE_SAFELY(_powerFlagLabel);
    TT_RELEASE_SAFELY(_powerFlagImageView);
     touchedBlock = nil;
}

- (EGOImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[EGOImageView alloc] init];
        _imageView.userInteractionEnabled = YES;
        _imageView.frame =  CGRectMake(12.5, 15, 150, 150);
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _imageView.layer.borderWidth = 0;
        [_imageView.layer setCornerRadius:8.0];
        [_imageView.layer setMasksToBounds:YES];
        [self addSubview:_imageView];
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
            [self.powerFlagImageView addSubview:self.powerFlagLabel];
            //[self addSubview:self.powerFlagImageView];
            NSString *title = [powerFlgOrAmt stringByAppendingString:L(@" yuan")];
            self.powerFlagLabel.text = title;
        }else{
            [self.powerFlagImageView removeFromSuperview];
            [self.powerFlagLabel removeFromSuperview];
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



@interface ActivityProductImageCell(){

    BOOL  isSmallImagesLoaded;

}

@property (nonatomic, strong) NSArray *smallImageUrls;


@end

////////////////////////////////////////////////////////////////////
@implementation ActivityProductImageCell
@synthesize backView = _backView;
@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;

@synthesize smallImageUrls = _smallImageUrls;

@synthesize delegate = _delegate;

@synthesize item = _item;




- (void)dealloc
{
    TT_RELEASE_SAFELY(_backView);
    _scrollView.dataSource = nil;
    _scrollView.delegate = nil;
    TT_RELEASE_SAFELY(_scrollView);
    TT_RELEASE_SAFELY(_pageControl);
    
    TT_RELEASE_SAFELY(_smallImageUrls);    
    
    TT_RELEASE_SAFELY(_item);
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.size = CGSizeMake(320, 185);
        self.clipsToBounds = YES;
        isSmallImagesLoaded = NO;
        
        //添加背景图片
        //        UIImageView *backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ImageBackGround.png"]];
        //        backgroundView.frame = CGRectMake(0, 0, 320, 185);
        //        [self.contentView addSubview:backgroundView];
        //        TT_RELEASE_SAFELY(backgroundView);
        
        //传递触摸事件的view
        //self.contentView.clipsToBounds = YES;
        UIView *shadowView = [[UIView alloc] initWithFrame: CGRectMake(6.5, 0, 307, self.height)];
        shadowView.layer.backgroundColor = [UIColor whiteColor].CGColor;
//        [shadowView.layer setShadowOffset:CGSizeMake(0, 0)];
//        [shadowView.layer setShadowRadius:2.0];
//        [shadowView.layer setShadowOpacity:0.5];
        shadowView.layer.borderWidth = 0.5;
        shadowView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.contentView addSubview:shadowView];
        TT_RELEASE_SAFELY(shadowView);
        
        [self.contentView addSubview:self.backView];
        
        SNTouchView *scrollTouch_ = [[SNTouchView alloc] init];        
        scrollTouch_.frame = CGRectMake(0, 0, 320, self.height);        
        scrollTouch_.backgroundColor = [UIColor clearColor];  
        scrollTouch_.receiver = self.scrollView.scrollView;
        [self.backView addSubview:scrollTouch_];
        TT_RELEASE_SAFELY(scrollTouch_);
        
        [self.backView addSubview:self.scrollView];        
        //self.backView.clipsToBounds = YES;
        //pageControl
        [self.backView addSubview:self.pageControl];
        
        self.pageControl.currentPage = 0;
        
        self.backgroundView.backgroundColor = [UIColor clearColor];
    }
    return self;
}



#pragma mark-
#pragma mark scrollView & delegate
- (NJPageScrollView *)scrollView
{
    if (nil == _scrollView) {
        _scrollView = [[NJPageScrollView alloc]init];
        _scrollView.frame = CGRectMake(72.5, 0, 175, self.height);
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.scrollView.clipsToBounds = NO;
        _scrollView.scrollView.showsVerticalScrollIndicator = NO;
		_scrollView.scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.dataSource = self;
    }
    return _scrollView;
}


- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.frame = CGRectMake(6.5, 0, 307, self.height);
        _backView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"product_imageScrollView_background.png"]];
        imageView.frame = CGRectMake(0, 0, 307, self.height);
        [_backView addSubview:imageView];
         _backView.clipsToBounds = YES;
    }
    return _backView;
}

- (UIPageControl *)pageControl{
    
    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc] init];
        
        _pageControl.frame = CGRectMake(0, 165, 320, 20);
        
        //   _pageControl.currentPage = 0;
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
    CGFloat pageWidth = 175.0;
    
    CGFloat content =  scrollView.contentOffset.x - currentPageNumber * pageWidth;
    
    if ((content / pageWidth == (int)(content / pageWidth)) && content != 0)
    {
        int page = scrollView.contentOffset.x / pageWidth;
        
        self.pageControl.currentPage = page;
        
        if (currentPageNumber != page)
        {
            currentPageNumber = page;
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
        
        //获取小图url列表
        NSArray *smallImages = [ProductUtil getImageUrlListWithProduct:_item size:ProductImageSize200x200];
        self.smallImageUrls = smallImages;
        
        //设置pageControl的页数
        self.pageControl.numberOfPages = [smallImages count];
        self.pageControl.currentPage = currentPageNumber;
        
        //绘制图片
        [self.scrollView reloadData];
        
    }
}

#pragma mark - 
#pragma mark initImages with data


#pragma mark -
#pragma mark scroll view data source

- (NSInteger)numberOfPagesInPageScrollView:(NJPageScrollView *)pageScrollView
{
    return [self.smallImageUrls count];
}

- (NJPageScrollViewCell *)pageScrollView:(NJPageScrollView *)pageScrollView cellForPage:(NSInteger)page
{
    static NSString *pageIndentifier = @"pageIndentifier";
    ActivityProductImageViewCell *pageCell = (ActivityProductImageViewCell *)[pageScrollView dequeueReusablePageWithIdentifier:pageIndentifier];
    if (pageCell == nil)
    {
        pageCell = [[ActivityProductImageViewCell alloc] initWithReuseIdentifier:pageIndentifier];
        pageCell.frame = self.scrollView.bounds;
        //修复循环引用
        __weak ActivityProductImageCell *weakSelf = self;
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
        NSArray *bigImages = [ProductUtil getImageUrlListWithProduct:self.item size:ProductImageSize800x800];
        
        [_delegate didTouchImageAtIndex:currentPageNumber
                        withSmallImages:self.smallImageUrls
                           andBigImages:bigImages];
    }
}

+ (CGFloat)height
{
    return 185;
}


@end

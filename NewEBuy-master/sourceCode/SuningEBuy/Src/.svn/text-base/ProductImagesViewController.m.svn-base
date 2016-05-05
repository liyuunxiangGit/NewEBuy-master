//
//  ProductImagesViewController.m
//  SuningEBuy
//
//  Created by wangrui on 3/15/12.
//  Copyright (c) 2012 suning. All rights reserved.
//

#import "ProductImagesViewController.h"


#define VIEW_BASE_TAG        22

#define SMALL_IMG_COUNT      5
#define SMALL_IMG_HEIGHT     45
#define SMALL_IMG_WIDTH      60
#define SMALL_IMG_SPACE      6

@interface ProductImagesViewController ()

// 保存图片url的数组
@property (nonatomic, strong) NSArray *smallImageURLArray;
@property (nonatomic, strong) NSArray *bigImageURLArray;

@property (nonatomic, weak) NSString *productName;

// 中部大图
@property (nonatomic, strong) UIScrollView *bigImageScrollView;

// 底部缩略图
@property (nonatomic, strong) UIScrollView *thumbnailScrollView;

//缩略图上方商品名称。
@property (nonatomic, strong) UILabel      *productNameLabel;

// 设置图片
- (void)setImageViews;

// 设置大图
- (void)initBigImageViewAtNum:(NSInteger)viewNum;
// 设置小图
- (void)initSmallImageViewAtNum:(NSInteger)viewNum withTotalCount:(NSInteger)count;

// 更新图片状态
- (void)updateImageViewState:(NSInteger)page;

// 布局scrollView
- (void)layoutScrollView;

@end

@implementation ProductImagesViewController

@synthesize currentImagePage = _currentImagePage;
@synthesize smallImageURLArray = _smallImageURLArray;
@synthesize bigImageURLArray = _bigImageURLArray;
@synthesize productName = _productName;
@synthesize bigImageScrollView = _bigImageScrollView;
@synthesize thumbnailScrollView = _thumbnailScrollView;
@synthesize productNameLabel = _productNameLabel;

- (void)dealloc
{

    TT_RELEASE_SAFELY(_smallImageURLArray);
    TT_RELEASE_SAFELY(_bigImageURLArray);
    
    TT_RELEASE_SAFELY(_bigImageScrollView);
    TT_RELEASE_SAFELY(_thumbnailScrollView);
    
    TT_RELEASE_SAFELY(_productNameLabel);
    
}

// 初始化图片
- (id)initWithSmallImages:(NSArray *)smallImages withBigImages:(NSArray *)bigImages withName:(NSString *)productName
{
    if (self = [super init]) 
    {        
        self.title = L(@"Product_ProductImage");
        
        self.smallImageURLArray = smallImages;
        
        self.bigImageURLArray = bigImages;
        
        _productName = productName;
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.view.frame = CGRectMake(0, 0, 320, 367);
    
    [self.view addSubview:self.bigImageScrollView];
    
    [self.view addSubview:self.thumbnailScrollView];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    self.thumbnailScrollView.backgroundColor = [UIColor clearColor];
    
    self.bigImageScrollView.backgroundColor = [UIColor clearColor];
    
    UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(self.thumbnailScrollView.origin.x, self.thumbnailScrollView.origin.y, 320, self.thumbnailScrollView.height)];
    
    bar.barStyle = UIBarStyleBlackOpaque;
    
    bar.alpha = 0.7;

    self.productNameLabel.frame = CGRectMake(10, bar.frame.origin.y, self.productNameLabel.width, self.productNameLabel.height);
    
    [self.view insertSubview:bar belowSubview:self.thumbnailScrollView];
    
    [self.view insertSubview:self.productNameLabel aboveSubview:bar];
    
    TT_RELEASE_SAFELY(bar);
    
    self.productNameLabel.text = self.productName;
    
    [self setImageViews];
    
    [self layoutScrollView];
    
}

- (void)layoutScrollView
{
    
    // 显示当前小图
    EGOImageButton *imageButton = (EGOImageButton *)[self.thumbnailScrollView viewWithTag:VIEW_BASE_TAG + self.currentImagePage];
    
    [self.thumbnailScrollView scrollRectToVisible:imageButton.frame animated:YES];
    
    
    // 显示当前大图
    ImageBrowseView *bigImageView = (ImageBrowseView *)[self.bigImageScrollView viewWithTag:VIEW_BASE_TAG + self.currentImagePage];
    
    [self.bigImageScrollView scrollRectToVisible:bigImageView.frame animated:YES];
}

#pragma mark - 设置图片
- (void)setImageViews
{
    
    NSInteger imageCount = [self.smallImageURLArray count];
    
    for (int i = 0; i < imageCount; i++)
    {
        
        [self initBigImageViewAtNum:i];
        
        [self initSmallImageViewAtNum:i withTotalCount:imageCount];
        
    }
    
    
}

- (void)initBigImageViewAtNum:(NSInteger)viewNum
{
    
    // 大图
    ImageBrowseView *bigImageView = [[ImageBrowseView alloc] initWithFrame:CGRectMake(viewNum * self.view.width, 0, self.view.width, self.bigImageScrollView.height)];
    
    bigImageView.tag = VIEW_BASE_TAG + viewNum;
    
    NSURL *imageUrl = [self.bigImageURLArray objectAtIndex:viewNum];
    
    [bigImageView setImageUrl:imageUrl];
    
    [self.bigImageScrollView addSubview:bigImageView];
    
    TT_RELEASE_SAFELY(bigImageView);
}


- (void)initSmallImageViewAtNum:(NSInteger)viewNum withTotalCount:(NSInteger)count
{
    // 小图
    EGOImageButton *smallImageBtn = [[EGOImageButton alloc] init];
    smallImageBtn.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
    
    CGRect buttonFrame = CGRectMake(SMALL_IMG_SPACE + (SMALL_IMG_WIDTH + SMALL_IMG_SPACE) * viewNum, 44, SMALL_IMG_WIDTH, SMALL_IMG_HEIGHT);
    
    // 居中
    if (count < SMALL_IMG_COUNT) 
    {
        buttonFrame.origin.x = (self.view.width - (SMALL_IMG_WIDTH + SMALL_IMG_SPACE) * count)/2 + buttonFrame.origin.x;
    }
    
    smallImageBtn.frame = buttonFrame;
    
    smallImageBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    smallImageBtn.layer.cornerRadius = 3;
    
    if (viewNum == self.currentImagePage) 
    {
       // smallImageBtn.layer.borderColor = [UIColor colorWithRed:137.0/255.0 green:37.0/255.0 blue:37.0/255.0 alpha:0.6].CGColor;    
//          smallImageBtn.layer.borderColor = [UIColor colorWithRed:230.0/255.0 green:5/255.0 blue:9/255.0 alpha:0.8].CGColor;
        smallImageBtn.layer.borderColor = [UIColor colorWithRed:30.0/255.0 green:196.0/255.0 blue:236.0/255.0 alpha:0.8].CGColor;

        
    }
    
    smallImageBtn.layer.borderWidth = 1.5f;
    
    smallImageBtn.tag = VIEW_BASE_TAG + viewNum;
    
    NSURL *imageUrl = [self.smallImageURLArray objectAtIndex:viewNum];
    
    smallImageBtn.imageURL = imageUrl;
    
    smallImageBtn.contentMode = UIViewContentModeScaleAspectFill;
    
    smallImageBtn.clipsToBounds = YES;
    
    smallImageBtn.imageView.clipsToBounds = NO;
    
    [smallImageBtn addTarget:self action:@selector(displayBigImageView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.thumbnailScrollView addSubview:smallImageBtn];
    
    TT_RELEASE_SAFELY(smallImageBtn);
    
}


#pragma mark - UIScroll View Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.bigImageScrollView.frame.size.width;
    
    NSInteger page = floor((self.bigImageScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    if (page != self.currentImagePage) 
    {
        self.currentImagePage = page;
        
        NSInteger btnTag = page + VIEW_BASE_TAG;
        
        [self updateImageViewState:btnTag];
        
        EGOImageButton *imageButton = (EGOImageButton *)[self.thumbnailScrollView viewWithTag:btnTag];
        
        [self.thumbnailScrollView scrollRectToVisible:imageButton.frame animated:YES];
           
    }
}

- (void)updateImageViewState:(NSInteger)page
{
 
    // 还原大图的缩放
    ImageBrowseView *bigImageView = (ImageBrowseView *)[self.bigImageScrollView viewWithTag:page];
    
    if (bigImageView.zoomScale != bigImageView.minimumZoomScale)
    {
        bigImageView.zoomScale = bigImageView.minimumZoomScale;
    }
    
    // 更新缩略图状态（选中或未选中）
    for (EGOImageButton *button in self.thumbnailScrollView.subviews)
    {
        if (![button isKindOfClass:[EGOImageButton class]]) 
        {
            continue;
        }
        
        button.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        if (button.tag == page) 
        {
//            button.layer.borderColor = [UIColor colorWithRed:137.0/255.0 green:37.0/255.0 blue:37.0/255.0 alpha:1.0].CGColor;
            
//            button.layer.borderColor = [UIColor colorWithRed:230.0/255.0 green:5/255.0 blue:9/255.0 alpha:0.8].CGColor;
            button.layer.borderColor = [UIColor colorWithRed:30.0/255.0 green:196.0/255.0 blue:236.0/255.0 alpha:0.8].CGColor;

        }
        
    }
}

#pragma mark - 选中缩略图
- (void)displayBigImageView:(id)sender
{
    EGOImageButton *btn = (EGOImageButton *)sender;
    
    [self updateImageViewState:btn.tag];
    
    ImageBrowseView *bigImageView = (ImageBrowseView *)[self.bigImageScrollView viewWithTag:btn.tag];
    
    [self.bigImageScrollView scrollRectToVisible:bigImageView.frame animated:YES];
}

#pragma mark - View Getter Methods
- (UIScrollView *)bigImageScrollView
{
    if (!_bigImageScrollView) 
    {
        _bigImageScrollView = [[UIScrollView alloc] init];
        
        _bigImageScrollView.frame = CGRectMake(0, 0, self.view.width, 272);
        
        _bigImageScrollView.bounces = NO;
        
        _bigImageScrollView.delegate = self;
        
        _bigImageScrollView.backgroundColor = [UIColor whiteColor];
        
        _bigImageScrollView.pagingEnabled = YES;
        
        _bigImageScrollView.showsHorizontalScrollIndicator = NO;
        
        _bigImageScrollView.showsVerticalScrollIndicator = NO;
        
        NSInteger imageCount = 0;
        
        imageCount = [self.bigImageURLArray count];
        
        if (self.bigImageURLArray && imageCount > 0) 
        {
            _bigImageScrollView.contentSize = CGSizeMake(_bigImageScrollView.width * imageCount, _bigImageScrollView.height);
        }
    }
    
    return _bigImageScrollView;
}

- (UIScrollView *)thumbnailScrollView
{
    if (!_thumbnailScrollView) 
    {
        _thumbnailScrollView = [[UIScrollView alloc] init];
        
        _thumbnailScrollView.frame = CGRectMake(0, self.bigImageScrollView.bottom, self.view.width - SMALL_IMG_SPACE, self.view.height - self.bigImageScrollView.height);
        
         _thumbnailScrollView.clipsToBounds = NO;
        
        _thumbnailScrollView.pagingEnabled = YES;
        
        _thumbnailScrollView.showsHorizontalScrollIndicator = NO;
        _thumbnailScrollView.showsVerticalScrollIndicator = NO;
        
        _thumbnailScrollView.backgroundColor = [UIColor whiteColor];
        
        NSInteger imageCount = 0;
        
        imageCount = [self.smallImageURLArray count];
        
        if (self.smallImageURLArray && imageCount > 0) 
        {
            
            _thumbnailScrollView.contentSize = CGSizeMake((SMALL_IMG_WIDTH + SMALL_IMG_SPACE) * imageCount, SMALL_IMG_HEIGHT);
        }
    }
    
    return _thumbnailScrollView;
}

-(UILabel *)productNameLabel{

    if (!_productNameLabel) {
        _productNameLabel = [[UILabel alloc] init];
        _productNameLabel.frame = CGRectMake(10, 0, 300, 44);
        _productNameLabel.backgroundColor = [UIColor clearColor];
        _productNameLabel.alpha = 0.5;
        _productNameLabel.layer.shadowRadius = 5;
        _productNameLabel.shadowColor = [UIColor whiteColor];
        _productNameLabel.shadowOffset = CGSizeMake(0, 0);
        _productNameLabel.textAlignment = UITextAlignmentCenter;
        _productNameLabel.textColor = [UIColor whiteColor];
        _productNameLabel.font = [UIFont boldSystemFontOfSize:15];
        _productNameLabel.numberOfLines = 2;
    }

    return _productNameLabel;
}

@end

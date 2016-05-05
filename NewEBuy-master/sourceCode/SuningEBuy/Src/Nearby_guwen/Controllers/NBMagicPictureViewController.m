//
//  NBMagicPictureViewController.m
//  suningNearby
//
//  Created by suning on 14-8-7.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "NBMagicPictureViewController.h"
#import "NBMagicImgButton.h"
#import "NBImageUtils.h"
#import "NBImageColorMatrix.h"

@interface NBMagicPictureViewController ()

@property (nonatomic,strong) IBOutlet UIImageView  *imageView0;

@property (nonatomic,strong) IBOutlet UIButton     *tabButton0,*tabButton1;
@property (nonatomic,strong) IBOutlet UIScrollView *tabScrollView;

@property (nonatomic,strong) IBOutlet UIScrollView *tabScrollView0,*tabScrollView1;
@property (nonatomic,strong) IBOutlet UIView *selectedView0,*selectedView1;

@property (nonatomic,strong) IBOutlet UIActivityIndicatorView *loadingActivityView;

@property (nonatomic,assign) BOOL bLvJingLoadFinished; // default NO

@property (nonatomic,strong) UIImage *dealedImage; // 滤镜处理过后的图像 默认为原图
@property (nonatomic,strong) UIImage *selPhotoFrameImage; // 选中的相框 default nil

@end

@implementation NBMagicPictureViewController

- (void)dealloc {
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _imageView0.image = _selectedImage;
    self.dealedImage  = _selectedImage;
    
    [self loadPhotoFrameButtons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)performDelegateMethod {
    if (nil != _delegate
        && [_delegate respondsToSelector:@selector(delegate_MagicPictureViewController_composedImage:)]) {
        [_delegate delegate_MagicPictureViewController_composedImage:_imageView0.image];
    }
}

- (IBAction)on_navigationButton_clicked:(UIButton *)sender {
    if (0 == sender.tag) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (1 == sender.tag) {
        
        NBMagicPictureViewController *__weak weakSelf = self;
        [self dismissViewControllerAnimated:YES completion:^{
            [weakSelf performDelegateMethod];
        }];
    }
}

- (void)movePhotoFrameSelectedIndicator:(NSInteger)tag {
    
    UIView *__weak weakIndicator = self.selectedView0;
    CGFloat y = self.selectedView1.frame.origin.y;
    [UIView animateWithDuration:.25f animations:^{
        weakIndicator.frame =CGRectMake(9+tag*(73.0f),y,64.0f,2.0f);
    }];
}

- (void)moveLvJingSelectedIndicator:(NSInteger)tag {
    
    UIView *__weak weakIndicator = self.selectedView1;
    CGFloat y = self.selectedView1.frame.origin.y;
    [UIView animateWithDuration:.25f animations:^{
        weakIndicator.frame =CGRectMake(9+tag*(73.0f),y,64.0f,2.0f);
    }];
}

- (UIImage *)addImage:(UIImage *)image1
            withImage:(UIImage *)image2
                rect1:(CGRect)rect1
                rect2:(CGRect)rect2 {
    
    CGSize size = CGSizeMake(rect1.size.width/*+rect2.size.width*/, rect1.size.height);
    
    UIGraphicsBeginImageContext(size);
    
    [image1 drawInRect:rect1];
    [image2 drawInRect:rect2];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

- (void)onSelectPhotoFrame:(NSInteger)frameTag {
    
    CGSize sz = self.imageView0.frame.size;
    CGRect rect1 = CGRectMake(.0f,.0f,sz.width,sz.height);
    
    NSString *file =
    [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"nby_frame%.2d_v",(frameTag+1)]
                                    ofType:@"png"];
    
    self.selPhotoFrameImage = [UIImage imageWithContentsOfFile:file];
    
    UIImage *image = [self addImage:_dealedImage withImage:_selPhotoFrameImage
                                  rect1:rect1 rect2:rect1];
    
    self.imageView0.image = image;
    
    [self movePhotoFrameSelectedIndicator:frameTag];
}

- (void)onSelectLvJingPhoto:(UIImage *)lvJingedImage tag:(NSInteger)tag {
    
    UIImage *composedImg = lvJingedImage;
    if (nil != _selPhotoFrameImage) {
        
        CGSize sz = self.imageView0.frame.size;
        CGRect rect1 = CGRectMake(.0f,.0f,sz.width,sz.height);
        composedImg =
        [self addImage:lvJingedImage withImage:_selPhotoFrameImage rect1:rect1 rect2:rect1];
    }
    
    self.imageView0.image = composedImg;
    
    [self moveLvJingSelectedIndicator:tag];
}

- (void)loadPhotoFrameButtons {
    
    // {{{
    NSArray *photofArr = @[@"nby_photof_0",
                           @"nby_photof_1",
                           @"nby_photof_2",
                           @"nby_photof_3",
                           @"nby_photof_4",
                           @"nby_photof_5",
                           @"nby_photof_6",
                           @"nby_photof_7",
                           @"nby_photof_8",
                           @"nby_photof_9"];
    
    //UIImageView *__weak weakImgView = self.imageView0;
    NBMagicPictureViewController *__weak weakSelf = self;
    
    NSMutableArray *tmpBtsArr = [NSMutableArray array];
    for (NSInteger i = 0; i<photofArr.count;++i) {
        NBMagicImgButton *button = [[NBMagicImgButton alloc] initWithFrame:CGRectMake(9+i*(73.0f),20.0f,64.0f,84.0f)];
        button.tag = i;
        button.selectedComplete = ^(UIImage *params,NSNumber *tag) {
            [weakSelf onSelectPhotoFrame:tag.integerValue];
        };
        [_tabScrollView0 addSubview:button];
        
        [tmpBtsArr addObject:button];
    }
    _tabScrollView0.contentSize = CGSizeMake((tmpBtsArr.count*73.0f)+18.0f,
                                             _tabScrollView0.frame.size.height);
    
    NSMutableArray *tmpImgArr = [NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(0,0), ^{

        for (int i = 0; (i < tmpBtsArr.count) && (i < photofArr.count); ++i) {
            UIImage *image = [UIImage imageNamed:photofArr[i]];
            [tmpImgArr addObject:image];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            for (int i = 0; (i < tmpBtsArr.count) && (i < tmpImgArr.count);++i) {
                NBMagicImgButton *bt = tmpBtsArr[i];
                bt.image = tmpImgArr[i];
            }
        });
    });
    
    // }}}
}

- (void)loadLvJingButtons {
    
    if (_bLvJingLoadFinished) {
        return;
    }
    
    [_loadingActivityView startAnimating];
    
    // {{{

    NSArray *lvJingDataArr = @[L(@"PMOrigine"),@"LOMO",L(@"PMBlackWhite"),L(@"PMRetro"),L(@"PMGothic"),L(@"PMShapen"),L(@"PMSimpleElegant"),L(@"PMWineRed"),L(@"PMFreshTranquility"),L(@"PMRomance"),L(@"PMHalo"),L(@"PMBlues"),L(@"PMVisions"),L(@"PMNightColor")];
    
    //UIImageView *__weak weakImgView = self.imageView0;
    NBMagicPictureViewController *__weak weakSelf = self;
    
    NSMutableArray *tmpBtsArr = [NSMutableArray array];
    for (NSInteger i = 0; i<lvJingDataArr.count;++i) {
        NBMagicImgButton *button = [[NBMagicImgButton alloc] initWithFrame:CGRectMake(9+i*(73.0f),20.0f,64.0f,84.0f)];
        button.tag = i;
        button.title = lvJingDataArr[i];
        button.selectedComplete = ^(UIImage *params,NSNumber *tag) {
            [weakSelf onSelectLvJingPhoto:params tag:tag.integerValue];
        };
        [_tabScrollView1 addSubview:button];
        
        [tmpBtsArr addObject:button];
    }
    _tabScrollView1.contentSize = CGSizeMake((tmpBtsArr.count*73.0f)+18.0f,
                                             _tabScrollView1.frame.size.height);
    
    NSMutableArray *tmpImgArr = [NSMutableArray array];
    [tmpImgArr addObject:_selectedImage];
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        UIImage *image = [NBImageUtils imageWithImage:_selectedImage withColorMatrix:colormatrix_lomo];
        [tmpImgArr addObject:image];
        image = [NBImageUtils imageWithImage:_selectedImage withColorMatrix:colormatrix_heibai];
        [tmpImgArr addObject:image];
        image = [NBImageUtils imageWithImage:_selectedImage withColorMatrix:colormatrix_huajiu];
        [tmpImgArr addObject:image];
        image = [NBImageUtils imageWithImage:_selectedImage withColorMatrix:colormatrix_gete];
        [tmpImgArr addObject:image];
        image = [NBImageUtils imageWithImage:_selectedImage withColorMatrix:colormatrix_ruise];
        [tmpImgArr addObject:image];
        image = [NBImageUtils imageWithImage:_selectedImage withColorMatrix:colormatrix_danya];
        [tmpImgArr addObject:image];
        image = [NBImageUtils imageWithImage:_selectedImage withColorMatrix:colormatrix_jiuhong];
        [tmpImgArr addObject:image];
        image = [NBImageUtils imageWithImage:_selectedImage withColorMatrix:colormatrix_qingning];
        [tmpImgArr addObject:image];
        image = [NBImageUtils imageWithImage:_selectedImage withColorMatrix:colormatrix_langman];
        [tmpImgArr addObject:image];
        image = [NBImageUtils imageWithImage:_selectedImage withColorMatrix:colormatrix_guangyun];
        [tmpImgArr addObject:image];
        image = [NBImageUtils imageWithImage:_selectedImage withColorMatrix:colormatrix_landiao];
        [tmpImgArr addObject:image];
        image = [NBImageUtils imageWithImage:_selectedImage withColorMatrix:colormatrix_menghuan];
        [tmpImgArr addObject:image];
        image = [NBImageUtils imageWithImage:_selectedImage withColorMatrix:colormatrix_yese];
        [tmpImgArr addObject:image];
        dispatch_async(dispatch_get_main_queue(), ^{
            for (int i = 0; (i < tmpBtsArr.count) && (i < tmpImgArr.count);++i) {
                NBMagicImgButton *bt = tmpBtsArr[i];
                bt.image = tmpImgArr[i];
            }
            _bLvJingLoadFinished = YES;
            [_loadingActivityView removeFromSuperview];
            self.loadingActivityView = nil;
        });
    });
    
    // }}}
}

- (IBAction)on_tabButton_clicked:(UIButton *)sender {
    if (!sender.selected) {
        if (_tabButton0 == sender) {
            _tabButton0.selected = YES;
            _tabButton1.selected = NO;
        }else if (_tabButton1 == sender) {
            _tabButton1.selected = YES;
            _tabButton0.selected = NO;
            
            if (!_bLvJingLoadFinished) {
                [self loadLvJingButtons];
            }
        }
        
        _tabScrollView.contentOffset = CGPointMake(_tabScrollView.frame.size.width*sender.tag,.0f);
    }
}

@end

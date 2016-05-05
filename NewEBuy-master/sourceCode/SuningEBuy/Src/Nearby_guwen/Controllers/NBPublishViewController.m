//
//  NBPublishViewController.m
//  suningNearby
//
//  Created by suning on 14-8-1.
//  Copyright (c) 2014年 suning. All rights reserved.
//
//  发布页面

#import "NBPublishViewController.h"

#import "NBLocationAddrsListView.h"

#import "NBMagicPictureViewController.h"

#import "NBShakeButton.h"

#import "NBCCSharedData.h"


#define kNBTextLimitLength 140


@interface NBRectBorderView ()
@property (nonatomic,strong) UIImageView             *borderImgView;
@end

@implementation NBRectBorderView

- (UIImageView *)borderImgView {
    if (nil == _borderImgView) {
        CGSize f = self.frame.size;
        self.borderImgView = [[UIImageView alloc] initWithFrame:CGRectMake(.0f,.0f,f.width,f.height)];
        [self insertSubview:_borderImgView atIndex:0];
    }
    
    return _borderImgView;
}

- (void)setBorderCornerStyle:(int)borderCornerStyle {
    _borderCornerStyle = borderCornerStyle;
    
    UIImage *borderImg = nil;
    if (1 == _borderCornerStyle) {       // 圆角
        borderImg = [UIImage imageNamed:@"nb_border_1"];
    }else if (2 == _borderCornerStyle) { // 方角
        borderImg = [UIImage imageNamed:@"nb_border_2"];
        borderImg = [borderImg resizableImageWithCapInsets:UIEdgeInsetsMake(2.0f,2.0f,2.0f,2.0f)];
    }
    
    self.borderImgView.image = borderImg;
}

@end



#pragma mark - class NBPublishViewController

#import "NBYSHttpService.h"
#import "BMKPOILocationService.h"
#import "BMapKit.h"

@interface NBPublishViewController () <UITextViewDelegate,
                                       UIActionSheetDelegate,
                                       UIImagePickerControllerDelegate,
                                       UINavigationControllerDelegate,
                                       NBMagicPictureViewControllerDelegate,
                                       NBYSHttpServiceDelegate,
                                       BMKPOILocationServiceDelegate>

@property (nonatomic,strong) IBOutlet TPKeyboardAvoidingScrollView *iScrollView;
@property (nonatomic,strong) NBLocationAddrsListView   *locationView;
@property (nonatomic,strong) IBOutlet UITextView       *textView0;
@property (nonatomic,strong) IBOutlet UILabel          *placeHolderLabel;
@property (nonatomic,strong) IBOutlet UILabel          *inputCntLimtLabel;

@property (nonatomic,strong) IBOutlet NBRectBorderView *rectBorderView0;
@property (nonatomic,strong) IBOutlet NBRectBorderView *rectBorderView1;
@property (nonatomic,strong) IBOutlet NBRectBorderView *rectBorderView2;

@property (nonatomic,strong) IBOutlet UIButton         *addPicButton;
@property (nonatomic,strong) IBOutlet UIButton         *postionButton;
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView *posActivityView;

@property (nonatomic,strong) NSMutableArray            *shakeButtonsArr;

@property (nonatomic,strong) NBYSHttpService *httpService;

@property (nonatomic,strong) BMKPOILocationService *locationService;

@property (nonatomic,strong) NSMutableArray *uploadPicsArr;

@property (nonatomic,strong) UIButton       *publicBt;

@property (nonatomic,strong) BMKPoiBean     *selectedPoiBean;

@end

@implementation NBPublishViewController

- (void)dealloc {
    
    [self.locationService stopLocation];
    [self.posActivityView stopAnimating];
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
    [self setTitle:L(@"PageTitleContentModify")];
    
    // {{{
    _publicBt = [[UIButton alloc] initWithFrame:CGRectMake(.0f,.0f,50.0f,44.0f)];
    _publicBt.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [_publicBt setTitleColor:[UIColor colorWithRed:58.0f/255.0f
                                            green:204.0f/255.0f
                                             blue:196.0f/255.0f
                                            alpha:1.0f]
                   forState:UIControlStateNormal];
    [_publicBt setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [_publicBt setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [_publicBt setTitle:L(@"BTPublish") forState:UIControlStateNormal];
    _publicBt.titleEdgeInsets = UIEdgeInsetsMake(.0f,.0f,.0f,-14.0f);
    [_publicBt addTarget:self action:@selector(on_confirmPublicButton_clicked)
       forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_publicBt];
    // }}}
    
    self.shakeButtonsArr = [NSMutableArray array];
    [_shakeButtonsArr addObject:_addPicButton];
    
    if (nil != _passedImage) {
        [self delegate_MagicPictureViewController_composedImage:_passedImage];
    }
    
    [_placeHolderLabel setText:L(@"LCSaySomething")];
    
    // 预先 定位
    [self.locationService startLocation];
    [self.posActivityView startAnimating];
    
    NSArray *poisArr = [NBCCSharedData shared].lastLocationPoiArr;
    if (nil != poisArr
        && poisArr.count > 0) {
        self.locationView.sourceArray = poisArr;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setSelectedPoiBean:(BMKPoiBean *)selectedPoiBean {
    _selectedPoiBean = selectedPoiBean;

    [_postionButton setTitle:_selectedPoiBean.poi.name
                    forState:UIControlStateNormal];
}

- (void)on_confirmPublicButton_clicked {
    
    // todo
    NSString *text = _textView0.text;
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (nil == text
        || 0 == text.length) {
        
        [self presentSheet:L(@"PVDearContentCantBeNull")];
        return;
    }else if (nil == _selectedPoiBean) {
        [self presentSheet:L(@"DearNotSelectGeographicPosition")];
        return;
    }else if (nil == _uploadPicsArr
              || _uploadPicsArr.count == 0) {
        [self presentSheet:L(@"PVDearNotSelectUploadPic")];
        return;

    }else {
        self.navigationItem.rightBarButtonItem.enabled = NO;
        
        [self displayOverFlowActivityView];

        
        // 图片
        NSMutableArray *imgsList = [NSMutableArray array];
        for (NSString *uploadPic in _uploadPicsArr) {
            [imgsList addObject:@{@"imageUrl":uploadPic}];
        }
        //
        NSMutableDictionary *pos = [NSMutableDictionary dictionaryWithDictionary:[NBCCSharedData fixedPostion]];
        NSString *city = EncodeStringFromDic(pos, @"city");
        if ((nil == city
            || city.length == 0)
            && nil != _selectedPoiBean.poi.city) {
            [pos setObject:(_selectedPoiBean.poi.city) forKey:@"city"];
        }
        NSString *name = _selectedPoiBean.poi.name;
        [pos setObject:((nil==name)?L(@"UnknownGeographicPositionName"):name) forKey:@"pointName"];
        
        NSArray *pp = @[@(_selectedPoiBean.poi.pt.longitude),@(_selectedPoiBean.poi.pt.latitude)];
        [pos setObject:pp forKey:@"point"];
        
        NSString *chanelId = EncodeStringFromDic(_channel,@"id");
        NSDictionary *paras = @{@"channelId":((nil==chanelId)?@"":chanelId),
                               @"u":([NBCCSharedData userInfo]),
                               @"pos":pos,
                               @"srcId":@(10), // 固定10
                               @"tag":@"",// todo
                               @"cont":text,
                               @"imgList":imgsList};
        
        [self.httpService requestPublicContentWithParas:paras];
    }
}

- (NBLocationAddrsListView *)locationView {
    
    if (nil == _locationView) {
        
        UIWindow *win = [UIApplication sharedApplication].keyWindow;
        
        CGSize sz = win.bounds.size;
        self.locationView = [[NBLocationAddrsListView alloc] initWithFrame:CGRectMake(.0f,.0f,sz.width,sz.height)];
        _locationView.hidden = YES;
        
        
        NBPublishViewController *__weak weakSelf = self;
        _locationView.selectedBlock = ^(BMKPoiBean *one) {
            weakSelf.selectedPoiBean = one;
        };
        
        [win addSubview:_locationView];
    }
    
    return _locationView;
}

- (IBAction)on_locationButton_clicked:(UIButton *)sender {
    
    self.locationView.hidden = !self.locationView.hidden;
    
    // 如果 定位失败 点击后重新定位
    if (!self.locationView.hidden
        && !self.locationService.isLocationing
        && (nil==self.locationView.sourceArray
            ||self.locationView.sourceArray.count==0)) {
        [self.locationService startLocation];
        [self.posActivityView startAnimating];
    }
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    _rectBorderView1.userInteractionEnabled = NO;
    _rectBorderView2.userInteractionEnabled = NO;
    _placeHolderLabel.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    _rectBorderView1.userInteractionEnabled = YES;
    _rectBorderView2.userInteractionEnabled = YES;
}

- (void)textViewDidChange:(UITextView *)textView {

    unsigned cnt = (unsigned)textView.text.length;
    NSString *displayStr = [NSString stringWithFormat:@"%u/%d",cnt,kNBTextLimitLength];
    if (cnt > 140) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:displayStr];
        [attStr setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}
                        range:NSMakeRange(0,[displayStr rangeOfString:@"/"].location)];
        
        _inputCntLimtLabel.attributedText = attStr;
    }else {
        _inputCntLimtLabel.text = displayStr;
    }
}

#pragma mark - add

- (IBAction)on_addPicturebutton_clicked {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self
                                              cancelButtonTitle:L(@"BTCancel")
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:L(@"BTSelectFromPhotoAlbum"),
                                                                L(@"BTTakePic"), nil];
    [sheet showInView:self.view];
}

- (void)GetPhotoToModifyPortrait:(UIImagePickerControllerSourceType)sourceType {
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        }
    }
    
    UIImagePickerController *ctrler = [[UIImagePickerController alloc]init];
    ctrler.delegate      = self;
    ctrler.sourceType    = sourceType;
    ctrler.allowsEditing = YES;
    [self presentViewController:ctrler animated:YES completion:nil];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (0 == buttonIndex) {         // choose photo
        [self GetPhotoToModifyPortrait:UIImagePickerControllerSourceTypePhotoLibrary];
    }else if (1 == buttonIndex) {   // take photo
        [self GetPhotoToModifyPortrait:UIImagePickerControllerSourceTypeCamera];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage* editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        NSData *imgData = UIImageJPEGRepresentation(editedImage,1.0f);
        //NSLog(@"s:%lu",imgData.length/1024);
        if (imgData.length > (1024*1024)/4/*250k左右*/) {
            imgData = UIImageJPEGRepresentation(editedImage,.0f);
            //NSLog(@"c:%lu",imgData.length/1024);
        }
        
        NBMagicPictureViewController *ctrler = [[NBMagicPictureViewController alloc] init];
        ctrler.delegate      = self;
        ctrler.selectedImage = [UIImage imageWithData:imgData];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:ctrler];
        nav.navigationBarHidden = YES;
        [self presentViewController:nav animated:YES completion:nil];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 

- (void)updateShakeButtonsFrame {
    
    [UIView animateWithDuration:.3f animations:^{
        
        for (int i = 0; i < _shakeButtonsArr.count; ++i) {
            UIButton *bt = _shakeButtonsArr[i];
            bt.frame = CGRectMake(10.0f+(i*54.0f),10.0f,44.0f,44.0f);
        }
        _addPicButton.hidden = ((_shakeButtonsArr.count >= 6)?YES:NO);
    }];
}

- (void)delegate_MagicPictureViewController_composedImage:(UIImage *)composedImg {
    if (nil != composedImg) {
        
        NBPublishViewController *__weak weakSelf = self;
        
        NBShakeButton *shakeBt = [[NBShakeButton alloc] initWithFrame:CGRectMake(10.0f,10.0f,44.0f,44.0f)];
        [shakeBt setImage:composedImg forState:UIControlStateNormal];
        shakeBt.removeBlock = ^(NBShakeButton *button) {
            [weakSelf.shakeButtonsArr removeObject:button];
            [weakSelf updateShakeButtonsFrame];
        };
    
        [_shakeButtonsArr insertObject:shakeBt atIndex:_shakeButtonsArr.count-1];
        [self updateShakeButtonsFrame];
        
        [_rectBorderView1 addSubview:shakeBt];
        
        // 执行图片上传
        self.publicBt.enabled = NO;
        self.publicBt.userInteractionEnabled = NO;
        [self.httpService requestPostPicture:UIImageJPEGRepresentation(composedImg,.8f)];
    }
}

#pragma mark - location 

- (BMKPOILocationService *)locationService {
    if (nil == _locationService) {
        self.locationService = [[BMKPOILocationService alloc] init];
        _locationService.delegate = self;
    }
    return _locationService;
}



#pragma mark - http service --- --- --- ---

- (NBYSHttpService *)httpService {
    
    if (nil == _httpService) {
        _httpService = [[NBYSHttpService alloc] init];
        _httpService.delegate = self;
    }
    return _httpService;
}

- (void)delegate_nbys_httpService_result:(NSDictionary *)result
                                 usrInfo:(id)userInfo
                                   error:(NSError *)error
                                     cmd:(E_CMDCODE)cmd {
    
    if (nil == error) {
        
        if (cmd == CC_NBYUploadPicture) {
            NSDictionary *data = EncodeDicFromDic(result, @"data");
            NSString     *uploadPic = EncodeStringFromDic(data, @"picurl");
            if (nil == _uploadPicsArr) {
                self.uploadPicsArr = [NSMutableArray array];
            }
            [_uploadPicsArr addObject:uploadPic];
            
            self.publicBt.enabled = YES;
            self.publicBt.userInteractionEnabled = YES;
            
        }else if (CC_NBYPublicStick == cmd) {
            [self backForePage];
        }
        
    }else {
        
        if (cmd == CC_NBYUploadPicture) {
            self.publicBt.enabled = YES;
            self.publicBt.userInteractionEnabled = YES;
        }
        
        NSString *ret = EncodeStringFromDic(result, @"ret");
        if (nil != ret
            && ret.intValue == 2) {
            if (cmd == CC_NBYUploadPicture) {
                [self presentSheet:L(@"TodayUploadPicNumberUpperLimit")];
            }else if (CC_NBYPublicStick == cmd) {
                [self presentSheet:L(@"TodayPublishNumberUpperLimit")];
            }
            self.publicBt.enabled = NO;
            self.publicBt.userInteractionEnabled = NO;
            self.iScrollView.userInteractionEnabled = NO;
        }else {
            [self presentSheet:error.localizedDescription];
        }
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    
    [self removeOverFlowActivityView];
}

- (void)delegate_BMKPOILocationServiceResponse:(NSArray *)resutArr
                                         error:(NSError *)error {
    if (nil == error) {
        
        NSMutableArray *list = [NSMutableArray array];
        for (BMKPoiInfo *poi in resutArr) {
            BMKPoiBean *bean = [[BMKPoiBean alloc] init];
            bean.isSelected  = NO;
            bean.poi         = poi;
            
            BMKMapPoint pt = BMKMapPointForCoordinate([NBCCSharedData shared].coordinate);
            CLLocationDistance dis = BMKMetersBetweenMapPoints(pt,BMKMapPointForCoordinate(poi.pt));
            bean.distance = dis;
            
            [list addObject:bean];
        }

        NSArray *array = [list sortedArrayUsingComparator:^NSComparisonResult(BMKPoiBean *obj1,BMKPoiBean *obj2) {
            if (obj1.distance > obj2.distance) {
                return NSOrderedDescending;
            }else {
                return NSOrderedAscending;
            }
        }];
        
        if (array.count > 0) {
            self.selectedPoiBean = array.firstObject;
        }
        
        //
        [NBCCSharedData shared].lastLocationPoiArr = array;
        
        self.locationView.sourceArray = array;
        
        
    }else {
        [self presentSheet:error.localizedDescription];
        
        if (!self.locationView.hidden) {
            self.locationView.hidden = YES;
        }
    }
    
    [self.posActivityView stopAnimating];
}

@end

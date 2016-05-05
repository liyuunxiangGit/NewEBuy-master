//
//  SNCommentShareCreateViewController.m
//  SuningEBuy
//
//  Created by Joe on 14-11-9.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNCommentSharePostBaseViewController.h"
#import "PlaceholderTextView.h"
#import "SNCommentShareImagesView.h"
#import "ZYQAssetPickerController.h"
#import "UIView+Label.h"

#define kCommentShareView_TextView_Height   130
#define kCommentShareView_BottomView_Height   180

@interface SNCommentSharePostBaseViewController ()<UITextFieldDelegate,UITextViewDelegate,SNSInputImagesViewDelegate,ZYQAssetPickerControllerDelegate,DLStarRatingDelegate,SNCommentShareDelegate,UINavigationControllerDelegate>
{
    NSMutableArray     *_selectAssets;
    
    UIScrollView       *_contentView;
    UIView             *_maskView;
    BOOL                _ruleViewExpanded;
}

@property(nonatomic,strong)PlaceholderTextView *contentTextView;
@property(nonatomic,strong)SNCommentShareImagesView *imagesView;
@property(nonatomic,strong)SNCommentShareStar *productStar;             //商品满意度
@property(nonatomic,strong)SNCommentShareStar *logisticsStar;           //物流满意度
@property(nonatomic,strong)SNCommentShareStar *serviceStar;             //服务满意度
@property(nonatomic,strong)SNCommentShareSelecter *public;             //公开
@property(nonatomic,strong)SNCommentShareSelecter *private;            //匿名
@property(nonatomic,strong)UIView *grayLineView;
@property(nonatomic,strong)UIView *bottomPanelView;

@end

@implementation SNCommentSharePostBaseViewController

-(id)init{
    if (self = [super init]) {
        _selectAssets = [NSMutableArray array];
        _service = [[SNCommentShareService alloc] init];
        _service.delegate = self;
    }
    return self;
}

-(void)viewDidLoad
{
    self.title = L(@"Product_EvaluateAndDisOrder");
    self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"CommitBtn")];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpView];
    [self reSize];
    [self setUpValues];
    [self checkCanSubmit];
}

-(PlaceholderTextView*)contentTextView{
    if (!_contentTextView) {
        _contentTextView = [[PlaceholderTextView alloc] init];
        _contentTextView.frame = CGRectMake(0, 0, ApplicationScreenWidth, kCommentShareView_TextView_Height);
        _contentTextView.placeholder = L(@"CommentShare_InputTextPlaceHolder");
        _contentTextView.layer.masksToBounds = YES;
        _contentTextView.textColor = [UIColor blackColor];
        _contentTextView.font = [UIFont systemFontOfSize:15.0];
        _contentTextView.backgroundColor = [UIColor whiteColor];
        _contentTextView.autocorrectionType = UITextAutocorrectionTypeNo;
        _contentTextView.keyboardType = UIKeyboardTypeDefault;
        _contentTextView.returnKeyType = UIReturnKeyDone;
        _contentTextView.delegate = self;
    }
    return _contentTextView;
}

-(SNCommentShareImagesView*)imagesView{
    if (!_imagesView) {
        _imagesView = [[SNCommentShareImagesView alloc] initWithFrame:CGRectMake(0, kCommentShareView_TextView_Height, 320, 100)];
        _imagesView.backgroundColor = [UIColor whiteColor];
        _imagesView.imageView.showAdd = YES;
        _imagesView.imageView.delegate = self;
    }
    return _imagesView;
}

-(SNCommentShareStar*)productStar
{
    if (!_productStar) {
        _productStar = [[SNCommentShareStar alloc] initWithFrame:CGRectMake(15, 0, ApplicationScreenWidth-30, 30)];
        _productStar.star.delegate = self;
        _productStar.hintLabel.text = L(@"CommentShare_ProdcutPoints");
        _productStar.star.tag = 101;
    }
    return _productStar;
}

-(SNCommentShareStar*)logisticsStar
{
    if (!_logisticsStar) {
        _logisticsStar = [[SNCommentShareStar alloc] initWithFrame:CGRectMake(15, 0, ApplicationScreenWidth-30, 30)];
        _logisticsStar.star.delegate = self;
        _logisticsStar.hintLabel.text = L(@"CommentShare_LogisticsPoints");
        _logisticsStar.star.tag = 102;
    }
    return _logisticsStar;
}

-(SNCommentShareStar*)serviceStar
{
    if (!_serviceStar) {
        _serviceStar = [[SNCommentShareStar alloc] initWithFrame:CGRectMake(15, 0, ApplicationScreenWidth-30, 30)];
        _serviceStar.star.delegate = self;
        _serviceStar.hintLabel.text = L(@"CommentShare_ServicePoints");
        _serviceStar.star.tag = 103;
    }
    return _serviceStar;
}

-(SNCommentShareSelecter*)public{
    if (!_public) {
        _public = [[SNCommentShareSelecter alloc] initWithFrame:CGRectMake(15, 230, 60, 30)];
        _public.tag = 201;
        _public.hintLable.text = L(@"CommentShare_Public");
        _public.delegate = self;
    }
    return _public;
}

-(SNCommentShareSelecter*)private{
    if (!_private) {
        _private = [[SNCommentShareSelecter alloc] initWithFrame:CGRectMake(95, 230, 60, 30)];
        _private.tag = 202;
        _private.hintLable.text = L(@"CommentShare_Private");
        _private.delegate = self;
    }
    return _private;
}

-(UIView*)grayLineView
{
    if (!_grayLineView) {
        _grayLineView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ApplicationScreenWidth, 66)];
        _grayLineView.backgroundColor = [UIColor light_Gray_Color];
    }
    return _grayLineView;
}

-(UIView*)bottomPanelView
{
    if (!_bottomPanelView) {
        _bottomPanelView  = [[UIView alloc] initWithFrame:CGRectMake(0, ApplicationScreenHeight - 64 - 40, ApplicationScreenWidth, kCommentShareView_BottomView_Height)];
        _bottomPanelView.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 40, _bottomPanelView.width - 30, 1)];
        line.backgroundColor = [UIColor grayColor];
        [_bottomPanelView addSubview:line];
        
        UILabel *hintLabel = [_bottomPanelView labelWithMsg:L(@"CommentShare_YunZuanRule") color:[UIColor dark_Gray_Color] align:NSTextAlignmentCenter fontSize:13];
        hintLabel.frame = CGRectMake(15, 10, _bottomPanelView.width-30, 20);
        UILabel *hint2Label = [_bottomPanelView labelWithMsg:L(@"CommentShare_YunZuanRuleOne") color:[UIColor dark_Gray_Color] align:NSTextAlignmentLeft fontSize:13];
        hint2Label.frame = CGRectMake(15, 55, _bottomPanelView.width-30, 20);
        UILabel *hint3Label = [_bottomPanelView labelWithMsg:L(@"CommentShare_YunZuanRuleTwo") color:[UIColor dark_Gray_Color] align:NSTextAlignmentLeft fontSize:13];
        hint3Label.frame = CGRectMake(15, 86, _bottomPanelView.width-30, 20);
    }
    return _bottomPanelView;
}

-(void)setSelectImages:(NSMutableArray *)value
{
    _selectImages = value;
}

-(void)setUpView
{
    _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 40)];
    [self.view addSubview:_contentView];
    _contentView.scrollEnabled = YES;
    _contentView.backgroundColor = [UIColor whiteColor];
    
    [_contentView addSubview:self.contentTextView];
    [_contentView addSubview:self.imagesView];
    [self setUpStarsView];
    [self setUpPublicPrivate];
    
    [_contentView addSubview:self.grayLineView];
    
    _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    [self.view addSubview:_maskView];
    _maskView.backgroundColor = [UIColor blackColor];
    _maskView.alpha = .6;
    _maskView.hidden = YES;
    
    [self.view addSubview:self.bottomPanelView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ruleTaped:)];
    tap.numberOfTapsRequired = 1;
    [self.bottomPanelView addGestureRecognizer:tap];
    UITapGestureRecognizer *maskTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ruleTaped:)];
    maskTap.numberOfTapsRequired = 1;
    [_maskView addGestureRecognizer:maskTap];

}

-(void)setUpStarsView
{
    [_contentView addSubview:self.productStar];
    [_contentView addSubview:self.logisticsStar];
    [_contentView addSubview:self.serviceStar];
}

-(void)setUpPublicPrivate
{
    [_contentView addSubview:self.public];
    [_contentView addSubview:self.private];
}

-(void)imageSelectedWithImageArray:(NSMutableArray*)array pathArray:(NSMutableArray*)paths
{
    self.selectImages = paths;
    [self.imagesView.imageView clean];
    [self.imagesView.imageView addImages:array];
    [self reSize];
}

-(void)setUpValues
{
    self.productStar.star.rating = 5;
    self.logisticsStar.star.rating = 5;
    self.serviceStar.star.rating = 5;
    _productStarValue = _logisticsStarValue = _serviceStarValue = 5;
    self.public.selected = YES;
    _isPublic = YES;
}

-(void)setYunZuanRuleExpanded:(BOOL)yesOrNo
{
    _ruleViewExpanded = yesOrNo;
    if (yesOrNo) {
        _maskView.hidden = NO;
        [UIView animateWithDuration:.2 animations:^{
            _maskView.alpha = .6;
            _bottomPanelView.top = ApplicationScreenHeight - 64 - kCommentShareView_BottomView_Height;
        } completion:^(BOOL finish){
            
        }];
    }else{
        [UIView animateWithDuration:.2 animations:^{
            _bottomPanelView.top = ApplicationScreenHeight - 64 - 40;
            _maskView.alpha = 0;
        } completion:^(BOOL finish){
            _maskView.hidden = YES;
        }];
    }
    [self checkCanSubmit];
}

-(void)ruleTaped:(UIGestureRecognizer*)gesture
{
    [self setYunZuanRuleExpanded:!_ruleViewExpanded];
}

#pragma mark View Resize
-(void)reSize
{
    [self.imagesView reSize];
    self.productStar.top = self.imagesView.bottom + 10;
    self.logisticsStar.top = self.productStar.bottom + 8;
    self.serviceStar.top = self.logisticsStar.bottom + 8;
    self.public.top = self.serviceStar.bottom + 20;
    self.private.top = self.public.top;
    _grayLineView.top = self.private.bottom;
    _contentView.contentSize = CGSizeMake(self.view.width, _grayLineView.bottom);
    [self checkCanSubmit];
}

#pragma mark Star
- (void)newRating:(DLStarRatingControl *)control :(NSUInteger)rating
{
    if (control == _productStar.star) {
        _productStarValue = rating;
    }else if(control == _logisticsStar.star){
        _logisticsStarValue = rating;
    }else{
        _serviceStarValue = rating;
    }
}

#pragma mark Public&Private
-(void)tap:(id)sender
{
    if (sender == _public && _public.selected) {
        _private.selected = NO;
    }else if(sender == _private && _private.selected){
        _public.selected = NO;
    }
    _isPublic = _public.selected;
}
#pragma mark -
#pragma mark uitextfield delegate
//点击完成按钮或者done时，失去焦点
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//点击完成按钮或者done时，失去焦点
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }else{
        return YES;
    }
}

-(void)textViewDidChange:(UITextView *)tv
{
    if (tv.markedTextRange == nil &&  tv.text.length > 500) {
        tv.text = [tv.text substringWithRange:NSMakeRange(0, 500)];
    }
    [self checkCanSubmit];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.imagesView.imageView setDeleteMode:NO];
}

#pragma mark SNSInputImagesViewDelegate
-(void)imageDeletedAtIndex:(int)index
{
    [self.selectImages removeObjectAtIndex:index];
    [_selectAssets removeObjectAtIndex:index];
    [self reSize];
}

-(void)imagePressedAtIndex:(int)index
{
    
}

-(void)imageAdd
{
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = 10;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups = NO;
    picker.delegate = self;
    picker.selectAssets = _selectAssets;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
//        if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
//            NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
//            return duration >= 5;
//        }
        return YES;
    }];
    
    [self presentViewController:picker animated:YES completion:NULL];
}

-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    _selectAssets = [NSMutableArray arrayWithArray:assets];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *newImages = [NSMutableArray array];
        NSMutableArray *newImagePaths = [NSMutableArray array];
        for (int i=0; i<assets.count; i++) {
            ALAsset *asset=assets[i];
            UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
            NSString* file = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%d_%@",((int)CFAbsoluteTimeGetCurrent() ),asset.defaultRepresentation.filename]];
            [UIImageJPEGRepresentation(tempImg, .5) writeToFile:file atomically:YES];
            [newImagePaths addObject:file];
            [newImages addObject:tempImg];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self imageSelectedWithImageArray:newImages pathArray:newImagePaths];
        });
    });
}

#pragma mark Done Event
-(void)checkCanSubmit
{
    if (_ruleViewExpanded || (_contentTextView.text.length <= 0 && _selectImages.count <= 0)) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }else if(!_ruleViewExpanded && (_contentTextView.text.length > 0 || _selectImages.count > 0)){
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }else{
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

-(void)startValidateCanPulish:(NSString*)orderId customerId:(NSString*)customerId
{
    [_service validata:orderId customerId:customerId];
}

-(void)startUploadImages:(NSMutableArray*)images token:(NSString*)token orderId:(NSString*)orderId userId:(NSString*)userId imageLocalId:(NSMutableArray*)imageIds
{
    
}

#pragma mark Child Controller Event
- (void)righBarClick{}
-(void)validataResult:(BOOL)isSuccess token:(NSString*)token{}
-(void)imageUploadedResult:(BOOL)isSuccess imageId:(NSString*)imageId resultId:(NSString*)resourceId{}
-(void)publishResult:(BOOL)isSuccess commentId:(NSString*)commemtId serviceId:(NSString*)serviceId showId:(NSString*)showId{}

@end

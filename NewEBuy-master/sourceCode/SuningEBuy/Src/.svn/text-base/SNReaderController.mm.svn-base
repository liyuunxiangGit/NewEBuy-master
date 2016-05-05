//
//  SNReaderController.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-27.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SNReaderController.h"
#import "ProductDetailViewController.h"
#import "RegexKitLite.h"
#import "AdModel3ViewController.h"
#import "SNWebViewController.h"
#import "ScanHistoryDAO.h"
#import "ScanHistoryViewController.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>
//#import "DefineConstant.h"
//#import "ManualInputViewController.h"
#if kSNReaderUseZBar

#elif kSNReaderUseZXing

#endif

#if kSNReaderUseZBar
#import "SNReaderViewController.h"
@interface SNReaderController() <SNReaderDelegate>
#elif kSNReaderUseZXing
#import <ZXingWidgetController.h>
#import <QRCodeReader.h>
#import <MultiFormatOneDReader.h>
#import <TwoDDecoderResult.h>
#import "SNReaderViewControllerIOS7.h"

@interface SNReaderController() <ZXingDelegate, SNReaderDelegateIOS7>
#endif

{
    NSString            *_symbolsString;
}

#if kSNReaderUseZBar
@property (nonatomic, strong) SNReaderViewController *readerViewController;
#elif kSNReaderUseZXing
@property (nonatomic, strong) ZXingWidgetController *readerViewController;
#endif
@property (nonatomic, strong) EightBannerADService *adService;

@property (nonatomic, copy) NSString *adUrl;
@property (nonatomic, copy) NSString *redirectposition;

- (void)sendHttpRequestWithIsbn:(NSString *)isbn orProductId:(NSString *)productId;

@end


@implementation SNReaderController

@synthesize contentController = _contentController;
@synthesize isbnService = _isbnService;
@synthesize productService = _productService;

@synthesize readerViewController = _readerViewController;

- (void)dealloc {
    
    SERVICE_RELEASE_SAFELY(_isbnService);
    SERVICE_RELEASE_SAFELY(_productService);
    SERVICE_RELEASE_SAFELY(_adService);
}

- (id)initWithContentController:(UIViewController *)controller
{
    self = [super init];
    if (self) {
        self.contentController = controller;
    }
    return self;
}

- (SearchListService *)isbnService
{
    if (!_isbnService) {
        _isbnService = [[SearchListService alloc] init];
        _isbnService.delegate = self;
    }
    return _isbnService;
}

- (ProductDetailService *)productService
{
    if (!_productService) {
        _productService = [[ProductDetailService alloc] init];
        _productService.delegate = self;
    }
    return _productService;
}

#if kSNReaderUseZBar
- (SNReaderViewController *)readerViewController
{
    if (!_readerViewController) {
        _readerViewController = [[SNReaderViewController alloc] init];
        _readerViewController.snDelegate = self;
    }
    return _readerViewController;
}
#elif kSNReaderUseZXing
- (ZXingWidgetController *)readerViewController
{
    if (!_readerViewController) {
        if (IOS7_OR_LATER) {
            
            
            SNReaderViewControllerIOS7 *vc = [[SNReaderViewControllerIOS7 alloc] init];
            vc.delegate = self;
            _readerViewController = (id)vc;
            
        } else {
            _readerViewController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:YES showLicense:NO];
            NSMutableSet *readers = [[NSMutableSet alloc] init];
            
            QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
            [readers addObject:qrcodeReader];
            
            MultiFormatOneDReader *oneDReader = [[MultiFormatOneDReader alloc] init];
            [readers addObject:oneDReader];
            
            _readerViewController.readers = readers;
        }
    }
    return _readerViewController;
}
#endif


- (EightBannerADService *)adService
{
    if (!_adService) {
        _adService = [[EightBannerADService alloc] init];
        _adService.delegate = self;
        _adService.appType = BannerAppTypeQRCode;
    }
    return _adService;
}

- (void)beginReader
{
    NSString *platform = [SystemInfo platformString];
    
    if ([platform isEqualToString:@"iPhone Simulator"])
    {
        [self.readerViewController.view showTipViewAtCenter:L(@"Search_SimulatorCanNotSupportScan")];
    }
    else
    {
        //清理内存先
        [[SNMemoryCache defaultCache] clearMemory];
        SNImageCacheClearMemory();
        

        
        [self.contentController presentModalViewController:self.readerViewController
                                                  animated:YES];
        //add by zhangbeibei:20141010
        [self.readerViewController startReader];
    }
    
}

- (void)restartReader:(id)sender
{
    [self.readerViewController startReader];
}

- (void)endReader:(id)sender
{
    [self.readerViewController stopReader];
}

#pragma mark ----------------------------- reader call backs

#if kSNReaderUseZBar

- (void)readerView:(ZBarReaderView *)view
    didReadSymbols:(ZBarSymbolSet *)symbols
         fromImage:(UIImage *)image
{
    ZBarSymbol *symbol = nil;
    _symbolsString = @"";
    
    for(symbol in symbols) {
        break;
    }
    
    NSString *data = symbol.data;
    zbar_symbol_type_t type = symbol.type;
    
    [view stop];
    
    //开始判断是二维码还是条形码
    if (type == ZBAR_QRCODE) {
        
        [self parseQRTwoDCode:data];
    }else{
        
        [self parseOneDCode:data];
    }
}

- (void)snReaderDismissByCancel
{
    self.readerViewController = nil;
}


#elif kSNReaderUseZXing

- (void)zxingController:(ZXingWidgetController *)controller didScanResult:(TwoDDecoderResult *)result
{
    [controller stopReader];
    
    NSString *text = result.text.trim;    
    if ([result.formatReader isEqualToString:@"QRCodeReader"])
    {
        [self parseQRTwoDCode:text];
    }
    else
    {
        [self parseOneDCode:text];
    }
}

- (void)zxingControllerDidCancel:(ZXingWidgetController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:^{
        
        self.readerViewController = nil;
    }];
}

- (void)zxingControllerDidTapRightBtn:(ZXingWidgetController *)controller
{
    [self goToScanHistory];
}

#endif

- (void)readerController:(SNReaderViewControllerIOS7 *)readerController
           didScanResult:(NSString *)result isTwoDCode:(BOOL)isTwoDCode
{
    [readerController stopReader];
    
    if (isTwoDCode)
    {
        [self parseQRTwoDCode:result];
    }
    else
    {
        [self parseOneDCode:result];
    }
}

- (void)readerControllerScanHistoryButtonTapped:(SNReaderViewControllerIOS7 *)readerController
{
    [self goToScanHistory];
}

- (void)readerControllerCancelButtonTapped:(SNReaderViewControllerIOS7 *)readerController
{
    [readerController dismissViewControllerAnimated:YES completion:^{
        
        self.readerViewController = nil;
    }];
}


- (void)parseQRTwoDCode:(NSString *)data
{
    //二维码的情况处理
    
    //http://XX?city=025&platform=iphone&app =ebuy&adTypeCode =101& adId =1755
    //http://XX?city=025&platform=iphone&app =ebuy&adTypeCode =12 &adId =
    //http://XX?city=025&platform=iphone&app =ebuy&adTypeCode =12 &adId =3965196
    //http://XX?city=025&platform=iphone&app =ebuy&adTypeCode =17
    //http://XX?city=025&platform=iphone&app =ebuy&adTypeCode =17 &adId =3965196
    
    NSString *pidRegex = @"productid:(\\d+)";
    NSRange pidRange = [data rangeOfRegex:pidRegex
                                  options:RKLCaseless
                                  inRange:NSMakeRange(0, [data length])
                                  capture:0L
                                    error:nil];
    
    if (pidRange.location != NSNotFound)
    {
        NSString *urlStr = [data substringWithRange:pidRange];
        NSString *productId = [urlStr stringByMatching:@"\\d+"];
        
        if (productId)
        {
            [self sendHttpRequestWithIsbn:nil orProductId:productId];
            return;
        }
    }
    
    //是否是苏宁商品url
    NSString *urlRegex = @"http://(m\\.|www\\.|mapp\\.)?suning\\.(com|cn)/emall/(prd|snmwprd)_10052_(22001|10051)(_-7)?_(\\d+)_\\.(htm|html)";
    NSRange urlRange = [data rangeOfRegex:urlRegex];
    if (urlRange.location != NSNotFound) {
        NSString *urlStr = [data substringWithRange:urlRange];
        NSString *pidStr = [urlStr stringByMatching:@"_\\d+_\\.(htm|html)"];
        NSString *productId = [pidStr stringByMatching:@"\\d+"];
        [self sendHttpRequestWithIsbn:nil orProductId:productId];
        return;
    }
    _symbolsString = data;
    
    //页面路由逻辑
    @weakify(self);
    [SNRouter handleURL:data
             onChecking:^(SNRouterObject *obj) {
                 
                 @strongify(self);
                 [self.readerViewController.view showHUDIndicatorViewAtCenter:L(@"Loading...")];
                 
             } shouldRoute:^BOOL(SNRouterObject *obj) {
                 
                 @strongify(self);
                 [self.readerViewController.view hideHUDIndicatorViewAtCenter];
                 if (obj.errorMsg) {
                     [self showMessage:obj.errorMsg];
                     return NO;
                 }else{
                     if (obj.doRouteBlock)
                     {
                         [self.readerViewController dismissViewControllerAnimated:NO completion:NULL];
                     }
                     return YES;
                 }
                 
                 
             } didRoute:^(SNRouterObject *obj) {
                 
                 if (![self.readerViewController presentingViewController]) {
                     self.readerViewController = nil;
                 }
             } source:SNRouteSourceScan];
}

- (void)parseOneDCode:(NSString *)data
{
    //条形码
    //条形码直接进行isbn搜索
    [self sendHttpRequestWithIsbn:data orProductId:nil];
}

#pragma mark -
#pragma mark 提示语

-(void)showMessage:(NSString *)string
{
    NSString* str = nil;
    NSString* strR = nil;
    
    /**
     *  一直展示两个按钮选项
     *  @author liukun
     *  @since 2.4.2
     */
    str = L(@"Go on reading");
    strR = L(@"Return home");
//    if (!string)
//    {
//        str = L(@"Go on reading");
//        strR = L(@"Return home");
//    }
//    else
//    {
//        str = @"确定";
//    }
    
    NSString *errorMsg = string.trim.length?string:L(@"Can not match the Dimensional code!");
    BBAlertView *alertView = [[BBAlertView alloc]initWithStyle:BBAlertViewStyleDefault
                                                         Title:L(@"system-error")
                                                       message:errorMsg
                                                    customView:nil
                                                      delegate:nil
                                             cancelButtonTitle:str
                                             otherButtonTitles:strR];
    
    [alertView setConfirmBlock:^{
        
        [self doActionAfterDismiss:nil];
    }];
    
    [alertView setCancelBlock:^{
        
        [self restartReader:nil];        
    }];
    
    [alertView show];
}

#pragma mark ----------------------------- utils

- (void)doActionAfterDismiss:(void(^)(void))actionBlock
{
    [self.readerViewController dismissViewControllerAnimated:YES completion:^{
        
        if (actionBlock) {
            actionBlock();
        }
        self.readerViewController = nil;
    }];
}

#pragma mark -
#pragma mark controller 跳转

- (void)goToScanHistory
{
    [self doActionAfterDismiss:^{
        
        ScanHistoryViewController *scanVC = [[ScanHistoryViewController alloc] init];
        [scanVC setBackBlock:^{
            
            //清理内存先
            [[SNMemoryCache defaultCache] clearMemory];
            SNImageCacheClearMemory();
            
            [self.contentController presentModalViewController:self.readerViewController animated:YES];
        }];
        APP_DELEGATE.tabBarViewController.selectedIndex = 1;
        [self.contentController.navigationController pushViewController:scanVC animated:YES];
        
    }];
}

- (void)shouldBeginSearchIsbnWithISBN:(NSString *)isbn
{
    [self sendHttpRequestWithIsbn:isbn orProductId:nil];
}

- (void)alertErrorMsg:(NSString *)errorMsg
{
    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-error")
                                                    message:errorMsg?errorMsg:L(@"Sorry, No infomation")
                                                   delegate:nil
                                          cancelButtonTitle:L(@"Ok")
                                          otherButtonTitles:nil];
    [alert setCancelBlock:^{
        [self restartReader:nil];
    }];
    [alert show];
}

#pragma mark -
#pragma mark service delegate

- (void)sendHttpRequestWithIsbn:(NSString *)isbn orProductId:(NSString *)productId
{
    CommonViewController *modalController = (CommonViewController *)self.contentController.modalViewController;
    [modalController.view showHUDIndicatorViewAtCenter:L(@"Loading...")];
    
    if (isbn) {
        
        NSMutableDictionary *context = [NSMutableDictionary dictionaryWithDictionary:
                                        @{@"search":@"0", @"product":@"0",
                                        @"searchResult":@"0", @"productResult":@"0"}];
        
        SearchParamDTO *param = [[SearchParamDTO alloc] initWithSearchType:SearchTypeKeyword
                                                                       set:SearchSetMix];
        param.keyword = isbn;
        self.isbnService.context = context;
        [self.isbnService beginGetSearchListWithSearchCondition:param
                                                           page:0];
        TT_RELEASE_SAFELY(param);
        
        //且发送商品详情请求
        self.productService.context = context;
        [self.productService beginGetProductDetailInfoWithIsbn:isbn];
        
    }else{
        DataProductBasic *product = [[DataProductBasic alloc] init];
        product.productId = productId;
        product.productCode = @"";
        product.cityCode = [Config currentConfig].defaultCity;
        [self.productService beginGetProductDetailInfo:product];
        TT_RELEASE_SAFELY(product);
    }
}

- (void)getSearchListCompletionWithResult:(BOOL)isSuccess
                                 errorMsg:(NSString *)errorMsg
                                  service:(SearchListService *)service
{
    if (self.isbnService.context)
    {
        NSMutableDictionary *context = self.isbnService.context;
        [context setObject:@"1" forKey:@"search"];
        
        BOOL viaProductComplete = [[context objectForKey:@"product"] boolValue];
        if (viaProductComplete) {
            [self.readerViewController.view hideHUDIndicatorViewAtCenter];
        }
        
        BOOL viaProductOk = [[context objectForKey:@"productResult"] boolValue];
        if (viaProductOk) {
            self.isbnService.context = nil;
            return;
        }
    }
    else
    {
        [self.readerViewController.view hideHUDIndicatorViewAtCenter];
    }
    
    if (isSuccess && [service.productList count] > 0) {
        
        if (self.isbnService.context)
        {
            NSMutableDictionary *context = self.isbnService.context;
            [context setObject:@"1" forKey:@"searchResult"];
        }
        
        DataProductBasic *product = [service.productList objectAtIndex:0];
        
        [self goToProductDetail:product];
    }
    else
    {
        if (self.isbnService.context)
        {
            NSMutableDictionary *context = self.isbnService.context;
            BOOL viaProductComplete = [[context objectForKey:@"product"] boolValue];
            if (viaProductComplete) {
                [self alertErrorMsg:self.productService.errorMsg.length?self.productService.errorMsg:errorMsg];
            }
        }
        else
        {
            [self alertErrorMsg:errorMsg];
        }
    }
    
    self.isbnService.context = nil;
}

- (void)getProductDetailCompletionWithResult:(BOOL)isSuccess
                                    errorMsg:(NSString *)errorMsg
                               productDetail:(DataProductBasic *)product
{
    
    if (self.productService.context)
    {
        NSMutableDictionary *context = self.productService.context;
        [context setObject:@"1" forKey:@"product"];
        
        BOOL viaSearchComplete = [[context objectForKey:@"search"] boolValue];
        if (viaSearchComplete) {
            [self.readerViewController.view hideHUDIndicatorViewAtCenter];
        }
        
        BOOL viaSearchOk = [[context objectForKey:@"searchResult"] boolValue];
        if (viaSearchOk) {
            self.productService.context = nil;
            return;
        }
    }
    else
    {
        [self.readerViewController.view hideHUDIndicatorViewAtCenter];
    }
    
    if (isSuccess && product) {
        
        if (self.productService.context)
        {
            NSMutableDictionary *context = self.productService.context;
            [context setObject:@"1" forKey:@"productResult"];
        }
        
        [self goToProductDetail:product];
        
    }
    else
    {
        
        if (self.productService.context)
        {
            NSMutableDictionary *context = self.productService.context;
            BOOL viaSearchComplete = [[context objectForKey:@"search"] boolValue];
            if (viaSearchComplete) {
                [self alertErrorMsg:errorMsg];
            }
        }
        else
        {
            [self alertErrorMsg:errorMsg];
        }
    }
    
    self.productService.context = nil;
}

#pragma mark -
#pragma mark controller transform

- (void)goToProductDetail:(DataProductBasic *)product
{
    if (product.isCShop) {
        NSString *marketPrice = [NSString stringWithFormat:@"%@",product.marketPrice];
        if (IsStrEmpty(marketPrice)||[marketPrice isEqualToString:@"0"]) {
            if (NotNilAndNull(product.suningPrice)) {
                product.price = product.suningPrice;
            }
//            product.price = product.suningPrice;
        }
        else
        {
            if (NotNilAndNull(product.marketPrice)) {
                product.price = product.marketPrice;
            }
//            product.price = product.marketPrice;
        }
    }
    else
    {
        if (NotNilAndNull(product.suningPrice)) {
            product.price = product.suningPrice;
        }
//        product.price = product.suningPrice;
    }
    
    //存入数据库
    ScanHistoryDAO *dao = [[ScanHistoryDAO alloc] init];
    [dao writeProductToDB:product];
    
    [self doActionAfterDismiss:^{
        
        ProductDetailViewController *vc = [[ProductDetailViewController alloc] initWithDataBasicDTO:product];
        APP_DELEGATE.tabBarViewController.selectedIndex = 1;
        [self.contentController.navigationController pushViewController:vc animated:YES];
        
    }];
}

@end

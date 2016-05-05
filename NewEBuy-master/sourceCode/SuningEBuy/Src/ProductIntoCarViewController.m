   //
//  ProductIntoCarViewController.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-7-16.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ProductIntoCarViewController.h"
#import "MyPhotoSource.h"
#import "MyPhoto.h"
#import "ProductPackageView.h"
#import "LoginViewController.h"
#import "ProductDetailViewController.h"
#import "ShopCartV2ViewController.h"
#import "ReceiveInfoViewController.h"
#import "BuyNowCommand.h"

#define  ProductHeadSection   0
#define ColorSection     1
#define SizeSection      2
#define ServiceSection   3
#define PackageSection   3

#define kStartCurveX         65
#define kStartCurveY         63
#define kEndCurveY           [UIScreen mainScreen].bounds.size.height


@interface ProductIntoCarViewController ()

@end

@implementation ProductIntoCarViewController

-(void)dealloc{
    
    
    TT_RELEASE_SAFELY(_productDto);
    SERVICE_RELEASE_SAFELY(_detailService);
    
    SERVICE_RELEASE_SAFELY(_cartService);
    TT_RELEASE_SAFELY(_buttomView);
    
    TT_RELEASE_SAFELY(_okBtn);
    
    [CommandManage cancelCommandByClass:[BuyNowCommand class]];
    
}
- (ProductDetailService *)detailService
{
    if (!_detailService) {
        _detailService = [[ProductDetailService alloc] init];
        _detailService.delegate = self;
    }
    return _detailService;
}

-(UIImageView *)buttomView{
    
    if (!_buttomView) {
        
        _buttomView = [[UIImageView alloc] init];
        _buttomView.userInteractionEnabled = YES;
        _buttomView.image = [UIImage imageNamed:@"DJ_Detail_GroupBtnBack.png"];
    
//        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 170, 32)];
//        [btn setTitle:@"立即购买" forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(beginEasyBuy) forControlEvents:UIControlEventTouchUpInside];
//        [btn setBackgroundImage:[UIImage imageNamed:@"buy_n@2x.png"] forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage imageNamed:@"buy_h@2x.png"] forState:UIControlStateHighlighted];
//        // btn.backgroundColor = [UIColor redColor];
//        [_buttomView addSubview:btn];
//        [btn release];
        
        _okBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, 280, 32)];
        
        if (1 == self.carType) {
            
            [_okBtn setTitle:L(@"Product_BuyNow") forState:UIControlStateNormal];
        }
        else{
            
            [_okBtn setTitle:L(@"Product_AddConfirm") forState:UIControlStateNormal];
        }
        
        //[btn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_okBtn addTarget:self action:@selector(addToCar) forControlEvents:UIControlEventTouchUpInside];
        UIImage *nomralImg = nil;//[UIImage imageNamed:@"addtocar_n@2x.png"];
        UIImage *hightedImg = nil;// [UIImage imageNamed:@"addtocar_h@2x.png"];
        
        nomralImg = [[UIImage imageNamed:@"addtocar_n.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(16, 20, 16, 20)];
        hightedImg = [[UIImage imageNamed:@"addtocar_h.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(16, 20, 16, 20)];
        
        [_okBtn setBackgroundImage:nomralImg forState:UIControlStateNormal];
        [_okBtn setBackgroundImage:hightedImg forState:UIControlStateHighlighted];
        [_buttomView addSubview:_okBtn];        
        
        [self.view addSubview:_buttomView];
    }
    
    return _buttomView;
}
- (ShopCartV2Service *)cartService
{
    if (!_cartService) {
        _cartService = [[ShopCartV2Service alloc] init];
        _cartService.delegate = self;
    }
    return _cartService;
}
- (EGOImageView *)productImageView{
	
	if (!_productImageView) {
		_productImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(kStartCurveX, kEndCurveY, 200, 200)];
		_productImageView.backgroundColor = [UIColor clearColor];
        _productImageView.contentMode = UIViewContentModeScaleAspectFill;
        _productImageView.layer.backgroundColor = [UIColor clearColor].CGColor;
        _productImageView.layer.borderWidth = 0;
        [_productImageView.layer setCornerRadius:8.0];
        [_productImageView.layer  setMasksToBounds:YES];
		[self.view addSubview:_productImageView];
	}
	return _productImageView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)loadView
{
    [super loadView];
    
    if (1 == self.carType) {
        
        self.title = L(@"Product_BuyNow");
    }
    else{
        
        self.title = L(@"Add shopCart");
    }
    
    self.pageTitle = L(@"Product_Buy_Confirm");
    
    UIView *contentView = self.view;
	
	CGRect frame = contentView.frame;
	
	frame.origin.x = 0;
	
	frame.origin.y = 0;
    
    frame.size.height = contentView.bounds.size.height - 40 ;
    
    self.tableView.frame = frame;
    //[self.tableView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 8.0f, 0.0f)];
    
    [self.view addSubview:self.tableView];
    
    self.buttomView.frame = CGRectMake(0, contentView.bounds.size.height-97, 320, 55);
    [self.view bringSubviewToFront:self.buttomView];
    
    [self initColorAndVersion];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark 自定义

- (void)refreshData
{
    [self displayOverFlowActivityView];
    [self.detailService beginGetProductDetailInfo:self.productDto];
    
}

#pragma mark -
#pragma mark UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (ColorSection == section
        && 0 == [self.productDto.colorItemList count]) {
        

        return 0;
    }
    
    if (SizeSection == section
        && 0 == [self.productDto.versionItemList count]) {
        

        return 0;
    }
    //套餐商品栏
    if (PackageSection == section
        && ![self.productDto hasPackageList])
    {

        return 0;
    }

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (ProductHeadSection == indexPath.section) {
        
        static NSString *headCell = @"headCell";
        
        ProductHeadImgCell *cell = (ProductHeadImgCell *)[tableView dequeueReusableCellWithIdentifier:headCell];
        
        if (nil == cell)
        {
            cell = [[ProductHeadImgCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headCell];
            //cell.backgroundView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.type = 3;
            cell.delegate = self;
        }
        
        [cell setItem:self.productDto];
        
        [cell refreshFrame];
        
        return cell;
    }
    
    if (ColorSection == indexPath.section) {
        
        static NSString *colorCell = @"colorCell";
        
        SelectItemCell *cell = (SelectItemCell *)[tableView dequeueReusableCellWithIdentifier:colorCell];
        
        if (nil == cell)
        {
            cell = [[SelectItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:colorCell];
            cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
           
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.myDelegate = self;
        }
        
        [cell initViewWithSourse:self.productDto type:ColorCell];
        
        return cell;
    }
    
    if (SizeSection == indexPath.section) {
        
        static NSString *sizeCell = @"sizeCell";
        
        SelectItemCell *cell = (SelectItemCell *)[tableView dequeueReusableCellWithIdentifier:sizeCell];
        
        if (nil == cell)
        {
            cell = [[SelectItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sizeCell];
            cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.myDelegate = self;
        }
        
        [cell initViewWithSourse:self.productDto type:SizeCell];
        
        return cell;
    }
    //套餐商品栏
    if ([self.productDto hasPackageList])
    {
        static NSString *clusterCell = @"productClusterCell";
        ProductPackageView *cell = (ProductPackageView *)[tableView dequeueReusableCellWithIdentifier:clusterCell];
        
        if (cell == nil){
            
            cell = [[ProductPackageView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:clusterCell ];
            cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
//            cell.delegate = self;
        }
        
        cell.item = self.productDto;
        
        return cell;
    }
    
 
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    

    
    if (section == [tableView numberOfSections]-1) {
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        lab.backgroundColor = [UIColor clearColor];
        return lab;
    }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    if (section == [tableView numberOfSections]-1) {
        
        return 40;
    }
    
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    if(ProductHeadSection == indexPath.section){
        
        return 180;
    }
    else if(PackageSection == indexPath.section){
        
        return [ProductPackageView height:self.productDto];
        
////        if (self.productDto.packageType == PackageTypeAccessory)
////        {
////            return [self.productDto.accessoryPackageList count]*80 + 20;
////        }
////        else if (self.productDto.packageType == PackageTypeSmall)
////        {
////            return [self.productDto.smallPackageList count]*80 + 20;
////        }
//        
//        return 0;
    }
    else if(ColorSection == indexPath.section){
       
        //颜色高度
        
        return  [SelectItemCell cellHeight:self.productDto type:ColorCell];//[SelectItemCell cellHeight:self.productDto.colorItemList];
    }
    else if(SizeSection == indexPath.section){
        
        //版本高度
        
        return [SelectItemCell cellHeight:self.productDto type:SizeCell];//[SelectItemCell cellHeight:self.productDto.versionItemList];
    }
    return 44;
}
#pragma mark -
#pragma mark package view delegate

- (void)packageView:(ProductPackageView *)view didSelectProduct:(DataProductBasic *)product
{
   
    product.cityCode = [Config currentConfig].defaultCity;
    ProductDetailViewController *vc = [[ProductDetailViewController alloc] initWithDataBasicDTO:product];

    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -
#pragma mark service delegate
- (void)service:(ShopCartV2Service *)service orderCheckOutComplete:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    
    //  self.sectionHeaderView.easilyBuyButton.enabled = YES;
    
    if (isSuccess)
    {
        //       返回修改
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] init];
        barButtonItem.title = L(@"Back");
        self.navigationItem.backBarButtonItem = barButtonItem;
        
        // 导航到去结算页面
        ReceiveInfoViewController *receiveViewController = [[ReceiveInfoViewController alloc] init];
        
        ShopCartV2DTO *dto = [ShopCartV2DTO shopCartV2DTOFromProduct:self.productDto];
        NSMutableArray *array = [NSMutableArray arrayWithObject:dto];
        
        receiveViewController.powerFlag = self.productDto.powerFlgOrAmt;
//        receiveViewController.productList = array;  // 产品列表
        [receiveViewController calculateProduct:array];
        //刘坤5-28默认城市
        receiveViewController.deliveryCityCode = self.productDto.cityCode;
        receiveViewController.currentCityCode = self.productDto.cityCode;
        
        double price = [dto totalPrice];
        receiveViewController.totalPriceStr = [NSString stringWithFormat:@"￥%0.2f",price];
        receiveViewController.shouldPayPrice = [NSString stringWithFormat:@"￥%0.2f",price];
        
        receiveViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController: receiveViewController animated:YES];
        
        TT_RELEASE_SAFELY(receiveViewController);
    }
    else
    {
        if ([service.exceptionList count] > 0)
        {
            ShopCartV2DTO *dto = [service errorItemFromExceptionList:service.exceptionList];
            NSString *errorMsg = dto.errorDesc.length > 0?dto.errorDesc:L(@"System_Abnomal_Try_later");
            [self presentCustomDlg:errorMsg];
            //            [self presentSheet:errorMsg];
        }
        else
        {
            NSString *error = service.errorMsg ? service.errorMsg : L(@"System_Abnomal_Try_later");
            //            [self presentSheet:error];
            [self presentCustomDlg:error];
        }
    }
}


- (void)getProductDetailCompletionWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg productDetail:(DataProductBasic *)product
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        
        if (IsStrEmpty(product.productName)) {
            product.productName = self.productDto.productName;
        }
        self.productDto = product;
        
        
        [self initColorAndVersion];
        [self refreshBtn];
        [self.tableView reloadData];
       // [self loadWebView];
        
        //刷新上级的商品详情页面
        if (_clusterChangedBlock) {
            _clusterChangedBlock(self.productDto);
        }
    }
    else{
        
        
        self.okBtn.enabled = NO;
        
        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
                                                        message:errorMsg
                                                       delegate:nil
                                              cancelButtonTitle:L(@"Ok")
                                              otherButtonTitles:nil];
        if (!self.detailService.isRequestError) {
            [alert setCancelBlock:^{
               // [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        [alert show];
    }
    
}

- (void)addToFavoriteCompletionWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg errorCode:(NSString *)errorCode
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        
        errorMsg = L(@"addToFavorite success");
    }
    
    [self presentSheet:errorMsg];
    
   // self.navigationItem.rightBarButtonItem.enabled = YES;
}

//第一次设置颜色id  版本id
-(void)initColorAndVersion{
    
    
    for (int i = 0; i<[self.productDto.colorVersionMap count]; i++)
    {
        
        DataProductBasic *mapDTO = [self.productDto.colorVersionMap objectAtIndex:i];
        if ([self.productDto.productId isEqualToString: mapDTO.productId])
        {
            
            self.colorId = mapDTO.colorCurr;
            self.versionId = mapDTO.versionCurr;
            
            self.productDto.colorCurr = mapDTO.colorCurr;
            self.productDto.versionCurr = mapDTO.versionCurr;
            
            break;
        }

    }
}

//根据colorid versionid获取productDto
- (DataProductBasic *)getProductMap:(NSString *)colorId versionId:(NSString *)versionId{
    
    
    if (colorId == nil && versionId == nil)
    {
        return nil;
    }
    for (int i = 0; i<[self.productDto.colorVersionMap count]; i++)
    {
        
        DataProductBasic *mapDTO = [self.productDto.colorVersionMap objectAtIndex:i];
        if ([colorId isEqualToString: mapDTO.colorCurr]  &&[versionId isEqualToString: mapDTO.versionCurr])
        {
            return mapDTO;
        }
        
        //add by cuizl 由于主站商品数据维护有问题，部分商品商品簇中versionid为空
        if([versionId isEqualToString:@""]||[mapDTO.versionCurr isEqualToString:@""])
        {
            if(self.productDto.versionItemList.count == 1&&[colorId isEqualToString:mapDTO.colorCurr])
            {
                return mapDTO;
                
            }
        }
        if([colorId isEqualToString:@""]||[mapDTO.colorCurr isEqualToString:@""])
        {
            
            if(self.productDto.colorItemList.count == 1 && [versionId isEqualToString:mapDTO.versionCurr])
            {
                return mapDTO;
            }
            
        }
        
    }
    
    
    return nil;
}

-(void)selected:(NSString *)value cell:(NSInteger)type{
    
    
    if (nil == value) {
        
        
        BBAlertView *alert = [[BBAlertView alloc ]
                              initWithTitle:nil
                              message:L(@"Cluster_Not_Product_Found ")
                              delegate:nil
                              cancelButtonTitle:L(@"Ok")
                              otherButtonTitles:nil];
        [alert show];
        TT_RELEASE_SAFELY(alert);
        
        return;
    }
    
    if (ColorCell == type) {
        
        self.colorId = value;
    }
    else if(SizeCell == type){
        
        self.versionId = value;
    }
    
    [self displayOverFlowActivityView];
    [self.detailService beginGetProductDetailInfo:[self getProductMap:self.colorId versionId:self.versionId]];
    
}

//ProductImageCellDelegate
- (void)didTouchImageAtIndex:(NSInteger)index
             withSmallImages:(NSArray *)imageUrls
                andBigImages:(NSArray *)bigImageUrls
{
    NSMutableArray *sourceArr = [[NSMutableArray alloc] initWithCapacity:[bigImageUrls count]];
    for (NSURL *url in bigImageUrls)
    {
        MyPhoto *photo = [[MyPhoto alloc] initWithImageURL:url];
        [sourceArr addObject:photo];
    }
    MyPhotoSource *source = [[MyPhotoSource alloc] initWithPhotos:sourceArr];
    
    EGOPhotoViewController *photoController = [[EGOPhotoViewController alloc] initWithPhotoSource:source];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:photoController];
    
    navController.modalPresentationStyle = UIModalPresentationFullScreen;
    if (IOS5_OR_LATER)
    {
        [self presentViewController:navController animated:YES completion:^{
            photoController.scrollView.alpha = 1;
            [photoController moveToPhotoAtIndex:index animated:NO];
        }];
    }
    else
    {
        [self presentModalViewController:navController animated:YES];
        photoController.scrollView.alpha = 1;
        [photoController moveToPhotoAtIndex:index animated:NO];
    }
    
    TT_RELEASE_SAFELY(navController);
    TT_RELEASE_SAFELY(photoController);
    TT_RELEASE_SAFELY(source);
}



#pragma mark -
#pragma mark shopCar
/*
 @abstract      添加购物车
 */
//检查是否登录，如果未登录则弹出登录界面
- (BOOL)checkLogin
{
    if ([UserCenter defaultCenter].isLogined) {
        return YES;
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.loginDelegate = self;
        loginVC.loginDidOkSelector = loginSel;
        AuthManagerNavViewController *navController = [[AuthManagerNavViewController alloc] initWithRootViewController:loginVC];
        [self presentModalViewController:navController animated:YES];
        return NO;
    }
}

//商品是否可买
- (BOOL)isProductEnabled
{
    /*
     * liukun modify  12-12-06  如果商品价格小于等于0，默认也是不可买的
     */
    if (self.productDto.isCShop)
    {
        if (self.productDto.suningPrice.doubleValue > 0)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        if ([self.productDto.hasStorage isEqualToString:@"Y"] &&
            ![self.productDto.cityCode isEqualToString:@""] &&
            [self.productDto.suningPrice doubleValue] > 0  &&
            self.productDto.isPublished)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
}

-(void)refreshBtn{
    
    
    if ([self isProductEnabled]) {
        
        self.okBtn.enabled = YES;
    }
    else{
        
        self.okBtn.enabled = NO;
    }
}
/*
 @abstract      加入收藏
 */
- (void)addToFavorite{
    loginSel = @selector(addToFavoriteLoginSuccess);
    if ([self checkLogin]) {
        [self displayOverFlowActivityView];
       // self.navigationItem.rightBarButtonItem.enabled = NO;
        [self.detailService beginAddToFavorite:self.productDto];
    }
}
//登录完成
- (void)addToFavoriteLoginSuccess
{
    [self addToFavorite];
}

-(void)easyBuyLoginSuccess{
    
    [self addToCar];
}
- (void)addToCar
{
    
    if (1 == self.carType) {
        
        
        loginSel = @selector(easyBuyLoginSuccess);
        
        if ([self isProductEnabled] && [self checkLogin])
        {
            BuyNowCommand *command = [BuyNowCommand command];
            command.product = self.productDto;
            command.sController = self;
            [CommandManage excuteCommand:command completeBlock:nil];
        }
        else{
            
            [self removeOverFlowActivityView];
        }
        
        
        return;
    }
    
    if (![self isProductEnabled])
    {
        [self removeOverFlowActivityView];
        return;
    }
    
    if (self.productDto.cityCode.length == 0)
    {
        self.productDto.cityCode = [[Config currentConfig] defaultCity];
    }
    
    self.okBtn.enabled = NO;
    
    SNOperationCallBackBlock block = ^(BOOL isSuccess, NSString *errorMsg){
    self.okBtn.enabled = YES;
        
        [self removeOverFlowActivityView];
        if (isSuccess) {
           // [self playAnmationAndSoundForSuckEffect];
            
            BBAlertView *alert =[ [BBAlertView alloc]initWithTitle:nil message:L(@"Product_AddToCartSuccess") delegate:nil cancelButtonTitle:L(@"Ok") otherButtonTitles:L(@"Product_GoToShopCart")];
            [alert show];
            [alert setConfirmBlock:^{
                
//                [self.navigationController popToRootViewControllerAnimated:NO];
                [[AppDelegate currentAppDelegate].tabBarViewController setSelectedIndex:3];
                [(UINavigationController*)[[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:3] popToRootViewControllerAnimated:NO];
            }];
            [alert setCancelBlock:^{
                
            }];
            TT_RELEASE_SAFELY(alert);
        }
        else{
            [self presentCustomDlg:errorMsg];
        }
    };
    
    [self.shoppingCartBoard addProductToShoppingCart:self.productDto
                                     completionBlock:block];
}

- (void)initPorductAnimateView
{
    NSURL *imageUrl = [ProductUtil getImageUrlWithProductCode:self.productDto.productCode size:ProductImageSize200x200];
    self.productImageView.imageURL = imageUrl;
}
//动画和声音
- (void)playAnmationAndSoundForSuckEffect
{
    [self initPorductAnimateView];
    
    float duration = 0.6f;
    float pading = 0.0f;
    
    CABasicAnimation *xoffsetAnmatione = [CABasicAnimation animationWithKeyPath:@"position"];
    CGPoint currPos = CGPointMake(self.productImageView.layer.position.x, kStartCurveY);
    xoffsetAnmatione.fromValue = [NSValue valueWithCGPoint:currPos];
    xoffsetAnmatione.toValue = [NSValue valueWithCGPoint:CGPointMake( 64 * 3.8, self.productImageView.layer.position.y)];
    xoffsetAnmatione.duration = pading;
    xoffsetAnmatione.repeatCount=1 ;//动画重复次数
    xoffsetAnmatione.autoreverses=NO;//是否自动重复
    xoffsetAnmatione.timingFunction =  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CAKeyframeAnimation* opacityAnimation;
    opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.values = [NSArray arrayWithObjects:
                               [NSNumber numberWithFloat:0.1],
                               [NSNumber numberWithFloat:0.8],
                               [NSNumber numberWithFloat:1.0],
                               nil];
    //opacityAnimation.beginTime = pading;
    opacityAnimation.duration = duration - pading;
    opacityAnimation.repeatCount = 1;
    
    CABasicAnimation *origeScaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	//origeScaleAnimation.fromValue = [NSNumber numberWithDouble:0];
    origeScaleAnimation.toValue = [NSNumber numberWithDouble:0.1];
    origeScaleAnimation.duration = duration - pading;
    //    origeScaleAnimation.autoreverses			= NO;
	origeScaleAnimation.repeatCount			= 1;  //"forever"
	origeScaleAnimation.removedOnCompletion	= YES;
    origeScaleAnimation.timingFunction =  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:
                            xoffsetAnmatione,
                            // pulseAnimation,
                            origeScaleAnimation,
                            nil];
    animGroup.duration = duration;
    animGroup.removedOnCompletion = YES;
    animGroup.repeatCount = 1;
    animGroup.autoreverses = NO;
    
    [self.productImageView.layer addAnimation:animGroup forKey:nil];
    
    //刘坤, 12-12-10， 不播放声音
    //[PlaySoundAndShacking playSoundAndShacking:YES];
}


- (void)beginEasyBuy{
    
//    loginSel = @selector(easyBuyLoginSuccess);
//    
//    if ([self isProductEnabled] && [self checkLogin])
//    {
//        //self.sectionHeaderView.easilyBuyButton.enabled = NO;
//        
//        if (self.productDto.cityCode.length == 0)
//        {
//            self.productDto.cityCode = [[Config currentConfig] defaultCity];
//        }
//        
//        NSMutableArray *list = [NSMutableArray arrayWithArray:self.shoppingCartBoard.shopCartItemList];
//        
//        for (ShopCartV2DTO *dto in list) {
//            if (dto.isChecked) {
//                dto.isChecked = NO;
//            }
//        }
//        
//        ShopCartV2DTO *dto = [ShopCartV2DTO shopCartV2DTOFromProduct:self.productDto];
//        [list addObject:dto];
//        
//        [self displayOverFlowActivityView:L(@"Loading...")];
//        
//        [self.cartService requestOrderCheckOut:list];
//    }
}

@end

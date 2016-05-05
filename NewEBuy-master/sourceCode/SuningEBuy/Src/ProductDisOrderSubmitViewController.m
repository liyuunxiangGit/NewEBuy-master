//
//  ProductDisOrderSubmitViewController.m
//  SuningEBuy
//
//  Created by xy ma on 12-3-14.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "ProductDisOrderSubmitViewController.h"
#import "ProductDetailSubmitService.h"
#import "ProductUtil.h"
#import <AVFoundation/AVFoundation.h>
#import <SSA_IOS/SSAIOSSNDataCollection.h>

#define kLeftMargin                 98.0
#define kTopMargin                  8.0
#define kTextFieldWidth             188.0
#define kTextFieldHeight            44.0
#define kTextFieldFontSize          15.0
#define KConbineCellImageHeight     80.0
#define KConbineImageWidth          280.0
#define KLittlePhotoSize            46.0

@interface ProductDisOrderSubmitViewController()

-(void)updateTable;                     //更新table中的数据
-(void)addToArray:(UIImage *)image;     //讲用户添加的照片添加到数组中
//-(void)refreshList;                     //更新数据
-(void)validataData;                    //前台数据验证
- (void)openAuthenticateView;           //用户授权

@end

@implementation ProductDisOrderSubmitViewController
@synthesize submitTitleTextField = _submitTitleTextField;
@synthesize submitContentTextView = _submitContentTextView;
@synthesize imageView = _imageView;
@synthesize closeBtn = _closeBtn;
@synthesize imageAndButtonView = _imageAndButtonView;
@synthesize separatorLine = _separatorLine;
@synthesize cameraButton = _cameraButton;
@synthesize shareButton = _shareButton;
@synthesize tipLbl = _tipLbl;
@synthesize shareLbl = _shareLbl;
@synthesize takePhotoAndShare = _takePhotoAndShare;
@synthesize showImageListView = _showImageListView;

@synthesize imageSelect =imageSelect_;

@synthesize imageArray = imageArray_;
@synthesize imageViewList = _imageViewList;
@synthesize imageAndBtnList = _imageAndBtnList;
@synthesize closeBtnList = _closeBtnList;
@synthesize imageProList = _imageProList;

@synthesize titleLabel = _titleLabel;
@synthesize contentLabel = _contentLabel;


@synthesize imageConbineView = _imageConbineView;
@synthesize totalImageString = _totalImageString;
@synthesize MemberOrderDetailsDTO = _MemberOrderDetailsDTO;

@synthesize service=_service;


-(id)initWithDTO:(MemberOrderDetailsDTO *)dto isMember:(BOOL)aIsMember
{
    if ((self = [super init])){
        self.title = L(@"Show My Order Now");
        if (aIsMember)
        {
            self.pageTitle = [NSString stringWithFormat:@"%@",L(@"member_myEbuy_userDisOrder")];
        }
        else
        {
            self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"show_productDetail"),self.title];
        }
        
        self.MemberOrderDetailsDTO = dto;
        _isSelected = NO;
        
//        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(validataData)];
//        self.navigationItem.rightBarButtonItem = rightItem;
//        TT_RELEASE_SAFELY(rightItem);

        if (!_evalutionDto) {
            _evalutionDto = [[EvalutionDetailDTO alloc] init];
        }
        
        if (dto.orderItemId.length) {
            _evalutionDto.orderItemId = dto.orderItemId;
        }
        if (dto.productId.length) {
            _evalutionDto.catentryId = dto.productId;
        }
        if (dto.productCode.length) {
            _evalutionDto.partNumber = dto.productCode;
        }
        if (dto.productName.length) {
            _evalutionDto.catentryName = dto.productName;
        }
        if (dto.cShopName.length) {
            _evalutionDto.supplierName = dto.cShopName;
        }
        
        if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
            
            _evalutionDto.productUrl = [ProductUtil getImageUrlWithProductCode:dto.productCode size:ProductImageSize160x160];
        }
        else{
            
            _evalutionDto.productUrl = [ProductUtil getImageUrlWithProductCode:dto.productCode size:ProductImageSize120x120];
        }
        
//        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:@"发布"];

        imageArray_=[[NSMutableArray alloc]init];
        _closeBtnList=[[NSMutableArray alloc]init];
        _imageAndBtnList=[[NSMutableArray alloc]init];
        _imageViewList=[[NSMutableArray alloc]init];
        _imageProList=[[NSMutableArray alloc]init];
        
        _service=[[ProductDetailSubmitService alloc]init];
        _service.delegate=self;
        
        isSendSubmitOrderRequest = YES;
        isCouldSubmit = YES;
        
        self.hasNav = YES;
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

-(id)init{
    
    self = [super init];
    if(self){
        self.title = L(@"BaskSingle");//L(@"Show My Order Now");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"show_productDetail"),self.title];
        _isSelected = NO;
//        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"Submit Display Order")];        

        
        imageArray_=[[NSMutableArray alloc]init];
        _closeBtnList=[[NSMutableArray alloc]init];
        _imageAndBtnList=[[NSMutableArray alloc]init];
        _imageViewList=[[NSMutableArray alloc]init];
        _imageProList=[[NSMutableArray alloc]init];
        
        isCouldSubmit = YES;
        
    }
    return self;
    
}

- (void)righBarClick
{
    [self validataData];
}

- (void)dealloc{
    TT_RELEASE_SAFELY(_submitContentTextView);
    TT_RELEASE_SAFELY(_submitTitleTextField);
//    TT_RELEASE_SAFELY(_tpTableView);
    TT_RELEASE_SAFELY(_button);
    TT_RELEASE_SAFELY(imageSelect_);
    TT_RELEASE_SAFELY(_imageView);
    TT_RELEASE_SAFELY(_closeBtn);
    TT_RELEASE_SAFELY(_separatorLine);
    
    TT_RELEASE_SAFELY(_cameraButton);
    TT_RELEASE_SAFELY(_shareBtn);
    TT_RELEASE_SAFELY(_tipLbl);
    TT_RELEASE_SAFELY(_shareLbl);
    TT_RELEASE_SAFELY(_takePhotoAndShare);
    
    TT_RELEASE_SAFELY(_showImageListView);
    
    TT_RELEASE_SAFELY(_imageViewList);
    TT_RELEASE_SAFELY(_imageAndBtnList);
    TT_RELEASE_SAFELY(_closeBtnList);
    TT_RELEASE_SAFELY(_titleLabel);
    TT_RELEASE_SAFELY(imageArray_);
    
    TT_RELEASE_SAFELY(_contentLabel);
    
    TT_RELEASE_SAFELY(_imageConbineView);
    TT_RELEASE_SAFELY(_totalImageString);
    
    TT_RELEASE_SAFELY(_MemberOrderDetailsDTO);
    
    TT_RELEASE_SAFELY(_service);
    
    TT_RELEASE_SAFELY(_cameraBtnImageThree);
    TT_RELEASE_SAFELY(_cameraBtnImageTwo);
    TT_RELEASE_SAFELY(_cameraBtnImageOne);

    TT_RELEASE_SAFELY(_fullVC);

}

- (void)loadView{
    [super loadView];
    
    self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    
   	CGRect frame = self.view.frame;
	
	frame.origin.x = 0;
	
	frame.origin.y = 0;
    
    frame.size.height = self.view.bounds.size.height - 92 ;
    

    self.tpTableView.frame = [self setViewFrame:self.hasNav];//[self setCommonViewFrame:self.hasNav WithTab:YES];//;//frame;
//    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tpTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tpTableView];
        
    [self useBottomNavBar];
    [self.bottomNavBar addSubview:self.bottomCell];
    self.bottomCell.yiGouBtn.hidden = YES;
    self.bottomCell.backBtn.hidden = YES;
    self.bottomCell.payBtn.hidden = NO;
    self.bottomCell.payBtn.frame = CGRectMake(32.5, 6.5, 255, 35);
    
    [self.bottomCell.payBtn setTitle:L(@"Submit Display Order") forState:UIControlStateNormal];
    [self.bottomCell.payBtn addTarget:self action:@selector(validataData) forControlEvents:UIControlEventTouchUpInside];

}


#pragma mark -
#pragma mark Table View Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0)
    {
        return 1;
    }
    
    return 2;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0)
    {
        return 115;
    }
    else if(indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            return 60;
        }
    }
    
    return 113+5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
//    return 115;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
//    self.headView.backgroundColor = [UIColor whiteColor];
//    return self.headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if(section == 0)
    {
        return 0;
    }
    
    return 85;//80;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    self.showImageListView.backgroundColor = [UIColor whiteColor];
    
    return self.showImageListView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0)
    {
        static NSString *evalutionContontIdentifier = @"evalutionContontIdentifier_productDisOrder";
        
        SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:evalutionContontIdentifier];
        
        if(cell == nil)
        {
            cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:evalutionContontIdentifier];
            cell.textLabel.textColor = [UIColor dark_Gray_Color];            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }

        [cell.contentView addSubview:self.headView];
        
        return cell;
    }
    else
    {
        switch (indexPath.row) {
            case 0:
            {
                
                static NSString *productCellIdentifier = @"productCellIdentifier";
                
                SNUITableViewCell *productCell = [tableView dequeueReusableCellWithIdentifier:productCellIdentifier];
                
                if (!productCell)
                {
                    productCell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productCellIdentifier];
                    
                }
                
                
                [productCell.contentView addSubview:self.submitTitleTextField];
                
                
                productCell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                self.submitTitleTextField.frame = CGRectMake(15, 15, 290, 35);
                
                return productCell;
                
            }
                
            case 1:
            {
                
                static NSString *disOrderDetailIdentifier = @"disOrderDetailIdentifier";
                
                SNUITableViewCell *disOrderDetailCell = [tableView dequeueReusableCellWithIdentifier:disOrderDetailIdentifier];
                
                if (!disOrderDetailCell)
                {
                    disOrderDetailCell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:disOrderDetailIdentifier];
                    
                }
                
                //            self.contentLabel.text = L(@"Display Order Content");
                //            [disOrderDetailCell.contentView addSubview:self.contentLabel];
                [disOrderDetailCell.contentView addSubview:self.submitContentTextView];
                
                //            disOrderDetailCell.backgroundColor = [UIColor whiteColor];
                disOrderDetailCell.selectionStyle = UITableViewCellSelectionStyleNone;
                self.submitContentTextView.frame = CGRectMake(15, 5, 290, 103);
                
                disOrderDetailCell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return disOrderDetailCell;
                
            }
                
            default:
                break;
        }

    }
    
    return [[UITableViewCell alloc] init];
}


#pragma mark - self define view


- (UIImageView *)headView
{
    if (!_headView) {
        _headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 115)];
        _headView.backgroundColor = [UIColor clearColor];
        _headView.userInteractionEnabled = YES;
        
        
        EGOImageView *productimg = [[EGOImageView alloc] initWithFrame:CGRectMake(15, 15, 85, 85)];
        productimg.backgroundColor = [UIColor clearColor];
        //        productimg.layer.cornerRadius = 5;
        productimg.delegate = self;
        productimg.layer.borderWidth = 0.4;
        productimg.layer.borderColor = RGBCOLOR(235, 235, 235).CGColor;
        productimg.layer.masksToBounds = YES;
       
        productimg.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
        productimg.contentMode = UIViewContentModeScaleToFill;
        
        productimg.imageURL = self.evalutionDto.productUrl;
        [_headView addSubview:productimg];
        
        UILabel *productName = [[UILabel alloc] init];
        UIFont *cellFont =[UIFont systemFontOfSize:15.0];
        productName.numberOfLines = 2;
        productName.backgroundColor = [UIColor clearColor];
        //        productName.lineBreakMode = NSLineBreakByCharWrapping;
        productName.font = cellFont;
        productName.textColor = [UIColor blackColor];
        productName.text = self.evalutionDto.catentryName;
       
        productName.frame = CGRectMake(110, 16, 193, 38);
        
        [_headView addSubview:productName];
        
//        UILabel *priceLbl = [[UILabel alloc] init];
//        priceLbl.backgroundColor = [UIColor clearColor];
//        priceLbl.textColor = [UIColor colorWithRGBHex:0xFF0000];
//		priceLbl.font = [UIFont systemFontOfSize:17];
//        priceLbl.text = @"￥";
//		priceLbl.autoresizingMask = UIViewAutoresizingNone;
//        priceLbl.frame = CGRectMake(110, 62, 140, 20);
//		[_headView addSubview:priceLbl];
        
//        EGOImageView *priceImg = [[EGOImageView alloc] init];
//        priceImg.backgroundColor = [UIColor clearColor];
//        priceImg.contentMode = UIViewContentModeLeft;
//        priceImg.placeholderImage = nil;
//        priceImg.cacheAge = kEGOCacheAgeOneLifeCycle;
//        priceImg.frame = CGRectMake(125, 62, 135, 16);
//        NSString *cityId = [Config currentConfig].defaultCity;
//        priceImg.imageURL = [ProductUtil bestPriceImageOfProductId:self.evalutionDto.catentryId
//                                                              city:cityId];
//		[_headView addSubview:priceImg];
        
        UILabel *supplierNameLbl = [[UILabel alloc] init];
        supplierNameLbl.backgroundColor = [UIColor clearColor];
        supplierNameLbl.textColor = RGBCOLOR(151, 151, 151);
        supplierNameLbl.font = [UIFont systemFontOfSize:12];
        supplierNameLbl.text = self.evalutionDto.supplierName;
        supplierNameLbl.frame = CGRectMake(110, 84, 195, 12);
        [_headView addSubview:supplierNameLbl];
        
        UIImageView *seperateLineImg = [[UIImageView alloc] init];
        seperateLineImg.image = [UIImage imageNamed:@"line.png"];
        seperateLineImg.backgroundColor = [UIColor clearColor];
        seperateLineImg.frame = CGRectMake(0, 114, 320, 0.5);
        [_headView addSubview:seperateLineImg];
        
        //        UILabel *label = [[UILabel alloc] init];
        //        label.frame = CGRectMake(95, 62, 120, 30);
        //        label.backgroundColor = [UIColor clearColor];
        //        label.text = @"商品满意度";
        //        label.textColor = RGBCOLOR(140, 140, 140);
        //        label.font = [UIFont systemFontOfSize:15.0];
        //
        //        [_headView addSubview:label];
        //
        //        [_headView addSubview:self.StarRatingControl];
    }
    return _headView;
}


-(UILabel *)titleLabel{
    if (nil == _titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, 80, 30)];
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    return _titleLabel;
}

-(UILabel *)contentLabel{
    if (nil == _contentLabel) {
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 2, 80, 30)];
        _contentLabel.font = [UIFont systemFontOfSize:16.0];
        _contentLabel.backgroundColor = [UIColor clearColor];
    }
    return _contentLabel;
}



- (UITextField *)submitTitleTextField
{
    if (_submitTitleTextField == nil)
    {
        _submitTitleTextField = [[UITextField alloc]init];
        _submitTitleTextField.placeholder = L(@"Product_DisplayTheme");
        _submitTitleTextField.borderStyle = UITextBorderStyleNone;
        _submitTitleTextField.textColor = [UIColor blackColor];
        _submitTitleTextField.font = [UIFont systemFontOfSize:kTextFieldFontSize];
        _submitTitleTextField.backgroundColor = [UIColor clearColor];
        _submitTitleTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _submitTitleTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _submitTitleTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _submitTitleTextField.keyboardType = UIKeyboardTypeDefault;
        _submitTitleTextField.returnKeyType = UIReturnKeyDone;
        _submitTitleTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _submitTitleTextField.userInteractionEnabled = YES;
        _submitTitleTextField.delegate = self;
        
        _submitTitleTextField.layer.borderWidth = 0.4;
        _submitTitleTextField.layer.borderColor = RGBCOLOR(235, 235, 235).CGColor;
        _submitTitleTextField.layer.masksToBounds = YES;
    }
    
    return _submitTitleTextField;
}


- (GCPlaceholderTextView *)submitContentTextView
{
    if (_submitContentTextView == nil)
    {
        _submitContentTextView = [[GCPlaceholderTextView alloc] init];
        _submitContentTextView.placeholder = L(@"Product_TheseWordsDisplay");
        _submitContentTextView.textColor = [UIColor blackColor];
        _submitContentTextView.font = [UIFont systemFontOfSize:kTextFieldFontSize];
        _submitContentTextView.backgroundColor = [UIColor clearColor];
        _submitContentTextView.autocorrectionType = UITextAutocorrectionTypeNo;
        _submitContentTextView.keyboardType = UIKeyboardTypeDefault;
        _submitContentTextView.returnKeyType = UIReturnKeyDone;
        _submitContentTextView.delegate = self;
        
        _submitContentTextView.layer.borderWidth = 0.4;
        _submitContentTextView.layer.borderColor = RGBCOLOR(235, 235, 235).CGColor;
        _submitContentTextView.layer.masksToBounds = YES;
    }
    
    return _submitContentTextView;
}




////定义可以随着键盘显示而动态上移的tableview
//- (TPKeyboardAvoidingTableView *)tpTableView
//{
//	
//	
//	if(!_tpTableView){
//		
//		_tpTableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero
//                                                                    style:UITableViewStyleGrouped];
//		
//		
//		[_tpTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//		
//		[_tpTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
//		
//		_tpTableView.scrollEnabled = YES;
//		
//		_tpTableView.userInteractionEnabled = YES;
//		
//		_tpTableView.delegate =self;
//		
//		_tpTableView.dataSource =self;
//		
//		_tpTableView.backgroundColor =[UIColor clearColor];
//		
//        _tpTableView.backgroundView = nil;
//	}
//	
//	return _tpTableView;
//}


//存放照片的视图
-(UIImageView *)imageView{
    if(nil == _imageView){
        _imageView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KLittlePhotoSize, KLittlePhotoSize)];
    }
    return _imageView;
}

//关闭按钮
-(UIButton *)closeBtn{
    if (nil == _closeBtn)
    {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setFrame:CGRectMake(30, 0, 15, 15)];
        [_closeBtn setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
        [_closeBtn setBackgroundColor:[UIColor whiteColor]];
        [_closeBtn addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _closeBtn;
    
}


//存放图片视图和关闭按钮的容器视图
-(UIView *)imageAndButtonView{
    if (nil == _imageAndButtonView) {
        _imageAndButtonView = [[UIView alloc]init];
    }
    return _imageAndButtonView;
}


//分割线
-(UIImageView *)separatorLine{
    
    if (nil == _separatorLine) {
        _separatorLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 31, 320, 2)];
        _separatorLine.image = [UIImage imageNamed:@"cellSeparatorLine.png"];
    }
    return  _separatorLine;
}


//照相机按钮
-(UIButton *)cameraButton{
    
    if (_cameraButton == nil) {
        _cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cameraButton.frame = CGRectMake(10, 5, 30, 25);
        [_cameraButton setBackgroundImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
        [_cameraButton addTarget:self action:@selector(presentActionSheet:) forControlEvents:UIControlEventTouchUpInside];
        [self.takePhotoAndShare addSubview:_cameraButton];
    }
    return  _cameraButton;
    
}

//照相机按钮 1
-(EGOImageButton *)cameraBtnImageOne{
    
    if (_cameraBtnImageOne == nil) {
        _cameraBtnImageOne = [EGOImageButton buttonWithType:UIButtonTypeCustom];
        
        _cameraBtnImageOne.frame = CGRectMake(125+10, 18, 46, 44);

        _cameraBtnImageOne.imageView.hidden = NO;
        
        _cameraBtnImageOne.tag = 1;

        [_cameraBtnImageOne setBackgroundImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
        
        [_cameraBtnImageOne addTarget:self action:@selector(presentActionSheet:) forControlEvents:UIControlEventTouchUpInside];
        

        [self.takePhotoAndShare addSubview:_cameraBtnImageOne];
    }
    return  _cameraBtnImageOne;
    
}
//照相机按钮2
-(EGOImageButton *)cameraBtnImageTwo{
    
    if (_cameraBtnImageTwo == nil) {
        _cameraBtnImageTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _cameraBtnImageTwo.frame = CGRectMake(125+10+46+10, 18, 46, 44);
        
        _cameraBtnImageTwo.imageView.hidden = NO;

        _cameraBtnImageTwo.tag = 2;

        [_cameraBtnImageTwo setBackgroundImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
        
        [_cameraBtnImageTwo addTarget:self action:@selector(presentActionSheet:) forControlEvents:UIControlEventTouchUpInside];
        

        [self.takePhotoAndShare addSubview:_cameraBtnImageTwo];
    }
    return  _cameraBtnImageTwo;
    
}
//照相机按钮3
-(EGOImageButton *)cameraBtnImageThree{
    
    if (_cameraBtnImageThree == nil) {
        _cameraBtnImageThree = [UIButton buttonWithType:UIButtonTypeCustom];
        _cameraBtnImageThree.frame = CGRectMake(125+10+46+10+46+10, 18, 46, 44);
        _cameraBtnImageThree.imageView.hidden = NO;
        
        _cameraBtnImageThree.tag = 3;
        
        [_cameraBtnImageThree setBackgroundImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
        
        [_cameraBtnImageThree addTarget:self action:@selector(presentActionSheet:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [self.takePhotoAndShare addSubview:_cameraBtnImageThree];
    }
    return  _cameraBtnImageThree;
    
}


//分享按钮
-(UIButton *)shareButton{
    if (nil == _shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.frame = CGRectMake(200, 6, 20, 20);
        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"Remember_unselected.png"] forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(ShareToSNS) forControlEvents:UIControlEventTouchUpInside];
        //        [self.takePhotoAndShare addSubview:_shareBtn];
    }
    
    return  _shareBtn;
}


//提示用户“传多张照片可以获取云钻”
-(UILabel *)tipLbl{
    
    if (_tipLbl == nil) {
        _tipLbl = [[UILabel alloc]initWithFrame:CGRectMake(15,25,105,30)];
        _tipLbl.text = L(@"Product_DisplayAndGetCloudDiamond");//L(@"Three will get achievements");
        _tipLbl.backgroundColor = [UIColor clearColor];
        _tipLbl.textColor = [UIColor colorWithRGBHex:0x313131];
        _tipLbl.font = [UIFont systemFontOfSize:13.0];
    }
    return _tipLbl;
}

//提示用户是否分享到新浪微博
-(UILabel *)shareLbl{
    if (nil == _shareLbl) {
        _shareLbl = [[UILabel alloc]initWithFrame:CGRectMake(225,0,130,30)];
        _shareLbl.text = L(@"Share to sina");
        _shareLbl.backgroundColor = [UIColor clearColor];
        _shareLbl.textColor = [UIColor blackColor];
        _shareLbl.font = [UIFont systemFontOfSize:12.0];
        //        [self.takePhotoAndShare addSubview:_shareLbl];
    }
    return _shareLbl;
}


//存放照相机按钮、分享按钮和两个提示的文本标签
-(UIView *)takePhotoAndShare{
    if (nil == _takePhotoAndShare) {
        _takePhotoAndShare = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 85)];
        _takePhotoAndShare.backgroundColor = [UIColor clearColor];
        
        _takePhotoAndShare.userInteractionEnabled = YES;
//        [_takePhotoAndShare addSubview:self.cameraButton];
        [_takePhotoAndShare addSubview:self.tipLbl];
        [_takePhotoAndShare addSubview:self.cameraBtnImageOne];
        [_takePhotoAndShare addSubview:self.cameraBtnImageTwo];
        [_takePhotoAndShare addSubview:self.cameraBtnImageThree];

        
    }
    
    return _takePhotoAndShare;
}


//区块底部的所有内容都是由此视图展示的，具体操作过程中，会添加图片
-(UIView *)showImageListView{
    if (nil == _showImageListView) {
        
        _showImageListView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, KLittlePhotoSize)];
        _showImageListView.backgroundColor = [UIColor clearColor];
        
        _showImageListView.userInteractionEnabled = YES;
        
        [_showImageListView addSubview:self.takePhotoAndShare];
        
    }
    return _showImageListView;
}


-(UIImageView *)imageConbineView{
    if (nil == _imageConbineView) {
        _imageConbineView = [[UIImageView alloc]init];
    }
    
    return _imageConbineView;
}



#pragma mark - action


//弹出选择 “相册”或者“照相机”
-(void)presentActionSheet:(id)sender
{

    int tag = (int)((EGOImageButton*)sender).tag;
    
    if(tag - 10 < 0)
    {
        UIActionSheet *action = [[UIActionSheet alloc]
                                 initWithTitle:L(@"Please choose photoes")
                                 delegate:self
                                 cancelButtonTitle:L(@"Cancel photoes")
                                 destructiveButtonTitle:nil
                                 otherButtonTitles:L(@"Choose album"),L(@"Choose camera"), nil ];
        
        [action showInView:self.view.superview];
        
        TT_RELEASE_SAFELY(action);

    }
    else
    {
        
        NSString *str = [NSString stringWithFormat:@"%i",tag];
        
        UIImage *img = [self.BtnImageDic objectForKey:str];
        
        self.fullVC.imageV.image = img;
        
        self.fullVC.hasNav = NO;
        self.fullVC.hidesBottomBarWhenPushed = YES;
        self.fullVC.bottomCell.backBtn.hidden = NO;
        
        self.fullVC.deleteBtn.tag = tag;
        self.fullVC.camerAgainBtn.tag = tag;
        
        [self.fullVC.deleteBtn addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];

        [self.fullVC.camerAgainBtn addTarget:self action:@selector(showCamera:) forControlEvents:UIControlEventTouchUpInside];

        [self.navigationController pushViewController:self.fullVC animated:YES];
        
    }
    
    self.selectbtnTag = tag;
}

- (FullScreenmagesViewController*)fullVC
{
    if(!_fullVC)
    {
        _fullVC = [[FullScreenmagesViewController alloc] init];
    }
    
    return _fullVC;
}

- (NSMutableDictionary*)BtnImageDic
{
    if(!_BtnImageDic)
    {
        _BtnImageDic = [[NSMutableDictionary alloc] init];
    }
    
    return _BtnImageDic;
}


//获取用户选择的按钮值，根据该值判断是进入照相机还是相册
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
        {
            [self showAlbum]; //进入相册
            break;
        }
            
        case 1:
        {
            UIButton *btn = [[UIButton alloc] init];
            
            btn.tag = 100;
            [self showCamera:btn];//进入相机
            
            TT_RELEASE_SAFELY(btn);
            break;
        }
        default:
            break;
    }
    
}


//进入相册
- (void)showAlbum
{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *albumPicker = [[UIImagePickerController alloc] init];
        albumPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        albumPicker.delegate = self;
        albumPicker.allowsEditing = NO;
        [self presentModalViewController:albumPicker animated:NO];
    }
    else
    {
        [self presentSheet:L(@"sorry,photosalbum not avilable")];
    }
}

//进入相机
- (void)showCamera:(id)sender
{
    int tag = ((UIButton*)sender).tag;
    
    
//    BOOL isCameraValid = YES;
//    //下边的方法是iOS7新加的，7以下调用会报错
//    if(IOS7_OR_LATER)
//    {
//        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//        if (authStatus != AVAuthorizationStatusAuthorized)
//        {
//            isCameraValid = NO;
//        }
//    }

//    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera] && isCameraValid == YES)
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])

        {
            if(tag == 100)
            {
                
            }
            else
            {
                if(tag > 10)
                {
                    self.selectbtnTag = tag - 10;
                    
                }
            }
            
        
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            picker.allowsEditing = NO;
            
            picker.delegate = self;
            
            [self presentModalViewController:picker animated:YES];
            
        }
        else
        {
                [self presentSheet:L(@"sorry,camera not avilable")];

        }

    if(tag == 100)
    {
        
    }
    else
    {
        [self backForePage];
        
    }

}


//用户删除已经选择的照片
-(void)deletePhoto:(id)sender
{
    
    int tag = ((UIButton*)sender).tag;
    
    if(tag == 11)
    {
        self.cameraBtnImageOne.tag = 1;
        [self.cameraBtnImageOne setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
        [self.BtnImageDic removeObjectForKey:@"11"];
//        [self.BtnImageDic setObject:@"" forKey:@"11"];
    }
    else if(tag == 12)
    {
        self.cameraBtnImageTwo.tag = 2;
        [self.cameraBtnImageTwo setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
        [self.BtnImageDic removeObjectForKey:@"12"];

//        [self.BtnImageDic setObject:@"" forKey:@"12"];

    }
    else if(tag == 13)
    {
        self.cameraBtnImageThree.tag = 3;
        [self.cameraBtnImageThree setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
        [self.BtnImageDic removeObjectForKey:@"13"];

//        [self.BtnImageDic setObject:@"" forKey:@"13"];

    }
    
    [self backForePage];
    
    //通过获取点击button的下标定位应该被删除的照片
/*    int index = 0;
    int i = 0;
    for (UIButton *tempBtn in _closeBtnList)
    {
        if (sender == tempBtn) {
            index = i;
            break;
        }
        
        i++;
    }
    //将视图移走
    UIView *tempView = [_imageAndBtnList objectAtIndex:index];
    [tempView removeFromSuperview];
    
    //从数组中删除
    [_imageAndBtnList removeObjectAtIndex:index];
    [_imageViewList removeObjectAtIndex:index];
    [_closeBtnList removeObjectAtIndex:index];
    [_imageProList removeObjectAtIndex:index];
    [imageArray_ removeObjectAtIndex:index];*/
    
    [self updateTable];
    
}


//分享到新浪微博的按钮点击后，会改变按钮的背景图片，同时改变_isSelected标识位
- (void)ShareToSNS
{
    
    if (_isSelected) {
        _isSelected = NO;
        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"Remember_unselected.png"] forState:UIControlStateNormal];
        
    }else{
        _isSelected = YES;
        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"Remember_selected.png"] forState:UIControlStateNormal];
        
    }
    [self updateTable];
    
}




//一旦选择了照片， ImagePicker 将回调 didFinishPickingMediaWithInfo。在PhotoAppViewController.m 文件中进入下列代码：
//
//第一行代码隐藏拾取器。随后将图像视图的image 属性设置为返回的图像。拾取器返回一个NSDictionary对象。这是由于 UIImagePickerControllerMediaType 将指示返回的是视频还是图像。

-(void)imagePickerController:(UIImagePickerController*)picker    didFinishPickingMediaWithInfo:(NSDictionary*)info {
    [picker dismissModalViewControllerAnimated:YES];
    //imageView.image =[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    if (![[info objectForKey:@"UIImagePickerControllerMediaType"] isEqualToString: @"public.image"]) {
        
        [self displayAlertMessage:L(@"Please choose photo")];
        
        return;
    }
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    //如果图片的大小超过（300*300），则等比压缩，否则，后台会提示http请求过长.
    double size = image.size.height*image.size.width;
    double height = image.size.height;
    double width = image.size.width;
    
    float tempPercentage = 1.0;
    if ( size > 1000000) {
        
        tempPercentage = 1000000.0/size;
        

    }
    
    DLog(@"tempPercentage =%f", tempPercentage);
    UIImageTransformation *reduceImage = [[UIImageTransformation alloc]init];
    image = [reduceImage imageByScalingAndCroppingForSize:CGSizeMake(width*tempPercentage,height*tempPercentage) image:image];
    
    TT_RELEASE_SAFELY(reduceImage);
    
    
/*    if ([_imageViewList count] == 3) {
        
        [self displayAlertMessage:L(@"Just could select 3 photoes")];
        
        return;
    }
    */
    [self showImageView:image];
    
//    [self.imageArray addObject:image];
    //self.imageSelect = image;
    
    [self addToArray:image];
    [self updateTable];
    
}

//将选择的图片显示出来
- (void)showImageView:(UIImage*)image
{

    NSData *imageData1;
    NSData *imageData2;
    NSData *imageData3;
    
    if(self.selectbtnTag == 1)
    {
  
        [self.cameraBtnImageOne setImage:image forState:UIControlStateNormal];
        
        imageData1 = UIImageJPEGRepresentation(image, 0.5);
        
        [self.BtnImageDic setObject:image forKey:@"11"];
        
        self.cameraBtnImageOne.tag =11;
    }
    else if(self.selectbtnTag == 2)

    {
        [self.cameraBtnImageTwo setImage:image forState:UIControlStateNormal];

        imageData2 = UIImageJPEGRepresentation(image, 0.5);
        
        [self.BtnImageDic setObject:image forKey:@"12"];
        
        self.cameraBtnImageTwo.tag =12;

    }
    else if(self.selectbtnTag == 3)
    {
        [self.cameraBtnImageThree setImage:image forState:UIControlStateNormal];

        imageData3 = UIImageJPEGRepresentation(image, 0.5);
        
        [self.BtnImageDic setObject:image forKey:@"13"];

        self.cameraBtnImageThree.tag =13;
        
        
    }
    
    
    
    [self.tpTableView reloadData];
}



//将用户添加的照片  逐一添加到数组中，用于展示和合并图片
-(void)addToArray:(UIImage *)image{
    
    NSDictionary *tempDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                             [NSString stringWithFormat:@"%f",image.size.width],@"imageWidth",
                             [NSString stringWithFormat:@"%f",image.size.height],@"imageHeight",
                             nil];
    
    [_imageProList addObject:tempDic];
    TT_RELEASE_SAFELY(tempDic);
    
    self.imageView.image = image;
    [_imageViewList addObject:self.imageView];
    
    
    UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tempBtn setFrame:CGRectMake(28, 0, 20, 20)];
    [tempBtn setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [tempBtn setBackgroundColor:[UIColor clearColor]];
    [tempBtn addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [_closeBtnList addObject:tempBtn];
    TT_RELEASE_SAFELY(tempBtn);
    
    //存放照片和按钮的容器视图
    UIView *tempView = [[UIView alloc]init];
    [_imageAndBtnList addObject:tempView];
    TT_RELEASE_SAFELY(tempView);
    
}

//前台验证用户输入
-(void)validataData{
    
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"770706"], nil]];
    if (isSendSubmitOrderRequest == NO) {
        return;
    }
    
    if (isCouldSubmit==NO) {
        return;
    }
    
    //判断晒单主题是否合法
    NSString *string1 = [self.submitTitleTextField.text trim];
    
    if (IsStrEmpty(string1) || [string1 length] == 0) {
        
        [self displayAlertMessage:L(@"Please input display order title")];
        [self.submitTitleTextField becomeFirstResponder];
        return;
//        string1 = @"来自客户端用户的晒单";
    }
    
    if ([string1 length]<5 || [string1 length] > 10)
    {
        [self displayAlertMessage:L(@"Input 5-10 characters")];
        [self.submitTitleTextField becomeFirstResponder];
        return;
    }
    
    
    //判断晒单内容是否合法
    NSString *string2 = [self.submitContentTextView.text trim];
    
    if ([string2 length] == 0) {
        [self displayAlertMessage:L(@"Please input display order content")];
        [self.submitContentTextView becomeFirstResponder];
        return;
    }
    
    if (([string2 length]< 5 && [string2 length] != 0)||[string2 length] > 150)
    {
        [self displayAlertMessage:L(@"Input 5-150 characters")];
        [self.submitContentTextView becomeFirstResponder];
        return;
        
    }
    
    //判断用户是否上传图片
    BOOL hasImage = NO;
    
    for(int i=0; i<3; i++)
    {
        NSString *str = [NSString stringWithFormat:@"%i",i+11];
        
        UIImage *img = [self.BtnImageDic objectForKey:str];
        
        if(img&& img != [UIImage imageNamed:@"add.png"]&& img != nil && img !=[UIImage imageNamed:@""])
        {
            hasImage = YES;
            
            break;
        }
        else
        {
            
        }
    }
    
    [self.imageArray removeAllObjects];

    for(int i=0; i<3; i++)
    {
        NSString *str = [NSString stringWithFormat:@"%i",i+11];
        
        UIImage *img = [self.BtnImageDic objectForKey:str];
        
        if(img && img != [UIImage imageNamed:@"add.png"] && img != nil && img !=[UIImage imageNamed:@""])
        {
            [self.imageArray addObject:img];
            
        }
        else
        {
            
        }
    }
    
    if ([self.imageArray count] < 3) {
        [self displayAlertMessage:L(@"Product_Submit3Pic")];
        return;
    }
    
    if (hasImage == NO) {
        [self displayAlertMessage:L(@"Please upload 1-3 photoes")];
        return;
    }
//    
//    if ([_imageViewList count]<1 || [_imageViewList count]>3) {
//            [self displayAlertMessage:L(@"Please upload 1-3 photoes")];
//            return;
//    }

    if ([self.imageArray count]<1 || [self.imageArray count]>3) {
            [self displayAlertMessage:L(@"Three will get achievements")];
            return;
    }

    
    isCouldSubmit = NO;
    isSendSubmitOrderRequest=NO;
    [self.service sendSubmitOrderHttpRequest:_MemberOrderDetailsDTO
                                  imageArray:self.imageArray
                            totalImageString:self.totalImageString
                                       title:string1
                                     content:_submitContentTextView.text];
    [self displayOverFlowActivityView:L(@"Product_SubmittIng")];
    
    //如果用户选择里分享微博，则调用组合图片的方法
    if (_isSelected)
    {
        [self conbineImage];
        [self openAuthenticateView];
        
    }
    
}


//将多张图片组合成一张图片
-(UIImage *)conbineImage{
    
    //如果用户勾选了分享到微博，则此处将多张图片组合成一张
    if (nil == _conbineImage) {
        _conbineImage = [[UIImage alloc]init];
    }
    int index = 0;
    float height = 0;
    for (UIImageView *tempImageView in _imageViewList)
    {
        //定义好宽度后，高度是等比缩放的
        float originalWidth = [[[_imageProList safeObjectAtIndex:index] objectForKey:@"imageWidth"] doubleValue];
        float originalHeight = [[[_imageProList safeObjectAtIndex:index] objectForKey:@"imageHeight"] doubleValue];
        
        height = originalHeight*KConbineImageWidth/originalWidth;
        
        if (index == 0) {
            UIGraphicsBeginImageContext(CGSizeMake(KConbineImageWidth, height));
            [tempImageView.image drawInRect:CGRectMake(0, 0, KConbineImageWidth, height)];
            
        }else{
            UIGraphicsBeginImageContext(CGSizeMake(KConbineImageWidth, height+_conbineImage.size.height));
            [_conbineImage drawInRect:CGRectMake(0, 0, KConbineImageWidth, _conbineImage.size.height)];
            [tempImageView.image drawInRect:CGRectMake(0, _conbineImage.size.height, KConbineImageWidth, height)];
        }
        _conbineImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self.imageConbineView setFrame:CGRectMake(30, 0, KConbineImageWidth,_conbineImage.size.height)];
        self.imageConbineView.image = _conbineImage;
        index++;
        
    }
    
    return _conbineImage;//该返回值为组合后的照片
    
}

////刷新页面视图中的数据
//-(void)refreshList{
//    
//    int i = 0;
//    if (_imageViewList != nil && [_imageViewList count]>0)
//    {
//        
//        for (_imageView in _imageViewList)
//        {
//            UIButton *tempBtn = [_closeBtnList safeObjectAtIndex:i];
//            _imageAndButtonView =  [_imageAndBtnList safeObjectAtIndex:i];
//            [self.imageAndButtonView setFrame:CGRectMake(10+i*(KLittlePhotoSize+5),33, KLittlePhotoSize, KLittlePhotoSize)];
//            
//            [self.imageAndButtonView addSubview:self.imageView];
//            [self.imageAndButtonView addSubview:tempBtn];
//            
////            [_showImageListView addSubview:self.separatorLine];
//            [_showImageListView addSubview:self.imageAndButtonView];
//            
//            i++;
//            
//        }
//    }
//    
//}


//更新table
- (void) updateTable{
    
//    [self refreshList];
    
//    if(self.tpTableView.superview == nil){
//        
//        [self.view addSubview:self.tpTableView];
//        
//    }
//    
//    [self.tpTableView reloadData];
    if(self.tpTableView.superview == nil){
        
        [self.view addSubview:self.tpTableView];
        
    }
    
    [self.tpTableView reloadData];
}

//提示框
- (void)displayAlertMessage:(NSString *)message
{
    [self presentSheet:message posY:100];
}


//根据key和secret获取一个OAuthEngine的实例，若用户未授权，则弹出授权页面；若已经授权，则直接发送数据
- (void)openAuthenticateView {
    
    
}



#pragma mark - TextField And TextView  delegate method


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

- (void)BackToOrderDetail:(NSString *)message{
    
    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-error") message:L(message) delegate:self cancelButtonTitle:nil otherButtonTitles:L(@"Ok")];
    alert.tag = 226;
    [alert show];
    
    
}
#pragma mark - AlertMessageViewDelegate
-(void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 226) {
        if (buttonIndex == 0) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
    }
    
}

#pragma mark -
#pragma mark Http Requests

-(void)ProductDisOrderSubmitHttpRequestCompleteWithService:(ProductDetailSubmitService *)service
                                                 isSuccess:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    
    if(isSuccess==YES)
    {
        isSendSubmitOrderRequest = YES;
        _isSucessSubmit = YES;
        isCouldSubmit=NO;
        NSString *message=L(@"Display Order Sucess");
        [self BackToOrderDetail:message];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shaidanSuccess" object:nil];
        
    }
    else{
        isSendSubmitOrderRequest = YES;
        isCouldSubmit = YES;
        _isSucessSubmit = NO;
        NSString *message=service.errorMsg?service.errorMsg:L(@"Display Order fail");
        [self BackToOrderDetail:message];
    }
}
@end

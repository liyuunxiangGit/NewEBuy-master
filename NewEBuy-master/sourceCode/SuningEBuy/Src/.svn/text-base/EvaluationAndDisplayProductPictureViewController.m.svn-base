//
//  EvaluationAndDisplayProductPictureViewController.m
//  SuningEBuy
//
//  Created by Yang on 14-7-16.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "EvaluationAndDisplayProductPictureViewController.h"
#import "ProductDetailSubmitService.h"
#import "ProductUtil.h"
#import <AVFoundation/AVFoundation.h>

#define kLeftMargin                 98.0
#define kTopMargin                  8.0
#define kTextFieldWidth             188.0
#define kTextFieldHeight            44.0
#define kTextFieldFontSize          15.0
#define KConbineCellImageHeight     80.0
#define KConbineImageWidth          280.0
#define KLittlePhotoSize            46.0

@interface EvaluationAndDisplayProductPictureViewController ()
{
    BOOL    _isAnonFlag;
    
}

@property (nonatomic, assign) BOOL successOrFailures;

-(void)updateTable;                     //更新table中的数据
-(void)addToArray:(UIImage *)image;     //讲用户添加的照片添加到数组中
-(void)refreshList;                     //更新数据
-(void)validataData;                    //前台数据验证
- (void)openAuthenticateView;           //用户授权

@end

@implementation EvaluationAndDisplayProductPictureViewController

-(id)initWithDTO:(MemberOrderDetailsDTO *)dto isMember:(BOOL)aIsMember
{
    if ((self = [super init])){
        self.title = L(@"MyEBuy_EvaluateDisplayOrder");
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
        
        //        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:@"发布"];
        
        self.imageArray=[[NSMutableArray alloc]init];
        _closeBtnList=[[NSMutableArray alloc]init];
        _imageAndBtnList=[[NSMutableArray alloc]init];
        _imageViewList=[[NSMutableArray alloc]init];
        _imageProList=[[NSMutableArray alloc]init];
        _service=[[ProductDetailSubmitService alloc]init];
        _service.delegate=self;
        isSendSubmitOrderRequest = YES;
        isCouldSubmit = YES;
        _isAnonFlag = NO;
        
        if (!_evalutionDto) {
            _evalutionDto = [[EvalutionDetailDTO alloc] init];
        }
        
        if (!_evalDto) {
            _evalDto = [[EvalutionDTO alloc] init];
        }
        _successOrFailures = NO;

        
    }
    return self;
}
-(id)init
{
    
    self = [super init];
    if(self)
    {
        self.title = L(@"MyEBuy_DisplayOrder");//L(@"Show My Order Now");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"show_productDetail"),self.title];
        _isSelected = NO;
        self.imageArray=[[NSMutableArray alloc]init];
        _closeBtnList=[[NSMutableArray alloc]init];
        _imageAndBtnList=[[NSMutableArray alloc]init];
        _imageViewList=[[NSMutableArray alloc]init];
        _imageProList=[[NSMutableArray alloc]init];
        isCouldSubmit = YES;
    }
    return self;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _isAnonFlag = NO;
        
        if (!_evalutionDto) {
            _evalutionDto = [[EvalutionDetailDTO alloc] init];
        }
        
        if (!_evalDto) {
            _evalDto = [[EvalutionDTO alloc] init];
        }

    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    CGRect frame = [self setViewFrame:self.hasNav];
    frame.size.height = 400.0f;
    frame.origin.y = 56.0f;
    self.tpTableView.frame = frame;
    self.tpTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tpTableView];
    
    [self useBottomNavBar];
    [self.bottomNavBar addSubview:self.bottomCell];
    self.bottomCell.yiGouBtn.hidden = YES;
    self.bottomCell.backBtn.hidden = YES;
    self.bottomCell.payBtn.hidden = NO;
    self.bottomCell.payBtn.frame = CGRectMake(32.5, 6.5, 255, 35);
    [self.bottomCell.payBtn setTitle:L(@"BTPublish") forState:UIControlStateNormal];
    [self.bottomCell.payBtn addTarget:self action:@selector(raleaseInfo) forControlEvents:UIControlEventTouchUpInside];
    self.topView.frame = CGRectMake(0, 0, 320, 56);
    self.evaluationBtn.frame = CGRectMake(0, 0, 159.5, 56);
    self.showPhotoBtn.frame = CGRectMake(160.5, 0, 159.5, 56);
    self.bottomLine.frame = CGRectMake(0,55 , 320, 1);
    self.leftLine.frame = CGRectMake(0, 54, 160, 2);
    self.rightLine.frame = CGRectMake(160,54, 160, 2);
    self.middleLine.frame = CGRectMake(159.5, 10, 1, 34);
    self.remindView.frame = CGRectMake(0, 56, 320, 448);
    self.smileImageView.frame = CGRectMake(130, 80, 60, 60);
    self.remindInfo.frame = CGRectMake(0, self.smileImageView.bottom + 10, 320, 40);
    
}

#pragma mark -
#pragma mark tableview delegate/datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.showPJOrSD eq:@"0"])
    {
        return 1;
    }
    else if ( [self.showPJOrSD eq:@"1"])
    {
        if(section == 0)
        {
            return 1;
        }
        return 2;
    }
    else
    {
        return 0;
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.showPJOrSD eq:@"0"])
    {
        return 3;
    }
    else if ([self.showPJOrSD eq:@"1"])
    {
        return 2;
    }
    else
    {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.showPJOrSD eq:@"0"])
    {
        if(indexPath.section == 0)
        {
            return 115;
        }
        else if(indexPath.section == 1)// && self.isBook)
        {
            return 152;
        }
        else if(indexPath.section == 2)
        {
            
            if (self.showReviewStatus == NO)
            {
                return 160;
            }
            else
            {
                return 50;
            }
            
            return 160;//138;
        }
        return 44;
    }
    else if ([self.showPJOrSD eq:@"1"])
    {
        if(indexPath.section == 0)
        {
            return 115;
        }
        else if(indexPath.section == 1)
        {
            if (indexPath.row == 0)
            {
                return 60;
            }
        }
        return 113+5;
    }
    else
    {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([self.showPJOrSD eq:@"0"])
    {
        return 0;
    }
    else if ([self.showPJOrSD eq:@"1"])
    {
        if(section == 0)
        {
            return 0;
        }
        return 85;//80;
    }
    else
    {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if ([self.showPJOrSD eq:@"0"])
    {
        return nil;
    }
    else if ([self.showPJOrSD eq:@"1"])
    {
        self.showImageListView.backgroundColor = [UIColor whiteColor];
        return self.showImageListView;
    }
    else
    {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.showPJOrSD eq:@"0"])
    {
        static NSString *evalutionContontIdentifier = @"evalutionContontIdentifier";
        SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:evalutionContontIdentifier];
        if(cell == nil)
        {
            cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:evalutionContontIdentifier];
            cell.textLabel.textColor = [UIColor dark_Gray_Color];//[UIColor darkTextColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.backgroundView.size = CGSizeMake(290, 80);
        if(indexPath.section == 0)
        {
            [cell.contentView addSubview:self.headView];
        }
        else if(indexPath.section == 1)
        {
            [cell.contentView addSubview:self.evalutionView];
        }
        else if (indexPath.section == 2)
        {
            [cell.contentView addSubview:self.evaluServiceView];
        }
        cell.clipsToBounds = YES;
        return cell;
    }
    else if ([self.showPJOrSD eq:@"1"])
    {
        if(indexPath.section == 0)
        {
            static NSString *evalutionContontIdentifier = @"evalutionContontIdentifier_productDisOrder";
            SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:evalutionContontIdentifier];
            if(cell == nil)
            {
                cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:evalutionContontIdentifier];
                cell.textLabel.textColor = [UIColor dark_Gray_Color];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell.contentView addSubview:self.headView];
            return cell;
        }
        else
        {
            switch (indexPath.row)
            {
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
                    [disOrderDetailCell.contentView addSubview:self.submitContentTextView];
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
    else
    {
        return [[UITableViewCell alloc] init];
    }
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
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    else
    {
        return YES;
    }
    
}

#pragma mark -
#pragma mark  DlStarRatingDelegate Method
- (void)newRating:(DLStarRatingControl *)control :(NSUInteger)rating
{
    if (control.tag == 100)
    {
        DLog(@"100");
        self.evaluationBasicDto.qualityStar = STR_FROM_INT(rating);
    }
    else if(control.tag == 101)
    {
        DLog(@"101");
        self.evaluationBasicDto.attitudeStar = STR_FROM_INT(rating);
    }
    else if(control.tag == 102)
    {
        DLog(@"102");
        self.evaluationBasicDto.dlvrSpeedStar = STR_FROM_INT(rating);
    }
}

#pragma mark
#pragma mark setMethod
-(UILabel *)titleLabel
{
    if (nil == _titleLabel)
    {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, 80, 30)];
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    return _titleLabel;
}

-(UILabel *)contentLabel
{
    if (nil == _contentLabel)
    {
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
        _submitTitleTextField.placeholder = [NSString stringWithFormat:@" %@",L(@"MyEBuy_DisplayItem")];
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
        _submitContentTextView.placeholder = L(@"MyEBuy_DisplayTheseWords");
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

//存放照片的视图
-(UIImageView *)imageView
{
    if(nil == _imageView)
    {
        _imageView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KLittlePhotoSize, KLittlePhotoSize)];
    }
    return _imageView;
}

//关闭按钮
-(UIButton *)closeBtn
{
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
-(UIView *)imageAndButtonView
{
    if (nil == _imageAndButtonView)
    {
        _imageAndButtonView = [[UIView alloc]init];
    }
    return _imageAndButtonView;
}

//分割线
-(UIImageView *)separatorLine
{
    if (nil == _separatorLine)
    {
        _separatorLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 31, 320, 2)];
        _separatorLine.image = [UIImage imageNamed:@"cellSeparatorLine.png"];
    }
    return  _separatorLine;
}

//照相机按钮
-(UIButton *)cameraButton
{
    if (_cameraButton == nil)
    {
        _cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cameraButton.frame = CGRectMake(10, 5, 30, 25);
        [_cameraButton setBackgroundImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
        [_cameraButton addTarget:self action:@selector(presentActionSheet:) forControlEvents:UIControlEventTouchUpInside];
        [self.takePhotoAndShare addSubview:_cameraButton];
    }
    return  _cameraButton;
}

//照相机按钮 1
-(EGOImageButton *)cameraBtnImageOne
{
    if (_cameraBtnImageOne == nil)
    {
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
-(EGOImageButton *)cameraBtnImageTwo
{
    
    if (_cameraBtnImageTwo == nil)
    {
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
-(EGOImageButton *)cameraBtnImageThree
{
    if (_cameraBtnImageThree == nil)
    {
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
-(UIButton *)shareButton
{
    if (nil == _shareBtn)
    {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.frame = CGRectMake(200, 6, 20, 20);
        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"Remember_unselected.png"] forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(ShareToSNS) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _shareBtn;
}

//提示用户“传多张照片可以获取云钻”
-(UILabel *)tipLbl
{
    if (_tipLbl == nil)
    {
        _tipLbl = [[UILabel alloc]initWithFrame:CGRectMake(15,25,105,30)];
        _tipLbl.text = L(@"MyEBuy_DisplayOrderToGetIntegral");//L(@"Three will get achievements");
        _tipLbl.backgroundColor = [UIColor clearColor];
        _tipLbl.textColor = [UIColor colorWithRGBHex:0x313131];
        _tipLbl.font = [UIFont systemFontOfSize:13.0];
    }
    return _tipLbl;
}

//提示用户是否分享到新浪微博
-(UILabel *)shareLbl
{
    if (nil == _shareLbl)
    {
        _shareLbl = [[UILabel alloc]initWithFrame:CGRectMake(225,0,130,30)];
        _shareLbl.text = L(@"Share to sina");
        _shareLbl.backgroundColor = [UIColor clearColor];
        _shareLbl.textColor = [UIColor blackColor];
        _shareLbl.font = [UIFont systemFontOfSize:12.0];
    }
    return _shareLbl;
}


//存放照相机按钮、分享按钮和两个提示的文本标签
-(UIView *)takePhotoAndShare
{
    if (nil == _takePhotoAndShare)
    {
        _takePhotoAndShare = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 85)];
        _takePhotoAndShare.backgroundColor = [UIColor clearColor];
        _takePhotoAndShare.userInteractionEnabled = YES;
        [_takePhotoAndShare addSubview:self.tipLbl];
        [_takePhotoAndShare addSubview:self.cameraBtnImageOne];
        [_takePhotoAndShare addSubview:self.cameraBtnImageTwo];
        [_takePhotoAndShare addSubview:self.cameraBtnImageThree];
    }
    return _takePhotoAndShare;
}


//区块底部的所有内容都是由此视图展示的，具体操作过程中，会添加图片
-(UIView *)showImageListView
{
    if (nil == _showImageListView)
    {
        _showImageListView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, KLittlePhotoSize)];
        _showImageListView.backgroundColor = [UIColor clearColor];
        _showImageListView.userInteractionEnabled = YES;
        [_showImageListView addSubview:self.takePhotoAndShare];
    }
    return _showImageListView;
}

-(UIImageView *)imageConbineView
{
    if (nil == _imageConbineView)
    {
        _imageConbineView = [[UIImageView alloc]init];
    }
    return _imageConbineView;
}

- (UIButton *)evaluationBtn
{
    if (!_evaluationBtn)
    {
        _evaluationBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 159.5, 54)];
        _evaluationBtn.backgroundColor = [UIColor clearColor];
        [_evaluationBtn setTitle:L(@"MyEBuy_Evaluate") forState:UIControlStateNormal];
        [_evaluationBtn setTitleColor:KBtnTitleColor forState:UIControlStateNormal];
        _evaluationBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        [_evaluationBtn addTarget:self action:@selector(evaluationAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:_evaluationBtn];
    }
    return _evaluationBtn;
}

- (UIButton *)showPhotoBtn
{
    if (!_showPhotoBtn)
    {
        _showPhotoBtn = [[UIButton alloc] initWithFrame:CGRectMake(160.5, 0, 159.5, 54)];
        _showPhotoBtn.backgroundColor = [UIColor clearColor];
        [_showPhotoBtn setTitle:L(@"MyEBuy_DisplayOrder") forState:UIControlStateNormal];
        [_showPhotoBtn setTitleColor:[UIColor colorWithHexString:@"#949494"] forState:UIControlStateNormal];
        _showPhotoBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        [_showPhotoBtn addTarget:self action:@selector(showPhotoAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:_showPhotoBtn];
    }
    return _showPhotoBtn;
}

- (UIView *)topView
{
    if (!_topView)
    {
        _topView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
        _topView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_topView];
    }
    return _topView;
}

- (UIImageView *)leftLine
{
    if (!_leftLine)
    {
        _leftLine = [[UIImageView alloc] init];
        _leftLine.backgroundColor = KBtnTitleColor;
        [self.topView addSubview:_leftLine];
    }
    return _leftLine;
}

- (UIImageView *)rightLine
{
    if (!_rightLine)
    {
        _rightLine = [[UIImageView alloc] init];
        _rightLine.backgroundColor = [UIColor clearColor];
        [self.topView addSubview:_rightLine];
    }
    return _rightLine;
}

- (UIImageView *)bottomLine
{
    if (!_bottomLine)
    {
        _bottomLine = [[UIImageView alloc] init];
        _bottomLine.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
        [self.topView addSubview:_bottomLine];
    }
    return _bottomLine;
}

- (UIImageView *)middleLine
{
    if (!_middleLine)
    {
        _middleLine = [[UIImageView alloc] init];
        _middleLine.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
        [self.topView addSubview:_middleLine];
    }
    return _middleLine;
}

- (UIView *)remindView
{
    if (!_remindView)
    {
        _remindView = [[UIView alloc] init];
        _remindView.backgroundColor = [UIColor whiteColor];
        _remindView.hidden = YES;
        [self.view addSubview:_remindView];
    }
    return _remindView;
}

- (UIImageView *)smileImageView
{
    if (!_smileImageView)
    {
        _smileImageView = [[UIImageView alloc] init];
        _smileImageView.image = [UIImage imageNamed:@"Smile_Image_View.png"];
        _smileImageView.backgroundColor = [UIColor clearColor];
        [self.remindView addSubview:_smileImageView];
    }
    return _smileImageView;
}

- (UILabel *)remindInfo
{
    if (!_remindInfo)
    {
        _remindInfo = [[UILabel alloc] init];
        _remindInfo.backgroundColor = [UIColor clearColor];
        _remindInfo.textColor = [UIColor colorWithRGBHex:0x313131];
        _remindInfo.textAlignment = UITextAlignmentCenter;
        _remindInfo.font = [UIFont systemFontOfSize:13.0];
        [self.remindView addSubview:self.remindInfo];
    }
    return _remindInfo;
}



#pragma mark -
#pragma mark views

- (UIImageView *)headView
{
    if (!_headView)
    {
        _headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 115)];
        _headView.backgroundColor = [UIColor clearColor];
        _headView.userInteractionEnabled = YES;
        
        EGOImageView *productimg = [[EGOImageView alloc] initWithFrame:CGRectMake(15, 15, 85, 85)];
        productimg.backgroundColor = [UIColor clearColor];
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
        productName.font = cellFont;
        productName.textColor = [UIColor blackColor];
        productName.text = self.evalutionDto.catentryName;
        productName.frame = CGRectMake(110, 16, 193, 38);
        [_headView addSubview:productName];
        
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
    }
    return _headView;
}

- (UIView *)evalutionView
{
    if (!_evalutionView)
    {
        _evalutionView = [[UIView alloc] init];
        _evalutionView.backgroundColor = [UIColor clearColor];
        _evalutionView.frame = CGRectMake(0, 0, 320, 152);
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = CGRectMake(15, 18, 60, 15);
        lable.textColor = [UIColor dark_Gray_Color];//RGBCOLOR(97, 97, 97);
        lable.text = L(@"MyEBuy_Grade");
        lable.font = [UIFont systemFontOfSize:14];
        lable.backgroundColor = [UIColor clearColor];
        lable.textAlignment = UITextAlignmentLeft;
        [_evalutionView addSubview:lable];
        [_evalutionView addSubview:self.StarRatingControl];
        [_evalutionView addSubview:self.contentTextView];
    }
    return _evalutionView;
}

- (UIView *)evaluServiceView
{
    if (!_evaluServiceView)
    {
        _evaluServiceView = [[UIView alloc] init];
        _evaluServiceView.frame = CGRectMake(0, 0, 310, 160);
        _evaluServiceView.backgroundColor = [UIColor clearColor];
        
        UIImageView *seperateLineImg = [[UIImageView alloc] init];
        seperateLineImg.frame = CGRectMake(15, 0, 320, 0.5);
        seperateLineImg.image = [UIImage imageNamed:@"line.png"];
        seperateLineImg.backgroundColor = [UIColor clearColor];
        [_evaluServiceView addSubview:seperateLineImg];
        
        UILabel *label1 = [[UILabel alloc] init];
        label1.frame = CGRectMake(15, 12, 170, 20);
        label1.textColor = [UIColor colorWithRGBHex:0x313131];
        label1.font = [UIFont systemFontOfSize:15.0];
        label1.backgroundColor = [UIColor clearColor];
        label1.text = L(@"MyEBuy_IsSatisfied");
        [_evaluServiceView addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc] init];
        label2.frame = CGRectMake(15, 44, 90, 20);
        label2.textColor = [UIColor dark_Gray_Color];
        label2.font = [UIFont systemFontOfSize:14.0];
        label2.text = L(@"MyEBuy_ServiceSatisfaction");
        label2.backgroundColor = [UIColor clearColor];
        [_evaluServiceView addSubview:label2];
        
        UILabel *label3 = [[UILabel alloc] init];
        label3.frame = CGRectMake(15, 80, 90, 20);
        label3.backgroundColor = [UIColor clearColor];
        label3.font = [UIFont systemFontOfSize:14.0];
        label3.text = L(@"MyEBuy_ExpressSatisfaction");
        label3.textColor = [UIColor dark_Gray_Color];
        [_evaluServiceView addSubview:label3];
        
        DLStarRatingControl *starRating1 = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(90, 38, 190, 35)];
        starRating1.delegate = self;
        starRating1.tag = 101;
        [_evaluServiceView addSubview:starRating1];
        
        DLStarRatingControl *starRating2 = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(90, 75, 190, 35)];
        starRating2.delegate = self;
        starRating2.tag = 102;
        [_evaluServiceView addSubview:starRating2];

        UIView *footView = [[UIView alloc] init];
        footView.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] init];
        if (self.showReviewStatus == NO)
        {
            footView.frame = CGRectMake(0, 105, 320, 50);
            label.frame = CGRectMake(45, 0, 100, 40);
        }
        else
        {
            footView.frame = CGRectMake(0, 0, 320, 50);
            label.frame = CGRectMake(45, 5, 100, 40);
        }
        label.backgroundColor = [UIColor clearColor];
        label.text = L(@"MyEBuy_AnonymousEvaluate");
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = [UIColor blackColor];
        [footView addSubview:label];
        [footView addSubview:self.anonBtn];
        [_evaluServiceView addSubview:footView];
        
        if (self.showReviewStatus == NO)
        {
            seperateLineImg.hidden = NO;
            label1.hidden = NO;
            label2.hidden = NO;
            label3.hidden = NO;
            starRating1.hidden = NO;
            starRating2.hidden = NO;
            self.anonBtn.hidden = NO;
            label.hidden = NO;
        }
        else
        {
            seperateLineImg.hidden = YES;
            label1.hidden = YES;
            label2.hidden = YES;
            label3.hidden = YES;
            starRating1.hidden = YES;
            starRating2.hidden = YES;
            self.anonBtn.hidden = NO;
            label.hidden = NO;
        }
    }
    return _evaluServiceView;
}

- (UIButton *)anonBtn
{
    if (!_anonBtn)
    {
        _anonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (self.showReviewStatus == NO)
        {
            _anonBtn.frame = CGRectMake(5, 5, 45, 30);
        }
        else
        {
            _anonBtn.frame = CGRectMake(5, 10, 45, 30);
        }
        [_anonBtn setImage:[UIImage imageNamed:@"singleCheck_unselect.png"] forState:UIControlStateNormal];
        [_anonBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _anonBtn;
}

- (DLStarRatingControl *)StarRatingControl
{
    if (!_StarRatingControl)
    {
        _StarRatingControl = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(75, 0, 180, 49)];
        _StarRatingControl.delegate = self;
        _StarRatingControl.tag = 100;
    }
    return _StarRatingControl;
}

- (PlaceholderTextView *)contentTextView
{
    if (!_contentTextView)
    {
        _contentTextView = [[PlaceholderTextView alloc] init];
        _contentTextView.frame = CGRectMake(15, 50, 290, 87);
        _contentTextView.placeholder = L(@"MyEBuy_TellTheseWordsToFriends");//@"请输入使用心得(5-500个字以内)";
        _contentTextView.layer.borderWidth = 0.4;
        _contentTextView.layer.borderColor = RGBCOLOR(232, 232, 232).CGColor;
        _contentTextView.layer.masksToBounds = YES;
        _contentTextView.textColor = [UIColor blackColor];
        _contentTextView.font = [UIFont systemFontOfSize:15.0];
        _contentTextView.backgroundColor = [UIColor clearColor];
        _contentTextView.autocorrectionType = UITextAutocorrectionTypeNo;
        _contentTextView.keyboardType = UIKeyboardTypeDefault;
        _contentTextView.returnKeyType = UIReturnKeyDone;
        _contentTextView.delegate = self;
    }
    return _contentTextView;
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

- (NewEvalutionService *)evalutionService
{
    if (!_evalutionService)
    {
        _evalutionService = [[NewEvalutionService alloc] init];
        _evalutionService.delegate = self;
    }
    return _evalutionService;
}

- (EvaluationBsicDTO *)evaluationBasicDto
{
    if (!_evaluationBasicDto)
    {
        _evaluationBasicDto = [[EvaluationBsicDTO alloc] init];
        _evaluationBasicDto.orderItemId = _evalutionDto.orderItemId;
        _evaluationBasicDto.orderId = _evalDto.orderId;
        _evaluationBasicDto.partNumber = _evalutionDto.partNumber;
        _evaluationBasicDto.anonFlag = @"0";
    }
    return _evaluationBasicDto;
}

#pragma mark - action

- (void)raleaseInfo
{
    if ([self.showPJOrSD eq:@"0"])
    {
        [self commitEvaluate];
    }
    else if([self.showPJOrSD eq:@"1"])
    {
        [self validataData];
    }
    else
    {
        return;
    }
    
}

- (void)commitEvaluate
{
    
    NSString *contentString = [self.contentTextView.text trim];
    if(IsStrEmpty(self.evaluationBasicDto.qualityStar) || [self.evaluationBasicDto.qualityStar intValue] == 0)
    {
        [self presentSheet:L(@"PVGrade") posY:100];
        return;
    }
    if (IsStrEmpty(contentString))
    {
        [self presentSheet:L(@"PVPleaseEnterUseExperience") posY:100];
        [self.contentTextView becomeFirstResponder];
        return;
    }
    if (contentString.length < 5 || contentString.length > 500)
    {
        [self presentSheet:L(@"PVUseExperienceShouldBeFiveToFivehundredWords") posY:100];
        [self.contentTextView becomeFirstResponder];
        return;
    }
    [self.contentTextView resignFirstResponder];
    self.evaluationBasicDto.content = contentString;
    if (!self.showReviewStatus)
    {
        if (IsStrEmpty(self.evaluationBasicDto.attitudeStar) || [self.evaluationBasicDto.attitudeStar intValue] == 0) {
            [self presentSheet:L(@"PVPleaseEvaluateServiceSatisfaction") posY:100];
            return;
        }
        if (IsStrEmpty(self.evaluationBasicDto.dlvrSpeedStar) || [self.evaluationBasicDto.dlvrSpeedStar intValue] == 0) {
            [self presentSheet:L(@"PVPleaseEvaluateExpressSatisfaction") posY:100];
            return;
        }
    }
    [self displayOverFlowActivityView];
    [self.evalutionService beginEvalutionPublish:self.evaluationBasicDto];
}

- (void)click
{
    if (_isAnonFlag == NO)
    {
        self.evaluationBasicDto.anonFlag = @"1";
        [self.anonBtn setImage:[UIImage imageNamed:@"singleCheck_selected.png"] forState:UIControlStateNormal];
        _isAnonFlag = YES;
    }
    else
    {
        self.evaluationBasicDto.anonFlag = @"0";
        [self.anonBtn setImage:[UIImage imageNamed:@"singleCheck_unselect.png"] forState:UIControlStateNormal];
        _isAnonFlag = NO;
    }
}

- (void)evaluationAction:(id)sender
{
    [self.evaluationBtn setTitleColor:KBtnTitleColor forState:UIControlStateNormal];
    self.leftLine.backgroundColor = KBtnTitleColor;
    [self.showPhotoBtn setTitleColor:[UIColor colorWithHexString:@"#949494"] forState:UIControlStateNormal];
    self.rightLine.backgroundColor = [UIColor clearColor];
    if (isEvaluation == YES)
    {
        self.remindView.hidden = NO;
        self.bottomCell.hidden = YES;
        self.bottomNavBar.hidden = YES;
        return;
    }
    else
    {
        self.remindView.hidden = YES;
        self.bottomCell.hidden = NO;
        self.bottomNavBar.hidden = NO;
    }
    self.showPJOrSD = @"0";
    [self.tpTableView reloadData];
}

- (void)showPhotoAction:(id)sender
{
    [self.evaluationBtn setTitleColor:[UIColor colorWithHexString:@"#949494"] forState:UIControlStateNormal];
    self.leftLine.backgroundColor = [UIColor clearColor];
    [self.showPhotoBtn setTitleColor:KBtnTitleColor forState:UIControlStateNormal];
    self.rightLine.backgroundColor = KBtnTitleColor;

    if (isShowPhoto == YES)
    {
        self.remindView.hidden = NO;
        self.bottomCell.hidden = YES;
        self.bottomNavBar.hidden = YES;
        return;
    }
    else
    {
        self.remindView.hidden = YES;
        self.bottomCell.hidden = NO;
        self.bottomNavBar.hidden = NO;;
    }
    self.showPJOrSD = @"1";
    [self.tpTableView reloadData];
}


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

//获取用户选择的按钮值，根据该值判断是进入照相机还是相册
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex)
    {
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
    }
    else if(tag == 12)
    {
        self.cameraBtnImageTwo.tag = 2;
        [self.cameraBtnImageTwo setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
        [self.BtnImageDic removeObjectForKey:@"12"];
    }
    else if(tag == 13)
    {
        self.cameraBtnImageThree.tag = 3;
        [self.cameraBtnImageThree setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
        [self.BtnImageDic removeObjectForKey:@"13"];
    }
    [self backForePage];
    [self updateTable];
}


//分享到新浪微博的按钮点击后，会改变按钮的背景图片，同时改变_isSelected标识位
- (void)ShareToSNS
{
    if (_isSelected)
    {
        _isSelected = NO;
        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"Remember_unselected.png"] forState:UIControlStateNormal];
    }
    else
    {
        _isSelected = YES;
        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"Remember_selected.png"] forState:UIControlStateNormal];
    }
    [self updateTable];
}

//一旦选择了照片， ImagePicker 将回调 didFinishPickingMediaWithInfo。在PhotoAppViewController.m 文件中进入下列代码：
//
//第一行代码隐藏拾取器。随后将图像视图的image 属性设置为返回的图像。拾取器返回一个NSDictionary对象。这是由于 UIImagePickerControllerMediaType 将指示返回的是视频还是图像。
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    [picker dismissModalViewControllerAnimated:YES];
    if (![[info objectForKey:@"UIImagePickerControllerMediaType"] isEqualToString: @"public.image"])
    {
        [self displayAlertMessage:L(@"Please choose photo")];
        return;
    }
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //如果图片的大小超过（300*300），则等比压缩，否则，后台会提示http请求过长.
    double size = image.size.height*image.size.width;
    double height = image.size.height;
    double width = image.size.width;
    float tempPercentage = 1.0;
    if ( size > 1000000)
    {
        tempPercentage = 1000000.0/size;
    }
    DLog(@"tempPercentage =%f", tempPercentage);
    UIImageTransformation *reduceImage = [[UIImageTransformation alloc]init];
    image = [reduceImage imageByScalingAndCroppingForSize:CGSizeMake(width*tempPercentage,height*tempPercentage) image:image];
    TT_RELEASE_SAFELY(reduceImage);
    [self showImageView:image];
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
-(void)addToArray:(UIImage *)image
{
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
-(void)validataData
{
    if (isSendSubmitOrderRequest == NO)
    {
        return;
    }
    if (isCouldSubmit==NO)
    {
        return;
    }
    //判断晒单主题是否合法
    NSString *string1 = [self.submitTitleTextField.text trim];
    if (IsStrEmpty(string1) || [string1 length] == 0)
    {
        [self displayAlertMessage:L(@"Please input display order title")];
        [self.submitTitleTextField becomeFirstResponder];
        return;
    }
    if ([string1 length]<5 || [string1 length] > 10)
    {
        [self displayAlertMessage:L(@"Input 5-10 characters")];
        [self.submitTitleTextField becomeFirstResponder];
        return;
    }
    //判断晒单内容是否合法
    NSString *string2 = [self.submitContentTextView.text trim];
    if ([string2 length] == 0)
    {
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
    if ([self.imageArray count] < 3)
    {
        [self displayAlertMessage:L(@"MyEBuy_UploadThreePhotosAndObtainIntegral")];
        return;
    }
    if (hasImage == NO)
    {
        [self displayAlertMessage:L(@"Please upload 1-3 photoes")];
        return;
    }
    if ([self.imageArray count]<1 || [self.imageArray count]>3)
    {
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
    [self displayOverFlowActivityView:L(@"PVPublishing")];
    //如果用户选择里分享微博，则调用组合图片的方法
    if (_isSelected)
    {
        [self conbineImage];
        [self openAuthenticateView];
    }
}


//将多张图片组合成一张图片
-(UIImage *)conbineImage
{
    //如果用户勾选了分享到微博，则此处将多张图片组合成一张
    if (nil == _conbineImage)
    {
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
        if (index == 0)
        {
            UIGraphicsBeginImageContext(CGSizeMake(KConbineImageWidth, height));
            [tempImageView.image drawInRect:CGRectMake(0, 0, KConbineImageWidth, height)];
        }
        else
        {
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

//刷新页面视图中的数据
-(void)refreshList
{
    int i = 0;
    if (_imageViewList != nil && [_imageViewList count]>0)
    {
        for (_imageView in _imageViewList)
        {
            UIButton *tempBtn = [_closeBtnList safeObjectAtIndex:i];
            _imageAndButtonView =  [_imageAndBtnList safeObjectAtIndex:i];
            [self.imageAndButtonView setFrame:CGRectMake(10+i*(KLittlePhotoSize+5),33, KLittlePhotoSize, KLittlePhotoSize)];
            [self.imageAndButtonView addSubview:self.imageView];
            [self.imageAndButtonView addSubview:tempBtn];
            [_showImageListView addSubview:self.imageAndButtonView];
            i++;
        }
    }
}

//更新table
- (void) updateTable
{
    if(self.tpTableView.superview == nil)
    {
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
- (void)openAuthenticateView
{

    
}

- (void)BackToOrderDetail:(NSString *)message isSuccess:(BOOL)successORfailures
{
    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-error") message:L(message) delegate:self cancelButtonTitle:nil otherButtonTitles:L(@"Ok")];
    self.successOrFailures = successORfailures;
    alert.tag = 226;
    [alert show];
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
        isShowPhoto = YES;
        NSString *message=L(@"Display Order Sucess");
        [self BackToOrderDetail:message isSuccess:isSuccess];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DisplayOrderOrEvaluationSucessRefresh" object:nil];
    }
    else
    {
        isSendSubmitOrderRequest = YES;
        isCouldSubmit = YES;
        _isSucessSubmit = NO;
        NSString *message=service.errorMsg?service.errorMsg:L(@"Display Order fail");
        [self BackToOrderDetail:message isSuccess:isSuccess];
    }
}

- (void)evalutionPublishCompletedWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    if (isSuccess)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DisplayOrderOrEvaluationSucessRefresh" object:nil];

        [self BackToOrderDetail:L(@"MyEBuy_EvaluateSuccess") isSuccess:isSuccess];
        isEvaluation = YES;
    }
    else
    {
        NSString *errorMsg1 = errorMsg ? errorMsg :L(@"Evaluate failed,please try again later");
        [self presentSheet:errorMsg1];
    }
}

- (void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (_successOrFailures != YES) {
        return;
    }
    if ([self.showPJOrSD eq:@"0"])
    {
        if (alertView.tag == 226)
        {
            if (buttonIndex == 0)
            {
                if (isEvaluation == YES && isShowPhoto == YES)
                {
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    self.showPJOrSD = @"1";
                    [self refreshView];
                }
            }
        }
    }
    else if ([self.showPJOrSD eq:@"1"])
    {
        if (alertView.tag == 226)
        {
            if (buttonIndex == 0)
            {
                if (isEvaluation == YES && isShowPhoto == YES)
                {
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    self.showPJOrSD = @"0";
                    [self refreshView];
                }
            }
        }
    }
}

- (void)refreshView
{
    [self.tpTableView reloadData];
    if (isEvaluation == YES)
    {
        self.remindInfo.text = L(@"MyEBuy_GoodsHasEvaluated");
        [self.evaluationBtn setTitleColor:[UIColor colorWithHexString:@"#949494"] forState:UIControlStateNormal];
        self.leftLine.backgroundColor = [UIColor clearColor];
        [self.showPhotoBtn setTitleColor:KBtnTitleColor forState:UIControlStateNormal];
        self.rightLine.backgroundColor = KBtnTitleColor;
    }
    else if (isShowPhoto == YES)
    {
        self.remindInfo.text = L(@"MyEBuy_GoodsHasDisplayed");
        [self.evaluationBtn setTitleColor:KBtnTitleColor forState:UIControlStateNormal];
        self.leftLine.backgroundColor = KBtnTitleColor;
        [self.showPhotoBtn setTitleColor:[UIColor colorWithHexString:@"#949494"] forState:UIControlStateNormal];
        self.rightLine.backgroundColor = [UIColor clearColor];
    }
    else
    {
        self.remindInfo.text = @"";
    }
}

@end

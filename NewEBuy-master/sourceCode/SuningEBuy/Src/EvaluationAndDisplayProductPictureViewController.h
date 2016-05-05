//
//  EvaluationAndDisplayProductPictureViewController.h
//  SuningEBuy
//
//  Created by Yang on 14-7-16.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "PlaceholderTextView.h"
#import "NewEvalutionService.h"
#import "EvalutionDTO.h"

#import "DLStarRatingControl.h"
#import "EvaluationBsicDTO.h"
#import "AllOrderDetailCommonViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "ToolBarTextField.h"
#import "ProductDisImgeCell.h"
#import "UIImageTransformation.h"
#import "GCPlaceholderTextView.h"
#import "NSData+Base64.h"
#import "GetAllSysInfo.h"
#import "MemberOrderDetailsDTO.h"
#import "ProductDetailSubmitService.h"
#import "FullScreenmagesViewController.h"

@interface EvaluationAndDisplayProductPictureViewController : AllOrderDetailCommonViewController
<UITextFieldDelegate,UITextViewDelegate,NewEvalutionServiceDelegate,EGOImageViewDelegate,DLStarRatingDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,ProductDetailSubmitServiceDelegate>
{
    UIButton                                *_button;
    UIButton                                *_shareBtn;    //分享到微博的按钮
    BOOL                                    _isSelected;   //判断分享微博的按钮是否被勾选
    UIImage                                 *_conbineImage;    //用于微博分享的组合图片
    NSDictionary                            *_imageProperties;    //用于存放图片从相册或者照相机中获取时的初始尺寸
    BOOL                                    _isSucessSubmit;//晒单是否成功标示
    CGFloat                                   percentage;//压缩比
    BOOL                                    isSendSubmitOrderRequest;
    BOOL                                    isCouldSubmit;//避免顾客快速点击发布按钮，出现2个重复的晒单
    BOOL                                    isEvaluation;//是否评价
    BOOL                                    isShowPhoto;//是否晒单
}
@property (nonatomic, strong) EvalutionDetailDTO      *evalutionDto;
@property (nonatomic, strong) EvalutionDTO            *evalDto;
@property (nonatomic, strong) NewEvalutionService *evalutionService;
@property (nonatomic, strong) DLStarRatingControl  *StarRatingControl;
@property (nonatomic, strong) PlaceholderTextView *contentTextView;
@property (nonatomic, strong) UIImageView         *headView;
@property (nonatomic, strong) UIView             *evalutionView;
@property (nonatomic, strong) UIView             *evaluServiceView;
@property (nonatomic, strong) EvaluationBsicDTO      *evaluationBasicDto;
@property (nonatomic, strong) UIButton     *anonBtn;
@property (nonatomic, assign) BOOL         showReviewStatus;
@property (nonatomic,strong) UITextField                    *submitTitleTextField;      //晒单标题
@property (nonatomic,strong) GCPlaceholderTextView          *submitContentTextView;     //晒单内容
@property (nonatomic,strong) UIImageView                    *imageView;                 //用于存放照片的视图
@property (nonatomic,strong) UIButton                       *closeBtn;                  //关闭按钮
@property (nonatomic,strong) UIView                         *imageAndButtonView;        //存放照片视图和关闭按钮的视图
@property (nonatomic,strong) UIImageView                    *separatorLine;             //分割线图片视图
@property (nonatomic,strong) UIButton                       *cameraButton;              //照相机按钮
@property (nonatomic,strong) UIButton                       *shareButton;               //分享微博的按钮
@property (nonatomic,strong) UILabel                        *tipLbl;                    //提示“上传三张照片可获得云钻”
@property (nonatomic,strong) UILabel                        *shareLbl;                  //提示“分享到新浪微博”
@property (nonatomic,strong) UIView                         *takePhotoAndShare;         //放置照相机、分享按钮和提示标签的容器视图
@property (nonatomic,strong) NSMutableArray                 *imageViewList;             //用于存放照片视图数组
@property (nonatomic,strong) NSMutableArray                 *imageAndBtnList;           //用于存放照片和关闭按钮组合视图的数组
@property (nonatomic,strong) NSMutableArray                 *closeBtnList;              //用于存放关闭按钮的数组
@property (nonatomic,strong) NSMutableArray                 *imageProList;              //用于存放照片初始尺寸的数组
@property (nonatomic,strong) UIView                         *showImageListView;         //显示照片数组中的照片
@property (nonatomic,strong) UIView                         *showImageListViewNew;         //显示照片数组中的照片
@property (nonatomic, strong) NSMutableArray                *imageArray;
@property (nonatomic,strong) UIImage                        *imageSelect;
@property (nonatomic,strong) UILabel                        *titleLabel;                // “晒单标题”
@property (nonatomic,strong) UILabel                        *contentLabel;              //“晒单内容”
@property (nonatomic,strong) UIImageView                     *imageConbineView;
@property (nonatomic,strong) NSString                        *totalImageString;
@property (nonatomic,strong) MemberOrderDetailsDTO           *MemberOrderDetailsDTO;
@property (nonatomic,strong) ProductDetailSubmitService      *service;
@property (nonatomic,strong)UIGestureRecognizer *tip;
@property (nonatomic, strong)EGOImageButton *cameraBtnImageOne;
@property (nonatomic, strong)EGOImageButton *cameraBtnImageTwo;
@property (nonatomic, strong)EGOImageButton *cameraBtnImageThree;
@property (nonatomic, strong)NSMutableDictionary *BtnImageDic;
@property (nonatomic)int selectbtnTag;
@property (nonatomic, strong)FullScreenmagesViewController *fullVC;
@property (nonatomic, strong) NSString                     *showPJOrSD;//0:评价  1:晒单 2:都不展示
@property (nonatomic, strong) UIButton                     *evaluationBtn;//评价TAB
@property (nonatomic, strong) UIButton                     *showPhotoBtn;//晒单TAB
@property (nonatomic, strong) UIView                       *topView;
@property (nonatomic, strong) UIImageView                  *leftLine;
@property (nonatomic, strong) UIImageView                  *rightLine;
@property (nonatomic, strong) UIImageView                  *bottomLine;
@property (nonatomic, strong) UIImageView                  *middleLine;
@property (nonatomic, strong) UIView                       *remindView;
@property (nonatomic, strong) UIImageView                  *smileImageView;
@property (nonatomic, strong) UILabel                      *remindInfo;

-(id)initWithDTO:(MemberOrderDetailsDTO *)dto isMember:(BOOL)aIsMember;
-(void)showAlbum;               //调用相册里的照片
-(UIImage *)conbineImage;       //组合多张照片成为一张，返回值为合成后的照片
-(void)displayAlertMessage:(NSString *)message;//提示框

@end

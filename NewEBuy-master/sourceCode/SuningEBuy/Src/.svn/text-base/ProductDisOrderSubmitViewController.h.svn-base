//
//  ProductDisOrderSubmitViewController.h
//  SuningEBuy
//
//  Created by xy ma on 12-3-14.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPKeyboardAvoidingTableView.h"
#import "ToolBarTextField.h"
#import "ProductDisImgeCell.h"
#import "UIImageTransformation.h"
#import "GCPlaceholderTextView.h"
#import "NSData+Base64.h"
#import "GetAllSysInfo.h"
#import "MemberOrderDetailsDTO.h"
#import "ProductDetailSubmitService.h"

#import "EvalutionDTO.h"

#import "FullScreenmagesViewController.h"
#import "AllOrderDetailCommonViewController.h"


@interface ProductDisOrderSubmitViewController : AllOrderDetailCommonViewController<UIImagePickerControllerDelegate,UITextFieldDelegate,UITextViewDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,ProductDetailSubmitServiceDelegate,EGOImageViewDelegate>{
    
    UITextField                             *_submitTitleTextField;//晒单标题输入框
    
    GCPlaceholderTextView					*_submitContentTextView;//晒单内容输入框
        
    NSMutableArray                          *imageArray_; //用于存放照片的数组
    
    UIButton                                *_button;
    
    UIImage                                 *imageSelect_;
    
    UIButton                                *_shareBtn;    //分享到微博的按钮
    
    NSMutableArray                          *_imageViewList;    //用于存放照片视图数组
    
    NSMutableArray                          *_imageAndBtnList;    //用于存放照片和关闭按钮组合视图的数组
    
    NSMutableArray                          *_closeBtnList;    //用于存放关闭按钮的数组
    
    BOOL                                    _isSelected;   //判断分享微博的按钮是否被勾选
    
    UIImage                                 *_conbineImage;    //用于微博分享的组合图片
    
    NSDictionary                            *_imageProperties;    //用于存放图片从相册或者照相机中获取时的初始尺寸
    
    NSMutableArray                          *_imageProList;    //用于存放照片初始尺寸的数组
    
    NSString                                *_totalImageString;//存储需上传的几个图片的字符串集合，各个图片以10个逗号拆分
    
    MemberOrderDetailsDTO                   *_MemberOrderDetailsDTO;//存储订单行项目id，商品id的dto
    
    BOOL                                    _isSucessSubmit;//晒单是否成功标示
    
    CGFloat                                   percentage;//压缩比
        
    BOOL                                    isSendSubmitOrderRequest;
     BOOL                                    isCouldSubmit;//避免顾客快速点击发布按钮，出现2个重复的晒单
    
}
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

@property (nonatomic,strong) UIImageView                         *headView;    //存放商品信息
@property (nonatomic, strong) EvalutionDetailDTO            *evalutionDto;

@property (nonatomic,strong)UIGestureRecognizer *tip;

//xmy
@property (nonatomic, strong)EGOImageButton *cameraBtnImageOne;
@property (nonatomic, strong)EGOImageButton *cameraBtnImageTwo;
@property (nonatomic, strong)EGOImageButton *cameraBtnImageThree;
@property (nonatomic, strong)NSMutableDictionary *BtnImageDic;

@property (nonatomic)int selectbtnTag;

@property (nonatomic, strong)FullScreenmagesViewController *fullVC;

-(id)initWithDTO:(MemberOrderDetailsDTO *)dto isMember:(BOOL)aIsMember;


-(void)showAlbum;               //调用相册里的照片
//-(void)showCamera;              //调用照相机进行拍照
-(UIImage *)conbineImage;       //组合多张照片成为一张，返回值为合成后的照片
-(void)displayAlertMessage:(NSString *)message;//提示框
//-(void)sendSubmitOrderRequest;


@end

//
//  ProductDisOrderDetailsViewController.h
//  SuningEBuy
//
//  Created by xy ma on 12-2-17.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ProductTitleCell.h"
#import "zhishiDetailsHttpDataSource.h"
#import "DisProductDetailsDTO.h"
#import "ProductDisOrderReplyCell.h"
#import "ProductDisImgeDTO.h"
#import "ProductDisOrderCell.h"
#import "ProductDIsProductCell.h"
#import "ProductDetailViewController.h"
#import "DataProductBasic.h"
#import "SolrProductCell.h"
#import "DisOrderPhotosViewController.h"
#import "ProductImageCell.h"
#import "FindDisorderByIdService.h"



//#define kProductAppraisalCELL_label_title_font      [UIFont systemFontOfSize:16]
#define kProductAppraisalCELL_label_time_font       [UIFont systemFontOfSize:13]
//#define kProductAppraisalCELL_label_content_font    [UIFont systemFontOfSize:14]
#define kProductAppraisalCELL_label_name_font       [UIFont systemFontOfSize:13]

//#define kProductAppraisalCELL_label_content_width   280
@interface ProductDisOrderDetailsViewController : CommonViewController<UIActionSheetDelegate,FindDisorderByIdServiceDelegate>{
    
    
    UITableViewCell                 *_webUITableView;
    
    UIWebView      *_webView;
    
    UILabel                         *productTextLabel_;
    UILabel                         *disOrderDetailLabel_;
    NSInteger                       rowCount;
    NSMutableArray                  *imageArray_;
    EGOImageViewEx                  *disOrderimageView_;
    
    BOOL                            isOrderLoaded;
    
    NSMutableArray					*disProductDetailsItemList_;
    
    NSString                        *productName_;
    NSString                        *shaidanzhengwen_;
    
    NSMutableArray                  *imageDownloadList_;
    
    BOOL                            isImageLoaded;
    
    NSMutableArray                  *ProductDisOrderReplyItem_;
    
    DisProductDetailsDTO            *selectDisProductDetailsDTO_;
    
    DataProductBasic                *dataProductBasic_;
    
    
    
    
}

@property (nonatomic, strong) UITableViewCell *webUITableView;
@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UILabel                   *productTextLabel;
@property (nonatomic, strong) UILabel                   *disOrderDetailLabel;
@property (nonatomic, strong) NSMutableArray            *imageArray;
@property (nonatomic, strong) EGOImageViewEx            *disOrderimageView;
@property (nonatomic, strong) NSMutableArray            *disProductDetailsItemList;
@property (nonatomic, strong) NSString                  *productName;
@property (nonatomic, strong) NSString                  *shaidanzhengwen;
@property (nonatomic, strong) NSMutableArray            *imageDownloadList;
@property (nonatomic, strong) NSMutableArray            *ProductDisOrderReplyItem;
@property (nonatomic, strong) DisProductDetailsDTO      *selectDisProductDetailsDTO;
@property (nonatomic, strong) DataProductBasic          *dataProductBasic;
@property (nonatomic, strong) FindDisorderByIdService   *service;

-(id)initWithDTO:(DisProductDetailsDTO *)dto;

//- (EGOImageViewEx *)disOrderDetailsimageView:(NSInteger)imageid;

//-(void)sendfindDisOrderByIdHttpRequest;

- (int)countSubString:(NSString *)TotalString subString:(NSString *)subString;



@end

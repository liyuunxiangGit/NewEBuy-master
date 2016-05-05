//
//  EbuyQuanCell.h
//  SuningEBuy
//
//  Created by li xiaokai on 14-2-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYEbuyCoumonDTO.h"

#import "ExCouponDto.h"


@protocol EbuyQuanCellDelegate <NSObject>

@optional
-(void)expendCell;
@end


@interface EbuyQuanCell : UITableViewCell {
    UITapGestureRecognizer *tapGesture;
}


@property(nonatomic,strong)UIImageView *backImg;

@property(nonatomic,strong)UILabel *quanNOLab;

@property(nonatomic,strong)UILabel *dateLab;

@property(nonatomic,strong)UILabel *priceLab;

@property(nonatomic,strong)UILabel *quanName;

@property(nonatomic,strong)UILabel *memoLab;

@property(nonatomic,strong)UILabel *lineView;

@property(nonatomic,strong)UIButton *markBtn;

@property(nonatomic,assign)id<EbuyQuanCellDelegate> myDelegate;

@property(nonatomic,strong)MYEbuyCoumonDTO *dto;

//cell正面view
@property(nonatomic, strong) UIView *cellFrontView;

//cell正面的指示图片
@property (nonatomic, strong) UIImageView   *frontIndicatorImageView;

//cell背面view
@property(nonatomic, strong) UIView *cellBackView;

//背面view是否是hidden状态
@property (nonatomic, assign) BOOL isCellBackViewHidden;

//背面 背景图
@property (nonatomic, strong) UIImageView *cellBackViewImage;

//背面 券NO
@property (nonatomic, strong) UILabel *backQuanNOLab;

//背面 券时间
@property (nonatomic, strong) UILabel *backDateLab;

//背面 券description
@property (nonatomic, strong) UITextView *backQuanDescrption;

//是否是优惠券，电子礼金券是不能翻页的
@property (nonatomic, assign) BOOL isYouHuiQuan;

-(void)setUIItem:(id)dto;


+(float)heightOfCell:(id )dto;
@end

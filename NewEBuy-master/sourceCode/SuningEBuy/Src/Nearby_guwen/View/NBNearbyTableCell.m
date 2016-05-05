//
//  NBNearbyTableCell.m
//  suningNearby
//
//  Created by suning on 14-7-29.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "NBNearbyTableCell.h"
#import "UIImageView+WebCache.h"
#import "NBYStickItemDTO.h"
#import "NBYRadiusPortriatView.h"
#import "NBYUtils.h"

@interface NBNearbyTableCell ()

@property (nonatomic,strong) IBOutlet UIView         *ccontentView;
@property (nonatomic,strong) IBOutlet UIImageView    *portriatImgView;
@property (nonatomic,strong) IBOutlet UIImageView    *stickImgView;
@property (nonatomic,strong) IBOutlet UIImageView    *sexTypeImgView;
@property (nonatomic,strong) IBOutlet UIImageView    *stickTypeImgView;
@property (nonatomic,strong) IBOutlet UILabel        *nameLabel;
@property (nonatomic,strong) IBOutlet UILabel        *timeLabel;
@property (nonatomic,strong) IBOutlet UILabel        *nameDescLabel;

@property (nonatomic,strong) IBOutlet UILabel        *contentLabel;
// 最近打赏 该 stick
@property (nonatomic,strong) IBOutlet UIImageView    *recentCntsView;

@property (nonatomic,strong) IBOutlet UIButton       *operationBt0; // 评论
@property (nonatomic,strong) IBOutlet UIButton       *operationBt1; // 打赏
@property (nonatomic,strong) IBOutlet UIButton       *operationBt2; // 举报

@end


@implementation NBNearbyTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor colorWithRed:242.0f/255.0f
                                           green:242.0f/255.0f
                                            blue:242.0f/255.0f
                                           alpha:1.0f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NBNearbyTableCell *)cellWithTemplate:(int)templateType {
    
    return ([[NSBundle mainBundle] loadNibNamed:@"NBNearbyTableCell" owner:nil options:nil][0]);
}

- (IBAction)on_functionButtons_clicked:(UIButton *)sender {
    // sender.tag;
    // 1评论，2打赏，3举报
    if (nil != _delegate
        && [_delegate respondsToSelector:@selector(delegate_NBNearbyTableCell_operetion:item:)]) {
       
        // 1评论，2打赏，3我要参与,4去看看
        [_delegate delegate_NBNearbyTableCell_operetion:sender.tag item:_dto];
    }
}

- (void)setDto:(NBYStickItemDTO *)dto {
    
    _dto = dto;
    if (_dto != nil) {
        // todo
        NSDictionary *item        = _dto.item;
        
        NSDictionary *u           = EncodeDicFromDic(item,@"u");
        NSString     *poraitUrl   = EncodeStringFromDic(u,@"faceUrl");
        NSString     *name        = EncodeStringFromDic(u,@"nick");
        NSNumber     *sex         = EncodeNumberFromDic(u,@"sex");
        
        if (nil == name
            || name.length == 0) {
            //name = EncodeStringFromDic(u, @"id");
            name = L(@"LCUser");
        }
        
        //NSString     *cntUrl      = EncodeStringFromDic(item,@"contUrl");
        
        _nameLabel.text = name;
        
        // 性别 标识
        if (sex.intValue == 1) {
            _sexTypeImgView.image = [UIImage imageNamed:@"nnby_sexType_0"];
        }else{
            _sexTypeImgView.image = [UIImage imageNamed:@"nnby_sexType_1"];
        }
        // 帖子 标识
        // 内容来源，10表示会员发布，11苏宁门店，12满座，13标识C店，14标识晒单
        NSNumber *srcId         = EncodeNumberFromDic(item,@"srcId");
        if (srcId.intValue == 10) {
            _stickTypeImgView.image = [UIImage imageNamed:@"nnby_stick_from_1"];
        }else if (srcId.intValue == 14) {
             _stickTypeImgView.image = [UIImage imageNamed:@"nnby_stick_from_0"];
        }else {
            _stickTypeImgView.image = nil;
        }
        // 时间
        _timeLabel.text = [NBYUtils dateFormartString:EncodeStringFromDic(item,@"createTime")];
        // 获赏多少云钻
        _nameDescLabel.text = [NSString stringWithFormat:@"%@%@%@",L(@"GetAward"),EncodeStringFromDic(item,@"scoreCount"),L(@"CloudDiamond")];
        
        // 评论次数
//        NSString *title = [NSString stringWithFormat:@"评论(%@)",EncodeStringFromDic(item,@"commentCount")];
        [_operationBt0 setTitle:[NSString stringWithFormat:@"%@(%d)",/*L(@"Comment")*/@"评分",(int)_dto.commentNum]
                       forState:UIControlStateNormal];
        // 打赏次数
//        title = [NSString stringWithFormat:@"打赏(%@)",EncodeStringFromDic(item,@"rewardCount")];
        
        [_operationBt1 setTitle:[NSString stringWithFormat:@"%@(%d)",L(@"Award"),(int)_dto.dashangNum]
                       forState:UIControlStateNormal];
        // stick content
        _contentLabel.text = EncodeStringFromDic(item,@"cont");
        
        [_portriatImgView sd_setImageWithURL:[NSURL URLWithString:poraitUrl]
                            placeholderImage:[UIImage imageNamed:@"nnby_portriat"]];
        
        NSArray *tmpImgs = EncodeArrayFromDic(item, @"images");
        if (nil != tmpImgs
            && tmpImgs.count > 0) {
             NSString *oneImageUrl = EncodeStringFromDic((tmpImgs[0]),@"imageUrl");
            if (nil != oneImageUrl) {
                [_stickImgView sd_setImageWithURL:[NSURL URLWithString:oneImageUrl]
                                 placeholderImage:[UIImage imageNamed:@"nby_ac_img_default"]];
            }
        }
        
        // 最近打赏 人
        UIView *btsView   = _operationBt0.superview;
        CGSize sz0        = btsView.frame.size;
        NSArray *rewards  = EncodeArrayFromDic(item, @"rewardList");
        if (nil == rewards
            || rewards.count == 0) {
            _recentCntsView.hidden = YES;
            btsView.frame = CGRectMake(.0f,
                                       430.0f
                                       ,sz0.width,sz0.height);
            _ccontentView.frame = CGRectMake(.0f,15.0f,sz0.width,510.0f-44.0f);
        }else {
            _recentCntsView.hidden = NO;
            btsView.frame = CGRectMake(.0f,
                                       469.0f,
                                       sz0.width,sz0.height);
             _ccontentView.frame = CGRectMake(.0f,15.0f,sz0.width,510.0f);
            
            [self.recentCntsView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            
            for (int i = 0; i < rewards.count; ++i) {
                
                NSDictionary *ur = rewards[i];
                
                CGRect f = CGRectMake(i*41.0f,.0f,36.0f,36.0f);
                NBYRadiusPortriatView *v = [[NBYRadiusPortriatView alloc] initWithFrame:f];
                [v sd_setImageWithURL:[NSURL URLWithString:EncodeStringFromDic(ur, @"faceUrl")] placeholderImage:[UIImage imageNamed:@"nnby_portriat"]];
                [self.recentCntsView addSubview:v];
            }
        }
    }
}

@end

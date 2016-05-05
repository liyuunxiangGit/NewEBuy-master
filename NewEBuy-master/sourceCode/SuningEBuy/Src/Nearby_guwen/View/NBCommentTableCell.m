//
//  NBCommentTableCell.m
//  suningNearby
//
//  Created by suning on 14-8-4.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "NBCommentTableCell.h"
#import "UIImageView+WebCache.h"
#import "NBYUtils.h"

@interface NBCommentTableCell ()
@property (nonatomic,strong) IBOutlet UIImageView *portriatImgView;
@property (nonatomic,strong) IBOutlet UIImageView *sexTypeImgView;
@property (nonatomic,strong) IBOutlet UILabel     *nameLabel;
@property (nonatomic,strong) IBOutlet UILabel     *floorLabel;
@property (nonatomic,strong) IBOutlet UILabel     *timeLabel;
@property (nonatomic,strong) IBOutlet UILabel     *contentLabel;

@end


@implementation NBCommentTableCell

+ (NBCommentTableCell *)cell {
    return ([[NSBundle mainBundle] loadNibNamed:@"NBCommentTableCell" owner:nil options:nil][0]);
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCommentItem:(NSDictionary *)commentItem {
    if (_commentItem != commentItem) {
        _commentItem = commentItem;
        
        NSDictionary *u           = EncodeDicFromDic(_commentItem,@"u");
        NSString     *poraitUrl   = EncodeStringFromDic(u,@"faceUrl");
        NSString     *name        = EncodeStringFromDic(u,@"nick");
        NSNumber     *sex         = EncodeNumberFromDic(u,@"sex");
        
        // 性别 标识
        if (sex.intValue == 1) {
            _sexTypeImgView.image = [UIImage imageNamed:@"nnby_sexType_0"];
        }else {
            _sexTypeImgView.image = [UIImage imageNamed:@"nnby_sexType_1"];
        }
        // 名字
        if (nil == name
            || name.length == 0) {
            // name = EncodeStringFromDic(u, @"id");
             name = L(@"LCUser");
        }
        _nameLabel.text = name;
        // 头像
        [_portriatImgView sd_setImageWithURL:[NSURL URLWithString:poraitUrl]
                            placeholderImage:[UIImage imageNamed:@"nnby_portriat"]];
        // 时间
        _timeLabel.text = [NBYUtils dateFormartString:EncodeStringFromDic(_commentItem,@"createTime")];
        // 楼层
        _floorLabel.text = [NSString stringWithFormat:@"%d%@",(int)(_idxPath.row+1),L(@"Floor")];
        // 内容
        _contentLabel.text = EncodeStringFromDic(_commentItem,@"comment");
    }
}

@end

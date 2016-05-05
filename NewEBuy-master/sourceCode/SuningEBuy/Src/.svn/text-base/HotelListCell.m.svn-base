//
//  HotelListCell.m
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-2.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import "HotelListCell.h"
#import "NSAttributedString+Attributes.h"


@implementation HotelListCell

@synthesize hotelImage = _hotelImage;
@synthesize hotelName = _hotelName;
@synthesize hotelAdds = _hotelAdds;
@synthesize price = _price;
@synthesize evaluationView = _evaluationView;
@synthesize lineView = _lineView;
@synthesize arrowImgView=_arrowImgView;
@synthesize item =_item;


- (void)dealloc {
    
    TT_RELEASE_SAFELY(_price);
    TT_RELEASE_SAFELY(_hotelAdds);
    TT_RELEASE_SAFELY(_hotelName);
    TT_RELEASE_SAFELY(_hotelImage);
    TT_RELEASE_SAFELY(_evaluationView);
    TT_RELEASE_SAFELY(_lineView);
    TT_RELEASE_SAFELY(_arrowImgView);
    TT_RELEASE_SAFELY(_item);
    
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
		
        self.backgroundColor = [UIColor clearColor];
        
		self.autoresizesSubviews = YES;
        
    }
    
    return self;
}


//- (EGOImageViewEx *)hotelImage{
//    
//    if (!_hotelImage) {
//        
//        _hotelImage = [[EGOImageViewEx alloc] init];
//        
//        _hotelImage.backgroundColor = [UIColor clearColor];
//        
//        _hotelImage.frame = CGRectMake(10, 8, 58, 64);
//                
//        _hotelImage.exDelegate = self;
//        
//        _hotelImage.delegate = self;
//        _hotelImage.layer.borderColor=RGBCOLOR(220, 220, 220).CGColor;
//        _hotelImage.layer.borderWidth=0.5;
////        _hotelImage.layer.cornerRadius = 5;
//        
////        _hotelImage.layer.masksToBounds = YES;
//        
//        _hotelImage.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
//        
//        _hotelImage.userInteractionEnabled = YES;
//        
//        _hotelImage.contentMode = UIViewContentModeScaleToFill;
//        
//        [self addSubview:_hotelImage];
//    }
//    
//    return _hotelImage;
//}
-(EGOImageButton*)hotelImage{
    if (!_hotelImage) {
        _hotelImage = [[EGOImageButton alloc]init];
        _hotelImage.frame=CGRectMake(14, 12, 58, 64);
        _hotelImage.backgroundColor = [UIColor clearColor];
        _hotelImage.layer.borderColor = RGBCOLOR(220, 220, 220).CGColor;
        _hotelImage.layer.borderWidth = .5;
        [self.contentView addSubview:_hotelImage];
    }
    return _hotelImage;
}
- (UILabel *)hotelName{
    
    if (!_hotelName) {
        
        _hotelName = [[UILabel alloc] initWithFrame:CGRectMake(self.hotelImage.right  + 10, 5, 220, 30)];

        _hotelName.backgroundColor = [UIColor clearColor];
        _hotelName.textColor=[UIColor light_Black_Color];//313131
        _hotelName.font = [UIFont boldSystemFontOfSize:17.0];
        
        [self addSubview:_hotelName];
    }
    
    return _hotelName;
}

- (UILabel *)hotelAdds{
    
    if (!_hotelAdds) {
        
        _hotelAdds = [[UILabel alloc] initWithFrame:CGRectMake(self.hotelImage.right + 10, 35, 220, 20)];
        
        _hotelAdds.backgroundColor = [UIColor clearColor];
        
        _hotelAdds.textColor = [UIColor dark_Gray_Color];//707070
        
        _hotelAdds.font = [UIFont boldSystemFontOfSize:15.0];
        
        [self addSubview:_hotelAdds];
    }
    
    return _hotelAdds;
}

- (OHAttributedLabel *)price{
    
    if (!_price) {
        
        _price = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(self.hotelImage.right + 10, 57, 100, 20)];
        
        _price.backgroundColor = [UIColor clearColor];
        
        _price.textColor = [UIColor orange_Red_Color];
        _price.font=[UIFont systemFontOfSize:14];
//        _price.font = [UIFont boldSystemFontOfSize:17.0];
        
        [self addSubview:_price];
    }
    
    return _price;
}

- (void)setDiscountAttrText:(NSString *)orderPrice{
    NSString *string = [NSString stringWithFormat:@"%@ %@",orderPrice,L(@"BTStart")];
    NSMutableAttributedString *mutaString = [[NSMutableAttributedString alloc] initWithString:string];
    [mutaString setFont:[UIFont boldSystemFontOfSize:14.0]];
    [mutaString setTextColor:[UIColor light_Gray_Color]];
    [mutaString setTextColor:[UIColor orange_Red_Color] range:[string rangeOfString:orderPrice]];
    self.price.attributedText = mutaString;
    TT_RELEASE_SAFELY(mutaString);
}


- (HotelStarView *)evaluationView
{
    if (!_evaluationView) {
        
        _evaluationView = [[HotelStarView alloc] init];
        
        _evaluationView.backgroundColor = [UIColor clearColor];
        
        _evaluationView.frame = CGRectMake(180, 58, 80, 20);
        
        [self.contentView addSubview:_evaluationView];
    }
    return _evaluationView;
}

-(UIImageView *)lineView{
    
    if (!_lineView) {
        
        _lineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"category_cellSeparatorLine.png"]];
        
        _lineView.userInteractionEnabled = YES;
        
        [self.contentView addSubview:_lineView];
    }
    
    return _lineView;
    
}
-(UIImageView*)arrowImgView{
    if (!_arrowImgView) {
        UIImage* img=[UIImage newImageFromResource:@"cellDetail@2x.png"];
        _arrowImgView=[[UIImageView alloc] initWithFrame:CGRectMake(303, 38, 6, 11)];
        [_arrowImgView setImage:img];
        TT_RELEASE_SAFELY(img);
        
    }
    return _arrowImgView;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.lineView.frame = CGRectMake(0, 87, 320, 1);
    
}


- (void)setItem:(HotelListDTO *)aItem{
    
    if (aItem == nil) {
        return;
    }
    if (aItem != _item) {
        
        _item = aItem;
    
        self.hotelImage.imageURL = _item.hotelImg;
        self.hotelName.text = _item.hotelName;
        self.hotelAdds.text = _item.hotelAdds;
        [self setDiscountAttrText:[NSString stringWithFormat:@"￥%d",[_item.hotelPrice intValue]]];
        [self.evaluationView setStarsImages:_item.category];
        
        [self.contentView addSubview:self.arrowImgView];
    }
}

@end

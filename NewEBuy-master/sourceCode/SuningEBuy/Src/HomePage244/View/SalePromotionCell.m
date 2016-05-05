//
//  SalePromotionCell.m
//  SuningEBuy
//
//  Created by GUO on 14-9-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SalePromotionCell.h"

@interface SalePromotionCell()
{
    NSString *_saleModel;
}
@property (nonatomic, strong) EGOImageButton                *titleImageView;
@property (nonatomic, strong) EGOImageButton                *firstImageView;
@property (nonatomic, strong) EGOImageButton                *secondImageView;
@property (nonatomic, strong) EGOImageButton                *thirdImageView;
@property (nonatomic, strong) EGOImageButton                *forthImageView;
@property (nonatomic, strong) EGOImageButton                *fifthImageView;
@property (nonatomic, strong) EGOImageButton                *sixthImageView;
@property (nonatomic, strong) EGOImageButton                *sevenImageView;
@property (nonatomic, strong) EGOImageButton                *eightImageView;
@property (nonatomic, strong) EGOImageButton                *nineImageView;
@property (nonatomic, strong) UIImageView                   *backImageView;
@property (nonatomic, strong) NSMutableArray                *imageViewArray;
@property (nonatomic, strong) ZhuanTiDTO                    *salePromotionDto;

@end

@implementation SalePromotionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle = UITableViewCellStyleDefault;
        [self.imageViewArray addObject:self.firstImageView];
        [self.imageViewArray addObject:self.secondImageView];
        [self.imageViewArray addObject:self.thirdImageView];
        [self.imageViewArray addObject:self.forthImageView];
        [self.imageViewArray addObject:self.fifthImageView];
        [self.imageViewArray addObject:self.sixthImageView];
        [self.imageViewArray addObject:self.sevenImageView];
        [self.imageViewArray addObject:self.eightImageView];
        [self.imageViewArray addObject:self.nineImageView];
    }
    return self;
}

- (NSMutableArray *)imageViewArray
{
    if(!_imageViewArray)
    {
        _imageViewArray = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _imageViewArray;
}

- (EGOImageButton *)titleImageView
{
    if(!_titleImageView)
    {
        _titleImageView = [[EGOImageButton alloc] init];
        _titleImageView.delegate = self;
        [_titleImageView addTarget:self action:@selector(didSelectPromotionImage:) forControlEvents:UIControlEventTouchUpInside];
        _titleImageView.tag = 0;
        _titleImageView.backgroundColor = [UIColor clearColor];
        _titleImageView.layer.masksToBounds = YES;
        _titleImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _titleImageView;
}

- (EGOImageButton *)firstImageView
{
    if(!_firstImageView)
    {
        _firstImageView = [[EGOImageButton alloc] init];
        _firstImageView.delegate = self;
        [_firstImageView addTarget:self action:@selector(didSelectPromotionImage:) forControlEvents:UIControlEventTouchUpInside];
        _firstImageView.tag = 1;
        _firstImageView.backgroundColor = [UIColor clearColor];
        _firstImageView.layer.masksToBounds = YES;
        _firstImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _firstImageView;
}

- (EGOImageButton *)secondImageView
{
    if(!_secondImageView)
    {
        _secondImageView = [[EGOImageButton alloc] init];
        _secondImageView.delegate = self;
        [_secondImageView addTarget:self action:@selector(didSelectPromotionImage:) forControlEvents:UIControlEventTouchUpInside];
        _secondImageView.tag = 2;
        _secondImageView.backgroundColor = [UIColor clearColor];
        _secondImageView.layer.masksToBounds = YES;
        _secondImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _secondImageView;
}

- (EGOImageButton *)thirdImageView
{
    if(!_thirdImageView)
    {
        _thirdImageView = [[EGOImageButton alloc] init];
        _thirdImageView.delegate = self;
        [_thirdImageView addTarget:self action:@selector(didSelectPromotionImage:) forControlEvents:UIControlEventTouchUpInside];
        _thirdImageView.tag = 3;
        _thirdImageView.backgroundColor = [UIColor clearColor];
        _thirdImageView.layer.masksToBounds = YES;
        _thirdImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _thirdImageView;
}

- (EGOImageButton *)forthImageView
{
    if(!_forthImageView)
    {
        _forthImageView = [[EGOImageButton alloc] init];
        _forthImageView.delegate = self;
        [_forthImageView addTarget:self action:@selector(didSelectPromotionImage:) forControlEvents:UIControlEventTouchUpInside];
        _forthImageView.tag = 4;
        _forthImageView.backgroundColor = [UIColor clearColor];
        _forthImageView.layer.masksToBounds = YES;
        _forthImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _forthImageView;
}

- (EGOImageButton *)fifthImageView
{
    if(!_fifthImageView)
    {
        _fifthImageView = [[EGOImageButton alloc] init];
        _fifthImageView.delegate = self;
        [_fifthImageView addTarget:self action:@selector(didSelectPromotionImage:) forControlEvents:UIControlEventTouchUpInside];
        _fifthImageView.tag = 5;
        _fifthImageView.backgroundColor = [UIColor clearColor];
        _fifthImageView.layer.masksToBounds = YES;
        _fifthImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _fifthImageView;
}

- (EGOImageButton *)sixthImageView
{
    if(!_sixthImageView)
    {
        _sixthImageView = [[EGOImageButton alloc] init];
        _sixthImageView.delegate = self;
        [_sixthImageView addTarget:self action:@selector(didSelectPromotionImage:) forControlEvents:UIControlEventTouchUpInside];
        _sixthImageView.tag = 6;
        _sixthImageView.backgroundColor = [UIColor clearColor];
        _sixthImageView.layer.masksToBounds = YES;
        _sixthImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _sixthImageView;
}

- (EGOImageButton *)sevenImageView
{
    if(!_sevenImageView)
    {
        _sevenImageView = [[EGOImageButton alloc] init];
        _sevenImageView.delegate = self;
        [_sevenImageView addTarget:self action:@selector(didSelectPromotionImage:) forControlEvents:UIControlEventTouchUpInside];
        _sevenImageView.tag = 7;
        _sevenImageView.backgroundColor = [UIColor clearColor];
        _sevenImageView.layer.masksToBounds = YES;
        _sevenImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _sevenImageView;
}

- (EGOImageButton *)eightImageView
{
    if(!_eightImageView)
    {
        _eightImageView = [[EGOImageButton alloc] init];
        _eightImageView.delegate = self;
        [_eightImageView addTarget:self action:@selector(didSelectPromotionImage:) forControlEvents:UIControlEventTouchUpInside];
        _eightImageView.tag = 8;
        _eightImageView.backgroundColor = [UIColor clearColor];
        _eightImageView.layer.masksToBounds = YES;
        _eightImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _eightImageView;
}

- (EGOImageButton *)nineImageView
{
    if(!_nineImageView)
    {
        _nineImageView = [[EGOImageButton alloc] init];
        _nineImageView.delegate = self;
        [_nineImageView addTarget:self action:@selector(didSelectPromotionImage:) forControlEvents:UIControlEventTouchUpInside];
        _nineImageView.tag = 9;
        _nineImageView.backgroundColor = [UIColor clearColor];
        _nineImageView.layer.masksToBounds = YES;
        _nineImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _nineImageView;
}

- (UIImageView *)backImageView
{
    if(!_backImageView)
    {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.backgroundColor = [UIColor clearColor];
        _backImageView.layer.masksToBounds = YES;
        _backImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _backImageView;
}

#pragma mark
#pragma mark - setViews

- (void)setViewsWith:(ZhuanTiDTO *)dto
{
    self.salePromotionDto = dto;
    _saleModel = dto.templateID;
    if(self.tag == 0){
        [self.contentView addSubview:self.titleImageView];
    }
    else{
        if ([_saleModel isEqualToString:@"30001"])
        {
            for(int i = 0;i < 5;i++)
            {
                [self.contentView addSubview:[self.imageViewArray objectAtIndex:i]];
            }
        }else if ([_saleModel isEqualToString:@"30002"])
        {
            [self.contentView addSubview:[self.imageViewArray objectAtIndex:0]];
        }else if ([_saleModel isEqualToString:@"30003"])
        {
            for(int i = 0;i < 2;i++)
            {
                [self.contentView addSubview:[self.imageViewArray objectAtIndex:i]];
            }
        }else if ([_saleModel isEqualToString:@"30004"])
        {
            for(int i = 0;i < 9;i++)
            {
                [self.contentView addSubview:[self.imageViewArray objectAtIndex:i]];
            }
        }
        else if ([_saleModel isEqualToString:@"30005"])
        {
            for(int i = 0;i < 4;i++)
            {
                [self.contentView addSubview:[self.imageViewArray objectAtIndex:i]];
            }
        }
        else if ([_saleModel isEqualToString:@"30006"])
        {
            for(int i = 0;i < 5;i++)
            {
                [self.contentView addSubview:[self.imageViewArray objectAtIndex:i]];
            }
        }else if([_saleModel isEqualToString:@"30007"])
        {
            for(int i = 0;i < 3;i++)
            {
                [self.contentView addSubview:[self.imageViewArray objectAtIndex:i]];
            }
        }
    }
    //设置图片位置及URL
    [self setImageFrame];
    [self setImageUrl:dto];
}

- (void)setImageFrame
{
    if(self.tag == 0){
        if(![_saleModel isEqualToString:@"30002"]){
            self.titleImageView.frame = CGRectMake(0, 0, 320, 120);
        }
        else{
            self.titleImageView.frame = CGRectMake(10, 10, 300, 120);
        }
    }
    else{
        if ([_saleModel isEqualToString:@"30001"])
        {
            self.firstImageView.frame = CGRectMake(10, 10, 145, 180);
            self.secondImageView.frame = CGRectMake(165, 10, 145, 85);
            self.thirdImageView.frame = CGRectMake(165, 105, 145, 85);
            self.forthImageView.frame = CGRectMake(10, 200, 145, 85);
            self.fifthImageView.frame = CGRectMake(165, 200, 145, 85);
        }else if ([_saleModel isEqualToString:@"30002"])
        {
            self.firstImageView.frame = CGRectMake(10, 10, 300, 120);
        }else if ([_saleModel isEqualToString:@"30003"])
        {
            self.firstImageView.frame = CGRectMake(0, 0, 160, 130);
            self.secondImageView.frame = CGRectMake(160, 0, 160, 130);
        }else if ([_saleModel isEqualToString:@"30004"])
        {
            self.firstImageView.frame  = CGRectMake(10, 10, 100, 150);
            self.secondImageView.frame = CGRectMake(110, 10, 100, 150);
            self.thirdImageView.frame  = CGRectMake(210, 10, 100, 150);
            self.forthImageView.frame  = CGRectMake(10, 160, 100, 150);
            self.fifthImageView.frame  = CGRectMake(110, 160, 100, 150);
            self.sixthImageView.frame  = CGRectMake(210, 160, 100, 150);
            self.sevenImageView.frame  = CGRectMake(10, 310, 100, 150);
            self.eightImageView.frame  = CGRectMake(110, 310, 100, 150);
            self.nineImageView.frame   = CGRectMake(210, 310, 100, 150);
        }
        else if ([_saleModel isEqualToString:@"30005"])
        {
            if(self.tag % 2 == 1){
                self.firstImageView.frame = CGRectMake(10, 10, 100, 150);
                self.secondImageView.frame = CGRectMake(110, 10, 200, 75);
                self.thirdImageView.frame = CGRectMake(110, 85, 100, 75);
                self.forthImageView.frame = CGRectMake(210, 85, 100, 75);
            }else{
                self.firstImageView.frame = CGRectMake(10, 10, 200, 75);
                self.secondImageView.frame = CGRectMake(10, 85, 100, 75);
                self.thirdImageView.frame = CGRectMake(110, 85, 100, 75);
                self.forthImageView.frame = CGRectMake(210, 10, 100, 150);
            }
        }
        else if ([_saleModel isEqualToString:@"30006"])
        {
            if(self.tag % 2 == 1){
                self.firstImageView.frame = CGRectMake(10, 10, 100, 75);
                self.secondImageView.frame = CGRectMake(110, 10, 200, 75);
                self.thirdImageView.frame = CGRectMake(10, 85, 100, 75);
                self.forthImageView.frame = CGRectMake(110, 85, 100, 75);
                self.fifthImageView.frame = CGRectMake(210, 85, 100, 75);
            }else{
                self.firstImageView.frame = CGRectMake(10, 10, 200, 75);
                self.secondImageView.frame = CGRectMake(210, 10, 100, 75);
                self.thirdImageView.frame = CGRectMake(10, 85, 100, 75);
                self.forthImageView.frame = CGRectMake(110, 85, 100, 75);
                self.fifthImageView.frame = CGRectMake(210, 85, 100, 75);
            }
        }
        else if([_saleModel isEqualToString:@"30007"])
        {
            if(self.tag % 2 == 1){
                self.firstImageView.frame = CGRectMake(10, 10, 150, 150);
                self.secondImageView.frame = CGRectMake(160, 10, 150, 75);
                self.thirdImageView.frame = CGRectMake(160, 85, 150, 75);
            }else{
                self.firstImageView.frame = CGRectMake(10, 10, 150, 75);
                self.secondImageView.frame = CGRectMake(10, 85, 150, 75);
                self.thirdImageView.frame = CGRectMake(160, 10, 150, 150);
            }
        }
    }
}

- (void)setImageUrl:(ZhuanTiDTO *)dto
{
    int index = self.tag - 1;
    int count = [dto.dataArray count];
    if(self.tag == 0){
        self.titleImageView.imageURL = [NSURL URLWithString:dto.topAD.adImg];
        if([_saleModel isEqualToString:@"30002"])
        {
            [self.titleImageView addFullLine];
        }
    }
    else{
        if ([_saleModel isEqualToString:@"30001"])
        {
            for(int i = 0;i < 5;i++)
            {
                if(index*5+i < count)
                {
                    HomeModuleDTO *tempDto = [dto.dataArray objectAtIndex:index*5+i];
                    EGOImageButton *tempImage = [self.imageViewArray objectAtIndex:i];
                    if(tempDto != nil){
                        tempImage.imageURL = [NSURL URLWithString:tempDto.bgImg];
                        [tempImage addFullLine];
                    }
                }
            }
        }else if ([_saleModel isEqualToString:@"30002"])
        {
            if(index <count){
                HomeModuleDTO *tempDto = [dto.dataArray objectAtIndex:index];
                EGOImageButton *tempImage = [self.imageViewArray objectAtIndex:0];
                if(tempDto != nil){
                    tempImage.imageURL = [NSURL URLWithString:tempDto.bgImg];
                    [tempImage addFullLine];
                }
            }
        }else if ([_saleModel isEqualToString:@"30003"])
        {
            for(int i = 0;i < 2;i++)
            {
                if(index*2+i < count)
                {
                    HomeModuleDTO *tempDto = [dto.dataArray objectAtIndex:index*2+i];
                    EGOImageButton *tempImage = [self.imageViewArray objectAtIndex:i];
                    if(tempDto != nil){
                        tempImage.imageURL = [NSURL URLWithString:tempDto.bgImg];
                        if(i == 0){
                            [tempImage addRightBottomLineLeftOffset];
                        }else{
                            [tempImage addBottomLineRightOffset];
                        }
                        //模版3最后的边线与上面不同
                        if(count%2 == 0){
                            if(index*2+i == count-1 || index*2+i == count-2){
                                [tempImage addBottomLine];
                            }
                        }else{
                            if(index*2+i == count-1){
                                [tempImage addBottomLine];
                            }
                        }
                    }
                }
            }
        }else if ([_saleModel isEqualToString:@"30004"])
        {
            for(int i = 0;i < 9;i++)
            {
                if(index*9+i < count)
                {
                    HomeModuleDTO *tempDto = [dto.dataArray objectAtIndex:index*9+i];
                    EGOImageButton *tempImage = [self.imageViewArray objectAtIndex:i];
                    if(tempDto != nil){
                        tempImage.imageURL = [NSURL URLWithString:tempDto.bgImg];
                        [tempImage addRightBottomLine];
                        if(i == 0 || i == 1 || i == 2){
                            [tempImage addTopLine];
                        }
                        if(i%3 == 0){
                            [tempImage addLeftLine];
                        }
                    }
                }
            }
        }
        else if ([_saleModel isEqualToString:@"30005"])
        {
            for(int i = 0;i < 4;i++)
            {
                if(index*4+i < count)
                {
                    HomeModuleDTO *tempDto = [dto.dataArray objectAtIndex:index*4+i];
                    EGOImageButton *tempImage = [self.imageViewArray objectAtIndex:i];
                    if(tempDto != nil){
                        tempImage.imageURL = [NSURL URLWithString:tempDto.bgImg];
                        [tempImage addRightBottomLine];
                        if(i == 0){
                            [tempImage addTopLine];
                            [tempImage addLeftLine];
                        }
                        if(self.tag % 2 == 1){
                            if(i == 1){
                                [tempImage addTopLine];
                            }
                        }
                        else{
                            if(i == 1){
                                [tempImage addLeftLine];
                            }else if(i == 3){
                                [tempImage addTopLine];
                            }
                        }
                    }
                }
            }
        }
        else if ([_saleModel isEqualToString:@"30006"])
        {
            for(int i = 0;i < 5;i++)
            {
                if(index*5+i < count)
                {
                    HomeModuleDTO *tempDto = [dto.dataArray objectAtIndex:index*5+i];
                    EGOImageButton *tempImage = [self.imageViewArray objectAtIndex:i];
                    if(tempDto != nil){
                        tempImage.imageURL = [NSURL URLWithString:tempDto.bgImg];
                        [tempImage addRightBottomLine];
                        if(i == 0){
                            [tempImage addTopLine];
                            [tempImage addLeftLine];
                        }else if(i == 1){
                            [tempImage addTopLine];
                        }else if(i == 2){
                            [tempImage addLeftLine];
                        }
                    }
                }
            }
        }
        else if([_saleModel isEqualToString:@"30007"])
        {
            for(int i = 0;i < 3;i++)
            {
                if(index*3+i < count)
                {
                    HomeModuleDTO *tempDto = [dto.dataArray objectAtIndex:index*3+i];
                    EGOImageButton *tempImage = [self.imageViewArray objectAtIndex:i];
                    if(tempDto != nil){
                        tempImage.imageURL = [NSURL URLWithString:tempDto.bgImg];
                        [tempImage addRightBottomLine];
                        if(i == 0){
                            [tempImage addTopLine];
                            [tempImage addLeftLine];
                        }
                        if(self.tag % 2 == 1){
                            if(i == 1){
                                [tempImage addTopLine];
                            }
                        }else{
                            if(i == 1){
                                [tempImage addLeftLine];
                            }else if(i == 2){
                                [tempImage addTopLine];
                            }
                        }
                    }
                }
            }
        }
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark
#pragma mark - didSelectPromotionImage

- (void)didSelectPromotionImage:(id)sender
{
    EGOImageButton *button = (EGOImageButton *)sender;
    int buttonIndex = button.tag - 1;
    int rowIndex = self.tag - 1;
    HomeModuleDTO *sendHMDto = [[HomeModuleDTO alloc] init];
    TopADInfoDTO  *sendTopDto = [[TopADInfoDTO alloc] init];
    if(button.tag == 0)
    {
        sendTopDto = self.salePromotionDto.topAD;
        if (_delegate && [_delegate respondsToSelector:@selector(goToTargetPageWithTopAD:)])
        {
            [_delegate goToTargetPageWithTopAD:sendTopDto];
        }
    }else{
        if([_saleModel isEqualToString:@"30001"])
        {
            if(rowIndex*5 + buttonIndex < [self.salePromotionDto.dataArray count])
            {
                sendHMDto = [self.salePromotionDto.dataArray objectAtIndex:rowIndex*5+buttonIndex];
            }
        }else if ([_saleModel isEqualToString:@"30002"])
        {
            if(rowIndex + buttonIndex < [self.salePromotionDto.dataArray count])
            {
                sendHMDto = [self.salePromotionDto.dataArray objectAtIndex:rowIndex+buttonIndex];
            }
        }else if([_saleModel isEqualToString:@"30003"])
        {
            if(rowIndex*2 + buttonIndex < [self.salePromotionDto.dataArray count])
            {
                sendHMDto = [self.salePromotionDto.dataArray objectAtIndex:rowIndex*2+buttonIndex];
            }
        }else if([_saleModel isEqualToString:@"30004"])
        {
            if(rowIndex*9 + buttonIndex < [self.salePromotionDto.dataArray count])
            {
                sendHMDto = [self.salePromotionDto.dataArray objectAtIndex:rowIndex*9+buttonIndex];
            }
        }else if([_saleModel isEqualToString:@"30005"])
        {
            if(rowIndex*4 + buttonIndex < [self.salePromotionDto.dataArray count])
            {
                sendHMDto = [self.salePromotionDto.dataArray objectAtIndex:rowIndex*4+buttonIndex];
            }
        }else if([_saleModel isEqualToString:@"30006"])
        {
            if(rowIndex*5 + buttonIndex < [self.salePromotionDto.dataArray count])
            {
                sendHMDto = [self.salePromotionDto.dataArray objectAtIndex:rowIndex*5+buttonIndex];
            }
        }else if([_saleModel isEqualToString:@"30007"])
        {
            if(rowIndex*3 + buttonIndex < [self.salePromotionDto.dataArray count])
            {
                sendHMDto = [self.salePromotionDto.dataArray objectAtIndex:rowIndex*3+buttonIndex];
            }
        }
        if (_delegate && [_delegate respondsToSelector:@selector(goToTargetPageWithHMDTO:)])
        {
            [_delegate goToTargetPageWithHMDTO:sendHMDto];
        }
    }
}
@end

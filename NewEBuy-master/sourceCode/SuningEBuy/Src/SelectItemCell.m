//
//  SelectItemCell.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-7-16.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SelectItemCell.h"

#define kClusterColorId   @"colorId"
#define kClusterColorName @"colorNm"

#define kClusterVersionId @"versionId"
#define kClusterVersionName @"versionNm"


#define RowNum   4
@implementation SelectItemCell

-(void)dealloc{
    
    TT_RELEASE_SAFELY(_dataSourse);
    TT_RELEASE_SAFELY(_singleBtnService);
    
    TT_RELEASE_SAFELY(_productDto);
    
}

-(SSBtnService *)singleBtnService{
    
    
    if (!_singleBtnService) {
        
        _singleBtnService = [[SSBtnService alloc] init];
    }
    
    return _singleBtnService;
}
-(UIImageView *)separatorLine{
    
    if (!_separatorLine) {
        
        _separatorLine = [[UIImageView alloc] init];
        
        _separatorLine.image = [UIImage imageNamed:@"line.png"];
        
        
    }
    
    return _separatorLine;
}
-(UILabel *)selectTypeTitle{
    
    
    if (!_selectTypeTitle) {
        
        _selectTypeTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];
        _selectTypeTitle.backgroundColor = [UIColor clearColor];
        
        _selectTypeTitle.font = [UIFont systemFontOfSize:13];
        
        _selectTypeTitle.textColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1];
        
        
    }
    

    return _selectTypeTitle;

}

//-(void)initViewWithSourse:(DataProductBasic *)dto type:(NSInteger)type{
//    
//    
//    NSArray *array = nil;
//    NSString *idKey = nil;
//    NSString *valueVey = nil;
//    NSString *compareStr = nil;
//    NSString *title = nil;
//    self.cellType = type;
//    if (ColorCell == type) {
//        
//        array = dto.colorItemList;
//        idKey = kClusterColorId;
//        valueVey = kClusterColorName;
//        compareStr = dto.colorCurr;
//        title = @"颜色";
//    }
//    else if(SizeCell == type){
//        
//        array = dto.versionItemList;
//        idKey = kClusterVersionId;
//        valueVey = kClusterVersionName;
//        compareStr = dto.versionCurr;
//        title = dto.versionDesc;
//    }
//    
//    
//    
//    
//    
//    NSMutableArray *btnArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
//    
//    int x = 10;
//    int y = 20;
//    self.titleLabel.text = title;
//    for (int i=0; i<[array count]; i++) {
//        
//        
//        NSDictionary *dic = [array objectAtIndex:i];
//        
//        SingleBtn *btn = [[SingleBtn alloc] initWithFrame:CGRectMake(x + i%RowNum*80, y+i/RowNum*30, 60, 25)];
//        
//        btn.btnValue = [dic objectForKey:idKey];
//        
//        btn.titleLabel.font = [UIFont systemFontOfSize:12];
//
//        if ([btn.btnValue isEqualToString:compareStr]) {
//            
//            btn.selected = YES;
//        }
//        
//        [btn setTitle:[dic objectForKey:valueVey] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage imageNamed:@"selectitem_s@2x.png"] forState:UIControlStateSelected];
//        [btn setBackgroundImage:[UIImage imageNamed:@"selectitem_u@2x.png"] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
//        [btn addTarget:self action:@selector(selectSingleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [self.contentView addSubview:btn];
//        
//        [btnArray addObject:btn];
//        [btn release];
//        
//    }
//    
//    self.singleBtnService.btnArray = btnArray;
//    [btnArray release];
//
//}
-(void)initViewWithSourse:(DataProductBasic *)dto type:(NSInteger)type{
    
    self.contentView.backgroundColor = RGBCOLOR(239, 239, 239);
    self.productDto = dto;
    
    NSArray *array = nil;
    NSString *idKey = nil;
    NSString *valueVey = nil;
    NSString *compareStr = nil;
    NSString *title = nil;
    self.cellType = type;
    
//    NSArray *adsrg = nil;
    NSMutableArray  *mapArr = [[NSMutableArray alloc] init];
    
    if (ColorCell == type) {
        
        array = dto.colorItemList;
        idKey = kClusterColorId;
        valueVey = kClusterColorName;
        compareStr = dto.colorCurr;
        title = L(@"Product_ColorCategory");
        
    }
    else if(SizeCell == type){
        
        array = dto.versionItemList;
        idKey = kClusterVersionId;
        valueVey = kClusterVersionName;
        compareStr = dto.versionCurr;
        title = dto.versionDesc;
        
        for (DataProductBasic *tempDto in dto.colorVersionMap) {
            if ([dto.colorCurr isEqualToString:tempDto.colorCurr]) {
                [mapArr addObject:tempDto.versionCurr];
            }
        }
    }
    
    
    NSMutableArray *btnArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    

    float edgeX = 10;           //边缘间隔
    float x = edgeX;
    float divideX = 20;         //两个控件之间的间隔
    float y = 35;
    float minWidth = 60;        //控件最小宽度
    float maxWidth = 300;       //控件最大宽度
    
    float leaveWith = 300;
    
    self.selectTypeTitle.text = title;
    [self.contentView addSubview:_selectTypeTitle];
    
    for (int i=0; i<[array count]; i++) {
        
        NSDictionary *dic = [array objectAtIndex:i];
        
        
    
        CGSize nameSize = [[dic objectForKey:valueVey] sizeWithFont:[UIFont systemFontOfSize:12]
                                                  constrainedToSize:CGSizeMake(320, 200)
                                                      lineBreakMode:UILineBreakModeCharacterWrap];
    
        float btnWidth = minWidth;
        if (nameSize.width+10 > 300) {
            
            //很长时 最长300
            btnWidth = maxWidth;
        }
        else if(nameSize.width+10 >= 60){
            
            btnWidth = nameSize.width+10;
        }
        
        if (leaveWith < btnWidth) {
            
            x = edgeX;
            y = y + 30;
            
            leaveWith = 300;
        }
        
        SingleBtn *btn = [[SingleBtn alloc] initWithFrame:CGRectMake(x, y, btnWidth, 25)];
        leaveWith = leaveWith - btnWidth - divideX;
        x = x + btnWidth + divideX;
        
        btn.btnValue = [dic objectForKey:idKey];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        if ([btn.btnValue isEqualToString:compareStr]) {
            
            btn.selected = YES;
        }
        
        if (ColorCell == type) {
            BOOL hasCurrColor = NO;
            for (DataProductBasic *tempDto in dto.colorVersionMap) {
                if ([btn.btnValue isEqualToString:tempDto.colorCurr]) {
                    hasCurrColor = YES;
                    break;
                }
            }
            btn.enabled = hasCurrColor;
        }
        else if (SizeCell == type)
        {
            BOOL has = NO;
            for (NSString *mapStr in mapArr) {
                if ([btn.btnValue isEqualToString:mapStr]) {
                    has = YES;
                    break;
                }
            }
            btn.enabled = has;
        }

        UIImage *nomralImg = nil;
        UIImage *selectImg = nil;
        UIImage *disableImg = nil;
        
        nomralImg = [[UIImage imageNamed:@"button_white_normal.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 15, 20)];
        selectImg = [[UIImage imageNamed:@"canshu_select_clicked.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 15, 20)];
        disableImg = [[UIImage imageNamed:@"button_white_disable.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 15, 20)];
        
        [btn setTitle:[dic objectForKey:valueVey] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:selectImg forState:UIControlStateSelected];
        [btn setBackgroundImage:nomralImg forState:UIControlStateNormal];
        [btn setBackgroundImage:disableImg forState:UIControlStateDisabled];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [btn setTitleColor:RGBCOLOR(246, 102, 30) forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(selectSingleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [self.contentView addSubview:btn];
        
        [btnArray addObject:btn];
        
    }
    
    self.separatorLine.frame = CGRectMake(15, y+39, 305, 0.5);
    [self.contentView addSubview:_separatorLine];
    self.singleBtnService.btnArray = btnArray;
    
}

//+(float)cellHeight:(NSArray *)array{
//    
//    int i = [array count]/RowNum;
//    
//    if(0 == ([array count]%RowNum)) {
//        
//        return i*30+15;
//    }
//    
//    return i*30 + 45;
//    
//    
//}

+(float)cellHeight:(DataProductBasic *)dto type:(NSInteger)type{
    
    NSArray *array = nil;
//    NSString *idKey = nil;
    NSString *valueVey = nil;
    
    if (ColorCell == type) {
        
        array = dto.colorItemList;
       // idKey = kClusterColorId;
        valueVey = kClusterColorName;
    }
    else if(SizeCell == type){
        
        array = dto.versionItemList;
      //  idKey = kClusterVersionId;
        valueVey = kClusterVersionName;
    }
    
    
    float edgeX = 10;           //边缘间隔
    float x = edgeX;
    float divideX = 20;         //两个控件之间的间隔
    float y = 20;
    float minWidth = 60;        //控件最小宽度
    float maxWidth = 300;       //控件最大宽度
    
    float leaveWith = 300;
    
    
    for (int i=0; i<[array count]; i++) {
        
        NSDictionary *dic = [array objectAtIndex:i];
                
        CGSize nameSize = [[dic objectForKey:valueVey] sizeWithFont:[UIFont systemFontOfSize:12]
                                                  constrainedToSize:CGSizeMake(320, 200)
                                                      lineBreakMode:UILineBreakModeCharacterWrap];
        
        float btnWidth = minWidth;
        if (nameSize.width+10 > 300) {
            
            //很长时 最长300
            btnWidth = maxWidth;
        }
        else if(nameSize.width+10 >= 60){
            
            btnWidth = nameSize.width+10;
        }
        
        if (leaveWith < btnWidth) {
            
            x = edgeX;
            y = y + 30;
            
            leaveWith = 300;
        }
        
        leaveWith = leaveWith - btnWidth - divideX;
        x = x + btnWidth + divideX;
        
    }

    
    return y+30+20;
}

+(float)cellHeight:(NSArray *)array
{
    
    return 0;
}

-(void)selectSingleBtnAction:(SingleBtn *)btn{
    
    
//    if (ColorCell == self.cellType) {
//        
//        if (nil == [self getProductMap:[btn btnValue] versionId:self.productDto.versionCurr]) {
//            
//            if (_myDelegate && [_myDelegate respondsToSelector:@selector(selected:cell:)]) {
//                [_myDelegate selected:nil cell:self.cellType];
//            }
//            
//            return;
//        }
//    }
//    else if(SizeCell == self.cellType){
//       
//        if (nil == [self getProductMap:self.productDto.colorCurr versionId:[btn btnValue]]) {
//            
//            if (_myDelegate && [_myDelegate respondsToSelector:@selector(selected:cell:)]) {
//                [_myDelegate selected:nil cell:self.cellType];
//            }
//            
//            return;
//        }
//        
//    }
    
    [self.singleBtnService touchbtn:btn];
        
    if (_myDelegate && [_myDelegate respondsToSelector:@selector(selected:cell:)]) {
        [_myDelegate selected:[self.singleBtnService singleValue] cell:self.cellType];
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (DataProductBasic *)getProductMap:(NSString *)colorId versionId:(NSString *)versionId{
    
    
    if (colorId == nil&&versionId == nil)
    {
        return nil;
    }
    for (int i = 0; i<[self.productDto.colorVersionMap count]; i++)
    {
        
        DataProductBasic *mapDTO = [self.productDto.colorVersionMap objectAtIndex:i];
        if ([colorId isEqualToString: mapDTO.colorCurr]  &&[versionId isEqualToString: mapDTO.versionCurr])
        {
            return mapDTO;
        }
        
        //add by cuizl 由于主站商品数据维护有问题，部分商品商品簇中versionid为空
        if([versionId isEqualToString:@""]||[mapDTO.versionCurr isEqualToString:@""])
        {
            if(self.productDto.versionItemList.count == 1&&[colorId isEqualToString:mapDTO.colorCurr])
            {
                return mapDTO;
                
            }
        }
        if([colorId isEqualToString:@""]||[mapDTO.colorCurr isEqualToString:@""])
        {
            
            if(self.productDto.colorItemList.count == 1 && [versionId isEqualToString:mapDTO.versionCurr])
            {
                return mapDTO;
            }
            
        }
        
    }
    
    
    return nil;
}


@end

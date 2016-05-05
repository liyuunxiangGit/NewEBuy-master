//
//  Floor12View.m
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-27.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#define KCellImageTag   12000

#import "Floor12View.h"

@implementation Floor12View


- (id)initWithFrame:(CGRect)frame {
    self  = [super initWithFrame:frame];
    if (self) {
        //cell内容是一个scroll，一行显示5ge，可多个
        self.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];

        imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KSpace, frame.size.width, frame.size.height)];
        imageScrollView.showsHorizontalScrollIndicator = YES;
        imageScrollView.delegate = self;
        imageScrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:imageScrollView];
    }
    return self;
}

- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto {
    
    //若为空数组，则直接返回
    if (IsNilOrNull(dto)) {
        return;
    }
    
    if (_floorDTO != dto) {
        _floorDTO = dto;
    }
    
    int imageCount = [dto.moduleList count];
    int width = imageCount * kScreenWidth * 150 / 640;
    
    //移除旧的UI元素
    NSArray *oldArray = [imageScrollView subviews];
    [oldArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    imageScrollView.contentSize = CGSizeMake(width > kScreenWidth ? width : kScreenWidth, self.frame.size.height);
    
    for (int i = 0; i < imageCount; i++) {
        HomeModuleDTO *tempDTO = [_floorDTO.moduleList safeObjectAtIndex:i];
        EGOImageViewEx *tempImage = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(i*kScreenWidth*150/640, 0, kScreenWidth*150/640, 75)];
        tempImage.exDelegate = self;
        tempImage.tag = KCellImageTag + i;
        [tempImage addTopRightBottonLine];
        tempImage.placeholderImage = nil;
        tempImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]];
        [imageScrollView addSubview:tempImage];
        TT_RELEASE_SAFELY(tempImage);
    }
}

- (void)imageExViewDidOk:(EGOImageViewEx *)imageViewEx {
    NSArray *moduleList = _floorDTO.moduleList;
    int flag = imageViewEx.tag - KCellImageTag;
    if (_delegate && [_delegate respondsToSelector:@selector(selectModuleDTO:)]) {
        [_delegate selectModuleDTO:[moduleList safeObjectAtIndex:flag]];
    }
    
    //添加埋点
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"112%02d%03d", [_floorDTO.orderNO intValue], 51 + flag], nil]];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

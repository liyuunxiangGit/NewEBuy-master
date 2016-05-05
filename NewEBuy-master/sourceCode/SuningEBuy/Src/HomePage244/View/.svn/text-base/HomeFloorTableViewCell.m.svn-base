//
//  HomeFloorTableViewCell.m
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-23.
//  Copyright (c) 2014年 Suning. All rights reserved.
//  modify by zhangbeibei 20141108:修改图片为按钮
//

#define KImageTagStart  9900


#import "HomeFloorTableViewCell.h"
#import "HomeFloorDTO.h"
#import <objc/message.h>

@implementation HomeFloorTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    }
    return self;
}

- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto {
    if (_floorDTO != dto) {
        _floorDTO = dto;
    }
    
    //移除旧的视图
    NSArray *viewArray = [self.contentView subviews];
    [viewArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    //依据楼层type，组成对应的方法
    NSString *floorIDString = [[GlobalDataCenter defaultCenter].floorID_TypeDict objectForKey:dto.templateID];
    int floorType = -1;
    if (NotNilAndNull(floorIDString)) {
        floorType = [floorIDString intValue];
    }
    
    NSString *methodName = [NSString stringWithFormat:@"addFloor_%d", floorType];
    
    SEL selectorMethod = NSSelectorFromString(methodName);
    if ([self respondsToSelector:selectorMethod]) {
        objc_msgSend(self, selectorMethod);
    }
}

- (void)addFloor_1 {
    
}

- (void)addFloor_2 {
    //功能区一行、功能区两行、八连版楼层的顶部没有10px的灰色间距,所以这些楼层的顶部不需要划线
    self.contentView.backgroundColor = [UIColor whiteColor];
    NSArray *moduleList = _floorDTO.moduleList;
    //一行5张图,图片加文字的模式
    for (int i = 0; i < 5; i++) {
        HomeModuleDTO *moduleDTO = [moduleList safeObjectAtIndex:i];
        EGOImageViewEx *imageView = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(12+i*kScreenWidth/5, 10, kScreenWidth*80/640, 40)];
        imageView.exDelegate = self;
        imageView.tag = KImageTagStart + i;
        imageView.placeholderImage = nil;
        imageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", moduleDTO.bgImg]];
        [self.contentView addSubview:imageView];
        TT_RELEASE_SAFELY(imageView);
        
        //文字
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5+(i%5)*kScreenWidth/5, 50, kScreenWidth/5-10, 20)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.textColor = [UIColor colorWithHexString:@"#707070"];
        nameLabel.text = moduleDTO.moduleName ? moduleDTO.moduleName : @"";
        nameLabel.font = [UIFont fontWithName:@"Arial" size:12.0];
        [self.contentView addSubview:nameLabel];
        TT_RELEASE_SAFELY(nameLabel);
    }
    
    //底部还需要划线
    UIImageView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 75-0.5, kScreenWidth, 0.5)];
    bottomImageView.image = [UIImage streImageNamed:@"line.png"];
    [self.contentView addSubview:bottomImageView];
    TT_RELEASE_SAFELY(bottomImageView);
}

- (void)addFloor_3 {
    NSArray *moduleList = _floorDTO.moduleList;
    //一行3张图
    for (int i = 0; i < 3; i++) {
        HomeModuleDTO *moduleDTO = [moduleList safeObjectAtIndex:i];
        EGOImageButton *imageButton = [[EGOImageButton alloc] initWithFrame:CGRectMake(i*kScreenWidth/3, 0+KSpace, kScreenWidth/3, 140)];
        imageButton.tag = KImageTagStart + i;
        [imageButton setTitleShadowColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2] forState:UIControlStateHighlighted|UIControlStateSelected];
        [imageButton addTopRightBottomLine];
        imageButton.placeholderImage = nil;
        [imageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [imageButton setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", moduleDTO.bgImg]]];
        [self.contentView addSubview:imageButton];
    }
}

- (void)addFloor_4 {
    HomeModuleDTO *moduleDTO_0 = [_floorDTO.moduleList safeObjectAtIndex:0];
    EGOImageButton *imageButton_0 = [[EGOImageButton alloc] initWithFrame:CGRectMake(0, 0+KSpace, kScreenWidth/2, 120)];
    imageButton_0.tag = KImageTagStart + 0;
    [imageButton_0 addTopRightBottomLine];
    imageButton_0.placeholderImage = nil;
    [imageButton_0 addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageButton_0 setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", moduleDTO_0.bgImg]]];
    [self.contentView addSubview:imageButton_0];
    
//    EGOImageViewEx *imageView_0 = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(0, 0+KSpace, kScreenWidth/2, 120)];
//    imageView_0.exDelegate = self;
//    imageView_0.tag = KImageTagStart + 0;
//    [imageView_0 addTopRightBottonLine];
//    imageView_0.placeholderImage = nil;
//    imageView_0.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", moduleDTO_0.bgImg]];
//    [self.contentView addSubview:imageView_0];
//    TT_RELEASE_SAFELY(imageView_0);
    
    for (int i = 0; i < 2; i++) {
        HomeModuleDTO *tempDTO = [_floorDTO.moduleList safeObjectAtIndex:1+i];
        EGOImageButton *imageButton = [[EGOImageButton alloc] initWithFrame:CGRectMake(kScreenWidth/2, 60*i+KSpace, kScreenWidth/2, 60)];
        imageButton.tag = KImageTagStart + 1 + i;
        if (i==0) {
            [imageButton addTopRightBottomLine];
        }
        else {
            [imageButton addRightBottomLine];
        }
        imageButton.placeholderImage = nil;
        [imageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [imageButton setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]]];
        [self.contentView addSubview:imageButton];
        
        
//        EGOImageViewEx *tempImageView = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(kScreenWidth/2, 60*i+KSpace, kScreenWidth/2, 60)];
//        tempImageView.exDelegate = self;
//        tempImageView.tag = KImageTagStart + 1 + i;
//        
//        if (i==0) {
//            [tempImageView addTopRightBottonLine];
//        }
//        else {
//            [tempImageView addRightBottomLine];
//        }
//        tempImageView.placeholderImage = nil;
//        tempImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]];
//        [self.contentView addSubview:tempImageView];
//        TT_RELEASE_SAFELY(tempImageView);
    }
    
    for (int i = 0; i < 3; i++) {
        HomeModuleDTO *tempDTO = [_floorDTO.moduleList safeObjectAtIndex:3+i];
        EGOImageButton *imageButton = [[EGOImageButton alloc] initWithFrame:CGRectMake(i * kScreenWidth/3, 120+KSpace, kScreenWidth/3, 75)];
        imageButton.tag = KImageTagStart + 3 + i;
        [imageButton addRightBottomLine];
        imageButton.placeholderImage = nil;
        [imageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [imageButton setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]]];
        [self.contentView addSubview:imageButton];
        
//        EGOImageViewEx *tempImageView = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(i * kScreenWidth/3, 120+KSpace, kScreenWidth/3, 75)];
//        tempImageView.exDelegate = self;
//        tempImageView.tag = KImageTagStart + 3 + i;
//        [tempImageView addRightBottomLine];
//        tempImageView.placeholderImage = nil;
//        tempImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]];
//        [self.contentView addSubview:tempImageView];
//        TT_RELEASE_SAFELY(tempImageView);
    }
}

- (void)addFloor_5 {

    HomeModuleDTO *moduleDTO = [_floorDTO.moduleList safeObjectAtIndex:0];
    EGOImageButton *imageButton = [[EGOImageButton alloc] initWithFrame:CGRectMake(0, 0+KSpace, kScreenWidth, 70)];
    imageButton.tag = KImageTagStart + 0;
    [imageButton addFullLine];
    imageButton.placeholderImage = nil;
    [imageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageButton setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", moduleDTO.bgImg]]];
    [self.contentView addSubview:imageButton];
    
//    EGOImageViewEx *imageView = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(0, 0+KSpace, kScreenWidth, 70)];
//    imageView.exDelegate = self;
//    imageView.tag = KImageTagStart + 0;
//    [imageView addFullLine];
//    imageView.placeholderImage = nil;
//    imageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", moduleDTO.bgImg]];
//    [self.contentView addSubview:imageView];
//    TT_RELEASE_SAFELY(imageView);
}


- (void)addFloor_6 {
    NSArray *moduleList = _floorDTO.moduleList;
    //一行2张图
    for (int i = 0; i < 2; i++) {
        HomeModuleDTO *moduleDTO = [moduleList safeObjectAtIndex:i];
        EGOImageButton *imageButton = [[EGOImageButton alloc] initWithFrame:CGRectMake(i*kScreenWidth/2, 0+KSpace, kScreenWidth/2, 70)];
        imageButton.tag = KImageTagStart + i;
        [imageButton addTopRightBottomLine];
        imageButton.placeholderImage = nil;
        [imageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [imageButton setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", moduleDTO.bgImg]]];
        [self.contentView addSubview:imageButton];
    }
}


- (void)addFloor_7 {
    HomeModuleDTO *moduleDTO = [_floorDTO.moduleList safeObjectAtIndex:0];
    EGOImageButton *imageButton = [[EGOImageButton alloc] initWithFrame:CGRectMake(0, 0+KSpace, kScreenWidth, 120)];
    imageButton.tag = KImageTagStart + 0;
    [imageButton addFullLine];
    imageButton.placeholderImage = nil;
    [imageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageButton setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", moduleDTO.bgImg]]];
    [self.contentView addSubview:imageButton];
    
//    EGOImageViewEx *imageView = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(0, 0+KSpace, kScreenWidth, 120)];
//    imageView.exDelegate = self;
//    imageView.tag = KImageTagStart + 0;
//    [imageView addFullLine];
//    imageView.placeholderImage = nil;
//    imageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", moduleDTO.bgImg]];
//    [self.contentView addSubview:imageView];
//    TT_RELEASE_SAFELY(imageView);
}

- (void)addFloor_8 {
    HomeModuleDTO *moduleDTO = [_floorDTO.moduleList safeObjectAtIndex:0];
    EGOImageButton *imageButton = [[EGOImageButton alloc] initWithFrame:CGRectMake(0, 0+KSpace, kScreenWidth*240/640, 150)];
    imageButton.tag = KImageTagStart + 0;
    [imageButton addTopRightBottomLine];
    imageButton.placeholderImage = nil;
    [imageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageButton setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", moduleDTO.bgImg]]];
    [self.contentView addSubview:imageButton];
    
//    EGOImageViewEx *imageView = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(0, 0+KSpace, kScreenWidth*240/640, 150)];
//    imageView.exDelegate = self;
//    imageView.tag = KImageTagStart + 0;
//    [imageView addTopRightBottonLine];
//    imageView.placeholderImage = nil;
//    imageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", moduleDTO.bgImg]];
//    [self.contentView addSubview:imageView];
//    TT_RELEASE_SAFELY(imageView);
    
    HomeModuleDTO *moduleDTO_1 = [_floorDTO.moduleList safeObjectAtIndex:1];
    EGOImageButton *imageButton_1 = [[EGOImageButton alloc] initWithFrame:CGRectMake(kScreenWidth*240/640, 0+KSpace, kScreenWidth*400/640, 75)];
    imageButton_1.tag = KImageTagStart + 1;
    [imageButton_1 addTopRightBottomLine];
    imageButton_1.placeholderImage = nil;
    [imageButton_1 addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageButton_1 setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", moduleDTO_1.bgImg]]];
    [self.contentView addSubview:imageButton_1];
    
//    EGOImageViewEx *imageView_1 = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(kScreenWidth*240/640, 0+KSpace, kScreenWidth*400/640, 75)];
//    imageView_1.exDelegate = self;
//    imageView_1.tag = KImageTagStart + 1;
//    [imageView_1 addTopRightBottonLine];
//    imageView_1.placeholderImage = nil;
//    imageView_1.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", moduleDTO_1.bgImg]];
//    [self.contentView addSubview:imageView_1];
//    TT_RELEASE_SAFELY(imageView_1);
    
    for (int i = 0; i < 2; i++) {
        HomeModuleDTO *tempDTO = [_floorDTO.moduleList safeObjectAtIndex:2+i];
        EGOImageButton *imageButton = [[EGOImageButton alloc] initWithFrame:CGRectMake(kScreenWidth*240/640 + i * kScreenWidth*200/640, 75+KSpace, kScreenWidth*200/640, 75)];
        imageButton.tag = KImageTagStart + 2 + i;
        [imageButton addRightBottomLine];
        imageButton.placeholderImage = nil;
        [imageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [imageButton setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]]];
        [self.contentView addSubview:imageButton];
        
//        EGOImageViewEx *tempImage = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(kScreenWidth*240/640 + i * kScreenWidth*200/640, 75+KSpace, kScreenWidth*200/640, 75)];
//        tempImage.exDelegate = self;
//        tempImage.tag = KImageTagStart + 2+i;
//        [tempImage addRightBottomLine];
//        tempImage.placeholderImage = nil;
//        tempImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]];
//        [self.contentView addSubview:tempImage];
//        TT_RELEASE_SAFELY(tempImage);
    }
}

- (void)addFloor_9 {
    HomeModuleDTO *moduleDTO = [_floorDTO.moduleList safeObjectAtIndex:0];
    EGOImageButton *imageButton = [[EGOImageButton alloc] initWithFrame:CGRectMake(0, 0+KSpace, kScreenWidth*400/640, 75)];
    imageButton.tag = KImageTagStart + 0;
    [imageButton addTopRightBottomLine];
    imageButton.placeholderImage = nil;
    [imageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageButton setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", moduleDTO.bgImg]]];
    [self.contentView addSubview:imageButton];
    
//    EGOImageViewEx *imageView = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(0, 0+KSpace, kScreenWidth*400/640, 75)];
//    imageView.exDelegate = self;
//    imageView.tag = KImageTagStart + 0;
//    [imageView addTopRightBottonLine];
//    imageView.placeholderImage = nil;
//    imageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", moduleDTO.bgImg]];
//    [self.contentView addSubview:imageView];
//    TT_RELEASE_SAFELY(imageView);
    
    for (int i = 0; i < 2; i++) {
        HomeModuleDTO *tempDTO = [_floorDTO.moduleList safeObjectAtIndex:1+i];
        EGOImageButton *tempImageButton = [[EGOImageButton alloc] initWithFrame:CGRectMake(i * kScreenWidth*200/640, 75+KSpace, kScreenWidth*200/640, 75)];
        tempImageButton.tag = KImageTagStart + 1+i;
        [tempImageButton addRightBottomLine];
        tempImageButton.placeholderImage = nil;
        [tempImageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [tempImageButton setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]]];
        [self.contentView addSubview:tempImageButton];
        
//        EGOImageViewEx *tempImage = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(i * kScreenWidth*200/640, 75+KSpace, kScreenWidth*200/640, 75)];
//        tempImage.exDelegate = self;
//        tempImage.tag = KImageTagStart + 1+i;
//        [tempImage addRightBottomLine];
//        tempImage.placeholderImage = nil;
//        tempImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]];
//        [self.contentView addSubview:tempImage];
//        TT_RELEASE_SAFELY(tempImage);
    }
    
    HomeModuleDTO *moduleDTO_3 = [_floorDTO.moduleList safeObjectAtIndex:3];
    EGOImageButton *imageButton_3 = [[EGOImageButton alloc] initWithFrame:CGRectMake(kScreenWidth*400/640, 0+KSpace, kScreenWidth*240/640, 150)];
    imageButton_3.tag = KImageTagStart + 3;
    [imageButton_3 addTopRightBottomLine];
    imageButton_3.placeholderImage = nil;
    [imageButton_3 addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageButton_3 setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", moduleDTO_3.bgImg]]];
    [self.contentView addSubview:imageButton_3];
    
//    EGOImageViewEx *imageView_3 = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(kScreenWidth*400/640, 0+KSpace, kScreenWidth*240/640, 150)];
//    imageView_3.exDelegate = self;
//    imageView_3.tag = KImageTagStart + 3;
//    [imageView_3 addTopRightBottonLine];
//    imageView_3.placeholderImage = nil;
//    imageView_3.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", moduleDTO_3.bgImg]];
//    [self.contentView addSubview:imageView_3];
//    TT_RELEASE_SAFELY(imageView_3);
}

- (void)addFloor_10 {
    for (int i = 0; i < 4; i++) {
        HomeModuleDTO *tempDTO = [_floorDTO.moduleList safeObjectAtIndex:i];
        EGOImageButton *tempImageButton = [[EGOImageButton alloc] initWithFrame:CGRectMake((i%2) * kScreenWidth*320/640, (i/2)*75+KSpace, kScreenWidth*320/640, 75)];
        tempImageButton.tag = KImageTagStart + i;
        if (i/2 == 0) {
            [tempImageButton addTopRightBottomLine];
        }
        else {
            [tempImageButton addRightBottomLine];
        }
        tempImageButton.placeholderImage = nil;
        [tempImageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [tempImageButton setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]]];
        [self.contentView addSubview:tempImageButton];
        
//        EGOImageViewEx *tempImage = [[EGOImageViewEx alloc] initWithFrame:CGRectMake((i%2) * kScreenWidth*320/640, (i/2)*75+KSpace, kScreenWidth*320/640, 75)];
//        tempImage.exDelegate = self;
//        tempImage.tag = KImageTagStart + i;
//        if (i/2 == 0) {
//            [tempImage addTopRightBottonLine];
//        }
//        else {
//            [tempImage addRightBottomLine];
//        }
//
//        tempImage.placeholderImage = nil;
//        tempImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]];
//        [self.contentView addSubview:tempImage];
//        TT_RELEASE_SAFELY(tempImage);
    }
}

- (void)addFloor_11 {
    HomeModuleDTO *moduleDTO = [_floorDTO.moduleList safeObjectAtIndex:0];
    EGOImageButton *imageButton = [[EGOImageButton alloc] initWithFrame:CGRectMake(0, 0+KSpace, kScreenWidth*320/640, 180)];
    imageButton.tag = KImageTagStart + 0;
    [imageButton addTopRightBottomLine];
    imageButton.placeholderImage = nil;
    [imageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageButton setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", moduleDTO.bgImg]]];
    [self.contentView addSubview:imageButton];
    
//    EGOImageViewEx *imageView = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(0, 0+KSpace, kScreenWidth*320/640, 180)];
//    imageView.exDelegate = self;
//    imageView.tag = KImageTagStart + 0;
//    [imageView addTopRightBottonLine];
//    imageView.placeholderImage = nil;
//    imageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", moduleDTO.bgImg]];
//    [self.contentView addSubview:imageView];
//    TT_RELEASE_SAFELY(imageView);
    
    for (int i = 0; i < 3; i++) {
        HomeModuleDTO *tempDTO = [_floorDTO.moduleList safeObjectAtIndex:i+1];
        EGOImageButton *tempImageButton = [[EGOImageButton alloc] initWithFrame:CGRectMake(kScreenWidth*320/640, i*60+KSpace, kScreenWidth*320/640, 60)];
        tempImageButton.tag = KImageTagStart + 1+i;
        if (i == 0) {
            [tempImageButton addTopRightBottomLine];
        }
        else {
            [tempImageButton addRightBottomLine];
        }
        tempImageButton.placeholderImage = nil;
        [tempImageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [tempImageButton setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]]];
        [self.contentView addSubview:tempImageButton];
        
//        EGOImageViewEx *tempImage = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(kScreenWidth*320/640, i*60+KSpace, kScreenWidth*320/640, 60)];
//        tempImage.exDelegate = self;
//        tempImage.tag = KImageTagStart + 1+i;
//        
//        if (i == 0) {
//            [tempImage addTopRightBottonLine];
//        }
//        else {
//            [tempImage addRightBottomLine];
//        }
//        tempImage.placeholderImage = nil;
//        tempImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]];
//        [self.contentView addSubview:tempImage];
//        TT_RELEASE_SAFELY(tempImage);
    }
}

- (void)addFloor_12 {
    //cell内容是一个scroll，一行显示5ge，可多个
    int imageCount = [_floorDTO.moduleList count];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.backgroundColor = [UIColor clearColor];
    int width = imageCount * kScreenWidth * 150 / 640;
    scrollView.contentSize = CGSizeMake(width > kScreenWidth ? width : kScreenWidth, self.frame.size.height);
    for (int i = 0; i < imageCount; i++) {
        HomeModuleDTO *tempDTO = [_floorDTO.moduleList safeObjectAtIndex:i];
        EGOImageButton *tempImageButton = [[EGOImageButton alloc] initWithFrame:CGRectMake(i*kScreenWidth*150/640, 0+KSpace, kScreenWidth*150/640, 75)];
        tempImageButton.tag = KImageTagStart + i;
        [tempImageButton addRightBottomLine];
        tempImageButton.placeholderImage = nil;
        [tempImageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [tempImageButton setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]]];
        [self.contentView addSubview:tempImageButton];
        
//        EGOImageViewEx *tempImage = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(i*kScreenWidth*150/640, 0+KSpace, kScreenWidth*150/640, 75)];
//        tempImage.exDelegate = self;
//        tempImage.tag = KImageTagStart + i;
//        [tempImage addRightBottomLine];
//        tempImage.placeholderImage = nil;
//        tempImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]];
//        [self.contentView addSubview:tempImage];
//        TT_RELEASE_SAFELY(tempImage);
    }
}

- (void)addFloor_13 {
    //功能区两行
    self.contentView.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < 8; i++) {
        HomeModuleDTO *tempDTO = [_floorDTO.moduleList safeObjectAtIndex:i];
        EGOImageViewEx *tempImage = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(20+(i%4) * kScreenWidth*160/640, 10 + (i/4)*75, 40, 40)];
        tempImage.exDelegate = self;
        tempImage.tag = KImageTagStart + i;
        tempImage.placeholderImage = nil;
        tempImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]];
        [self.contentView addSubview:tempImage];
        TT_RELEASE_SAFELY(tempImage);
        
        //文字
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5+(i%4)*kScreenWidth/4, 50+(i/4)*75, kScreenWidth/4-10, 20)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.textColor = [UIColor colorWithHexString:@"#707070"];
        nameLabel.text = tempDTO.moduleName ? tempDTO.moduleName : @"";
        nameLabel.font = [UIFont fontWithName:@"Arial" size:12.0];
        [self.contentView addSubview:nameLabel];
        TT_RELEASE_SAFELY(nameLabel);
    }
    
    //划线，功能区两行内部不需要分割线了
    //bottom
    for (int i = 1; i < 2; i++) {
        UIImageView *horizonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, i*150-0.5, kScreenWidth, 0.5)];
        horizonImageView.image = [UIImage streImageNamed:@"line.png"];
        [self.contentView addSubview:horizonImageView];
        TT_RELEASE_SAFELY(horizonImageView);
    }
}

- (void)moreBUttonClick {
    NSArray *moduleList = _floorDTO.moduleList;
    if (_delegate && [_delegate respondsToSelector:@selector(selectModuleDTO:)]) {
        [_delegate selectModuleDTO:[moduleList safeObjectAtIndex:0]];
    }
    
    [self addClickEventWithIndex:0];
}

- (void)addFloor_14 {
    //配置module0，也就是显示模块标题
    [self configModule0];
    
    for (int i = 0; i < 10; i++) {
        HomeModuleDTO *tempDTO = [_floorDTO.moduleList safeObjectAtIndex:i+1];
        EGOImageButton *tempImageButton = [[EGOImageButton alloc] initWithFrame:CGRectMake((i%2) * kScreenWidth*320/640, (i/2)*60+KTitleHeight+KSpace, kScreenWidth*320/640, 60)];
        tempImageButton.tag = KImageTagStart + 1 + i;
        [tempImageButton addRightBottomLine];
        tempImageButton.placeholderImage = nil;
        [tempImageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [tempImageButton setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]]];
        [self.contentView addSubview:tempImageButton];
        
//        EGOImageViewEx *tempImage = [[EGOImageViewEx alloc] initWithFrame:CGRectMake((i%2) * kScreenWidth*320/640, (i/2)*60+KTitleHeight+KSpace, kScreenWidth*320/640, 60)];
//        tempImage.exDelegate = self;
//        tempImage.tag = KImageTagStart + 1 + i;
//        [tempImage addRightBottomLine];
//        tempImage.placeholderImage = nil;
//        tempImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]];
//        [self.contentView addSubview:tempImage];
//        TT_RELEASE_SAFELY(tempImage);
    }
}

- (void)addFloor_15 {
    
    [self configModule0];
    
    HomeModuleDTO *tempDTO_1 = [_floorDTO.moduleList safeObjectAtIndex:1];
    EGOImageButton *imageButton = [[EGOImageButton alloc] initWithFrame:CGRectMake(0, KTitleHeight+KSpace, kScreenWidth*320/640, 150)];
    imageButton.tag = KImageTagStart + 1;
    [imageButton addRightBottomLine];
    imageButton.placeholderImage = nil;
    [imageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageButton setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO_1.bgImg]]];
    [self.contentView addSubview:imageButton];
    
//    EGOImageViewEx *tempImage = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(0, KTitleHeight+KSpace, kScreenWidth*320/640, 150)];
//    tempImage.exDelegate = self;
//    tempImage.tag = KImageTagStart + 1;
//    [tempImage addRightBottomLine];
//    tempImage.placeholderImage = nil;
//    tempImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO_1.bgImg]];
//    [self.contentView addSubview:tempImage];
//    //TT_RELEASE_SAFELY(tempImage);
    
    for (int i = 0; i < 2; i++) {
        HomeModuleDTO *tempDTO = [_floorDTO.moduleList safeObjectAtIndex:i+2];
        EGOImageButton *imageButton = [[EGOImageButton alloc] initWithFrame:CGRectMake(kScreenWidth*320/640, i*75+KTitleHeight+KSpace, kScreenWidth*320/640, 75)];
        imageButton.tag = KImageTagStart + 2+i;
        [imageButton addRightBottomLine];
        imageButton.placeholderImage = nil;
        [imageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [imageButton setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]]];
        [self.contentView addSubview:imageButton];
        
//        EGOImageViewEx *tempImage = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(kScreenWidth*320/640, i*75+KTitleHeight+KSpace, kScreenWidth*320/640, 75)];
//        tempImage.exDelegate = self;
//        tempImage.tag = KImageTagStart + 2+i;
//        [tempImage addRightBottomLine];
//        tempImage.placeholderImage = nil;
//        tempImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]];
//        [self.contentView addSubview:tempImage];
//        //TT_RELEASE_SAFELY(tempImage);
    }
}

- (void)addFloor_16 {
    
}

- (void)addFloor_17 {
    
}

- (void)addFloor_18 {
    
    [self configModule0];

    HomeModuleDTO *tempDTO_1 = [_floorDTO.moduleList safeObjectAtIndex:1];
    EGOImageButton *imageButton = [[EGOImageButton alloc] initWithFrame:CGRectMake(0, KTitleHeight+KSpace, kScreenWidth, 75)];
    imageButton.tag = KImageTagStart + 1;
    [imageButton addRightBottomLine];
    imageButton.placeholderImage = nil;
    [imageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageButton setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO_1.bgImg]]];
    [self.contentView addSubview:imageButton];
    
//    EGOImageViewEx *tempImage = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(0, KTitleHeight+KSpace, kScreenWidth, 75)];
//    tempImage.exDelegate = self;
//    tempImage.tag = KImageTagStart + 1;
//    [tempImage addRightBottomLine];
//    tempImage.placeholderImage = nil;
//    tempImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO_1.bgImg]];
//    [self.contentView addSubview:tempImage];
//    TT_RELEASE_SAFELY(tempImage);
    
    HomeModuleDTO *tempDTO_2 = [_floorDTO.moduleList safeObjectAtIndex:2];
    EGOImageButton *imageButton_2 = [[EGOImageButton alloc] initWithFrame:CGRectMake(0, KTitleHeight+75+KSpace, kScreenWidth*320/640, 120)];
    imageButton_2.tag = KImageTagStart + 2;
    [imageButton_2 addRightBottomLine];
    imageButton_2.placeholderImage = nil;
    [imageButton_2 addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageButton_2 setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO_2.bgImg]]];
    [self.contentView addSubview:imageButton_2];
    
//    EGOImageViewEx *tempImage_2 = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(0, KTitleHeight+75+KSpace, kScreenWidth*320/640, 120)];
//    tempImage_2.exDelegate = self;
//    tempImage_2.tag = KImageTagStart + 2;
//    [tempImage_2 addRightBottomLine];
//    tempImage_2.placeholderImage = nil;
//    tempImage_2.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO_2.bgImg]];
//    [self.contentView addSubview:tempImage_2];
//    TT_RELEASE_SAFELY(tempImage_2);
    
    for (int i = 0; i < 2; i++) {
        HomeModuleDTO *tempDTO = [_floorDTO.moduleList safeObjectAtIndex:i+3];
        EGOImageButton *tempImageButton = [[EGOImageButton alloc] initWithFrame:CGRectMake(kScreenWidth*320/640, i*60+KTitleHeight+75+KSpace, kScreenWidth*320/640, 60)];
        tempImageButton.tag = KImageTagStart + 3+i;
        [tempImageButton addRightBottomLine];
        tempImageButton.placeholderImage = nil;
        [tempImageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [tempImageButton setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]]];
        [self.contentView addSubview:tempImageButton];
        
//        EGOImageViewEx *tempImage = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(kScreenWidth*320/640, i*60+KTitleHeight+75+KSpace, kScreenWidth*320/640, 60)];
//        tempImage.exDelegate = self;
//        tempImage.tag = KImageTagStart + 3+i;
//        [tempImage addRightBottomLine];
//        tempImage.placeholderImage = nil;
//        tempImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]];
//        [self.contentView addSubview:tempImage];
//        TT_RELEASE_SAFELY(tempImage);
    }
}

- (void)addFloor_19 {
    
    [self configModule0];
    
    //白色背景
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, KSpace+KTitleHeight, kScreenWidth, 140)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:whiteView];
    
    //底部需要划线
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 140-0.5, kScreenWidth, 0.5)];
    topImageView.image = [UIImage streImageNamed:@"line.png"];
    [whiteView addSubview:topImageView];
    TT_RELEASE_SAFELY(topImageView);
    TT_RELEASE_SAFELY(whiteView);
    
    for (int i = 0; i < 3; i++) {
        HomeModuleDTO *tempDTO = [_floorDTO.moduleList safeObjectAtIndex:i+1];
        EGOImageViewEx *tempImage = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(5+i*kScreenWidth*210/640, KTitleHeight+KSpace+10, kScreenWidth*200/640, 120)];
        tempImage.exDelegate = self;
        tempImage.tag = KImageTagStart + 1+i;
        [tempImage addFullLine];
        tempImage.placeholderImage = nil;
        tempImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]];
        [self.contentView addSubview:tempImage];
        TT_RELEASE_SAFELY(tempImage);
    }
}

- (void)addFloor_20 {
    
    [self configModule0];
    
    HomeModuleDTO *tempDTO_1 = [_floorDTO.moduleList safeObjectAtIndex:1];
    EGOImageButton *tempImageButton_1 = [[EGOImageButton alloc] initWithFrame:CGRectMake(0, KTitleHeight+KSpace, kScreenWidth*400/640, 75)];
    tempImageButton_1.tag = KImageTagStart + 1;
    [tempImageButton_1 addRightBottomLine];
    tempImageButton_1.placeholderImage = nil;
    [tempImageButton_1 addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [tempImageButton_1 setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO_1.bgImg]]];
    [self.contentView addSubview:tempImageButton_1];
    
//    EGOImageViewEx *tempImage_1 = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(0, KTitleHeight+KSpace, kScreenWidth*400/640, 75)];
//    tempImage_1.exDelegate = self;
//    tempImage_1.tag = KImageTagStart + 1;
//    [tempImage_1 addRightBottomLine];
//    tempImage_1.placeholderImage = nil;
//    tempImage_1.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO_1.bgImg]];
//    [self.contentView addSubview:tempImage_1];
//    TT_RELEASE_SAFELY(tempImage_1);
    
    for (int i = 0; i < 2; i++) {
        HomeModuleDTO *tempDTO = [_floorDTO.moduleList safeObjectAtIndex:i+2];
        EGOImageButton *tempImageButton = [[EGOImageButton alloc] initWithFrame:CGRectMake(i*kScreenWidth*200/640, 75+KTitleHeight+KSpace, kScreenWidth*200/640, 75)];
        tempImageButton.tag = KImageTagStart + 2+i;
        [tempImageButton addRightBottomLine];
        tempImageButton.placeholderImage = nil;
        [tempImageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [tempImageButton setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]]];
        [self.contentView addSubview:tempImageButton];
        
//        EGOImageViewEx *tempImage = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(i*kScreenWidth*200/640, 75+KTitleHeight+KSpace, kScreenWidth*200/640, 75)];
//        tempImage.exDelegate = self;
//        tempImage.tag = KImageTagStart + 2+i;
//        [tempImage addRightBottomLine];
//        tempImage.placeholderImage = nil;
//        tempImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]];
//        [self.contentView addSubview:tempImage];
//        TT_RELEASE_SAFELY(tempImage);
    }
    
    HomeModuleDTO *tempDTO_4 = [_floorDTO.moduleList safeObjectAtIndex:4];
    EGOImageButton *tempImageButton_4 = [[EGOImageButton alloc] initWithFrame:CGRectMake(kScreenWidth*400/640, KTitleHeight+KSpace, kScreenWidth*240/640, 150)];
    tempImageButton_4.tag = KImageTagStart + 4;
    [tempImageButton_4 addRightBottomLine];
    tempImageButton_4.placeholderImage = nil;
    [tempImageButton_4 addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [tempImageButton_4 setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO_4.bgImg]]];
    [self.contentView addSubview:tempImageButton_4];
    
//    EGOImageViewEx *tempImage_4 = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(kScreenWidth*400/640, KTitleHeight+KSpace, kScreenWidth*240/640, 150)];
//    tempImage_4.exDelegate = self;
//    tempImage_4.tag = KImageTagStart + 4;
//    [tempImage_4 addRightBottomLine];
//    tempImage_4.placeholderImage = nil;
//    tempImage_4.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO_4.bgImg]];
//    [self.contentView addSubview:tempImage_4];
//    TT_RELEASE_SAFELY(tempImage_4);
}

- (void)addFloor_21 {
    
    [self configModule0];
    
    HomeModuleDTO *tempDTO_1 = [_floorDTO.moduleList safeObjectAtIndex:1];
    EGOImageButton *tempImageButton_1 = [[EGOImageButton alloc] initWithFrame:CGRectMake(0, KTitleHeight+KSpace, kScreenWidth*240/640, 150)];
    tempImageButton_1.tag = KImageTagStart + 1;
    [tempImageButton_1 addRightBottomLine];
    tempImageButton_1.placeholderImage = nil;
    [tempImageButton_1 addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [tempImageButton_1 setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO_1.bgImg]]];
    [self.contentView addSubview:tempImageButton_1];
    
//    EGOImageViewEx *tempImage_1 = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(0, KTitleHeight+KSpace, kScreenWidth*240/640, 150)];
//    tempImage_1.exDelegate = self;
//    tempImage_1.tag = KImageTagStart + 1;
//    [tempImage_1 addRightBottomLine];
//    tempImage_1.placeholderImage = nil;
//    tempImage_1.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO_1.bgImg]];
//    [self.contentView addSubview:tempImage_1];
//    TT_RELEASE_SAFELY(tempImage_1);
    
    HomeModuleDTO *tempDTO_2 = [_floorDTO.moduleList safeObjectAtIndex:2];
    EGOImageButton *tempImageButton_2 = [[EGOImageButton alloc] initWithFrame:CGRectMake(kScreenWidth*240/640, KTitleHeight+KSpace, kScreenWidth*400/640, 75)];
    tempImageButton_2.tag = KImageTagStart + 2;
    [tempImageButton_2 addRightBottomLine];
    tempImageButton_2.placeholderImage = nil;
    [tempImageButton_2 addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [tempImageButton_2 setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO_2.bgImg]]];
    [self.contentView addSubview:tempImageButton_2];
    
//    EGOImageViewEx *tempImage_2 = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(kScreenWidth*240/640, KTitleHeight+KSpace, kScreenWidth*400/640, 75)];
//    tempImage_2.exDelegate = self;
//    tempImage_2.tag = KImageTagStart + 2;
//    [tempImage_2 addRightBottomLine];
//    tempImage_2.placeholderImage = nil;
//    tempImage_2.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO_2.bgImg]];
//    [self.contentView addSubview:tempImage_2];
//    TT_RELEASE_SAFELY(tempImage_2);
    
    for (int i = 0; i < 2; i++) {
        HomeModuleDTO *tempDTO = [_floorDTO.moduleList safeObjectAtIndex:i+3];
        EGOImageButton *tempImageButton = [[EGOImageButton alloc] initWithFrame:CGRectMake(i*kScreenWidth*200/640+kScreenWidth*240/640, 75+KTitleHeight+KSpace, kScreenWidth*200/640, 75)];
        tempImageButton.tag = KImageTagStart + 3+i;
        [tempImageButton addRightBottomLine];
        tempImageButton.placeholderImage = nil;
        [tempImageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [tempImageButton setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]]];
        [self.contentView addSubview:tempImageButton];
        
//        EGOImageViewEx *tempImage = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(i*kScreenWidth*200/640+kScreenWidth*240/640, 75+KTitleHeight+KSpace, kScreenWidth*200/640, 75)];
//        tempImage.exDelegate = self;
//        tempImage.tag = KImageTagStart + 3+i;
//        [tempImage addRightBottomLine];
//        tempImage.placeholderImage = nil;
//        tempImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]];
//        [self.contentView addSubview:tempImage];
//        TT_RELEASE_SAFELY(tempImage);
    }
}

- (void)addFloor_22 {
    
    [self configModule0];

    HomeModuleDTO *moduleDTO_1 = [_floorDTO.moduleList safeObjectAtIndex:1];
    EGOImageButton *tempImageButton_1 = [[EGOImageButton alloc] initWithFrame:CGRectMake(0, KTitleHeight+KSpace, kScreenWidth/2, 120)];
    tempImageButton_1.tag = KImageTagStart + 1;
    [tempImageButton_1 addRightBottomLine];
    tempImageButton_1.placeholderImage = nil;
    [tempImageButton_1 addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [tempImageButton_1 setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", moduleDTO_1.bgImg]]];
    [self.contentView addSubview:tempImageButton_1];
    
//    EGOImageViewEx *imageView_1 = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(0, KTitleHeight+KSpace, kScreenWidth/2, 120)];
//    imageView_1.exDelegate = self;
//    imageView_1.tag = KImageTagStart + 1;
//    [imageView_1 addRightBottomLine];
//    imageView_1.placeholderImage = nil;
//    imageView_1.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", moduleDTO_1.bgImg]];
//    [self.contentView addSubview:imageView_1];
//    TT_RELEASE_SAFELY(imageView_1);
    
    for (int i = 0; i < 2; i++) {
        HomeModuleDTO *tempDTO = [_floorDTO.moduleList safeObjectAtIndex:2+i];
        EGOImageButton *tempImageButton = [[EGOImageButton alloc] initWithFrame:CGRectMake(kScreenWidth/2, 60*i+KTitleHeight+KSpace, kScreenWidth/2, 60)];
        tempImageButton.tag = KImageTagStart + 2+i;
        [tempImageButton addRightBottomLine];
        tempImageButton.placeholderImage = nil;
        [tempImageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [tempImageButton setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]]];
        [self.contentView addSubview:tempImageButton];
        
//        EGOImageViewEx *tempImageView = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(kScreenWidth/2, 60*i+KTitleHeight+KSpace, kScreenWidth/2, 60)];
//        tempImageView.exDelegate = self;
//        tempImageView.tag = KImageTagStart + 2+i;
//        [tempImageView addRightBottomLine];
//        tempImageView.placeholderImage = nil;
//        tempImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]];
//        [self.contentView addSubview:tempImageView];
//        TT_RELEASE_SAFELY(tempImageView);
    }
    
    for (int i = 0; i < 3; i++) {
        HomeModuleDTO *tempDTO = [_floorDTO.moduleList safeObjectAtIndex:4+i];
        EGOImageButton *tempImageButton = [[EGOImageButton alloc] initWithFrame:CGRectMake(i * kScreenWidth/3, 120+KTitleHeight+KSpace, kScreenWidth/3, 75)];
        tempImageButton.tag = KImageTagStart + 4+i;
        [tempImageButton addRightBottomLine];
        tempImageButton.placeholderImage = nil;
        [tempImageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [tempImageButton setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]]];
        [self.contentView addSubview:tempImageButton];
        
//        EGOImageViewEx *tempImageView = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(i * kScreenWidth/3, 120+KTitleHeight+KSpace, kScreenWidth/3, 75)];
//        tempImageView.exDelegate = self;
//        tempImageView.tag = KImageTagStart + 4+i;
//        [tempImageView addRightBottomLine];
//        tempImageView.placeholderImage = nil;
//        tempImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", tempDTO.bgImg]];
//        [self.contentView addSubview:tempImageView];
//        TT_RELEASE_SAFELY(tempImageView);
    }
}

/**
 *  配置模块标题
 *
 */
- (void)configModule0 {
    //顶需要画一条横线
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, KSpace-0.5, self.frame.size.width, 0.5)];
    topImageView.image = [UIImage streImageNamed:@"line.png"];
    [self.contentView addSubview:topImageView];
    TT_RELEASE_SAFELY(topImageView);
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenHeight, KSpace)];
    grayView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:grayView];
    TT_RELEASE_SAFELY(grayView);
    
    HomeModuleDTO *moduleDTO_0 = [_floorDTO.moduleList safeObjectAtIndex:0];
    
    if (!IsStrEmpty(moduleDTO_0.bgColor) || !IsStrEmpty(moduleDTO_0.moduleName)) {
        //显示背景色和文字
        UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0+KSpace, kScreenWidth, KTitleHeight)];
        if (!IsStrEmpty(moduleDTO_0.bgColor)) {
            tempView.backgroundColor = [UIColor colorWithHexString:moduleDTO_0.bgColor];
        }
        else {
            tempView.backgroundColor = [UIColor whiteColor];
        }
        [self.contentView addSubview:tempView];
        TT_RELEASE_SAFELY(tempView);
        
        UILabel *titleName = [[UILabel alloc] initWithFrame:CGRectMake(12, 0+KSpace, kScreenWidth-60, KTitleHeight)];
        titleName.backgroundColor = [UIColor clearColor];
        titleName.lineBreakMode = UILineBreakModeClip;
        titleName.textAlignment = NSTextAlignmentLeft;
        titleName.textColor = [UIColor colorWithHexString:@"#313131"];
        titleName.font = [UIFont fontWithName:@"Arial" size:17.0];
        titleName.text = NotNilAndNull(moduleDTO_0.moduleName) ? moduleDTO_0.moduleName : @"";
        [self.contentView addSubview:titleName];
        TT_RELEASE_SAFELY(titleName);

    }
    else {
        //显示背景图片
//        self.contentView.backgroundColor = [UIColor clearColor];
        
        EGOImageView *titleBGImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(0, 0+KSpace, kScreenWidth, KTitleHeight)];
        titleBGImageView.backgroundColor = [UIColor clearColor];
        [titleBGImageView addRightBottomLine];
        titleBGImageView.placeholderImage = nil;
        titleBGImageView.imageURL = [NSURL URLWithString:moduleDTO_0.bgImg];
        [self.contentView addSubview:titleBGImageView];
        TT_RELEASE_SAFELY(titleBGImageView);
    }
    
    
    if (!IsStrEmpty(moduleDTO_0.targetURL)) {
        UIButton *moreButton = [[UIButton alloc] initWithFrame:CGRectMake(265, 5+KSpace, 50, KTitleHeight-5)];
        [moreButton addTarget:self action:@selector(moreBUttonClick) forControlEvents:UIControlEventTouchUpInside];
        [moreButton setTitle:L(@"BTMore") forState:UIControlStateNormal];
        [moreButton setTitleColor:[UIColor colorWithHexString:@"#FC7C26"] forState:UIControlStateNormal];
        moreButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:17.0];
        [self.contentView addSubview:moreButton];
        
    }
    
    //底部需要画一条横线
    UIImageView *horizonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, KSpace+KTitleHeight-0.5, self.frame.size.width, 0.5)];
    horizonImageView.image = [UIImage streImageNamed:@"line.png"];
    [self.contentView addSubview:horizonImageView];
    TT_RELEASE_SAFELY(horizonImageView);
}

- (void)imageExViewDidOk:(EGOImageViewEx *)imageViewEx {
    NSArray *moduleList = _floorDTO.moduleList;
    int flag = imageViewEx.tag - KImageTagStart;
    if (_delegate && [_delegate respondsToSelector:@selector(selectModuleDTO:)]) {
        [_delegate selectModuleDTO:[moduleList safeObjectAtIndex:flag]];
    }
    
    [self addClickEventWithIndex:flag];
}

- (void)imageButtonClick:(id)sender {
    EGOImageButton *tempButton = (EGOImageButton *)sender;
    
    NSArray *moduleList = _floorDTO.moduleList;
    int flag = tempButton.tag - KImageTagStart;
    
    [self addClickEventWithIndex:flag];
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(selectModuleDTO:)]) {
        [_delegate selectModuleDTO:[moduleList safeObjectAtIndex:flag]];
    }
}

- (void)addClickEventWithIndex:(int)index {
    //添加点击埋点
    NSString *floorIDString = [[GlobalDataCenter defaultCenter].floorID_TypeDict objectForKey:_floorDTO.templateID];
    int floorType = -1;
    if (NotNilAndNull(floorIDString)) {
        floorType = [floorIDString intValue];
    }
    
    switch (floorType) {
        case 2: {
            //功能区一行
//            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",1120109 + index], nil]];
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"112%02d%03d",[_floorDTO.orderNO intValue], 9+index], nil]];
            break;
        }
        case 3: {
            //一行3个，大聚会楼层
//            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",1120122 + index], nil]];
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"112%02d%03d",[_floorDTO.orderNO intValue], 22+index], nil]];
            break;
        }
        case 4: {
            //左1右2下3
//            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",1120125 + index], nil]];
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"112%02d%03d",[_floorDTO.orderNO intValue], 25+index], nil]];
            break;
        }
        case 5: {
            //一行一个小
//            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"1120131"], nil]];
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"112%02d%03d",[_floorDTO.orderNO intValue], 31+index], nil]];
            break;
        }
        case 6: {
            //一行2个
//            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",1120132 + index], nil]];
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"112%02d%03d",[_floorDTO.orderNO intValue], 32+index], nil]];
            break;
        }
        case 7: {
            //一行一个大
//            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"1120134"], nil]];
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"112%02d%03d",[_floorDTO.orderNO intValue], 34+index], nil]];
            break;
        }
        case 8: {
//            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",1120135 + index], nil]];
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"112%02d%03d",[_floorDTO.orderNO intValue], 35+index], nil]];
            break;
        }
        case 9: {
//            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",1120139 + index], nil]];
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"112%02d%03d",[_floorDTO.orderNO intValue], 39+index], nil]];
            break;
        }
        case 10: {
            //4个平分
//            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",1120143 + index], nil]];
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"112%02d%03d",[_floorDTO.orderNO intValue], 43+index], nil]];
            break;
        }
        case 11: {
            //左1右3
//            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",1120147 + index], nil]];
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"112%02d%03d",[_floorDTO.orderNO intValue], 47+index], nil]];
            
            break;
        }
        case 13: {
            //功能区两行
//            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",1120114 + index], nil]];
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"112%02d%03d",[_floorDTO.orderNO intValue], 14+index], nil]];
            break;
        }
        case 14: {
            //频道、品类
//            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",1120166 + index], nil]];
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"112%02d%03d",[_floorDTO.orderNO intValue], 66+index], nil]];
            break;
        }
        case 15: {
            //左1右2带标题
//            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",1120177 + index], nil]];
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"112%02d%03d",[_floorDTO.orderNO intValue], 77+index], nil]];
            break;
        }
//        case 16: {
//            //推荐店铺
//            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",1120181 + index], nil]];
//            break;
//        }
//        case 17: {
//            //品牌推荐
//            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",1120194 + index], nil]];
//            break;
//        }
        case 18: {
            //上1左1右二带标题
//            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",11201119 + index], nil]];
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"112%02d%03d",[_floorDTO.orderNO intValue], 119+index], nil]];
            
            break;
        }
        case 19: {
            //推荐商品
//            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",11201124 + index], nil]];
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"112%02d%03d",[_floorDTO.orderNO intValue], 124+index], nil]];
            break;
        }
        case 20: {
            //左1下2右1带标题
//            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",11201128 + index], nil]];
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"112%02d%03d",[_floorDTO.orderNO intValue], 128+index], nil]];
            break;
        }
        case 21: {
            //左1右1下2带标题
//            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",11201133 + index], nil]];
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"112%02d%03d",[_floorDTO.orderNO intValue], 133+index], nil]];
            break;
        }
        case 22: {
            //左1右2下3带标题
//            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",11201138 + index], nil]];
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray:[NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"112%02d%03d",[_floorDTO.orderNO intValue], 138+index], nil]];
            break;
        }
        default:
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

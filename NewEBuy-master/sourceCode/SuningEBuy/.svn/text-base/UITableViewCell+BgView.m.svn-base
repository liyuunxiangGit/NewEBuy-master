//
//  UITableViewCell+BgView.m
//  SuningEBuy
//
//  Created by 孔斌 on 13-9-24.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "UITableViewCell+BgView.h"
#import "SNGraphics.h"
#import "SNCache.h"

@implementation UITableViewCell (BgView)

- (UIImage *)imageAtPosition:(CellPosition)pos hasLine:(BOOL)hasLine
{
    NSString *cacheKey = [NSString stringWithFormat:@"CellPosition_%d_%d", pos, hasLine];
    
    UIImage *image = [[SNMemoryCache defaultCache] objectForKey:cacheKey];
    
    if (image && [image isKindOfClass:[UIImage class]])
    {
        return image;
    }
    
    switch (pos) {
        case CellPositionSingle:
        {
            image = [UIImage streImageNamed:@"G_cell_bg_single.png"];
            break;
        }
        case CellPositionTop:
        {
            image = [UIImage streImageNamed:@"G_cell_bg_top.png"];
            break;
        }
        case CellPositionCenter:
        {
            if (hasLine)
            {
                image = [UIImage streImageNamed:@"G_cell_bg_center_hasline.png"];
            }
            else
            {
                image = [UIImage streImageNamed:@"G_cell_bg_center.png"];
            }
            break;
        }
        case CellPositionBottom:
        {
            if (hasLine) {
                image = [UIImage streImageNamed:@"G_cell_bg_bottom_hasline.png"];
            }else{
                image = [UIImage streImageNamed:@"G_cell_bg_bottom.png"];
            }
            break;
        }
        default:
            break;
    }
    
    if (image) {
        [[SNMemoryCache defaultCache] saveObject:image forKey:cacheKey];
    }
    
    return image;
}

- (void)setCoolBgViewWithCellPosition:(CellPosition)position
{
    if (IOS7_OR_LATER) {
        return;
    }
    
    UIImageView *bgImageView = (UIImageView *)self.backgroundView;
    
    if (bgImageView && [bgImageView isKindOfClass:[UIImageView class]])
    {
        
    }
    else
    {
        bgImageView = [[UIImageView alloc] init];
        self.backgroundView = bgImageView;
    }
    
//    bgImageView.image = [SNGraphics cellBgWithCellPosition:position
//                                                     color:RGBCOLOR(250, 247, 237)
//                                              cornerRadius:5];
    
    bgImageView.image = [self imageAtPosition:position hasLine:YES];
}

- (void)setCoolBgViewWithCellPosition:(CellPosition)position hasLine:(BOOL)hasLine
{
    if (IOS7_OR_LATER) {
        return;
    }
    UIImageView *bgImageView = (UIImageView *)self.backgroundView;
    
    if (bgImageView && [bgImageView isKindOfClass:[UIImageView class]])
    {
        
    }
    else
    {
        bgImageView = [[UIImageView alloc] init];
        self.backgroundView = bgImageView;
    }
    
    bgImageView.image = [self imageAtPosition:position hasLine:hasLine];
    
}

//- (void)setCoolBgViewWithCellPosition:(CellPosition)position color:(UIColor *)color
//{
//    UIImageView *bgImageView = (UIImageView *)self.backgroundView;
//    
//    if (bgImageView && [bgImageView isKindOfClass:[UIImageView class]])
//    {
//        
//    }
//    else
//    {
//        bgImageView = [[UIImageView alloc] init];
//        self.backgroundView = bgImageView;
//    }
//    
//    bgImageView.image = [SNGraphics cellBgWithCellPosition:position
//                                                     color:color
//                                              cornerRadius:5];
//}


@end

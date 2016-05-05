//
//  SearchListTopView.m
//  SuningEBuy
//
//  Created by chupeng on 14-7-21.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SearchListTopView.h"
#import "SearchListViewController.h"
@implementation SearchListTopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
        _State = SEGMENTVIEW;
    }
    return self;
}

- (void)setState:(int)State
{
    _State = State;
    
    switch (State) {
        case NOVIEW:
        {
            self.height = 0;
            break;
        }
        case SEGMENTVIEW:
        {
            self.height = 40;
            break;
        }
        case CATALOG_SEGMENTVIEW:
        {
            if (self.catalogArray.count <= 4 && self.catalogArray.count > 0)
                self.height = 54 + 40;
            else if (self.catalogArray.count == 0)
                self.height = 40;
            else
                self.height = 93 + 40;
            break;
        }
        case BRAND_SEGMENTVIEW:
        {
            self.height = 115;
            break;
        }
        case BRAND_CATALOG_SEGMENTVIEW:
        {
            if (self.catalogArray.count <= 4)
                self.height = 75 + 54 + 40;
            else if (self.catalogArray.count == 0)
                self.height = 75 + 40;
            else
                self.height = 75 + 93 + 40;
            break;
        }
        default:
            break;
    }
    [self.tableView reloadData];
}

- (void)setCatalogArray:(NSMutableArray *)catalogArray
{
    if (_catalogArray != catalogArray)
    {
        _catalogArray = catalogArray;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_State) {
        case SEGMENTVIEW:
        {
            return 40;
            
        }
        case CATALOG_SEGMENTVIEW:
        {
            if (indexPath.row == 0 && self.catalogArray.count > 4) {
                return 93;
            }
            else if (indexPath.row == 0 && self.catalogArray.count <= 4)
            {
                return 24 + 30;
            }
            else if (indexPath.row == 1)
            {
                return 40;
            }
            
        }
        case BRAND_SEGMENTVIEW:
        {
            if (indexPath.row == 0) {
                return 75;
            }
            else if (indexPath.row == 1)
            {
                return 40;
            }
            
        }
        case BRAND_CATALOG_SEGMENTVIEW:
        {
            if (indexPath.row == 0) {
                return 75;
            }
            else if (indexPath.row == 1 && self.catalogArray.count > 4)
            {
                return 93;
            }
            else if (indexPath.row == 1 && self.catalogArray.count <= 4)
            {
                return 24 + 30;
            }
            else if (indexPath.row == 2)
            {
                return 40;
            }
            
        }
        default:
            break;
    }
    
    return 0.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (_State) {
        case SEGMENTVIEW:
        {
            return 1;
            
        }
        case CATALOG_SEGMENTVIEW:
        {
            return 2;
           
        }
        case BRAND_SEGMENTVIEW:
        {
            return 2;
           
        }
        case BRAND_CATALOG_SEGMENTVIEW:
        {
            return 3;
            
        }
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_State) {
        case SEGMENTVIEW:
        {
            return [self getSegmentCell:indexPath];
        }
        case CATALOG_SEGMENTVIEW:
        {
            if (0 == indexPath.row)
            {
                return [self getCatalogCell:indexPath];
            }
            else if (1 == indexPath.row)
            {
                return [self getSegmentCell:indexPath];
            }
        }
        case BRAND_SEGMENTVIEW:
        {
            if (0 == indexPath.row)
            {
                return [self getBrandShopCell:indexPath];
            }
            else if (1 == indexPath.row)
            {
                return [self getSegmentCell:indexPath];
            }
        }
        case BRAND_CATALOG_SEGMENTVIEW:
        {
            if (0 == indexPath.row)
            {
                return [self getBrandShopCell:indexPath];
            }
            else if (1 == indexPath.row)
            {
                return [self getCatalogCell:indexPath];
            }
            else if (2 == indexPath.row)
            {
                return [self getSegmentCell:indexPath];
            }
        }
        default:
            break;
    }
    
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
}

- (UITableViewCell *)getSegmentCell:(NSIndexPath *)indexPath
{
    static NSString *strSegment = @"segment";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:strSegment];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strSegment];
        
        [cell addSubview:self.searchSegmentView];
    }
    
    return cell;
}

- (UITableViewCell *)getCatalogCell:(NSIndexPath *)indexPath
{
    static NSString *strCatalog = @"catalog";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:strCatalog];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCatalog];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    }
    
    [cell.contentView removeAllSubviews];
    
    int x = 19, y = 15;
    for (int i = 0; i < self.catalogArray.count; i++)
    {
        SugDirDTO *dto = (SugDirDTO *)[self.catalogArray objectAtIndex:i];
        
        NSString *name = dto.dirName;
        
        CGSize szStr = [name sizeWithFont:[UIFont systemFontOfSize:12]];
        if (szStr.width > 50)
        {
            name = [name substringToIndex:4];
            name = [name stringByAppendingString:@"..."];
        }
        
//        CGSize sz = [name sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(50, 13)];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, 63, 24)];
        btn.tag = 100 + i;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12.0];
        btn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [btn setTitle:name forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage streImageNamed:@"searchList_catalogs.png" capX:13.0 capY:20.0] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage streImageNamed:@"searchList_catalogsHot.png" capX:13.0 capY:20.0] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage streImageNamed:@"searchList_catalogsHot.png" capX:13.0 capY:20.0] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        if ([dto.dirId isEqualToString:self.strSelected])
        {
            [btn setSelected:YES];
        }
        [btn addTarget:self action:@selector(btnHotWordTapped:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btn];
        
        x += btn.width + 10;
        
        if (x >= 260)
        {
            x = 15;
            y += 39;
        }
        
        if (y > 55)
            break;
    }

    CGRect rc = [self.tableView rectForRowAtIndexPath:indexPath];
    UIImageView *vSep = [[UIImageView alloc] initWithFrame:CGRectMake(0, rc.size.height - 0.5, 320, 0.5) ];
    vSep.image = [UIImage imageNamed:@"line"];
    
    [cell.contentView addSubview:vSep];
    
    return cell;
}

-(void)setHidden:(BOOL)hidden
{
    [super setHidden:hidden];
    
//    if (hidden == YES)
//    {
//        self.strSelected = @"";
//    }
}

-(void)btnHotWordTapped:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    int index = btn.tag - 100;
    
    
    [self.tableView reloadData];

    if (index >= 0 && index < self.catalogArray.count)
    {
        SugDirDTO *dto = (SugDirDTO *)[self.catalogArray objectAtIndex:index];
        
        if ([self.delegate respondsToSelector:@selector(usualCatalogTapped:)])
        {
            [self.delegate usualCatalogTapped:dto.dirId];
            
            self.strSelected = dto.dirId;
            
            int i = 820602;
            i += index;
            NSString *str = [NSString stringWithFormat:@"%d", i];
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:str, nil]];
        }
    }
}

- (UITableViewCell *)getBrandShopCell:(NSIndexPath *)indexPath
{
    static NSString *strBrandShop = @"brandshop";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:strBrandShop];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strBrandShop];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //图片view
        CGRect productFrame =  CGRectMake(10, 10, 55, 55);
        EGOImageView *shopImgView = [[EGOImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
        shopImgView.backgroundColor = [UIColor whiteColor];
        shopImgView.contentMode = UIViewContentModeScaleAspectFit;
        shopImgView.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
        shopImgView.tag = 1000;
        
        //图片边框
        UIView *suppImageView = [[UIView alloc] initWithFrame:productFrame];
        suppImageView.backgroundColor = [UIColor clearColor];
        suppImageView.layer.borderWidth = 0.5;
        suppImageView.layer.borderColor = [UIColor colorWithRGBHex:0xdcdcdc].CGColor;
        [suppImageView addSubview:shopImgView];
        suppImageView.tag = 100;
        
        //店铺名称
        UILabel *shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(suppImageView.right + 15, 12, 210, 15)];
        shopNameLabel.textColor = [UIColor blackColor];
        shopNameLabel.backgroundColor = [UIColor clearColor];
        shopNameLabel.font = [UIFont systemFontOfSize:14.0];
        shopNameLabel.tag = 101;
        
        //店铺描述
        UILabel *shopDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(suppImageView.right + 15,shopNameLabel.bottom + 5, 210, 35)];
        shopDescLabel.numberOfLines = 2;
        shopDescLabel.backgroundColor = [UIColor clearColor];
        shopDescLabel.textColor = RGBCOLOR(194, 194, 194);
        shopDescLabel.font = [UIFont systemFontOfSize:13.0];
        shopDescLabel.tag = 102;
        
        [cell.contentView addSubview:suppImageView];
        [cell.contentView addSubview:shopNameLabel];
        [cell.contentView addSubview:shopDescLabel];
        
        
        UIImageView *vSep = [[UIImageView alloc] initWithFrame:CGRectMake(0, 74.5, 320, 0.5) ];
        vSep.image = [UIImage imageNamed:@"line"];
        
        [cell.contentView addSubview:vSep];
    }
    
    UIView *vSupp = [cell viewWithTag:100];
    EGOImageView *shopImage = (EGOImageView *)[vSupp viewWithTag:1000];
    if (shopImage)
    {
        shopImage.imageURL = [NSURL URLWithString:self.brandShopDto.brandImage];
    }
    
    UILabel *labelName = (UILabel *)[cell viewWithTag:101];
    if (labelName)
    {
        labelName.text = self.brandShopDto.brandName;
    }
    
    UILabel *labelDesc = (UILabel *)[cell viewWithTag:102];
    if (labelDesc)
    {

        labelDesc.text = self.brandShopDto.descriptions;

    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (_State) {
        case BRAND_SEGMENTVIEW:
        {
            if (indexPath.row == 0)
            {
                if ([self.delegate respondsToSelector:@selector(brandShopTapped:)])
                {
                    [self.delegate brandShopTapped:self.brandShopDto.url];
                }
            }
            break;
        }
        case BRAND_CATALOG_SEGMENTVIEW:
        {
            if (indexPath.row == 0)
            {
                if ([self.delegate respondsToSelector:@selector(brandShopTapped:)])
                {
                    [self.delegate brandShopTapped:self.brandShopDto.url];
                }
            }
            
            break;
        }
        default:
            break;
    }
}


@end

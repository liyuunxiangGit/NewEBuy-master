//
//  ShopCartShopContainerView.m
//  SuningEBuy
//
//  Created by  liukun on 13-10-16.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ShopCartShopContainerView.h"
#import "ShopCartV2ViewController.h"
#import "UITableViewCell+BgView.h"

@implementation ShopCartShopContainerView

- (id)init
{
    self = [super initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    if (self) {
        
        [self setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
		[self setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		self.scrollEnabled = NO;
		self.userInteractionEnabled = YES;
		self.delegate = self;
		self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
//		self.backgroundColor = RGBCOLOR(230, 226, 213);
        self.backgroundView = nil;
    }
    return self;
}

#pragma mark ----------------------------- set shop DTO

- (void)setShopDTO:(ShopCartShopDTO *)shopDTO
{
    if (_shopDTO != shopDTO) {
        _shopDTO = shopDTO;
    }
    
    CGFloat height = [ShopCartShopContainerView height:shopDTO];
    self.frame = CGRectMake(0, 0, 320, height);
    
    [self reloadData];
}

#pragma mark ----------------------------- table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.shopDTO.itemList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self getSectionRowCount:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ShopCartItemCell height:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 7;
    }else{
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int section = indexPath.section;
    int row = indexPath.row;
    
    static NSString *iden = @"itemCell";
    ShopCartItemCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil)
    {
        cell = [[ShopCartItemCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:iden];
        cell.delegate = self;
    }
    
    int rowCount = [self getSectionRowCount:indexPath.section];
    [cell setCoolBgViewWithCellPosition:CellPositionMake(rowCount, indexPath.row)];
    
    ShopCartV2DTO *dto = [self.shopDTO.itemList objectAtIndex:section];
    
    if (row == 0)
    {
        cell.item = dto;
    }
    else
    {
        switch (dto.packageType) {
            case PackageTypeAccessory:
            {
                if ([dto.accessoryPackageList count] > row-1)
                {
                    ShopCartV2DTO *innerDto = [dto.accessoryPackageList objectAtIndex:row-1];
                    cell.item = innerDto;
                }
                else
                {
                    [cell setItem:dto isAccessoryLastCell:YES];
                }
                
                break;
            }
            case PackageTypeSmall:
            {
                ShopCartV2DTO *innerDto = [dto.smallPackageList objectAtIndex:row-1];
                cell.item = innerDto;
                
                
                break;
            }
            case PackageTypeXn:
            {
                ShopCartV2DTO *innerDto = [dto.xnPackageList objectAtIndex:row-1];
                cell.item = innerDto;
                break;
            }
            default:
                break;
        }
    }
    return cell;

}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


- (NSInteger)getSectionRowCount:(NSInteger)section
{
    if (self.shopDTO.itemList.count <= section)
    {
        return 0;
    }
    
    ShopCartV2DTO *dto  = [self.shopDTO.itemList objectAtIndex:section];
    NSInteger row = 0;
    switch (dto.packageType) {
        case PackageTypeNormal:
        {
            row = 1;
            break;
        }
        case PackageTypeAccessory:
        {
            row = [dto.accessoryPackageList count]+2;
            break;
        }
        case PackageTypeSmall:
        {
            row = [dto.smallPackageList count]+1;
            break;
        }
        case PackageTypeXn:
        {
            row = [dto.xnPackageList count]+1;
            break;
        }
        default:
            break;
    }
    
    return row;
}

- (ShopCartV2DTO *)itemDataAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.shopDTO.itemList.count > indexPath.section)
    {
        ShopCartV2DTO *dto  = [self.shopDTO.itemList objectAtIndex:indexPath.section];
        
        NSInteger row = indexPath.row;
        if (row == 0)
        {
            return dto;
        }
        else
        {
            switch (dto.packageType) {
                case PackageTypeAccessory:
                {
                    if ([dto.accessoryPackageList count] > indexPath.row-1)
                        dto = [dto.accessoryPackageList objectAtIndex:indexPath.row-1];
                    else
                        dto = nil;
                    break;
                }
                case PackageTypeSmall:
                {
                    if ([dto.smallPackageList count] > indexPath.row-1) {
                        dto = [dto.smallPackageList objectAtIndex:indexPath.row-1];
                    }else{
                        dto = nil;
                    }
                    break;
                }
                case PackageTypeXn:
                {
                    if ([dto.smallPackageList count] > indexPath.row-1) {
                        dto = [dto.xnPackageList objectAtIndex:indexPath.row-1];
                    }else{
                        dto = nil;
                    }
                    break;
                }
                default:
                {
                    dto = nil;
                    break;
                }
            }
            
            return dto;
        }
    }
    
    return nil;
}

#pragma mark -
#pragma mark 滑动删除

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCartV2DTO *item = [self itemDataAtIndexPath:indexPath];
    
    return item?YES:NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ShopCartV2DTO *item = [self itemDataAtIndexPath:indexPath];
    
    if (item)
    {
        ShopCartV2ViewController *shopCart = [ShopCartV2ViewController sharedShopCart];
        
        [shopCart goToProductWithItem:item];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        ShopCartV2ViewController *shopCart = [ShopCartV2ViewController sharedShopCart];

        NSInteger row = indexPath.row;
        NSInteger section = indexPath.section;
        
        ShopCartV2DTO *cartItem = [self.shopDTO.itemList objectAtIndex:section];
        if (row == 0) //说明是主商品
        {
            [self.shopDTO.itemList removeObject:cartItem];
            if (self.shopDTO.itemList.count == 0)
            {
                [shopCart.logic.shopCartList removeObject:self.shopDTO];
                
                [shopCart refreshShopCartView];
                
                [shopCart syncShopCart];
            }
            else
            {
//                [tableView deleteSections:[NSIndexSet indexSetWithIndex:section]
//                         withRowAnimation:UITableViewRowAnimationAutomatic];
                [shopCart refreshShopCartView];

                [shopCart syncShopCart];
            }
        }
        else
        {
            if (cartItem.packageType == PackageTypeAccessory) //配件套餐
            {
                ShopCartV2DTO *innerDto = [cartItem.accessoryPackageList objectAtIndex:row-1];
                [cartItem.accessoryPackageList removeObject:innerDto];
                
                //如果配件套餐配件删除完了，就变为普通商品
                if (cartItem.accessoryPackageList.count == 0)
                {
                    cartItem.accessoryPackageList = nil;
                    cartItem.packageType = PackageTypeNormal;
                }
                
//                [tableView reloadSections:[NSIndexSet indexSetWithIndex:section]
//                         withRowAnimation:UITableViewRowAnimationAutomatic];
                [shopCart refreshShopCartView];
            }
            else if (cartItem.packageType == PackageTypeSmall) //小套餐
            {
                //小套餐移除一件，其余变普通
                ShopCartV2DTO *innerDto = [cartItem.smallPackageList objectAtIndex:row-1];
                NSMutableArray *itemList = [NSMutableArray arrayWithArray:cartItem.smallPackageList];
                [itemList removeObject:innerDto];
                
                //变为普通商品时，默认已勾选
                for (ShopCartV2DTO *item in itemList)
                {
                    item.isChecked = YES;
                }
                
                //移除小套餐
                [self.shopDTO.itemList removeObject:cartItem];
                //加入剩余的小套餐商品
                [self.shopDTO.itemList insertObjects:itemList
                                           atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(section, [itemList count])]];
                //刷新界面
//                [tableView reloadData];
                [shopCart refreshShopCartView];
            }
            
            //同步购物车
            [shopCart syncShopCart];
        }
    }
}


- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCartV2ViewController *shopCart = [ShopCartV2ViewController sharedShopCart];

//    [shopCart setNavigationItemEnable:NO];
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCartV2ViewController *shopCart = [ShopCartV2ViewController sharedShopCart];

//    [shopCart setNavigationItemEnable:YES];
}

//- (BOOL)hasCellPrepareToDelete
//{
//    __block BOOL hasInDelete = NO;
//    
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        
//        NSArray *cells = [self.tpTableView visibleCells];
//        
//        if ([cells count] > 0) {
//            
//            for (ShopCartItemCell *cell in cells)
//            {
//                if (cell.showingDeleteConfirmation)
//                {
//                    hasInDelete = YES; break;
//                }
//            }
//        }
//    });
//    
//    return hasInDelete;
//}

#pragma mark ----------------------------- calculate height

+ (CGFloat)height:(ShopCartShopDTO *)shopDTO
{
    CGFloat cellHeight = [ShopCartItemCell height:nil]+1;
    CGFloat sep = 7;
    
    int sectionCount = 0;
    int cellCount = 0;
    
    for (ShopCartV2DTO *dto in shopDTO.itemList)
    {
        sectionCount++;
        NSInteger row = 0;
        switch (dto.packageType) {
            case PackageTypeNormal:
            {
                row = 1;
                break;
            }
            case PackageTypeAccessory:
            {
                row = [dto.accessoryPackageList count]+2;
                break;
            }
            case PackageTypeSmall:
            {
                row = [dto.smallPackageList count]+1;
                break;
            }
            case PackageTypeXn:
            {
                row = [dto.xnPackageList count]+1;
                break;
            }
            default:
                break;
        }
        
        cellCount += row;
    }
    
    return sep*(sectionCount+1) + cellCount*cellHeight;
}

#pragma mark ----------------------------- itemCell Delegate

- (void)cartItemCheckedStateDidChange
{
    //刷新并同步购物车
    ShopCartV2ViewController *shopCart = [ShopCartV2ViewController sharedShopCart];

    [shopCart refreshShopCartView];
    
    [shopCart syncShopCart];
}

- (void)cartItemQuantityDidChange
{
    //刷新并同步购物车
    ShopCartV2ViewController *shopCart = [ShopCartV2ViewController sharedShopCart];
    
    [shopCart refreshShopCartView];
    
    [shopCart syncShopCart];
}

- (void)deleteItemAtCell:(ShopCartItemCell *)cell
{
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    
    if (indexPath)
    {
        [self tableView:self commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:indexPath];
    }
}

@end

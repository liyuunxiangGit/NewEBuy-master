//
//  SellerListViewController.m
//  SuningEBuy
//
//  Created by xmy on 12/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SellerListViewController.h"
#import "SellerDetailInfoCell.h"
#import "MyPhotoSource.h" 
#import "MyPhoto.h"

@interface SellerListViewController ()

@end

@implementation SellerListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self refreshData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    
    self.hasNav = YES;
    
    self.title = L(@"SellerList");
    
    CGRect frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    
    self.tableView.frame = frame;
    
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (SellerInfoService *)sellerService
{
    if (!_sellerService) {
        _sellerService = [[SellerInfoService alloc] init];
        
        _sellerService.delegate = self;
    }
    return _sellerService;
}

- (ProductDetailService*)detailService
{
    if(!_detailService)
    {
        _detailService = [[ProductDetailService alloc] init];
        
        _detailService.delegate = self;
    }
    
    return _detailService;
}


- (void)refreshData
{
    [self displayOverFlowActivityView];
    
    [self.sellerService requestSellerInfoWithProductId:self.productDTO.productId productCode:self.productDTO.productCode cityCode:self.productDTO.cityCode];
}

- (void)service:(SellerInfoService *)service didGetSellerInfoComplete:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    
    if (isSuccess)
    {
        self.shopList = service.shopList;
        [self.tableView reloadData];
    }
    else
    {
        [self presentSheet:service.errorMsg];
    }
}

#pragma mark -
#pragma UITableView Delegate And DataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0){}
    if (indexPath.section == 1)
    {
        //NSUInteger row = indexPath.row;
        //[self.navigationController pushViewController:nil animated:YES];
        
        SellerListDTO * sellerDTO = [self.shopList objectAtIndex:indexPath.row];
        if (sellerDTO)
        {
            if (_selectedBlock) {
                _selectedBlock(sellerDTO.shopCode);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(section == 0)
    {
        return 1;

    }
    else if(section == 1)
    {
        return self.shopList.count;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return 130;
    }
    else if(indexPath.section == 1)
    {
        return 75;
    }
    
    return 0;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 1)
    {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 37)];
        headView.backgroundColor = RGBCOLOR(239, 239, 239);
        
        UILabel *lbl = [[UILabel alloc] init];
        lbl.text = [NSString stringWithFormat:@"%@ %@%@",L(@"Product_GoodSeller"), self.productDTO.supplierNum,L(@"Product_SellerAmount")];
        lbl.textColor = [UIColor blackColor];
        lbl.frame = CGRectMake(15, 9, 160, 20);
        lbl.font = [UIFont systemFontOfSize:15];
        lbl.backgroundColor = [UIColor clearColor];
        [headView addSubview:lbl];
        
        UIImageView *sparetionImg = [[UIImageView alloc] init];
        sparetionImg.image = [UIImage imageNamed:@"line.png"];
        sparetionImg.frame = CGRectMake(0, 36, 320, 0.5);
        [headView addSubview:sparetionImg];
        return headView;
        
    }
    return nil;
    
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    if (section == 0)
//    {
//        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 37)];
//        footerView.backgroundColor = [UIColor grayColor];
//        
//        UILabel *lbl = [[UILabel alloc] init];
//        lbl.text = [NSString stringWithFormat:@"%@个优质商家", self.productDTO.supplierNum];
//        lbl.textColor = [UIColor colorWithRed:0X33/255.0
//                                        green:0X33/255.0
//                                         blue:0X33/255.0
//                                        alpha:1.0f];
//        lbl.frame = CGRectMake(20, 15, 160, 15);
//        lbl.font = [UIFont systemFontOfSize:15];
//        lbl.backgroundColor = [UIColor clearColor];
//        [footerView addSubview:lbl];
//        return footerView;
//    }
//    return nil;
//}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 1)
    {
        return 37;
    }
    
    return 0;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    if (section == 0)
//    {
//        return 37;
//    }
//    return 0;
//}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        static NSString *cellIdentifier =@"cellIdentifier-seller";
        
        ProductShowCell *cell = (ProductShowCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if(cell == nil)
        {
            cell = [[ProductShowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];

            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //cell.delegate = self;
        }
        
//        UIImageView *imageView = [[UIImageView alloc] init];
//        imageView.frame = CGRectMake(0, cell.frame.size.height+15, 320, 10);
//        cell.contentView.backgroundColor = [UIColor clearColor];
//        imageView.backgroundColor = [UIColor colorWithRed:0XF2/255.0
//                                                    green:0XEE/255.0
//                                                     blue:0XE0/255.0
//                                                    alpha:1.0f];
        //[cell addSubview:imageView];
        //[cell setItem:self.productDTO];
        [cell setProductDetailCell:self.productDTO];
        //[cell refreshFrame];
        
        return cell;
    }
    
    if(indexPath.section == 1)
    {
        static NSString *cellIdentifier = @"CellIdentifier-sellerDetail";
        
        SellerDetailInfoCell *cell = (SellerDetailInfoCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if(cell == nil)
        {
            cell = [[SellerDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.backgroundColor = [UIColor clearColor];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        SellerListDTO * sellerDTO = [self.shopList objectAtIndex:indexPath.row];
                
        [cell setSellerDetailCell:sellerDTO andCell:self.productDTO];
        
        return cell;
        
    }
    
    return [[UITableViewCell alloc] init];
}


#pragma ProductImageCellDelegate
- (void)didTouchImageAtIndex:(NSInteger)index
             withSmallImages:(NSArray *)imageUrls
                andBigImages:(NSArray *)bigImageUrls
{
    NSMutableArray *sourceArr = [[NSMutableArray alloc] initWithCapacity:[bigImageUrls count]];
    for (NSURL *url in bigImageUrls)
    {
        MyPhoto *photo = [[MyPhoto alloc] initWithImageURL:url];
        [sourceArr addObject:photo];
    }
    MyPhotoSource *source = [[MyPhotoSource alloc] initWithPhotos:sourceArr];
    
    EGOPhotoViewController *photoController = [[EGOPhotoViewController alloc] initWithPhotoSource:source];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:photoController];
    
    navController.modalPresentationStyle = UIModalPresentationFullScreen;
    if (IOS5_OR_LATER)
    {
        [self presentViewController:navController animated:YES completion:^{
            photoController.scrollView.alpha = 1;
            [photoController moveToPhotoAtIndex:index animated:NO];
        }];
    }
    else
    {
        [self presentModalViewController:navController animated:YES];
        photoController.scrollView.alpha = 1;
        [photoController moveToPhotoAtIndex:index animated:NO];
    }
}



@end

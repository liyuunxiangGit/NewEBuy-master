//
//  ProductMoreInfoViewController.m
//  SuningEBuy
//
//  Created by  on 12-9-13.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ProductMoreInfoViewController.h"
#import "ProductParaDTO.h"
#import "ProductParamInfoCell.h"
#import "productInfoDescribeCell.h"

@interface ProductMoreInfoViewController()

@property (nonatomic, strong) UIView            *paramView;

@property (nonatomic, strong) UIView            *packListView;

@property (nonatomic, strong) UIView            *featureListView;

- (void)refreshParamInfoData;
- (void)updateTableView;

@end

/*********************************************************************/

@implementation ProductMoreInfoViewController

@synthesize paraList = _paraList;
@synthesize paramView = _paramView;
@synthesize packListView = _packListView;
@synthesize featureListView = _featureListView;
@synthesize productDetailDto = _productDetailDto;
@synthesize service = _service;

- (void)dealloc {
    TT_RELEASE_SAFELY(_paraList);
    TT_RELEASE_SAFELY(_paramView);
    TT_RELEASE_SAFELY(_packListView);
    TT_RELEASE_SAFELY(_featureListView);
    TT_RELEASE_SAFELY(_productDetailDto);
    SERVICE_RELEASE_SAFELY(_service);
}

- (id)initWithProductDTO:(DataProductBasic *)dto
{
    self = [super init];
    if (self) {
        self.productDetailDto = dto;
        self.title = dto.productName;
        _serviceStr = L(@"product_Service");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"show_productDetail"),L(@"Production Para")];
    }
    return self;
}

- (ProductParamService *)service
{
    if (!_service) {
        _service = [[ProductParamService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

#pragma mark -
#pragma mark view life

- (void)loadView
{
    [super loadView];
    
    UIView *contentView = self.view;
	
	CGRect frame = contentView.frame;
	
	frame.origin.x = 0;
	
	frame.origin.y = 0;
    
    frame.size.height = contentView.bounds.size.height - 92;
    
    self.groupTableView.frame = frame;
    
    [self.groupTableView setSeparatorColor:[UIColor clearColor]];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!isParamInfoLoaded) {
        [self refreshParamInfoData];
    }
}

#pragma mark -
#pragma mark table view 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (self.productDetailDto.isABook) {
        
        return 1;
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
            
        case 0:
        {    
            if (IsNilOrNull(self.paraList)||[self.paraList count]==0) {
                
                return 44;
            }
            
            ProductParaDTO *tempDto = [self.paraList objectAtIndex:indexPath.row];
            
            if (tempDto != nil) 
            {
                
                //王漫 
                //修改cell高度
                
//                if ([ProductParamInfoCell height:tempDto]<44) {
//                    return 44;
//                }
                return [ProductParamInfoCell height:tempDto];
            }
            
        }    
            break;
            
        case 1:
        {   
            if (IsNilOrNull(self.productDetailDto.packageList)) {
                
                return 44;
                
            }
            //王漫 
            //修改cell高度
            
//            if ( [productInfoDescribeCell height:self.productDetailDto.packageList]<44) {
//                return 44;
//            }
            
            return  [productInfoDescribeCell height:self.productDetailDto.packageList];
            
        }  
            break;
            
        case 2:{
            
            
            if (IsNilOrNull(_serviceStr)) {
                
                return 44;
            }
            //王漫 
            //修改cell高度
            
//            if ([productInfoDescribeCell height:_serviceStr]<44) {
//                return 44;
//            }
            
            return [productInfoDescribeCell height:_serviceStr];
            
        }
            break;
            
        default:
            break;
            
    }
    
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {    
            if (self.paraList&&[self.paraList count]!=0)
            {
                return [self.paraList count];
            }else{
                
                return 1;
            }
            break;
        }   
            
        case 1:
        {    
            if (self.productDetailDto.packageList) {
                
                return 1;
                
            }else{
                
                return 0;
            }
            
            break;
        }  
            
        case 2:{
            
            if (IsNilOrNull(_serviceStr)) {
                
                return 0;
                
            }else{
                
                return 1;
            }
        }
            
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *paraCellIdentifier = @"paraCellIdentifier";
    
    switch (indexPath.section) {
        case 0:
        {    
            
            if (!_paraList || [_paraList count] == 0) {
                
                static NSString *infoCellIdentifier = @"paraNullCellIdentifier";
                
                productInfoDescribeCell *cell = (productInfoDescribeCell *)[tableView dequeueReusableCellWithIdentifier:infoCellIdentifier];
                
                if (nil == cell) 
                { 
                    cell = [[productInfoDescribeCell alloc] initWithReuseIdentifier:infoCellIdentifier];
                }
                
                [cell setInfoString:L(@"No_Data_Error")];
                
                return cell;
                
            }else{
                
                ProductParamInfoCell *cell = (ProductParamInfoCell *)[tableView dequeueReusableCellWithIdentifier:paraCellIdentifier];
                
                if (nil == cell) 
                { 
                    cell = [[ProductParamInfoCell alloc] initWithReuseIdentifier:paraCellIdentifier];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    
                }
                
                ProductParaDTO *dto = [self.paraList objectAtIndex:indexPath.row];
                
                [cell setContendTDO: dto];
                
                return cell;
            }
            
            break;
        }  
            
        case 1:
        {    
            static NSString *infoCellIdentifier = @"infoCellIdentifier";
            productInfoDescribeCell *cell = (productInfoDescribeCell *)[tableView dequeueReusableCellWithIdentifier:infoCellIdentifier];
            
            if (nil == cell) 
            { 
                cell = [[productInfoDescribeCell alloc] initWithReuseIdentifier:infoCellIdentifier];
            }
            
            [cell setInfoString: self.productDetailDto.packageList];
            
            return cell;
            
            break;
        } 
            
        case 2:
        {
            
            static NSString *infoCellIdentifier = @"descriptionCellIdentifier";
            
            productInfoDescribeCell *cell = (productInfoDescribeCell *)[tableView dequeueReusableCellWithIdentifier:infoCellIdentifier];
            
            if (nil == cell) 
            { 
                cell = [[productInfoDescribeCell alloc] initWithReuseIdentifier:infoCellIdentifier];
            }
            
            [cell setInfoString:_serviceStr];
            
            return cell;
            
            break;
        }
            
        default:
            break;
    }
    
    return nil;
    
}

#pragma -
#pragma Http viewForHeaderInSection
- (UIView *)paramView
{
    if (_paramView == nil)
    {
        _paramView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 14, 320, 17)];
        
        contentLabel.textColor = [UIColor skyBlueColor];
        
        contentLabel.font = [UIFont fontWithName:@"Heiti SC Medium" size:17.0];
        
        contentLabel.backgroundColor = [UIColor clearColor];
        
        contentLabel.text = L(@"Production Para");
        
        [_paramView addSubview:contentLabel];
        
        TT_RELEASE_SAFELY(contentLabel);
    }
    return _paramView;
}

- (UIView *)packListView
{
    if (_packListView == nil)
    {
        _packListView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 14, 320, 17)];
        
        contentLabel.textColor = [UIColor skyBlueColor];
        
        contentLabel.font = [UIFont fontWithName:@"Heiti SC Medium" size:17.0];
        
        contentLabel.backgroundColor = [UIColor clearColor];
        
        contentLabel.text = L(@"Packing List");
        
        [_packListView addSubview:contentLabel];
        
        TT_RELEASE_SAFELY(contentLabel);
    }
    return _packListView;
}

- (UIView *)featureListView
{
    if (_featureListView == nil)
    {
        _featureListView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 36)];
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 9.5, 320, 17)];
        
        contentLabel.textColor = [UIColor skyBlueColor];
        
        contentLabel.font = [UIFont fontWithName:@"Heiti SC Medium" size:17.0];
        
        contentLabel.backgroundColor = [UIColor clearColor];
        
        contentLabel.text = L(@"afterBuy Service");
        
        [_featureListView addSubview:contentLabel];
        
        TT_RELEASE_SAFELY(contentLabel);
    }
    return _featureListView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section) {
            
        case 0:
            return self.paramView;
            break;
        case 1:
            return self.packListView;
            break;
        case 2:
            return self.featureListView;
            break;
        default:
            break;
    }
    
    UIView *view = [[UIView alloc] init];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
	return 36;
}

#pragma mark -
#pragma mark data

- (void)updateTableView
{
    if (self.groupTableView.superview == nil) 
    {
        [self.view addSubview:self.groupTableView];
    }
    else
    {
        [self.groupTableView reloadData];
    }
}

- (void)refreshParamInfoData
{
    [self displayOverFlowActivityView];
    
    [self.service beginGetProductParamWithProduct:self.productDetailDto];
}

- (void)getProductParamCompletionWithResult:(BOOL)isSuccess 
                                   errorMsg:(NSString *)errorMsg 
                                  paramList:(NSArray *)list
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        self.paraList = list;
        [self updateTableView];
    }else{
        
        if([errorMsg isEqualToString:L(@"Product_NoProductPara")])
        {
            [self updateTableView];
        }else{
        
            [self presentSheet:errorMsg];
        }
    }
}

@end

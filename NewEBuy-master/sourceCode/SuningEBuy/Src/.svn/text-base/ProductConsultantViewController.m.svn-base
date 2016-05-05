//
//  ProductConstantViewController.m
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-24.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ProductConsultantViewController.h"

#import "ProductConsultantCell.h"

#import "NewProductConsultantViewController.h"

#import "UserConsultantViewController.h"

@implementation ProductConsultantViewController

@synthesize  nextPageList = _nextPageList;

@synthesize consultantList = _consultantList;

@synthesize product = _product;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_nextPageList);
    
    TT_RELEASE_SAFELY(service);
    
    TT_RELEASE_SAFELY(_consultantList);
    
    TT_RELEASE_SAFELY(_product);

}

- (id)initWithBasicDTO:(DataProductBasic *)dto{
    
    self = [super init];
    
    if (self) {
        
        self.product = dto;
        
        self.title = L(@"Custom Ask");
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"show_productDetail"),self.title];

        UIBarButtonItem *addNew = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNew)];
        
        //self.navigationItem.rightBarButtonItem = addNew;
        
        TT_RELEASE_SAFELY(addNew);
        
        /***********************ADD 我要咨询***********************/
//        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]
//                                      
//                                      initWithTitle:@"我要咨询" style:UIBarButtonItemStylePlain target:self action:@selector(consultantCommit)];
//		
//		self.navigationItem.rightBarButtonItem = rightItem;
//        
//        
//        TT_RELEASE_SAFELY(rightItem);
        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"New advisory")];

        /*********************************************************/

        self.currentPage = 1;
        
        _nextPageList = [[NSMutableArray alloc]init];
        
    }
    return self;
}

- (void)righBarClick
{
    [self consultantCommit];
}

- (void)consultantCommit
{
    UserConsultantViewController *nextNC = [[UserConsultantViewController alloc] initWithBasicDTO:self.product];
    [self.navigationController pushViewController:nextNC animated:YES];
}

//发表商品咨询
- (void)addNew{
    
    NewProductConsultantViewController *newProductConsultantVC = [[NewProductConsultantViewController alloc]initWithDTO:self.product];
    
    [self.navigationController pushViewController:newProductConsultantVC animated:YES];
    
    TT_RELEASE_SAFELY(newProductConsultantVC)
    
}

#pragma mark -

#pragma mark view lifecycle

- (void)loadView
{
    
    [super loadView];
    
    UIView *contentView = self.view;
    
    CGRect frame = contentView.frame;
    
    frame.origin.x = 0;
    
    frame.origin.y = 0;
    
    frame.size.height = contentView.bounds.size.height - 92;
    
    self.tableView.frame = frame;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView addSubview:self.refreshHeaderView];
    
    service = [[ProductConsultantService alloc]init];
    
    service.delegate = self;
    
    [self displayOverFlowActivityView];
    
    [service beginProductConstantListHttpRequest:_product currentPage:self.currentPage];
}

#pragma mark - Table View Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self hasMore]) {
        
        return [self.consultantList count]+1;
    }
    return [self.consultantList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self hasMore] && [self.consultantList count] == indexPath.row) {
        
        static NSString *MoreCellIdentifier = @"MoreCellIdentifier";
		
		UITableViewMoreCell * cell = (UITableViewMoreCell*)[tableView dequeueReusableCellWithIdentifier:MoreCellIdentifier];
		
		if (cell == nil) {
			
			
			UITableViewMoreCell *cell = [[UITableViewMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoreCellIdentifier];
			
			cell.title = L(@"Get More...");
            
            cell.animating = NO;
			
			return cell;
		}
		
		cell.animating = NO;
		
		return cell;
    }
    static NSString *ConsultantCellIdentifier = @"ConsultantCellIdentifier";
    
    ProductConsultantCell *cell = (ProductConsultantCell *)[tableView dequeueReusableCellWithIdentifier:ConsultantCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[ProductConsultantCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ConsultantCellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    ProductConsultantDTO *dto = [self.consultantList objectAtIndex:indexPath.row];
    
    [cell setItem:dto];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self hasMore] && [self.consultantList count] ==indexPath.row)
    {
        return  48;
    }
    
    ProductConsultantDTO *dto = [self.consultantList objectAtIndex:indexPath.row];
    
    return [ProductConsultantCell height:dto];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self hasMore] && [self.consultantList count] == indexPath.row){
        
        [self loadMoreData];
        
        return;
    }
    
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    cell.backgroundColor = RGBCOLOR(247, 247, 247);
}


#pragma mark - productConstantDelegate
//商品咨询数据请求完成后回调
//刷新tableView
- (void)productConstantCompletedWithResult:(BOOL)isSucess ProductConstantList:(NSMutableArray *)list pageInfo:(SNPageInfo)pageInfo errorMsg:(NSString *)errorMsg{
    
    [self removeOverFlowActivityView];
    
    if (self.isFromHead) {
        
        [self refreshDataComplete];
    }
    else{
        [self loadMoreDataComplete];
    }
    
    if (isSucess == NO) {
        
        [self backToProductDetail:@"Sorry loading failed"];
    }
    else{
        
        if ([errorMsg isEqualToString:@"no more product"]) {
            
            [self backToProductDetail:@"wrong product imformation"];
            
        }
       else  if ([errorMsg isEqualToString:@"product not correct"]) {
            
           [self backToProductDetail:@"wrong product imformation"];
        }
       else{
           
           self.totalPage = pageInfo.totalPage;
           
           self.currentPage = pageInfo.currentPage;
           
           self.totalCount = pageInfo.pageSize;
           
           if (list && [list count]>0) {
               
               if (self.isFromHead) {
                   
                   self.consultantList = list;
                   
               }else{
                   
                   if (!_consultantList) {
                       
                       _consultantList = [[NSMutableArray alloc]init];
                   }
                       
                   [self.consultantList addObjectsFromArray:list];
               }
               
               DLog("consultantList count %d  %d ", [_consultantList count] ,self.totalCount);

               [self updateTable];
           }
           else{
               [self backToProductDetail:@"sorry ,no consultant information"];
           }
       }
        
    }
    
}


//返回商品详细信息页面
- (void)backToProductDetail:(NSString *)message{

    [self presentSheet:L(message)];
//    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:nil message:L(message) delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    alert.tag = 226;
//    [alert show];
//    [alert release];
    
}


#pragma mark - AlertMessageViewDelegate
-(void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 226) {
        
        if (buttonIndex == 0) {
            
//            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
}

#pragma mark -
#pragma mark 下拉刷新和加载更多

- (void) updateTable{

    [self.tableView reloadData];
    
}


- (void)refreshData{//下拉刷新
    
    [super refreshData];
    
    self.currentPage = 1;
    
     [service beginProductConstantListHttpRequest:_product currentPage:self.currentPage];
}

- (void)loadMoreData{//加载更多
    
    [super loadMoreData];
    
    if ([self hasMore]) {
        
        self.currentPage ++;
        
         [service beginProductConstantListHttpRequest:_product currentPage:self.currentPage];   
    }
}

- (BOOL)hasMore{
    
    if ([self.consultantList count] >= self.totalCount) {
        
        return NO;
    }
    
    return YES;
}

@end

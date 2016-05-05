//
//  NProDetailBaseInfoView.m
//  SuningEBuy
//
//  Created by xmy on 20/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NProDetailBaseInfoView.h"


@implementation NProDetailBaseInfoView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _isFold = NO;
        _isFoldParam = NO;
        _isFoldPackList = NO;
        
        self.baseInfoTableV.frame = CGRectMake(self.origin.x, self.origin.y, self.frame.size.width, self.frame.size.height);
        

        [self addSubview:self.baseInfoTableV];
        
    }
    return self;
}

- (UITableView*)baseInfoTableV
{
    if(!_baseInfoTableV)
    {
        
        _baseInfoTableV = [[UITableView alloc] initWithFrame:self.bounds
                                                       style:UITableViewStylePlain];
		
		[_baseInfoTableV setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[_baseInfoTableV setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
//		_baseInfoTableV.scrollEnabled = NO;
		
		_baseInfoTableV.userInteractionEnabled = YES;
		
		_baseInfoTableV.delegate =self;
		
		_baseInfoTableV.dataSource =self;
		
		_baseInfoTableV.backgroundColor =[UIColor clearColor];
        
        _baseInfoTableV.backgroundView = nil;
        
        _baseInfoTableV.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.baseInfoTableV];
    }
    
    return _baseInfoTableV;
}

- (NSArray*)paraList
{
    if(!_paraList)
    {
        _paraList = [[NSArray alloc] init];
    }
    
    return _paraList;
}

- (void)setNProDetailBaseInfoViewData:(NSArray*)arr
{
    self.paraList = arr;
    
    [self.baseInfoTableV reloadData];
}


- (NProDetailParameterViewCell*)parameterView
{
    if(!_parameterView)
    {
        _parameterView = [[NProDetailParameterViewCell alloc] init];
        
        _parameterView.tableView.backgroundColor = [UIColor clearColor];
        
    }
    
    return _parameterView;
}

- (NProDetailParameterNbookTableView *)parameterTableView
{
    if (!_parameterTableView)
    {
        _parameterTableView = [[NProDetailParameterNbookTableView alloc] init];
        
        _parameterTableView.tableView.backgroundColor = [UIColor clearColor];
    }
    return _parameterTableView;
}

#pragma mark -
#pragma UITableViewDataSource And Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0 ||
       indexPath.row == 4 ||
       indexPath.row == 2 )
    {
        return 30;
    }
    
    if(indexPath.row == 1)
    {
        if(_isFoldParam == YES)
        {
            return 0;
        }
        else if(_isFoldParam == NO)
        {
            if (self.baseInfoDto.isABook) {
                return [NProDetailParameterViewCell height:self.paraList]+5;
            }
            return [NProDetailParameterNbookTableView height:self.paraList]+5;
            
        }
        
    }
    
    if(indexPath.row == 3)
    {
        if(_isFoldPackList == YES)
        {
            return 0;
        }
        else if(_isFoldPackList == NO)
        {
            return  [NewProductInfoDescribeCell height:self.baseInfoDto.packageList]+10;
            
        }
        
    }
    
    if(indexPath.row == 5)
        
    {
        if(_isFold == YES)
        {
            return 0;
        }
        else if(_isFold == NO)
        {
            return [NewProductInfoDescribeCell height:L(@"product_Service")];
            
        }
    }
    
    return 0.001;//self.frame.size.height;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //商品参数
    if(indexPath.row == 0 ||
       indexPath.row == 4 ||
       indexPath.row == 2 )
    {
        
        static NSString *productTitleCellIdentifier = @"NProParamHeadCell-0";
        
        NProParamHeadCell *cell =(NProParamHeadCell *)[tableView dequeueReusableCellWithIdentifier:productTitleCellIdentifier];
        
        if (nil == cell) {
            
            cell = [[NProParamHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productTitleCellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        [cell.arrowBtn addTarget:self action:@selector(serviceArrowAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if(indexPath.row == 0)
        {
            [cell setNProParamHeadCellInfo:self.baseInfoDto WithBool:_isFoldParam WithPosition:indexPath.row];
            
            cell.arrowBtn.tag = 100;
        }
        else if(indexPath.row == 2)
        {
            [cell setNProParamHeadCellInfo:self.baseInfoDto WithBool:_isFoldPackList WithPosition:indexPath.row];
            
            cell.arrowBtn.tag = 101;
        }
        else if(indexPath.row == 4)
        {
            [cell setNProParamHeadCellInfo:self.baseInfoDto WithBool:_isFold WithPosition:indexPath.row];
            cell.arrowBtn.tag = 102;
        }
        
        
        return cell;
        
    }
    if(indexPath.row == 1)
    {//商品参数
        static NSString *cellIdentifier = @"cellIdentifier-1";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (nil == cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
        }
        else
        {
            [cell.contentView removeAllSubviews];
        }
        
//        UIImage *img = [UIImage streImageNamed:@"yellow_mid.png"];
//        UIImageView *back = [[UIImageView alloc] initWithImage:img];
//        back.frame = cell.backgroundView.frame;
////        cell.backgroundView = back;
        cell.backgroundColor = [UIColor clearColor];
        
        cell.contentView.backgroundColor = [UIColor clearColor];
        
        if (self.baseInfoDto.isABook) {
            [self.parameterView loadParameterView:self.paraList];
            
            self.parameterView.tableView.frame = CGRectMake(10, 0, 280, [NProDetailParameterViewCell height:self.paraList]);
            
            [cell.contentView addSubview:self.parameterView.tableView];
        }
        else
        {
            [self.parameterTableView loadParameterView:self.paraList];
            
            self.parameterTableView.tableView.frame = CGRectMake(0, 0, 320, [NProDetailParameterNbookTableView height:self.paraList]);
            
            [cell.contentView addSubview:self.parameterTableView.tableView];
        }
        
        
        cell.clipsToBounds = YES;
        
        return cell;
        
    }
    
    
    if(indexPath.row == 3 ||
       indexPath.row == 5)
    {
        
        static NSString *infoCellIdentifier = @"descriptionCellIdentifier";
        
        NewProductInfoDescribeCell *cell = (NewProductInfoDescribeCell *)[tableView dequeueReusableCellWithIdentifier:infoCellIdentifier];
        
        if (nil == cell)
        {
            cell = [[NewProductInfoDescribeCell alloc] initWithReuseIdentifier:infoCellIdentifier];
            
//            UIImage *needImg = nil;
            
//            needImg = [UIImage streImageNamed:@"yellow_buttom.png"];
//            
//            UIImageView *back = [[UIImageView alloc] initWithImage:needImg];
//            back.frame = cell.backgroundView.frame;
            
            cell.backgroundView.backgroundColor = [UIColor clearColor];
            
//            cell.backgroundView = back;
            
            cell.backgroundColor = [UIColor clearColor];
        }
        
        if(indexPath.row == 3)
        {// 装箱清单
            [cell setInfoString:self.baseInfoDto.packageList WithBool:YES];
            
        }
        else if(indexPath.row == 5)
        {//售后服务
            [cell setInfoString:L(@"product_Service") WithBool:NO];
            
        }
        
        cell.clipsToBounds = YES;
        
        return cell;
        
    }
    return nil;
}


- (void)serviceArrowAction:(id)sender
{
    UIButton *tagBtn = (UIButton*)sender;
    
    if(tagBtn.tag == 100)
    {
        _isFoldParam = !_isFoldParam;
    }
    else if(tagBtn.tag == 101)
    {
        _isFoldPackList = !_isFoldPackList;
    }
    else if(tagBtn.tag == 102)
    {
        _isFold = !_isFold;
        
    }
    [self.baseInfoTableV reloadData];
}

- (CGFloat)setNProDetailBaseInfoViewHeight:(DataProductBasic*)dto WithArr:(NSArray*)arr
{    
    if(_isFoldPackList == YES && _isFoldParam == YES && _isFold == YES)
    {
        return 30*3;
    }
    else if(_isFoldPackList == YES && _isFoldParam == NO && _isFold == YES)
    {
        if (self.baseInfoDto.isABook) {
            return 30*3 + [NProDetailParameterViewCell height:self.paraList]+5;
        }
        return 30*3 + [NProDetailParameterNbookTableView height:self.paraList]+5;
    }
    else if(_isFoldPackList == NO && _isFoldParam == NO && _isFold == YES)
    {
        if (self.baseInfoDto.isABook) {
            return 30*3 + [NProDetailParameterViewCell height:self.paraList]+5 + [NewProductInfoDescribeCell height:self.baseInfoDto.packageList]+10;
        }
        return 30*3 + [NProDetailParameterNbookTableView height:self.paraList]+5 + [NewProductInfoDescribeCell height:self.baseInfoDto.packageList]+10;
    }
    else if(_isFoldPackList == NO && _isFoldParam == NO && _isFold == NO)
    {
        if (self.baseInfoDto.isABook) {
            return 30*3 + [NProDetailParameterViewCell height:self.paraList]+5 + [NewProductInfoDescribeCell height:self.baseInfoDto.packageList]+10 + [NewProductInfoDescribeCell height:L(@"product_Service")];
        }
        return 30*3 + [NProDetailParameterNbookTableView height:self.paraList]+5 + [NewProductInfoDescribeCell height:self.baseInfoDto.packageList]+10 + [NewProductInfoDescribeCell height:L(@"product_Service")];
    }
    else if(_isFoldPackList == NO && _isFoldParam == YES && _isFold == YES)
    {
        return 30*3 + [NewProductInfoDescribeCell height:self.baseInfoDto.packageList]+10;
    }
    else if(_isFoldPackList == NO && _isFoldParam == NO && _isFold == YES)
    {
        if (self.baseInfoDto.isABook) {
            return 30*3 + [NProDetailParameterViewCell height:self.paraList]+5 + [NewProductInfoDescribeCell height:self.baseInfoDto.packageList]+10 ;
        }
         return 30*3 + [NProDetailParameterNbookTableView height:self.paraList]+5 + [NewProductInfoDescribeCell height:self.baseInfoDto.packageList]+10 ;
    }
    else if(_isFoldPackList == YES && _isFoldParam == NO && _isFold == NO)
    {
        return 30*3 + [NewProductInfoDescribeCell height:self.baseInfoDto.packageList]+10 + [NewProductInfoDescribeCell height:L(@"product_Service")];
    }
    else if(_isFoldPackList == YES && _isFoldParam == YES && _isFold == NO)
    {
        return 30*3 + [NewProductInfoDescribeCell height:L(@"product_Service")];
    }
    else
    {
        return 0;
    }
}


+ (CGFloat)NProDetailBaseInfoViewHeight:(DataProductBasic*)dto WithArr:(NSArray*)arr
{
    return [[NProDetailBaseInfoView alloc] setNProDetailBaseInfoViewHeight:dto WithArr:arr];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.baseInfoTableV)
    {
//        if (self.baseInfoTableV.contentOffset.y < 0)
//        {
//            self.baseInfoTableV.scrollEnabled = NO;
//        }
    }

//    DLog(@"scrollview offset %f", scrollView.contentOffset.y);
}

// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}

// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView   // called on finger up as we are moving
{

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    self.baseInfoTableV.scrollEnabled = NO;
}
@end

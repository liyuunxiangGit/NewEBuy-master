//
//  HotSaleThumbnailsView.m
//  SuningEBuy
//
//  Created by robin wang on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TopRecommentCell.h"
#import "HomeTopRecommendDTO.h"
#import "HotSaleThumbnailsView.h"
#import "InnerProductDTO.h"


@interface HotSaleThumbnailsView ()

- (NSInteger)getRowNum:(NSInteger)listCount;

@end


@implementation HotSaleThumbnailsView

@synthesize hotSaleProductList = _hotSaleProductList;

- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    TT_RELEASE_SAFELY(_hotSaleProductList);
    
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) 
    {
    
        self.backgroundColor = [UIColor clearColor];
        
        self.dataSource = self;
        self.delegate = self;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.indicatorStyle = UIScrollViewIndicatorStyleBlack;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadHotSaleDataSource:) name:HOTSALE_LOADED_NOTIFICATION object:nil];
    }
    
    return self;
}

- (void)reloadHotSaleDataSource:(NSNotification *)notification
{
    self.hotSaleProductList = [notification object];
    
    [self reloadData];
}

#pragma mark -
#pragma mark UITableView Datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    
	return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    return 210;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	if (IsNilOrNull(self.hotSaleProductList) || [self.hotSaleProductList count] == 0) {
        
        return 0;
        
    }
    
	return [self getRowNum:[self.hotSaleProductList count]];	
}


- (NSInteger)getRowNum:(NSInteger)listCount{

    if (listCount%2 == 1) {
        
        return listCount/2+1;
        
    }else{
    
        return listCount/2;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    static NSString *topRecommentItemCellIdentifier = @"topRecommentItemCellIdentifier";
	
	TopRecommentCell *cell = (TopRecommentCell*)[tableView dequeueReusableCellWithIdentifier:topRecommentItemCellIdentifier];
	
	if(cell == nil)
    {
		
		cell = [[TopRecommentCell alloc]initWithReuseIdentifier:topRecommentItemCellIdentifier];
        
	}
    
    NSInteger row = indexPath.row;
    
    if ([self.hotSaleProductList count]%2 == 1 && row*2 == [self.hotSaleProductList count] - 1) {
        
        HomeTopRecommendDTO *leftDto = [self.hotSaleProductList objectAtIndex:row*2];   
        
        [cell setItem:leftDto rightItem:nil];
        
    }else{

        HomeTopRecommendDTO *leftDto = [self.hotSaleProductList objectAtIndex:row*2];
        
        HomeTopRecommendDTO *rightDto = [self.hotSaleProductList objectAtIndex:row*2+1];
        
        [cell setItem:leftDto rightItem:rightDto];
    }
    
	
    
	return cell;
}

@end

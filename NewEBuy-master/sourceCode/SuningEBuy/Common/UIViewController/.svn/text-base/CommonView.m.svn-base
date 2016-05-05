//
//  CommonView.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-17.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "CommonView.h"

@implementation CommonView

@synthesize tableView = _tableView;
@synthesize groupTableView = _groupTableView;
@synthesize tpTableView = _tpTableView;
@synthesize owner = _owner;

- (void)dealloc {
    TT_RELEASE_SAFELY(_tableView);
    TT_RELEASE_SAFELY(_groupTableView);
    TT_RELEASE_SAFELY(_tpTableView);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (id)initWithOwner:(id)owner
{
    self = [super init];
    if (self) {
        self.owner = owner;
    }
    return self;
}


- (UITableView *)tableView{
	
	
	if(!_tableView){
		
		_tableView = [UITableView tableView];
		
		[_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[_tableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_tableView.scrollEnabled = YES;
		
		_tableView.userInteractionEnabled = YES;
		
		_tableView.backgroundColor = [UIColor clearColor];
        
        _tableView.backgroundView = nil;
		
        _tableView.delegate = self.owner;
        
        _tableView.dataSource = self.owner;
	}
	
	return _tableView;
}

- (UITableView *)groupTableView{
	
	
	if(!_groupTableView){
		
        if (IOS7_OR_LATER) {
            _groupTableView = [UITableView groupTableView];
        }else{
            _groupTableView = [UITableView tableView];
        }
		
		[_groupTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[_groupTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_groupTableView.scrollEnabled = YES;
		
		_groupTableView.userInteractionEnabled = YES;
		
		_groupTableView.backgroundColor = [UIColor clearColor];
        
        _groupTableView.backgroundView = nil;
        
        _groupTableView.delegate = self.owner;
        
        _groupTableView.dataSource = self.owner;
	}
	
	return _groupTableView;
}

- (TPKeyboardAvoidingTableView *)tpTableView
{
    if(!_tpTableView)
    {
		if (IOS7_OR_LATER) {
            _tpTableView = [TPKeyboardAvoidingTableView groupTableView];
        }else{
            _tpTableView = [TPKeyboardAvoidingTableView tableView];
        }
        
		[_tpTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[_tpTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_tpTableView.scrollEnabled = YES;
		
		_tpTableView.userInteractionEnabled = YES;
		
		_tpTableView.backgroundColor = [UIColor clearColor];
		
        _tpTableView.backgroundView = nil;
        
        _tpTableView.delegate = self.owner;
        
        _tpTableView.dataSource = self.owner;
        
        _tpTableView.tableFooterView = [UIView new];
	}
	
	return _tpTableView;
}


@end

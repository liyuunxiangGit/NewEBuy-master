//
//  CategoryItemCell.m
//  SuningEBuy
//
//  Created by zhaojw on 11-9-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CategoryItemCell.h"
#import "SecondCategoryCell.h"

#define Category_CELL_HEIGHT       65

#define FrontWidth                 93
#define LabelWidth                 200

@implementation CategoryItemCell

@synthesize  menuTitleLbl  = _menuTitleLbl;

@synthesize firMenuTitleLbl = _firMenuTitleLbl;

@synthesize  item          = _item;

@synthesize cellSeparatorLine = _cellSeparatorLine;

@synthesize  menuImageView = _menuImageView;

@synthesize firstDesLbl = _firstDesLbl;

@synthesize isSelect = _isSelect;

@synthesize specailLine = _specailLine;

@synthesize myDelegate = _myDelegate;
@synthesize footViewBack = _footViewBack;


- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier{
	
	self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuseIdentifier];
    if (self) {
		
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		self.autoresizesSubviews = YES;
        
//		self.contentView.backgroundColor = [UIColor colorWithRed:239.0/255
//                                                           green:239.0/255
//                                                            blue:239.0/255
//                                                           alpha:1.0];
        
        [self.contentView addSubview: self.cellSeparatorLine];
        
        [self.contentView addSubview:self.specailLine];
        
	}
	
	return self;
}

-(void)dealloc{
	
	TT_RELEASE_SAFELY(_menuTitleLbl);
    
    TT_RELEASE_SAFELY(_item);
    
    TT_RELEASE_SAFELY(_footViewBack);
    
    TT_RELEASE_SAFELY(_cellSeparatorLine);
    
    TT_RELEASE_SAFELY(_menuImageView);
    
    TT_RELEASE_SAFELY(_firstDesLbl);
	
	
}

+(CGFloat) height:(id *)item{
	
	if (!item) {
		
		return Category_CELL_HEIGHT;
	}
	
	return  Category_CELL_HEIGHT;
	
}

-(void) setItem:(V2FristCategoryDTO *)aItem withDescription:(NSString *)des{
	
	if (aItem != _item) {
		
		
		_item = aItem;
		
		self.menuTitleLbl.text = _item.categoryName;
        self.firstDesLbl.text = aItem.categoryDes;
        
        if (aItem.categoryImageURL) {
            
            self.menuImageView.frame = CGRectMake(18, 4, 55, 55);
            [self.menuImageView setImageURL:[NSURL URLWithString:aItem.categoryImageURL]];
        }
        
	}
    
    self.detailTable.scrollEnabled = NO;
    if (_isSelect) {
        
        self.cellSeparatorLine.frame = CGRectMake(0, Category_CELL_HEIGHT-6, 320, 10);
        self.cellSeparatorLine.image = [UIImage imageNamed:@"sharpcorners.png"];
        
        NSInteger detailTableCellNum = [self secNums:-1];
        
        if (DetailCEllMaxNum < detailTableCellNum) {
            
            self.detailTable.scrollEnabled = YES;
            detailTableCellNum = DetailCEllMaxNum;
        }

        self.detailTable.frame = CGRectMake(0, Category_CELL_HEIGHT+4, 320, 80*detailTableCellNum);
        
        self.footViewBack.frame = CGRectMake(0, self.detailTable.bottom, 320, 3);
        
        [self.contentView addSubview:self.detailTable];
        
        [self.detailTable reloadData];
        self.footViewBack.hidden = NO;
        self.specailLine.hidden = YES;
    }
    else{
        
        self.cellSeparatorLine.frame = CGRectMake(0, Category_CELL_HEIGHT-1, 320, 1);
        self.cellSeparatorLine.image = [UIImage imageNamed:@"cellSeparatorLine.png"];
        self.footViewBack.hidden = YES;
        [self.detailTable removeFromSuperview];
        self.specailLine.hidden = YES;
    }
}


-(void) layoutSubviews{
	
	[super layoutSubviews];
    
}

-(UILabel *)firMenuTitleLbl{
	
	if (!_firMenuTitleLbl) {
        
        // UIFont *font = [UIFont  fontWithName:@"MarkerFelt" size:18];
		
        UIFont *font = [UIFont boldSystemFontOfSize:16];
        
		CGSize size = [@"a" sizeWithFont:font];
		
		_firMenuTitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(FrontWidth, (Category_CELL_HEIGHT-size.height)/2,LabelWidth, size.height)];
        
        _firMenuTitleLbl.textColor = RGBCOLOR(149, 129, 105);//[UIColor darkGrayColor];
		
		_firMenuTitleLbl.backgroundColor = [UIColor clearColor];
		
		_firMenuTitleLbl.font = font;
        
		_firMenuTitleLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_firMenuTitleLbl];
	}
	
	
	
	return _firMenuTitleLbl;
}

-(UILabel *) menuTitleLbl{
	
	if (!_menuTitleLbl) {
		
		UIFont *font = [UIFont boldSystemFontOfSize:18];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_menuTitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(FrontWidth, 12,LabelWidth, size.height)];
        
		_menuTitleLbl.backgroundColor = [UIColor clearColor];
        
        _menuTitleLbl.textColor = [UIColor colorWithRGBHex:0x59493f];//[UIColor darkTextColor];//[UIColor blackColor];
		
		_menuTitleLbl.font = font;
        
		_menuTitleLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_menuTitleLbl];
	}
	
	
	
	return _menuTitleLbl;
}

-(EGOImageView *) menuImageView{
	
	if (!_menuImageView) {
		
		_menuImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(18, 5, 55, 55)];
		
		_menuImageView.backgroundColor =[UIColor clearColor];
		
		[self.contentView addSubview:_menuImageView];
		
	}
	
	return _menuImageView;
}

/***********************new UI ***************/
-(UILabel *)firstDesLbl{
	
	if (!_firstDesLbl) {
        
        UIFont *font = [UIFont boldSystemFontOfSize:14];
        
		CGSize size = [@"a" sizeWithFont:font];
		
		_firstDesLbl = [[UILabel alloc] initWithFrame:CGRectMake(FrontWidth,34,LabelWidth,size.height)];
        
        _firstDesLbl.textColor = [UIColor colorWithRGBHex:0xA6937C];//[UIColor lightTextColor];//[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
		
		_firstDesLbl.backgroundColor = [UIColor clearColor];
		
		_firstDesLbl.font = font;
        
        _firstDesLbl.text = L(@"CTMobileChargeOrFeePay");
        
		_firstDesLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_firstDesLbl];
	}
	
	
	
	return _firstDesLbl;
}



-(UIImageView *)cellSeparatorLine{
    if (_cellSeparatorLine == nil) {
        _cellSeparatorLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, Category_CELL_HEIGHT-2, 320, 2)];
        UIImage *tempImage = [UIImage newImageFromResource:@"cellSeparatorLine.png"];
        _cellSeparatorLine.image = tempImage;
    }
    
    return _cellSeparatorLine;
}


- (UIImageView *)footViewBack
{
    if (!_footViewBack) {
        _footViewBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"category_second_footview.png"]];
        _footViewBack.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_footViewBack];
    }
    return _footViewBack;
}

-(UIImageView *)specailLine{
    
    if (_specailLine == nil) {
        _specailLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, Category_CELL_HEIGHT, 320, 5)];
        UIImage *tempImage = [UIImage newImageFromResource:@"sharpspecail.png"];
        _specailLine.image = tempImage;
    }
    
    return _specailLine;
}

-(UITableView *)detailTable{
    
    if (!_detailTable) {
        
        _detailTable = [[UITableView alloc] init];
        _detailTable.allowsSelection = NO;
        _detailTable.delegate = self;
        _detailTable.dataSource = self;
        _detailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _detailTable.showsVerticalScrollIndicator = NO;
        
//        _detailTable.backgroundColor = [UIColor colorWithRed:238.0/255
//                                                       green:235.0/255
//                                                        blue:215.0/255
//                                                       alpha:1.0];
//        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage streImageNamed:@"cellSeparatorLine.png"]];
//        image.backgroundColor = [UIColor clearColor];
//        image.frame = _detailTable.bounds;
//        _detailTable.backgroundView = image;
//        [image release];
    }
    
    return _detailTable;
}


-(NSInteger)secNums:(NSInteger)row{
    
    
    NSInteger secNum = [self.item.secList count];
    
    NSInteger rowNum = secNum/IMG_NUM;
    
    if (0 != secNum%IMG_NUM) {
        
        rowNum = rowNum + 1;
    }
    return rowNum;
}
#pragma mark -
#pragma mark TableView Delegate Method
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
        
        
    return DetailCellH;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        
        
    return [self secNums:-1];
        
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    static NSString *cellIdentifier = @"CategoryCellCellIdentifier";
    
    SecondCategoryCell *cell = (SecondCategoryCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        
        cell = [[SecondCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.myDelegate = _myDelegate;
    }
    
    
    int length = IMG_NUM;
    
    if ([self.item.secList count] < IMG_NUM*(indexPath.row+1))
    {
        length = [self.item.secList count] - indexPath.row*IMG_NUM;
    }
    NSArray *tempArray = nil;
    if (0 >= length) {
        
        tempArray = [[NSArray alloc] init];
    }
    else{
        
        tempArray = [self.item.secList subarrayWithRange:NSMakeRange(indexPath.row*IMG_NUM, length)];
    }
    
    [cell setCellItem:tempArray];
    
    return cell;
    
}


@end

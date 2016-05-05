//
//  SearchCityListViewController.m
//  SuningEBuy
//
//  Created by 芳奎 赵 on 12-7-2.
//  Copyright (c) 2012年 苏宁. All rights reserved.
//

#import "SearchCityListViewController.h"
@interface SearchCityListViewController ()

@property NSUInteger curSection;                //当前section
@property NSUInteger curRow;                    //当前行
@property NSUInteger defaultSelectionRow;       //默认选择行
@property NSUInteger defaultSelectionSection;   //默认选择section
@end


@implementation SearchCityListViewController
@synthesize bottomView=_bottomView;
@synthesize backBtn=_backBtn;
@synthesize yiGouBtn=_yiGouBtn;

@synthesize tableView = tableView_;

#define CHECK_TAG 1110

@synthesize cities, keys, curSection, curRow, delegate;
@synthesize defaultSelectionRow, defaultSelectionSection;

- (id)init {
    self = [super init];
    if (self) {
        self.title =L(@"GBChooseCity");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@%@",L(@"virtual_business"),L(@"Hotel"),self.title];
        NSMutableArray *tempArr = [[NSMutableArray alloc]init];
        self.keys = tempArr;
        
        self.bSupportPanUI = NO;
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle

-(void)loadView{
    
    [super loadView];
    
    UIView *contentView = self.view;
	
	CGRect frame = contentView.frame;
	
	frame.origin.x = 0;
	
	frame.origin.y = 0;
	
    if (IOS7_OR_LATER) {
        frame.size.height = contentView.bounds.size.height - 44;
    }else{
        frame.size.height = contentView.bounds.size.height - 44;
    }
	
	
	self.tableView.frame = frame;
    
	[self.view addSubview:self.tableView];
    
//    self.hasNav=NO;
//    CGRect frame =[self visibleBoundsShowNav:NO showTabBar:YES];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7) {
//        frame.origin.y=frame.origin.y;
//        frame.size.height=frame.size.height;
//    }
//    self.tableView.frame = frame;
//    [self.view addSubview:self.tableView];
//    [self.view addSubview:self.bottomView];
    [self getCityFromPlist];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    self.keys = nil;
    self.cities = nil;
    self.tableView = nil;
}

- (UITableView *)tableView
{
	if(!tableView_)
    {
        if (IOS7_OR_LATER) {
            tableView_ = [[UITableView alloc] initWithFrame:CGRectZero
                                                      style:UITableViewStyleGrouped];
        }else
            tableView_ = [[UITableView alloc] initWithFrame:CGRectZero
                                                      style:UITableViewStylePlain];
        
        [tableView_ setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
//		if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7) {
//            tableView_ = [[UITableView alloc] initWithFrame:CGRectZero
//                                                      style:UITableViewStylePlain];
//            [tableView_ setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
//            
//        }else{
//            
//        }
        
		
		
		[tableView_ setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		tableView_.scrollEnabled = YES;
		
		tableView_.userInteractionEnabled = YES;
		
		tableView_.delegate = self;
		
		tableView_.dataSource = self;
        
        tableView_.backgroundView = nil;
		
		tableView_.backgroundColor =[UIColor whiteColor];
        
        UIView *view = [UIView new];
        
        view.backgroundColor = [UIColor clearColor];
        
        tableView_.tableFooterView = view;
		
	}
	
	return tableView_;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)backForePage
{
    [self pressReturn:nil];
}



- (BOOL)checkHardWareIsSupportCallHotLine
{
    
    BOOL isSupportTel = NO;
    
    NSURL *telURL = [NSURL URLWithString:@"tel://4006766766"];
    
    isSupportTel = [[UIApplication sharedApplication] canOpenURL:telURL];
    
    return isSupportTel;
    
}

- (void)callHotLine
{
    if ([self checkHardWareIsSupportCallHotLine]) {
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://4006766766"]]];
        
    }else{       
        
        BBAlertView *alert = [[BBAlertView alloc] 
                              initWithTitle:L(@"Tips")
                              message:L(@"Sorry, Unsupport call tel \n hotline:4006766766")
                              delegate:nil
                              cancelButtonTitle:L(@"Ok")
                              otherButtonTitles:nil];            
        
        [alert show];
        
    }
}



- (UIImageView *)backgroundImageView
{
    if (!backgroundImageView_) {
        backgroundImageView_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_system_background.png"]];
        backgroundImageView_.frame = CGRectMake(0, 44, backgroundImageView_.width, backgroundImageView_.height);
        
    }
    return backgroundImageView_;
}

#pragma mark - bottomView
- (UIView*)bottomView
{
    if(!_bottomView)
    {
        _bottomView = [[UIView alloc] init];
        
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        _bottomView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height -55-20, self.view.frame.size.width, 55);
        [_bottomView addSubview:self.yiGouBtn];
        [_bottomView addSubview:self.backBtn];
        
        UIImageView* lineImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        UIImage* img=[UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
        [lineImage setImage:img];
        TT_RELEASE_SAFELY(img);
        [_bottomView addSubview:lineImage];
        TT_RELEASE_SAFELY(lineImage);
        
    }
    
    return _bottomView;
}

- (UIButton*)backBtn
{
    if(!_backBtn)
    {
        _backBtn = [[UIButton alloc] init];
        
        _backBtn.backgroundColor = [UIColor clearColor];
        
        _backBtn.frame = CGRectMake(0, 6, 44, 44);
        
        [_backBtn setImage:[UIImage imageNamed:@"nav_back_normal.png"] forState:UIControlStateNormal];
        
        [_backBtn setImage:[UIImage imageNamed:@"nav_back_select.png"] forState:UIControlStateHighlighted];
        
        [_backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.bottomView addSubview:_backBtn];
    }
    
    return _backBtn;
}

- (UIButton*)yiGouBtn
{
    if(!_yiGouBtn)
    {
        _yiGouBtn = [[UIButton alloc] init];
        
        _yiGouBtn.backgroundColor = [UIColor clearColor];
        
        _yiGouBtn.frame = CGRectMake(self.view.frame.size.width-57, 10, 57, 35);
        
        [_yiGouBtn setImage:[UIImage imageNamed:@"yigou.png"] forState:UIControlStateNormal];
        [_yiGouBtn setImage:[UIImage imageNamed:@"yigouDown.png"] forState:UIControlStateHighlighted];
        
        [_yiGouBtn addTarget:self action:@selector(goToFirstPage) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bottomView addSubview:_yiGouBtn];
        
    }
    
    return _yiGouBtn;
}

- (void)goToFirstPage
{
    
    [[AppDelegate currentAppDelegate].tabBarViewController setSelectedIndex:0];
    
    [(UINavigationController*)[[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:0] popToRootViewControllerAnimated:NO];
    
    
}

- (void)backBtnAction
{
    [self backForePage];
}
#pragma mark - action

-(void)getCityFromPlist{
    
    curRow = NSNotFound;    
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"HotelCities" ofType:@"plist"]; 
    
    self.cities = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSArray *tempArray = [[cities allKeys] sortedArrayUsingSelector: @selector(compare:)]; 
    
    int index = 0;
    
    for (index = 0; index<[tempArray count]; index++) {
        NSString *str = [tempArray objectAtIndex:index];
        if ([str isEqualToString:L(@"BTTopCity")]){
            break;
        }
    }
    
    
    [self.keys addObjectsFromArray:tempArray];
    
    [self.keys removeObjectAtIndex:index];
    
    [self.keys insertObject:L(@"BTTopCity") atIndex:0];
    
    //get default selection from delegate
    NSString* defaultCity = [delegate getDefaultCity];
    if (defaultCity) {
        NSArray *citySection;
        self.defaultSelectionRow = NSNotFound;
        //set table index to this city if it existed
        for (NSString* key in keys) {
            citySection = [cities objectForKey:key];
            self.defaultSelectionRow = [citySection indexOfObject:defaultCity];
            if (NSNotFound == defaultSelectionRow)
                continue;
            //found match recoard position
            self.defaultSelectionSection = [keys indexOfObject:key];
            break;
        }
        
        if (NSNotFound != defaultSelectionRow) {
            
            self.curSection = defaultSelectionSection;
            self.curRow = defaultSelectionRow;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:defaultSelectionRow inSection:defaultSelectionSection];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
            
        }
    }
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *key = [keys objectAtIndex:section];  
    NSArray *citySection = [cities objectForKey:key];
    return [citySection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    NSString *key = [keys objectAtIndex:indexPath.section];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    } 
    
    // Configure the cell...
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    cell.textLabel.text = [[cities objectForKey:key] objectAtIndex:indexPath.row];
    
    if (indexPath.section == curSection && indexPath.row == curRow)
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{  
    NSString *key = [keys objectAtIndex:section];  
    return key;  
}  
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView  
{  
    return keys;  
} 


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //clear previous
    NSIndexPath *prevIndexPath = [NSIndexPath indexPathForRow:curRow inSection:curSection];
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:prevIndexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    curSection = indexPath.section;
    curRow = indexPath.row;
    
    //add new check mark
    cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    [self pressReturn:self];
}

- (void)pressReturn:(id)sender {
    //notify delegate user selection if it different with default
    if (curRow != NSNotFound) {
        NSString* key = [keys objectAtIndex:curSection];
        [delegate citySelectionUpdate:[[cities objectForKey:key] objectAtIndex:curRow] andViewController:self];
    }
    
    [self dismissModalViewControllerAnimated:YES];
}
@end

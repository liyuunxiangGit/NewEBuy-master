//
//  CityListViewController.m
//
//  Created by Big Watermelon on 11-11-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CityListViewController.h"


@interface CityListViewController ()
@property NSUInteger curSection;
@property NSUInteger curRow;
@property NSUInteger defaultSelectionRow;
@property NSUInteger defaultSelectionSection;
@end

@implementation CityListViewController
//@synthesize tableView = tableView_;
//@synthesize navigationBar = navigationBar_;
@synthesize backgroundImageView = backgroundImageView_;

#define CHECK_TAG 1110

@synthesize cities, keys, curSection, curRow, delegate;
@synthesize defaultSelectionRow, defaultSelectionSection;

- (id)init {
    self = [super init];
    if (self) {
        self.title = L(@"GBChooseCity");
        
        self.pageTitle = L(@"virtual_business_flightCitySelect");
       
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

- (void)backForePage
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - View lifecycle

-(void)loadView{

    [super loadView];

    UIView *contentView = self.view;
	
	CGRect frame = contentView.frame;
	
	frame.origin.x = 0;
	
	frame.origin.y = 0;
	
	frame.size.height = contentView.bounds.size.height - 44;
	
    self.tableView = self.groupTableView;
	self.tableView.frame = frame;
	
//    [self.view addSubview:self.navigationBar];
    
    //[self.view addSubview:self.backgroundImageView];
    self.view.backgroundColor = [UIColor whiteColor];
    
	[self.view addSubview:self.tableView];
    
    [self getCityFromPlist];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    self.keys = nil;
    self.cities = nil;
    self.tableView = nil;
}


//-(UINavigationBar *)navigationBar{
//    
//    if (navigationBar_ == nil) {
//        
//        navigationBar_ = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
//        
//        navigationBar_.tintColor = [UIColor navTintColor];
//        
//        UINavigationItem *navigationItem = [[UINavigationItem alloc]initWithTitle:@"选择城市"];
//        
//        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(pressReturn:)];
//        
//        [navigationItem setLeftBarButtonItem:cancelBtn];
//        
//        if ([navigationBar_ respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
//            
//            UIImage *image = [UIImage imageNamed:@"system_nav_bg.png"];
//            
//            [navigationBar_ setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//
//        }
//               
//        TT_RELEASE_SAFELY(cancelBtn);
//        
//        [navigationBar_ pushNavigationItem:navigationItem animated:NO];
//        
//        TT_RELEASE_SAFELY(navigationItem);
//        
//    }
//    
//    return navigationBar_;
//}

- (UIImageView *)backgroundImageView
{
    if (!backgroundImageView_) {
        backgroundImageView_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_system_background.png"]];
        backgroundImageView_.frame = CGRectMake(0, 44, backgroundImageView_.width, backgroundImageView_.height);
        
    }
    return backgroundImageView_;
}


#pragma mark - action

-(void)getCityFromPlist{

    curRow = NSNotFound;    
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"citydict" ofType:@"plist"]; 
        
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

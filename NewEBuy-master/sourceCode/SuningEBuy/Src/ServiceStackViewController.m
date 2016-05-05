//
//  ServiceStackViewController.m
//  SuningEBuy
//
//  Created by wei xie on 12-9-7.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ServiceStackViewController.h"
#import "ServiceTrackListViewController.h"
#import "ServiceTrackingViewController.h"
#import "BookingViewController.h"

@implementation ServiceStackViewController

@synthesize serviceTrack = _serviceTrack;

@synthesize serviceApply = _serviceApply;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_serviceTrack);
    TT_RELEASE_SAFELY(_serviceApply);
    
}

- (id)init
{
    self = [super init];
	
    if (self) {
		
        self.title = L(@"ServiceStack");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"member_myEbuy"),self.title];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark -
#pragma mark property methods

- (UITableView *)tableView
{
	if(!_tableView){
		
		_tableView = [UITableView groupTableView];
		
		[_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[_tableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_tableView.scrollEnabled = YES;
		
		_tableView.userInteractionEnabled = YES;
		
		_tableView.delegate = self;
		
		_tableView.dataSource = self;
		
		_tableView.backgroundColor = [UIColor clearColor];
	}
	
	return _tableView;
}

//Head View Of Section
- (UIView *)serviceTrack
{
    if (!_serviceTrack)
    {
        _serviceTrack = [[UIView alloc] init];
        _serviceTrack.frame = CGRectMake(0, 0, 320, 48);
        
        UILabel *nameLbl = [[UILabel alloc] init];
        nameLbl.frame = CGRectMake(45, 26, 320, 17);
        nameLbl.backgroundColor = [UIColor clearColor];
        nameLbl.text = L(@"ServiceTrack");
        nameLbl.textColor = [UIColor colorWithRed:0 green:75.0/255 blue:163.0/255 alpha:1.0];
        nameLbl.font = [UIFont fontWithName:@"Heiti SC Medium" size:17.0];
        [_serviceTrack addSubview:nameLbl];
        TT_RELEASE_SAFELY(nameLbl);
        
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.frame = CGRectMake(15, 25, 20, 20);
        iconView.image = [UIImage imageNamed:@"serviceStack_icon_fw.png"];
        [_serviceTrack addSubview:iconView];
        TT_RELEASE_SAFELY(iconView);
    }
    
    return _serviceTrack;
}

- (UIView *)serviceApply
{
    if (!_serviceApply)
    {
        _serviceApply = [[UIView alloc] init];
        _serviceApply.frame = CGRectMake(0, 0, 320, 36);
        
        UILabel *nameLbl = [[UILabel alloc] init];
        nameLbl.frame = CGRectMake(45, 14, 320, 19);
        nameLbl.backgroundColor = [UIColor clearColor];
        nameLbl.text = L(@"ServiceApply");
        nameLbl.textColor = [UIColor colorWithRed:0 green:75.0/255 blue:163.0/255 alpha:1.0];
        nameLbl.font = [UIFont fontWithName:@"Heiti SC Medium" size:17.0];
        [_serviceApply addSubview:nameLbl];
        TT_RELEASE_SAFELY(nameLbl);
        
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.frame = CGRectMake(15, 13, 20, 20);
        iconView.image = [UIImage imageNamed:@"serviceStack_icon_sq.png"];
        [_serviceApply addSubview:iconView];
        TT_RELEASE_SAFELY(iconView);
        
    }
    
    return _serviceApply;
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    
    self.tableView.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:YES];
    
    [self.view addSubview:self.tableView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Table view data source / delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 2;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (cell == nil) 
    {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch ([indexPath section])
    {
        case 0:
            switch ([indexPath row]) {
                case 0:
                    cell.textLabel.text = L(@"DiliverQueary");
                    break;
                case 1:
                    cell.textLabel.text = L(@"RepairQueary");   
                default:
                    break;
            }
            break;
        case 1:
            cell.textLabel.text = L(@"OrderApply");
            break;
        default:
            break;
    }
	
	return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *tempView = [[UIView alloc] init];
    
    switch (section)
    {
        case 0:{
            
            tempView = self.serviceTrack;
            
            break;
        }
        case 1:{
            
            tempView = self.serviceApply;
            
            break;
        }
        default:
            break;
    }
    
    return tempView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (0 == section ? 48 : 36);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath section]) 
    {
        case 0:{
            
            switch ([indexPath row]) 
            {
                case 0:{
                    ServiceTrackListViewController *nextViewController = [[ServiceTrackListViewController alloc] init];
                    [self.navigationController pushViewController:nextViewController animated:YES];
                    TT_RELEASE_SAFELY(nextViewController);
                                    
                    break;
                }
                /*    
                case 1:{          
                    ServiceTrackingViewController   *serviceTrackingViewController = [[ServiceTrackingViewController alloc] init];
//                    serviceTrackingViewController.titleString = L(@"RepairQueary");
//                    serviceTrackingViewController.chooseType = NO;
                    [self.navigationController pushViewController:serviceTrackingViewController animated:YES];
                    TT_RELEASE_SAFELY(serviceTrackingViewController);
                    break;
                }
                 */
                    
                default:
                    break;
            }
            
            break;
        }
            
        case 1:{
            
            BookingViewController   *bookingViewController = [[BookingViewController alloc] init];
            
            [self.navigationController pushViewController:bookingViewController animated:YES];
            
            TT_RELEASE_SAFELY(bookingViewController);
            
            break;
        }
            
        default:
            break;
    }
}



@end

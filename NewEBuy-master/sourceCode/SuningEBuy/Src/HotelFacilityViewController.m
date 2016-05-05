//
//  HotelFacilityViewController.m
//  SuningEBuy
//
//  Created by robin wang on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HotelFacilityViewController.h"

@implementation HotelFacilityViewController

@synthesize contentTextView = _contentTextView;

@synthesize numberLbl = _numberLbl;

@synthesize postDto = _postDto;


- (id)init
{
    self = [super init];
    
    if (self) {
        
        self.title = L(@"facilityService");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_business"),self.title];
    }
    
    return self;
} 

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_contentTextView);
    
    TT_RELEASE_SAFELY(_numberLbl);

    TT_RELEASE_SAFELY(_postDto);
    
}

- (void)HttpRelease
{
    DLog(@"Http Release \n");
    
    HTTP_RELEASE_SAFELY(sendCommendASIHTTPRequest);
}

- (UILabel *)numberLbl
{
    if (_numberLbl == nil) 
    {
        
        UIFont *font = [UIFont boldSystemFontOfSize:17];
        
		_numberLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
		
//		_numberLbl.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        _numberLbl.backgroundColor = [UIColor clearColor];
		
		_numberLbl.font = font;
		
		_numberLbl.autoresizingMask = UIViewAutoresizingNone;
        
        _numberLbl.textAlignment = UITextAlignmentCenter;
        
    }
    return _numberLbl;
}

- (UITextView *)contentTextView{
    
    if (_contentTextView == nil) {
        
        CGRect frame = CGRectMake(0, _numberLbl.bottom, 320, self.view.bounds.size.height - 92-60);
        
        _contentTextView = [[UITextView alloc] initWithFrame:frame];
        
        _contentTextView.textColor = [UIColor blackColor];
        
        _contentTextView.backgroundColor = [UIColor whiteColor];
        
        _contentTextView.font = [UIFont systemFontOfSize:15.0];
        
        _contentTextView.userInteractionEnabled = YES;
        
        [_contentTextView setDelegate:self];
        //[self.view addSubview:_contentTextView];
        
    }
    return _contentTextView;
}

#pragma mark -
#pragma mark View lifecycle
- (void)loadView
{
    [super loadView];
    [self.view addSubview: self.numberLbl];
    
    self.numberLbl.text = self.postDto.name;

    UIView *contentView = self.view;
    
    CGRect frame = contentView.frame;
    
    frame.origin.x = 0;
    frame.origin.y=self.numberLbl.bottom;
    frame.size.height = contentView.bounds.size.height - 44-self.numberLbl.height;
    
    self.tableView.frame = frame;
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self.tableView setSeparatorStyle:UITableViewCellSelectionStyleNone];
    [self.view addSubview:self.tableView];

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    return NO;
}

#pragma mark -
#pragma mark Table View Delegate Methods
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 41;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView* view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 41)];
//    [view setBackgroundColor:[UIColor whiteColor]];
//    [view addSubview:self.numberLbl];
//    self.numberLbl.text = self.postDto.name;
//
//    UIImageView* lineImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 320, 1)];
//    UIImage* img=[UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
//    [lineImage setImage:img];
//    [view addSubview:lineImage];
//    
//    return view;
//    
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.postDto.serviceItemList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotelDetailImageListDTO *tempDto = [self.postDto.serviceItemList objectAtIndex:indexPath.row];
    
    return [HotelServiceInfoCell height: tempDto];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CustomCellIdentifier = @"CustomCellIdentifier";
    
    HotelServiceInfoCell *cell = (HotelServiceInfoCell *)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    
    if(cell == nil){
        
        cell = [[HotelServiceInfoCell alloc]initWithReuseIdentifier:CustomCellIdentifier];
        
        //cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    HotelDetailImageListDTO *tempDto = [self.postDto.serviceItemList objectAtIndex: indexPath.row];
    
    if (tempDto ==nil) {
        return nil;
    }
    
    cell.merchItemDTO = tempDto;
    
    return cell;
}


@end

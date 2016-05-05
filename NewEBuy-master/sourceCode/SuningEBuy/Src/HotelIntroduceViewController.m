//
//  HotelIntroduceViewController.m
//  SuningEBuy
//
//  Created by robin wang on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HotelIntroduceViewController.h"

@implementation HotelIntroduceViewController

@synthesize postDto = _postDto;

@synthesize parseDto = _parseDto;

@synthesize titelView = _titelView;

@synthesize contentTextView = _contentTextView;


- (id)init
{
    self = [super init];
    
    if (self) {
        
        self.title = L(@"hotelIntroduce");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_business"),self.title];
    }
    
    return self;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_postDto);
    
    TT_RELEASE_SAFELY(_parseDto);
    
    TT_RELEASE_SAFELY(_titelView);
    
    TT_RELEASE_SAFELY(_contentTextView);
    
}

- (void)HttpRelease
{
    DLog(@"Http Release \n");
    
    HTTP_RELEASE_SAFELY(sendCommendASIHTTPRequest);
}

-(HotelIntroduceTitelCell *)titelView
{
    if (!_titelView) {
        
        _titelView  = [[HotelIntroduceTitelCell alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
        
        _titelView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        
    }
    
    return _titelView;
}

- (UITextView *)contentTextView{
    
    if (_contentTextView == nil) {
        
        CGRect frame = CGRectMake(0, _titelView.bottom, 320, self.view.bounds.size.height - 92-self.titelView.height);
        
        _contentTextView = [[UITextView alloc] initWithFrame:frame];
        
        _contentTextView.textColor = [UIColor blackColor];
        
        _contentTextView.backgroundColor = [UIColor whiteColor];
        
        _contentTextView.font = [UIFont systemFontOfSize:15.0];
        
        _contentTextView.userInteractionEnabled = YES;
        
        [_contentTextView setDelegate:self];
        
    }
    return _contentTextView;
}

#pragma mark -
#pragma mark View lifecycle
- (void)loadView
{
    [super loadView];

    self.titelView.merchItemDTO = self.postDto;
    
    [self.view addSubview: self.titelView];
    
    self.contentTextView.top = self.titelView.bottom;
    
    self.contentTextView.text = self.postDto.introduce;
    
    [self.view addSubview: self.contentTextView];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    return NO;
}

@end

//
//  OWBAuthorizeWebView.m
//  SinaWeiBoSDK
//  Based on OAuth 2.0
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//
//  Copyright 2011 Sina. All rights reserved.
//

#import "OWBAuthorizeWebView.h"
#import <QuartzCore/QuartzCore.h> 


@implementation OWBAuthorizeWebView

@synthesize delegate;
@synthesize  dlgTimer = _dlgTimer;


#pragma mark - OWBAuthorizeWebView Life Circle

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        // background settings
        [self setBackgroundColor:[UIColor redColor]];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        
        // add the web view
        webView = [[UIWebView alloc] initWithFrame:self.bounds];
        webView.scalesPageToFit = YES;
		[webView setDelegate:self];
		[self addSubview:webView];
        
    }
    return self;
}


- (void)dealloc
{
    webView = nil;
    
    [_dlgTimer invalidate];
    
}




#pragma mark - OWBAuthorizeWebView Public Methods

- (void)loadRequestWithURL:(NSURL *)url
{
    NSURLRequest *request =[NSURLRequest requestWithURL:url
                                            cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                        timeoutInterval:60.0];
    [webView loadRequest:request];
}




#pragma mark - UIWebViewDelegate Methods

- (void)webViewDidStartLoad:(UIWebView *)aWebView
{
    [self displayOverFlowActivityView:L(@"loading...")];
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView
{    
    [self removeOverFlowActivityView];
}

- (void)webView:(UIWebView *)aWebView didFailLoadWithError:(NSError *)error
{
    [self removeOverFlowActivityView];
}

- (BOOL)webView:(UIWebView *)aWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    DLog(@"request is %@", [request URL]);
    
    NSRange range = [request.URL.absoluteString rangeOfString:@"code="];
    
    if (range.location != NSNotFound)
    {
        NSString *code = [request.URL.absoluteString substringFromIndex:range.location + range.length];
        
        if ([delegate respondsToSelector:@selector(authorizeWebView:didReceiveAuthorizeCode:)])
        {
            [delegate authorizeWebView:self didReceiveAuthorizeCode:code];
        }
    }
    
    return YES;
}


- (void)displayOverFlowActivityView:(NSString*)indiTitle{
	
	[self showActivityViewAtCenter:indiTitle ];
	
	
	self.dlgTimer= [NSTimer scheduledTimerWithTimeInterval:20.0f target:self selector: @selector(timerOutRemoveOverFlowActivityView)
                                                  userInfo:nil repeats:NO];
	
	return;	
}


- (void)removeOverFlowActivityView
{
	
	[self hideActivityViewAtCenter ];
	
	return;
}

- (void)timerOutRemoveOverFlowActivityView
{
	
	[self hideActivityViewAtCenter ];
	
	return;
}
@end

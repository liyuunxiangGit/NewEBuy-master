//
//  OWBAuthorizeWebView.h
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

#import <Foundation/Foundation.h>
#import "UIView+ActivityIndicator.h"


@class OWBAuthorizeWebView;

@protocol OWBAuthorizeWebViewDelegate <NSObject>

- (void)authorizeWebView:(OWBAuthorizeWebView *)webView didReceiveAuthorizeCode:(NSString *)code;

@end

@interface OWBAuthorizeWebView : UIView <UIWebViewDelegate> 
{
	UIWebView *webView;
    id<OWBAuthorizeWebViewDelegate> __weak delegate;
    
    NSTimer                 *_dlgTimer;                                 
          
}

@property (nonatomic, weak) id<OWBAuthorizeWebViewDelegate> delegate;
@property (nonatomic, strong) NSTimer           *dlgTimer; 


- (void)loadRequestWithURL:(NSURL *)url;
- (void)displayOverFlowActivityView:(NSString*)indiTitle;
- (void)removeOverFlowActivityView;
- (void)timerOutRemoveOverFlowActivityView;


@end
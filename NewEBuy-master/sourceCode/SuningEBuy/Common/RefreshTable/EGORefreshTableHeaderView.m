//
//  EGORefreshTableHeaderView.m
//  Demo
//
//  Created by Devin Doty on 10/14/09October14.
//  Copyright 2009 enormego. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "EGORefreshTableHeaderView.h"


#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define BORDER_COLOR [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]

#define UPIMG  [UIImage imageNamed:@"jiantou03_"]
#define REFRESH  [UIImage imageNamed:@"shuaxin_"]
@implementation EGORefreshTableHeaderView

@synthesize state=_state;


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
		lastUpdatedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 20.0f, self.frame.size.width, 20.0f)];
		lastUpdatedLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		lastUpdatedLabel.font = [UIFont systemFontOfSize:12.0f];
		lastUpdatedLabel.textColor = [UIColor colorWithRGBHex:0x909090];
		lastUpdatedLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		lastUpdatedLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		lastUpdatedLabel.backgroundColor = [UIColor clearColor];
		lastUpdatedLabel.textAlignment = UITextAlignmentCenter;
		[self addSubview:lastUpdatedLabel];

        //gjf 注释
//		if ([[NSUserDefaults standardUserDefaults] objectForKey:@"EGORefreshTableView_LastRefresh"]) {
//			lastUpdatedLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"EGORefreshTableView_LastRefresh"];
//		} else {
//			[self setCurrentDate];
//		}
		
		statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 48.0f, self.frame.size.width, 20.0f)];
		statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		statusLabel.font = [UIFont boldSystemFontOfSize:13.0f];
		statusLabel.textColor = [UIColor colorWithRGBHex:0x909090];
		statusLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		statusLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		statusLabel.backgroundColor = [UIColor clearColor];
		statusLabel.textAlignment = UITextAlignmentCenter;
		[self setState:EGOOPullRefreshNormal];
//		[self addSubview:statusLabel];
		
        //edit by gjf
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        backImage = [[UIImageView alloc] initWithFrame:CGRectMake((width-120)/2., frame.size.height - 48.0f -10, 120, 30)];
        backImage.image = [UIImage imageNamed:@"suning_logo"];
        [self addSubview:backImage];
        
		arrowImage = [[CALayer alloc] init];
        CGSize labelSize = [lastUpdatedLabel.text sizeWithFont:lastUpdatedLabel.font];
		arrowImage.frame = CGRectMake((width-labelSize.width)/2-20, frame.size.height - 18, 15., 15.);
		arrowImage.contentsGravity = kCAGravityResizeAspect;
		arrowImage.contents = (id)UPIMG.CGImage;
		[[self layer] addSublayer:arrowImage];
		
        refreshImg = [[UIImageView alloc] initWithImage:REFRESH];
        refreshImg.frame = arrowImage.frame;
        refreshImg.backgroundColor = [UIColor clearColor];
        [self addSubview:refreshImg];
        
		activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		activityView.frame = CGRectMake(25.0f, frame.size.height - 38.0f, 20.0f, 20.0f);
		activityView.hidesWhenStopped = YES;
		[self addSubview:activityView];
		
    }
    return self;
}


- (void)drawRect:(CGRect)rect{
    /*
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextDrawPath(context,  kCGPathFillStroke);
	[BORDER_COLOR setStroke];
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, 0.0f, self.bounds.size.height - 1);
	CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height - 1);
	CGContextStrokePath(context);
     */
}

-(void)setBegin{
    NSString *lastString = L(@"Updated Begin");
    
    lastUpdatedLabel.text = [NSString stringWithFormat:@"%@",lastString];
    lastUpdatedLabel.font = [UIFont boldSystemFontOfSize:12];
    
}

- (void)setCurrentDate {
	NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	
	
	if([Config currentConfig].isAMPM == [NSNumber numberWithBool:YES]){
	
		[formatter setAMSymbol:@"AM"];
		
		[formatter setPMSymbol:@"PM"];
		
		[formatter setDateFormat:@"yyyy/MM/dd hh:mm:a"];
		
	}
	else{
		
		[formatter setDateFormat:@"yyyy/MM/dd hh:mm"];
	}
	
	NSString *lastString = L(@"Last Updated");
	
	lastUpdatedLabel.text = [NSString stringWithFormat:@"%@",lastString];
    lastUpdatedLabel.font = [UIFont boldSystemFontOfSize:12];
	[[NSUserDefaults standardUserDefaults] setObject:lastUpdatedLabel.text forKey:@"EGORefreshTableView_LastRefresh"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setState:(EGOPullRefreshState)aState{
    arrowImage.hidden = NO;
    refreshImg.hidden = YES;
	switch (aState) {
		case EGOOPullRefreshPulling:
			lastUpdatedLabel.text = L(@"Last Updated");
            [CATransaction begin];
            [CATransaction setAnimationDuration:.18];
            arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
            [CATransaction commit];
			break;
		case EGOOPullRefreshNormal:
            lastUpdatedLabel.text =L(@"Last Updated");
            if (_state == EGOOPullRefreshPulling) {
                [CATransaction begin];
                [CATransaction setAnimationDuration:.18];
                arrowImage.transform = CATransform3DIdentity;
                [CATransaction commit];
                lastUpdatedLabel.text = L(@"Last Updated");

            }
            
			
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
            arrowImage.hidden = NO;
            arrowImage.transform = CATransform3DIdentity;
            [CATransaction commit];
			break;
        case EGOOPullRefreshLoading:{
            refreshImg.hidden = NO;
            lastUpdatedLabel.text = L(@"Refresh now...");
            CABasicAnimation* rotationAnimation;
            rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            rotationAnimation.duration = 2;
            rotationAnimation.RepeatCount = 1000;
            rotationAnimation.cumulative = NO;
            rotationAnimation.removedOnCompletion = NO;
            rotationAnimation.fillMode = kCAFillModeForwards;
            [refreshImg.layer addAnimation:rotationAnimation forKey:@"Rotation"];
//			[activityView startAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
			arrowImage.hidden = YES;
			[CATransaction commit];
        }
			break;
        default:
			break;
	}
	
	_state = aState;
}

- (void)dealloc {
	activityView = nil;
	statusLabel = nil;
	arrowImage = nil;
	lastUpdatedLabel = nil;
}


@end

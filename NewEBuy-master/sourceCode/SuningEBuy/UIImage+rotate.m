//
//  UIImage+rotate.m
//  iweibo
//
//  Created by Minwen Yi on 3/23/12.
//  Copyright 2012 Beyondsoft. All rights reserved.
//

#import "UIImage+rotate.h"



@implementation UIImage(Rotate)

-(UIImage*)rotateImage:(UIImageOrientation)orient
{
	CGRect			bnds = CGRectZero;
	UIImage*		   copy = nil;
	CGContextRef	  ctxt = nil;
	CGRect			rect = CGRectZero;
	CGAffineTransform  tran = CGAffineTransformIdentity;
	bnds.size = self.size;
	rect.size = self.size;
	//CLog("%s, %d", __FUNCTION__, orient);
	switch (orient)
	{
		case UIImageOrientationUp:
			return self;
		case UIImageOrientationUpMirrored:
			tran = CGAffineTransformMakeTranslation(rect.size.width, 0.0);
			tran = CGAffineTransformScale(tran, -1.0, 1.0);
			break;
		case UIImageOrientationDown:
			tran = CGAffineTransformMakeTranslation(rect.size.width,
													rect.size.height);
			tran = CGAffineTransformRotate(tran, degreesToRadians(180.0));
			break;
		case UIImageOrientationDownMirrored:
			tran = CGAffineTransformMakeTranslation(0.0, rect.size.height);
			tran = CGAffineTransformScale(tran, 1.0, -1.0);
			break;
		case UIImageOrientationLeft: {
			//CGFloat wd = bnds.size.width;
//			bnds.size.width = bnds.size.height;
//			bnds.size.height = wd;
			tran = CGAffineTransformMakeTranslation(0.0, rect.size.width);
			tran = CGAffineTransformRotate(tran, degreesToRadians(-90.0));
		}
			break;
		case UIImageOrientationLeftMirrored: {
			//CGFloat wd = bnds.size.width;
//			bnds.size.width = bnds.size.height;
//			bnds.size.height = wd;
			tran = CGAffineTransformMakeTranslation(rect.size.height,
													rect.size.width);
			tran = CGAffineTransformScale(tran, -1.0, 1.0);
			tran = CGAffineTransformRotate(tran, degreesToRadians(-90.0));
		}
			break;
		case UIImageOrientationRight: {
			CGFloat wd = bnds.size.width;
			bnds.size.width = bnds.size.height;
			bnds.size.height = wd;
			tran = CGAffineTransformMakeTranslation(rect.size.height, 0.0);
			tran = CGAffineTransformRotate(tran, degreesToRadians(90.0));
		}
			break;
		case UIImageOrientationRightMirrored: {
			//CGFloat wd = bnds.size.width;
//			bnds.size.width = bnds.size.height;
//			bnds.size.height = wd;
			tran = CGAffineTransformMakeScale(-1.0, 1.0);
			tran = CGAffineTransformRotate(tran, degreesToRadians(90.0));
		}
			break;
		default:
			// orientation value supplied is invalid
			assert(false);
			return nil;
	}
	UIGraphicsBeginImageContext(rect.size);
	ctxt = UIGraphicsGetCurrentContext();
	switch (orient)
	{
		case UIImageOrientationLeft:
		case UIImageOrientationLeftMirrored:
		case UIImageOrientationRight:
		case UIImageOrientationRightMirrored:
			CGContextScaleCTM(ctxt, -1.0 * (rect.size.width / rect.size.height), 1.0 * (rect.size.height / rect.size.width));
			CGContextTranslateCTM(ctxt, -rect.size.height, 0.0);
			break;
		default:
			CGContextScaleCTM(ctxt, 1.0, -1.0);
			CGContextTranslateCTM(ctxt, 0.0, -rect.size.height);
			break;
	}
	CGContextConcatCTM(ctxt, tran);
	CGContextDrawImage(ctxt, rect, self.CGImage);
	copy = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return copy;
}

@end



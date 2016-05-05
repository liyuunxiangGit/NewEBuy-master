//
//  BMKPOILocationService.m
//  SuningEBuy
//
//  Created by XZoscar on 14-10-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BMKPOILocationService.h"
#import "NBCCSharedData.h"
#import "BMapKit.h"

@interface BMKPOILocationService () <BMKGeoCodeSearchDelegate>
@property (nonatomic,strong) BMKGeoCodeSearch *poiSearch;
@end


@implementation BMKPOILocationService

- (void)dealloc {
    self.poiSearch.delegate = nil;
    self.poiSearch = nil;
}

- (void)stopLocation {
    
    self.isLocationing = NO;
    
    self.poiSearch.delegate = nil;
    self.poiSearch = nil;
}

- (void)startLocation {
    if (nil == _poiSearch) {
        self.poiSearch = [[BMKGeoCodeSearch alloc] init];
    }
    if (_poiSearch.delegate == nil) {
        _poiSearch.delegate = self;
    }
    
    self.isLocationing = YES;
    
    BMKReverseGeoCodeOption *op = [[BMKReverseGeoCodeOption alloc] init];
    // CLLocationCoordinate2D
    op.reverseGeoPoint = [NBCCSharedData shared].coordinate;
    [_poiSearch reverseGeoCode:op];
}

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher
                           result:(BMKReverseGeoCodeResult *)result
                        errorCode:(BMKSearchErrorCode)error {
    
    if (nil != _delegate
        && [_delegate respondsToSelector:@selector(delegate_BMKPOILocationServiceResponse:error:)]) {
        
        NSError *err = nil;
        if (error == BMK_SEARCH_NO_ERROR) {
            err = nil;
        }else if (error == BMK_SEARCH_RESULT_NOT_FOUND) {
            err = [NSError errorWithDomain:@""
                                      code:-1
                                  userInfo:@{NSLocalizedDescriptionKey:L(@"SorryDontFindLocateResult")}];
        }else {
            err = [NSError errorWithDomain:@""
                                      code:-1
                                  userInfo:@{NSLocalizedDescriptionKey:L(@"SorryLocateFail")}];
        }
        
        [_delegate delegate_BMKPOILocationServiceResponse:result.poiList
                                                    error:err];
    }
    
    [self stopLocation];
}

@end

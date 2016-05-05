//
//  V2FristCategoryDTO.h
//  SuningEBuy
//
//  Created by li xiaokai on 13-4-8.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpDTO.h"
#import "V2SecCategoryDTO.h"

@interface V2FristCategoryDTO : BaseHttpDTO{
    
    NSString    *_categoryId;    
	NSString	*_categoryName;
	NSString	*_categoryCode;
    NSString    *_categoryDes;
	NSString	*_categoryImageURL;
    NSString    *_catelogIds;
    
    NSMutableArray     *_secList;
    NSMutableArray     *_thirdList;

    NSString    *_kindId;
	NSString	*_parentId;
	NSString	*_kindName;
    NSString    *_kindDesc;
	NSString	*_pictureUrl;
    NSString    *_chaKind;
    NSString    *_usingRel;
    NSString    *_ci;
    NSString    *_cf;

}
@property (nonatomic, strong)   NSString	 *categoryId;
@property (nonatomic, strong)   NSString	 *categoryName;
@property (nonatomic, strong)   NSString	 *categoryCode;
@property (nonatomic, strong)   NSString	 *categoryDes;
@property (nonatomic, strong)   NSString	 *categoryImageURL;
@property (nonatomic, strong)   NSString     *catelogIds;

@property (nonatomic, strong)   NSMutableArray      *secList;
@property (nonatomic, strong)   NSMutableArray      *thirdList;

@property (nonatomic, strong)   NSString	 *kindId;
@property (nonatomic, strong)   NSString	 *parentId;
@property (nonatomic, strong)   NSString	 *kindName;
@property (nonatomic, strong)   NSString	 *kindDesc;
@property (nonatomic, strong)   NSString	 *pictureUrl;
@property (nonatomic, strong)   NSString     *chaKind;
@property (nonatomic, strong)   NSString     *usingRel;
@property (nonatomic, strong)   NSString     *ci;
@property (nonatomic, strong)   NSString     *cf;

@end

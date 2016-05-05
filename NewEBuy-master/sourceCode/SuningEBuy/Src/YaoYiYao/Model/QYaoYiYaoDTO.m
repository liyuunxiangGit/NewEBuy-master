//
//  QYaoYiYaoDTO.m
//  SuningEBuy
//
//  Created by XZoscar on 14-4-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "QYaoYiYaoDTO.h"

@implementation QHttpObject
@end

@implementation QYaoQueryDTO
@end

@implementation QYaoChouJiangDTO
@end

@implementation QYaoCloneValidateDTO
@end

@implementation QYaoScoreParkItemDTO
@end

@implementation QYaoScoreParkGrpDTO

- (id)init {
    if (self = [super init]) {
        self.items = [NSMutableArray array];
    }
    
    return self;
}

@end

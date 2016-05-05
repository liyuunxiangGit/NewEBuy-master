//
//  EvalutionContentViewController.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-4-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceholderTextView.h"
#import "NewEvalutionService.h"
#import "EvalutionDTO.h"

#import "DLStarRatingControl.h"
#import "EvaluationBsicDTO.h"
#import "AllOrderDetailCommonViewController.h"
@interface EvalutionContentViewController : AllOrderDetailCommonViewController<UITextFieldDelegate,UITextViewDelegate,NewEvalutionServiceDelegate,EGOImageViewDelegate,DLStarRatingDelegate>

@property (nonatomic, strong) EvalutionDetailDTO      *evalutionDto;

@property (nonatomic, strong) EvalutionDTO            *evalDto;

@property (nonatomic, strong) NewEvalutionService *evalutionService;

@property (nonatomic, strong) DLStarRatingControl  *StarRatingControl;

@property (nonatomic, strong) PlaceholderTextView *contentTextView;

@property (nonatomic, strong) UIImageView         *headView;

@property (nonatomic, strong) UIView             *evalutionView;

@property (nonatomic, strong) UIView             *evaluServiceView;

@property (nonatomic, strong) EvaluationBsicDTO      *evaluationBasicDto;

@property (nonatomic, strong) UIButton     *anonBtn;

@property (nonatomic, assign) BOOL         showReviewStatus;

@end

//
//  HsbcUISlideWebviewController.h
//  TestApp4
//
//  Created by jeffrey on 9/5/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import "HsbcUIWebviewController.h"

#define BASE_VIEW_TAG -1
#define MAIN_VIEW_TAG -2
#define LEFT_VIEW_TAG -3
#define RIGHT_VIEW_TAG -4

// for KVC/KVO support
#define HsbcUISlideWebviewController_kvcPath @"mainViewEnabled", @"leftViewEnabled", @"leftViewHidden", @"rightViewEnabled", @"rightViewHidden", nil

// for slide effect
#define CORNER_RADIUS 4
#define SLIDE_TIMING .25
#define PANEL_WIDTH 60

@interface HsbcUISlideWebviewController : HsbcUIWebviewController <HsbcUI, UIGestureRecognizerDelegate>

@property (nonatomic)HsbcUIWebviewController *mainWebviewController;
@property (nonatomic)HsbcUIWebviewController *leftWebviewController;
@property (nonatomic)HsbcUIWebviewController *rightWebviewController;

@property (nonatomic, assign) BOOL gestureExceedHalfWay;
@property (nonatomic, assign) CGPoint preVelocity;

// for KVC/KVO support
@property(nonatomic,getter=isMainViewEnabled) NSNumber *mainViewEnabled;
@property(nonatomic,getter=isLeftViewEnabled) NSNumber *leftViewEnabled;
@property(nonatomic,getter=isLeftViewHidden) NSNumber *leftViewHidden;
@property(nonatomic,getter=isRightViewEnabled) NSNumber *rightViewEnabled;
@property(nonatomic,getter=isRightViewHidden) NSNumber *rightViewHidden;

//=== instance method ===//
-(int) tag;
-(void)initMainView:(HsbcUIWebviewController *)newWebviewController withNibName:(NSString *)nibName;
-(void)initLeftView:(HsbcUIWebviewController *)newWebviewController withNibName:(NSString *)nibName;
-(HsbcUIViewController *)getSubViewControllerByTag:(int)tagValue;

@end
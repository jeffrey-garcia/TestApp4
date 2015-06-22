//
//  HsbcUIViewController.h
//  TestApp4
//
//  Created by jeffrey on 4/5/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Foundation/Foundation.h"

@interface HsbcUIViewController : UIViewController

enum SCREEN_TRANSITION {
    RIGHT_TO_LEFT =1,
    LEFT_TO_RIGHT,
    BOTTOM_TO_TOP,
    TOP_TO_BOTTOM
};

//=== instance method ===//
- (void)viewWillAppear:(BOOL)animated;
- (void)didReceiveMemoryWarning;
- (void)viewWillDisappear:(BOOL)animated;

- (void)dismissKeyboard;

- (void) dismissViewController:(enum SCREEN_TRANSITION) transition;
- (void) presentViewController:(UIViewController *) newViewController withTransition:(enum SCREEN_TRANSITION) transition;

- (UIView *)getViewFromXib:(UIView *)view forClassName:(NSString *)className;
- (void)createObserver;
- (void)createObserverFromView:(UIView *)view;
- (void)removeObserverFromView:(UIView *)view;
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)sender change:(NSDictionary *)change context:(void *)context;

-(id)lookupHsbcUI:(HsbcUIViewController *)viewController withTag:(int) tagValue targetClassName:(NSString *)className;

@end

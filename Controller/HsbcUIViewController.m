//
//  HsbcUIViewController.m
//  TestApp4
//
//  Created by jeffrey on 4/5/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import "HsbcUI.h"
#import "HsbcUIViewController.h"
#import "HsbcUISlideWebviewController.h"

@interface HsbcUIViewController ()

@end

@implementation HsbcUIViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)dismissKeyboard
{
    [self.view endEditing:YES];
}

-(void) dismissViewController:(enum SCREEN_TRANSITION)transition
{
    CATransition *transition_dismiss = [CATransition animation];
    transition_dismiss.duration = 0.3;
    transition_dismiss.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition_dismiss.type = kCATransitionPush;
    
    switch (transition) {
        case RIGHT_TO_LEFT:
            transition_dismiss.subtype = kCATransitionFromRight;
            break;
            
        case LEFT_TO_RIGHT:
            transition_dismiss.subtype = kCATransitionFromLeft;
            break;
            
        case BOTTOM_TO_TOP:
            transition_dismiss.subtype = kCATransitionFromTop;
            break;
            
        case TOP_TO_BOTTOM:
            transition_dismiss.subtype = kCATransitionFromBottom;
            break;
            
        default:
            break;
    }
    
    [self.view.window.layer addAnimation:transition_dismiss forKey:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) presentViewController:(UIViewController *)newViewController withTransition:(enum SCREEN_TRANSITION)transition
{
    CATransition *transition_present = [CATransition animation];
    transition_present.duration = 0.3;
    transition_present.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition_present.type = kCATransitionPush;
    
    switch (transition) {
        case RIGHT_TO_LEFT:
            transition_present.subtype = kCATransitionFromRight;
            break;
            
        case LEFT_TO_RIGHT:
            transition_present.subtype = kCATransitionFromLeft;
            break;
            
        case BOTTOM_TO_TOP:
            transition_present.subtype = kCATransitionFromTop;
            break;
            
        case TOP_TO_BOTTOM:
            transition_present.subtype = kCATransitionFromBottom;
            break;
            
        default:
            break;
    }
    
    [self.view.window.layer addAnimation:transition_present forKey:nil];
    [self presentViewController:newViewController animated:NO completion:nil];
}

- (UIView *)getViewFromXib:(UIView *)view forClassName:(NSString *)className
{
    UIView *foundView;
    
    // if view is target class return it
    if ([view isKindOfClass:NSClassFromString(className)]) {
        return view; // found the view and quit immediately
    }
    
    // Get the subviews of the view
    NSArray *subviews = [view subviews];
    
    // Return if there are no subviews
    if ([subviews count] == 0) return nil; // COUNT CHECK LINE
    
    for (UIView *subview in subviews) {
        if ([subview isKindOfClass:NSClassFromString(className)]) {
            foundView = subview;
            break;
        } else {
            // List the subviews of subview
            foundView = [self getViewFromXib:subview forClassName:className];
        }
    }
    
    return foundView;
}

- (void)createObserver
{
    if ([self conformsToProtocol:@protocol(HsbcUI)]) {
        [self createObserverFromHsbcUI:self];
    }
    [self createObserverFromView:self.view];
}

- (void)createObserverFromView:(UIView *)view
{
    // Testing only!!!
//    NSString *className = NSStringFromClass([view class]);
//    NSRange index = [className rangeOfString:@"HsbcUI"];
//    NSLog(@"Index of %@ - %ld", className, index.length);
    
    // Check if the view conforms HsbcUI protocol then create the observer
    //if ([NSStringFromClass([view class]) rangeOfString:@"HsbcUI"].length > 0) {
    if ([view conformsToProtocol:@protocol(HsbcUI) ]) {
        //NSLog(@"Tag found for %@ - %d", NSStringFromClass([view class]), (int)[view tag]);
        //[self createObserverByTag:(int)[view tag]];
        [self createObserverFromHsbcUI:view];
    }
    
    // Get the subviews of the view
    NSArray *subviews = [view subviews];
    
    for (UIView *subview in subviews) {
        // Iterate the subview of subviews
        [self createObserverFromView:subview];
    }
}

- (void)createObserverFromHsbcUI:(id) sender
{
    NSArray *keyPath = [NSArray arrayWithArray: [[sender class] getKeyPath]];
    for (id key in keyPath) {
        NSString * theKeyString = (NSString *)key;
        NSLog(@"%@ - createObserverFromHsbcUI - view: %@ - key: %@", NSStringFromClass([self class]), NSStringFromClass([sender class]) ,theKeyString);
        [sender addObserver:self forKeyPath:theKeyString options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
}

//- (void)createObserverByTag:(int)tag
//{
//    id sender = [self.view viewWithTag:tag];
//    
//    NSString *className = NSStringFromClass([sender class]);
//    NSLog(@"%@ - createObserverByTag - class: %@", NSStringFromClass([self class]), className);
//    
//    NSArray *keyPath = [NSArray arrayWithArray: [[sender class] getKeyPath]];
//    for (id key in keyPath) {
//        NSString * theKeyString = (NSString *)key;
//        NSLog(@"%@ - createObserverByTag - key: %@", NSStringFromClass([self class]), theKeyString);
//        
//        [sender addObserver:self forKeyPath:theKeyString options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
//    }
//}

- (void)removeObserverFromView:(UIView *)view
{
    // Testing only!!!
    //    NSString *className = NSStringFromClass([view class]);
    //    NSRange index = [className rangeOfString:@"HsbcUI"];
    //    NSLog(@"Index of %@ - %ld", className, index.length);
    
    // Check if the view conforms HsbcUI protocol then remove the observer
    //if ([NSStringFromClass([view class]) rangeOfString:@"HsbcUI"].length > 0) {
    if ([view conformsToProtocol:@protocol(HsbcUI) ]) {
        //NSLog(@"Tag found for %@ - %d", NSStringFromClass([view class]), (int)[view tag]);
        //[self removeObserverByTag:(int)[view tag]];
        [self removeObserverFromHsbcUI:view];
    }
    
    // Get the subviews of the view
    NSArray *subviews = [view subviews];
    
    for (UIView *subview in subviews) {
        // Iterate the subviews of subview
        [self removeObserverFromView:subview];
    }
}

- (void)removeObserverFromHsbcUI:(UIView *)view
{
    NSArray *keyPath = [NSArray arrayWithArray: [[view class] getKeyPath]];
    for (id key in keyPath) {
        NSString * theKeyString = (NSString *)key;
        NSLog(@"%@ - removeObserverFromHsbcUI - view: %@ - key: %@", NSStringFromClass([self class]), NSStringFromClass([view class]) ,theKeyString);
        [view removeObserver:self forKeyPath:theKeyString];
    }
}

//- (void)removeObserverByTag:(int)tag
//{
//    id sender = [self.view viewWithTag:tag];
//    
//    NSString *className = NSStringFromClass([sender class]);
//    NSLog(@"%@ - removeObserverByTag - class: %@", NSStringFromClass([self class]), className);
//    
//    NSArray *keyPath = [NSArray arrayWithArray: [[sender class] getKeyPath]];
//    for (id key in keyPath) {
//        NSString * theKeyString = (NSString *)key;
//        NSLog(@"%@ - removeObserverByTag - key: %@", NSStringFromClass([self class]), theKeyString);
//        
//        [sender removeObserver:self forKeyPath:theKeyString];
//    }
//}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)sender change:(NSDictionary *)change context:(void *)context
{
    NSString *className = NSStringFromClass([sender class]);
    NSLog(@"%@ - observeValueForKeyPath - class: %@", NSStringFromClass([self class]), className);
    NSLog(@"%@ - observeValueForKeyPath - keyPath: %@", NSStringFromClass([self class]), keyPath);
    NSLog(@"%@ - observeValueForKeyPath - value: %@", NSStringFromClass([self class]), [sender valueForKey:keyPath]);
}

-(id)lookupHsbcUI:(HsbcUIViewController *)viewController withTag:(int) tagValue targetClassName:(NSString *)className
{
    NSLog(@"%@ - lookupHsbcUI", NSStringFromClass([self class]));
    
    id sender;
    
    // attempt to look for the target KVC-complaint object from the view
    sender = [viewController.view viewWithTag:tagValue];
    if (sender != nil &&
        [sender conformsToProtocol:@protocol(HsbcUI)])
    {
        if (className != nil) {
            if ([sender isKindOfClass:NSClassFromString(className)]) {
                return sender;
            }
        } else {
            return sender;
        }
    }
    
    // attempt to look for the target KVC-compliant object from the view controller
    // only HsbcUISlideWebviewController supports getSubViewControllerByTag
    HsbcUISlideWebviewController * slideViewController;
    if (viewController.view.tag == MAIN_VIEW_TAG ||
        viewController.view.tag == LEFT_VIEW_TAG ||
        viewController.view.tag == RIGHT_VIEW_TAG)
    {
        slideViewController = (HsbcUISlideWebviewController *) viewController.parentViewController;
    } else if (viewController.view.tag == BASE_VIEW_TAG) {
        slideViewController = (HsbcUISlideWebviewController *) viewController;
    }
    
    if ([slideViewController respondsToSelector:@selector(getSubViewControllerByTag:)]) {
        sender = [(HsbcUISlideWebviewController *) slideViewController getSubViewControllerByTag:tagValue];
        if (sender != nil &&
            [sender conformsToProtocol:@protocol(HsbcUI)])
        {
            if (className != nil) {
                if ([sender isKindOfClass:NSClassFromString(className)]) {
                    return sender;
                }
            } else {
                return sender;
            }
        }
    }
    
    return nil;
}

@end
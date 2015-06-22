//
//  BackPrevView.m
//  TestApp4
//
//  Created by jeffrey on 9/5/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import "BackPrevView.h"

@interface BackPrevView()

@end

@implementation BackPrevView

+ (void)executeHook:(NSDictionary *)functionParams forViewController:(HsbcUIWebviewController *)viewController
{
    NSLog(@"%@ - executeHook", NSStringFromClass([self class]));
    
    // Custom Handling for Hook API execution
    NSString *transition = [functionParams objectForKey:@"transition"];
    NSLog(@"transition: %@", transition);
    
    // Proceed to dismiss ViewController
    [viewController dismissViewController:[transition intValue]];
    
    return;
}

@end
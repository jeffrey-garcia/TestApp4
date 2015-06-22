//
//  SetterUI.m
//  TestApp4
//
//  Created by jeffrey on 8/5/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import "SetterUI.h"

@interface SetterUI()

@end

@implementation SetterUI

+ (void)executeHook:(NSDictionary *)functionParams forViewController:(HsbcUIWebviewController *)viewController
{
    NSLog(@"%@ - executeHook", NSStringFromClass([self class]));
    
    // Custom Handling for Hook API execution
    
    NSString *tag = [functionParams objectForKey:@"tag"];
    NSString *key = [functionParams objectForKey:@"key"];
    NSString *value = [functionParams objectForKey:@"value"];
    NSString *class = [functionParams objectForKey:@"class"];
    
    // look up the sender's object using the tag
    id sender = [viewController lookupHsbcUI:viewController withTag:[tag intValue] targetClassName:class];
    
    if (sender != nil) {
        NSLog(@" *** sender class: %@", NSStringFromClass([sender class]));
        
        @try
        {
            [sender setValue:value forKey:key];
        }
        @catch (NSException * exc) {
            NSLog(@"%@ - Exception: %@", NSStringFromClass([self class]), [exc description]);
            if ([[exc name] isEqualToString:NSInvalidArgumentException]) {
                // KVC does not support setting NSString into BOOL value
                // need a wrapper here to convert NSString into BOOL value whenever necessary
                [sender setValue:[NSNumber numberWithBool:[value boolValue]] forKey:key];
            }
        }
        
    } else {
        NSLog(@" *** sender is nil");
    }
    
    return;
}

@end
//
//  GetterUI.m
//  TestApp4
//
//  Created by jeffrey on 25/5/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import "GetterUI.h"

@interface GetterUI()

@end

@implementation GetterUI

+ (void)executeHook:(NSDictionary *)functionParams forViewController:(HsbcUIWebviewController *)viewController
{
    NSLog(@"%@ - executeHook", NSStringFromClass([self class]));

    // Custom Handling for Hook API execution
    
    NSString *tag = [functionParams objectForKey:@"tag"];
    NSString *key = [functionParams objectForKey:@"key"];
    NSString *class = [functionParams objectForKey:@"class"];
    NSString *callbackJs = [functionParams objectForKey:@"callbackJs"];
    
    // look up the sender's object using the tag
    id sender = [viewController lookupHsbcUI:viewController withTag:[tag intValue] targetClassName:class];
    
    if (sender != nil) {
        NSLog(@" *** sender class: %@", NSStringFromClass([sender class]));
        
        @try
        {
            id value = [sender valueForKey:key];
            
            NSString *jsCall = [NSString stringWithFormat: @"%@(%d,'%@','%@')", callbackJs ,(int)[sender tag], key, value];
            NSLog(@"%@ - jsCall: %@", NSStringFromClass([self class]), jsCall);
            
            [viewController.webView stringByEvaluatingJavaScriptFromString:jsCall];
        }
        @catch (NSException * exc) {
            NSLog(@"%@ - Exception: %@", NSStringFromClass([self class]), [exc description]);
        }
        
    } else {
        NSLog(@" *** sender is nil");
    }
    
    return;
}
@end

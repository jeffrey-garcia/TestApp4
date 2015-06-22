//
//  HsbcHookApi.h
//  TestApp4
//
//  Created by jeffrey on 8/5/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import "HsbcUIWebviewController.h"

@protocol HsbcHookApi <NSObject>

@required

//=== static method ===
+ (void)executeHook:(NSDictionary *)functionParams forViewController:(HsbcUIWebviewController *)viewController;

@end
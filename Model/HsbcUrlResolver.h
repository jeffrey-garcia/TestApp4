//
//  HsbcUrlResolver.h
//  TestApp4
//
//  Created by jeffrey on 8/5/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HsbcUIWebviewController.h"

@interface HsbcUrlResolver : NSObject

//=== static method ===//
+ (NSDictionary *)getParams:(NSURLRequest*)request;
+ (void)parseHookRequest:(NSDictionary *)functionParams forViewController:(HsbcUIWebviewController *)viewController;

@end

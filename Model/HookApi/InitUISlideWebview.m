//
//  InitUISlideWebview.m
//  TestApp4
//
//  Created by jeffrey on 9/5/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import "InitUISlideWebview.h"
#import "HsbcUISlideWebviewController.h"

@interface InitUISlideWebview()

@end

@implementation InitUISlideWebview

+ (void)executeHook:(NSDictionary *)functionParams forViewController:(HsbcUISlideWebviewController *)viewController
{
    NSLog(@"%@ - executeHook", NSStringFromClass([self class]));
    
    // Custom Handling for Hook API execution
    
    NSString *controller = [functionParams objectForKey:@"controller"];
    NSString *xib = [functionParams objectForKey:@"xib"];
    NSString *html = [functionParams objectForKey:@"html"];
    NSString *viewTag = [functionParams objectForKey:@"viewTag"];
    
    NSLog(@"controller: %@", controller);
    NSLog(@"xib: %@", xib);
    NSLog(@"html: %@", html);
    NSLog(@"viewTag: %@", viewTag);
    
    HsbcUIWebviewController *newViewController;
    if (controller != nil) {
        // construct the View Controller with specified controller class and XIB
        newViewController = [[NSClassFromString(controller) alloc] initWithNibName:xib bundle:[NSBundle mainBundle]];
    } else {
        // by default construct the View Controller with HsbcUIWebviewController and specified XIB
        newViewController = [[HsbcUIWebviewController alloc] initWithNibName:xib bundle:[NSBundle mainBundle]];
    }
    
    // construct the NSURL with specified HTML
    NSURL *url;
    if ([html rangeOfString:@"http"].length > 0) {
        // remote file
        url = [NSURL URLWithString:html];
    } else {
        // local file
        NSString *path = [[NSBundle mainBundle] pathForResource:html ofType:@"html"];
        if (path != nil) {
            url = [NSURL fileURLWithPath:path];
        }
    }
    NSLog(@"NSURL: %@", url);
    // if NSURL is not nil, proceed to setup the main Webview Controller
    if (url != nil) {
        [newViewController setValue:url forKey:@"url"];
    }
    
    switch ([viewTag intValue]) {
        case MAIN_VIEW_TAG:
            [viewController initMainView:newViewController withNibName:xib];
            break;
        case LEFT_VIEW_TAG:
            [viewController initLeftView:newViewController withNibName:xib];
        default:
            break;
    }
    
    return;
}

@end

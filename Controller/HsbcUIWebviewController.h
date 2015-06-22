//
//  HsbcUIWebviewController.h
//  TestApp4
//
//  Created by jeffrey on 7/5/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import "HsbcUIViewController.h"
#import "HsbcUIWebView.h"
#import "HsbcUIActivityIndicatorView.h"

@protocol HsbcUIWebviewController <NSObject>

@required

@end

@interface HsbcUIWebviewController : HsbcUIViewController<UIWebViewDelegate>

@property (nonatomic, assign) id<HsbcUIWebviewController> delegate;

@property (nonatomic, strong)HsbcUIWebView *webView;
@property (nonatomic)NSURL *url;
@property (nonatomic)HsbcUIActivityIndicatorView *spinner;

//=== instance method ===//
- (void)viewDidLoad;

- (void)initActivityIndicator;

- (void)initWebview;



@end
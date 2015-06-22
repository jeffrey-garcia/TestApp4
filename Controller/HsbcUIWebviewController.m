//
//  HsbcUIWebviewController.m
//  TestApp4
//
//  Created by jeffrey on 7/5/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import "HsbcUIWebviewController.h"
#import "HsbcUIActivityIndicatorView.h"

#import "HsbcUrlResolver.h"

@implementation HsbcUIWebviewController

@synthesize webView;
@synthesize spinner;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@ - viewDidLoad", NSStringFromClass([self class]));
    
    // instantiate the activity indicator before webview
    [self initActivityIndicator];
    
    // instantiate the webview once only when the view is loaded
    [self initWebview];
}

- (void)viewWillAppear:(BOOL)animated;
{
    [super viewWillAppear:animated];
    
    // Do any additional setup whenever the view is about to made visible. Default does nothing
    NSLog(@"%@ - viewWillAppear", NSStringFromClass([self class]));
    
    // Create the observer
    //[self createObserverFromView:self.view];
    [self createObserver];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
    // make sure to remove a key-value observer!!
    NSLog(@"%@ - didReceiveMemoryWarning", NSStringFromClass([self class]));
    
    // Remove the observer
    [self removeObserverFromView:self.view];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // make sure to remove a key-value observer!!
    NSLog(@"%@ - viewWillDisappear", NSStringFromClass([self class]));
    
    // Remove the observer
    [self removeObserverFromView:self.view];
}

- (void)initActivityIndicator
{
    NSLog(@"%@ - initActivityIndicator", NSStringFromClass([self class]));
    
    //Retrieve the UIActivityIndicator object from XIB layout
    UIView *uiView = [self getViewFromXib:self.view forClassName:@"HsbcUIActivityIndicatorView"];
    if (uiView == nil) {
        NSLog(@"%@ - no acitivty indicator found from XIB!", NSStringFromClass([self class]));
        return;
    }
    
    //Cast the UIView into HsbcUIActivityIndicatorView.h
    spinner = (HsbcUIActivityIndicatorView *)uiView;
    
    //Default is hidden
    spinner.hidden = YES;
}

- (void)initWebview
{
    NSLog(@"%@ - initWebview", NSStringFromClass([self class]));
    
    //Retrieve the UIWebView object from XIB layout
    UIView *uiView = [self getViewFromXib:self.view forClassName:@"HsbcUIWebView"];
    if (uiView == nil) {
        NSLog(@"%@ - no webview found from XIB!", NSStringFromClass([self class]));
        return;
    }
    
    //Cast the UIView into HsbcUIWebView
    webView = (HsbcUIWebView *)uiView;
    
    //Set the delegate
    webView.delegate = self;
    
    //Set the webview as invisible by default
    self.webView.hidden = YES;
    
    if (self.url != nil) {
        NSLog(@"%@ - URL scheme: %@", NSStringFromClass([self class]), [self.url scheme]);
        
        if ([[self.url scheme] isEqualToString:@"http"] ||
            [[self.url scheme] isEqualToString:@"https"])
        {
            // load the URL to the webview
            [webView loadRequest:[NSURLRequest requestWithURL:self.url]];
            
            // server-side page, set the webview visible to display it
            webView.hidden = NO;
            
        } else if ([[self.url scheme] isEqualToString:@"file"]) {
            // load the URL to the webview
            [webView loadRequest:[NSURLRequest requestWithURL:self.url]];
            
            // local page, let the java script decide whether the webview should be visible
        }
        
    } else {
        NSLog(@"%@ - URL is nil", NSStringFromClass([self class]));
    }
}

// webview delegate methods support
- (BOOL)webView:(HsbcUIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"scheme = %@",[[request URL] scheme]);
    
    // intercept the webview URL
    NSURL *reqURL = [request URL];
    NSString *urlString = [reqURL absoluteString];
    
    NSLog(@"WebView:ShouldStartLoadWithRequest with url: %@", urlString);
    NSLog(@"URL scheme: %@",[reqURL scheme]);
   	NSLog(@"URL host: %@",[reqURL host]);
    NSLog(@"NavigationType: %li",(long)navigationType);
    
    if ([[reqURL scheme] isEqualToString:@"hsbc"]) {
        NSDictionary *functionParserParams = [HsbcUrlResolver getParams:request];
        NSDictionary *functionParams = [NSDictionary dictionaryWithDictionary:functionParserParams];
        
        // aysn notify to process NonHTTPRequest after 1/10 sec.
        [self performSelector:@selector(processNonHTTPRequest:) withObject:functionParams afterDelay:0.1];
        return NO;
    }
    
    return YES;
}

// webview delegate methods support
- (void)webViewDidStartLoad:(HsbcUIWebView *)webView
{
    NSLog(@"%@ - webviewDidStartLoad", NSStringFromClass([self class]));
    [self.webView setValue:[NSNumber numberWithBool:YES] forKey:@"loadingStatus"];
    [self.spinner setValue:[NSNumber numberWithBool:YES] forKey:@"animated"];
}

// webview delegate methods support
- (void)webViewDidFinishLoad:(HsbcUIWebView *)webView
{
    NSLog(@"%@ - webViewDidFinishLoad", NSStringFromClass([self class]));
    [self.webView setValue:[NSNumber numberWithBool:NO] forKey:@"loadingStatus"];
    [self.spinner setValue:[NSNumber numberWithBool:NO] forKey:@"animated"];
}

// webview delegate methods support
- (void)webView:(HsbcUIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@ - webView didFailLoadWithError", NSStringFromClass([self class]));
    [self.webView setValue:[NSNumber numberWithBool:NO] forKey:@"loadingStatus"];
    [self.spinner setValue:[NSNumber numberWithBool:NO] forKey:@"animated"];
}


- (void)processNonHTTPRequest:(NSDictionary *)functionParams
{
    NSString *functionName = [functionParams valueForKey:@"function"];
    NSLog(@"Hook API called: %@", functionName);
    NSLog(@"Parameters: %@", [functionParams description]);
    
    [HsbcUrlResolver parseHookRequest:functionParams forViewController:self];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)sender change:(NSDictionary *)change context:(void *)context
{
    [super observeValueForKeyPath:keyPath ofObject:sender change:change context:context];
    
    NSString *jsCall = [NSString stringWithFormat: @"notifyUiObserver(%d,'%@','%@')", (int)[sender tag], keyPath, [sender valueForKey:keyPath]];
    NSLog(@"%@ - jsCall: %@", NSStringFromClass([self class]), jsCall);
    
    [webView stringByEvaluatingJavaScriptFromString:jsCall];
}

@end

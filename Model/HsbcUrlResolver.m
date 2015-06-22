//
//  HsbcUrlResolver.m
//  TestApp4
//
//  Created by jeffrey on 8/5/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import "HsbcUrlResolver.h"
#import "SetterUI.h"

@interface HsbcUrlResolver()

@end

@implementation HsbcUrlResolver

+ (NSDictionary *)getParams:(NSURLRequest*)request
{
    
    NSString *urlString = [[request URL] absoluteString];
    urlString = [urlString substringWithRange:NSMakeRange([@"hsbc://" length],[urlString length] - [@"hsbc://" length])];
    urlString = [HsbcUrlResolver urlDecode:urlString];
    NSLog(@"%@ - decoded URL String to process: %@", NSStringFromClass([self class]), urlString);
    
    NSMutableDictionary *paramDictionary = [HsbcUrlResolver parseUrlString:urlString];
    
    return paramDictionary;
}

+ (NSString *)urlDecode:(NSString *)str
{
    NSString *url = (NSString *) CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                           (CFStringRef) str,
                                                                                                           CFSTR(""),
                                                                                                           kCFStringEncodingUTF8));
    return url;
}

+ (NSMutableDictionary *)parseUrlString:(NSString*)message
{
    NSArray *params = [message componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"&="]];
    
    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
    for (int i=0; i+1 < [params count]; i = i+2) {
        [mutableDictionary setObject:[[params objectAtIndex:i+1] stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding] forKey:[params objectAtIndex:i]];
    }
    
    return mutableDictionary;
}

+ (void)parseHookRequest:(NSDictionary *)functionParams forViewController:(HsbcUIWebviewController *)viewController
{
    NSString *functionName = [functionParams valueForKey:@"function"];
    NSLog(@"%@ - parseHookRequest - function: %@", NSStringFromClass([self class]), functionName);
    
    [NSClassFromString(functionName) executeHook:functionParams forViewController:viewController];
}

@end
//
//  HsbcUIWebView.h
//  TestApp4
//
//  Created by jeffrey on 7/5/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HsbcUI.h"

#define HsbcUIWebView_kvcPath @"loadingStatus", @"hidden", nil

@interface HsbcUIWebView : UIWebView <HsbcUI>

@property(nonatomic,getter=getLoadingStatus) NSNumber *loadingStatus;

@end

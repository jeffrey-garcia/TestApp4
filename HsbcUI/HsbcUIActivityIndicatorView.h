//
//  HsbcUIActivityIndicatorView.h
//  TestApp4
//
//  Created by jeffrey on 8/5/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HsbcUI.h"

//#define HsbcUIActivityIndicatorView_kvcPath @"animated", @"hidden", nil
#define HsbcUIActivityIndicatorView_kvcPath nil // nil observer required for spinner

@interface HsbcUIActivityIndicatorView : UIActivityIndicatorView <HsbcUI>

@property(nonatomic,getter=isAnimated) NSNumber *animated;

@end

//
//  HsbcUIButton.h
//  TestApp4
//
//  Created by jeffrey on 29/4/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HsbcUI.h"

#define HsbcUIButton_kvcPath @"currentTitle", @"clicked", @"enabled", @"borderWidth", @"borderColor", nil

@interface HsbcUIButton : UIButton <HsbcUI>

@property(nonatomic,getter=isClicked) NSNumber *clicked;
@property(nonatomic,getter=getBorderWidth) NSNumber *borderWidth;
@property(nonatomic,getter=getBorderColor) UIColor *borderColor;

@end
//
//  HsbcUILabel.h
//  TestApp4
//
//  Created by jeffrey on 4/5/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HsbcUI.h"

#define HsbcUILabel_kvcPath @"clicked", @"enabled", @"text", nil

@interface HsbcUILabel : UILabel <HsbcUI>

@property(nonatomic,getter=isClicked) NSNumber *clicked;

@end

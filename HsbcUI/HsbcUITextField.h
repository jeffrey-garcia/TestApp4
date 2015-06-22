//
//  HsbcUITextField.h
//  TestApp4
//
//  Created by jeffrey on 29/4/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HsbcUI.h"

#define HsbcUITextField_kvcPath @"textValue", @"focused", nil

@interface HsbcUITextField : UITextField <HsbcUI>

@property(nonatomic,getter=getTextValue) NSString *textValue;
@property(nonatomic,getter=isFocused) NSNumber *focused;

@end

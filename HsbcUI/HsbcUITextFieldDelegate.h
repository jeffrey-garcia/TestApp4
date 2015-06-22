//
//  HsbcUITextFieldDelegate.h
//  TestApp4
//
//  Created by jeffrey on 29/4/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HsbcUITextFieldDelegate : NSObject <UITextFieldDelegate>

//=== static method ===
+ (HsbcUITextFieldDelegate *)initDelegate;

//=== instance method ===
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;

- (void)textFieldDidBeginEditing:(UITextField *)textField;

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;

- (void)textFieldDidEndEditing:(UITextField *)textField;

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

- (BOOL)textFieldShouldClear:(UITextField *)textField;

- (BOOL)textFieldShouldReturn:(UITextField *)textField;

@end

static HsbcUITextFieldDelegate * theDelegate;
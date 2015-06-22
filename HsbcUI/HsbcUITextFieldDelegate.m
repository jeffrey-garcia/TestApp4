//
//  HsbcUITextFieldDelegate.m
//  TestApp4
//
//  Created by jeffrey on 29/4/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import "HsbcUITextFieldDelegate.h"


@implementation HsbcUITextFieldDelegate

+ (HsbcUITextFieldDelegate *)initDelegate
{
    @synchronized(self) {
        if (!theDelegate) {
            theDelegate = [[HsbcUITextFieldDelegate alloc] init];
        }
    }
    return theDelegate;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"%@ - textFieldShouldBeginEditing", NSStringFromClass([self class]));
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"%@ - textFieldDidBeginEditing", NSStringFromClass([self class]));
    [textField setValue:[NSNumber numberWithBool:YES] forKeyPath:@"focused"];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@"%@ - textFieldShouldEndEditing", NSStringFromClass([self class]));
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"%@ - textFieldDidEndEditing", NSStringFromClass([self class]));
    [textField setValue:[NSNumber numberWithBool:NO] forKeyPath:@"focused"];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *value = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"%@ - textField: %@", NSStringFromClass([self class]), value);
    [textField setValue:value forKeyPath:@"textValue"];
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    NSLog(@"%@ - textFieldShouldClear", NSStringFromClass([self class]));
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"%@ - textFieldShouldReturn", NSStringFromClass([self class]));
    // release focus such that the soft keyboard can be dismissed when the "DONE" key is clicked by user
    [textField resignFirstResponder];
    return YES;
}

@end
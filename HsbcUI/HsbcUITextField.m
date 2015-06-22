//
//  HsbcUITextField.m
//  TestApp4
//
//  Created by jeffrey on 29/4/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import "HsbcUITextField.h"
#import "HsbcUITextFieldDelegate.h"

@interface HsbcUITextField ()

@end

@implementation HsbcUITextField

+ (NSArray *)getKeyPath
{
    return [[NSArray alloc] initWithObjects:HsbcUITextField_kvcPath];
}

- (id)initWithFrame:(CGRect)frame
{
    NSLog(@"%@ - initWithFrame", NSStringFromClass([self class]));
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // Avoid setting a UITextField's delegate to itself, because it can end up going into a loop
        self.delegate = [HsbcUITextFieldDelegate initDelegate];
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    NSLog(@"%@ - initWithCoder", NSStringFromClass([self class]));
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        // Avoid setting a UITextField's delegate to itself, because it can end up going into a loop
        self.delegate = [HsbcUITextFieldDelegate initDelegate];
    }
    return self;
}

@end
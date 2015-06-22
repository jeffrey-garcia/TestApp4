//
//  HsbcUIButton.m
//  TestApp4
//
//  Created by jeffrey on 29/4/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import "HsbcUIButton.h"

@interface HsbcUIButton ()

@end

@implementation HsbcUIButton

+ (NSArray *)getKeyPath
{
    return [[NSArray alloc] initWithObjects:HsbcUIButton_kvcPath];
}

- (id)initWithFrame:(CGRect)frame
{
    NSLog(@"%@ - initWithFrame", NSStringFromClass([self class]));
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    NSLog(@"%@ - initWithCoder", NSStringFromClass([self class]));
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}

-(void)buttonClicked:(UIButton *)sender
{
    NSLog(@"%@ - buttonClicked", NSStringFromClass([self class]));
    
    // Custom implementation - beware of multiple click event fired to observer
    [self setValue:[NSNumber numberWithBool:YES] forKeyPath:@"clicked"];
    
    // Testing only !!!
//    [self setValue:[NSNumber numberWithInt:0] forKeyPath:@"borderWidth"];
//    NSLog(@"value from getBorderWidth %@", [self getBorderWidth]);
//    NSLog(@"value from borderWidth %@", [self valueForKey:@"borderWidth"]);
//    NSLog(@"value from self.borderWidth %@", self.borderWidth);
//    
//    [self setBorderColor:[UIColor purpleColor]];
//    NSLog(@"value from getBorderColor %@", [self getBorderColor]);
//    NSLog(@"value from borderColor %@", [self valueForKey:@"borderColor"]);
//    NSLog(@"value from self.borderColor %@", self.borderColor);
}

- (void) setBorderWidth:(NSNumber *) borderWidth
{
    // apply the new width to UIButton's layer
    CALayer *layer = (CALayer *)[self valueForKey:@"layer"];
    [layer setValue:borderWidth forKeyPath:@"borderWidth"];
}

- (NSNumber *) getBorderWidth
{
    // retrieve the border width from UIBUtton's layer
    CALayer *layer = (CALayer *)[self valueForKey:@"layer"];
    return [layer valueForKey:@"borderWidth"];
}

- (void) setBorderColor:(UIColor *)newBorderColor
{
    // apply the new border color to UIButton's layer
    CALayer *layer = (CALayer *)[self valueForKey:@"layer"];
    [layer setBorderColor:newBorderColor.CGColor];
}

- (UIColor *) getBorderColor
{
    // retrieve the border color from UIButton's layer
    CALayer *layer = (CALayer *)[self valueForKey:@"layer"];
    return [[UIColor alloc] initWithCGColor:layer.borderColor];
}

@end
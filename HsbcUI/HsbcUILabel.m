//
//  HsbcUILabel.m
//  TestApp4
//
//  Created by jeffrey on 4/5/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import "HsbcUILabel.h"

@interface HsbcUILabel ()

@end

@implementation HsbcUILabel

+ (NSArray *)getKeyPath
{
    return [[NSArray alloc] initWithObjects:HsbcUILabel_kvcPath];
}

- (id)initWithFrame:(CGRect)frame
{
    NSLog(@"%@ - initWithFrame", NSStringFromClass([self class]));
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(labelClicked:)]];
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    NSLog(@"%@ - initWithCoder", NSStringFromClass([self class]));
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                    initWithTarget:self
                                    action:@selector(labelClicked:)]];
    }
    return self;
}

-(void)labelClicked:(UILabel *)sender
{
    NSLog(@"%@ - labelClicked", NSStringFromClass([self class]));
    
    // for auto keyboard dismiss and release focus
    [[self superview] endEditing:YES];
    
    // Custom implementation - beware of multiple click event fired to observer
    [self setValue:[NSNumber numberWithBool:YES] forKeyPath:@"clicked"];
}

@end

//
//  HsbcUIActivityIndicatorView.m
//  TestApp4
//
//  Created by jeffrey on 8/5/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import "HsbcUIActivityIndicatorView.h"

@interface HsbcUIActivityIndicatorView ()

@end

@implementation HsbcUIActivityIndicatorView

@synthesize animated;

+ (NSArray *)getKeyPath
{
    return [[NSArray alloc] initWithObjects:HsbcUIActivityIndicatorView_kvcPath];
}

- (void) setAnimated:(NSNumber *) anim
{
    // update the property
    animated = anim;
    //NSLog(@"%@ - setAnimated: %d", NSStringFromClass([self class]), [animated intValue]);
    
    if ([animated intValue] == 1) {
        self.hidden = NO;
        [self startAnimating];
    } else {
        [self stopAnimating];
        self.hidden = YES;
    }
}



@end

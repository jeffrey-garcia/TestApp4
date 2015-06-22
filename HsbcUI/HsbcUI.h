//
//  HsbcUI.h
//  TestApp4
//
//  Created by jeffrey on 4/5/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HsbcUI <NSObject>

@required

//=== static method ===
+ (NSArray *)getKeyPath;

@end
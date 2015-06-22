//
//  ViewController.h
//  TestApp4
//
//  Created by jeffrey on 29/4/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

//=== instance method ===//
- (void)viewWillAppear:(BOOL)animated;
- (void)didReceiveMemoryWarning;
- (void)viewDidDisappear:(BOOL)animated;
- (void)dismissKeyboard;
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)sender change:(NSDictionary *)change context:(void *)context;
- (void)createObserverByTag:(int)tag;
- (void)removeObserverByTag:(int)tag;

@end


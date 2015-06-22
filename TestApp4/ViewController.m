//
//  ViewController.m
//  TestApp4
//
//  Created by jeffrey on 29/4/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import "ViewController.h"
#import "HsbcUIViewController.h"
#import "HsbcUITextField.h"
#import "HsbcUIButton.h"
#import "HsbcUILabel.h"

@interface ViewController ()

@end

@implementation ViewController

HsbcUITextField *theTextField;
HsbcUIButton *theUIButton;
HsbcUILabel *theUILabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@ - viewDidLoad", NSStringFromClass([self class]));
    
    // for auto keyboard dismiss and release focus
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:gesture];
    [gesture setCancelsTouchesInView:NO];
    
    // avoid multiple UI components being clicked at the same time
    [self.view setExclusiveTouch:YES];
    
    
    theTextField = [[HsbcUITextField alloc] initWithFrame:CGRectMake(10, 200, 300, 40)];
    theTextField.borderStyle = UITextBorderStyleRoundedRect;
    theTextField.font = [UIFont systemFontOfSize:15];
    theTextField.placeholder = @"enter text";
    theTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    theTextField.keyboardType = UIKeyboardTypeDefault;
    theTextField.returnKeyType = UIReturnKeyDone;
    theTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    theTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    theTextField.tag = 1;
    [self.view addSubview:theTextField];
    
//    NSLog(@"%@ - text field tag: %ld", NSStringFromClass([self class]), (long)[theTextField tag]);
//    id sender = [self.view viewWithTag:[theTextField tag]];
//    NSString *className = NSStringFromClass([sender class]);
//    NSLog(@"%@ - createObserverByTag - class %@", NSStringFromClass([self class]), className);
//    if ([sender isKindOfClass:[HsbcUITextField class]]) {
//        NSLog(@"%@ - sender tag: %ld", NSStringFromClass([self class]), (long)[sender tag]);
//    }
    
    theUIButton = [HsbcUIButton buttonWithType:UIButtonTypeSystem];
    theUIButton.frame = CGRectMake(10.0, 250.0, 300.0, 40.0);
    theUIButton.layer.cornerRadius = 10;
    theUIButton.clipsToBounds = YES;
    [[theUIButton layer] setBorderWidth:2.0f];
    [[theUIButton layer] setBorderColor:[UIColor grayColor].CGColor];
    [theUIButton setTitle:@"Testing UIButton" forState:UIControlStateNormal];
    theUIButton.tag = 2;
    [self.view addSubview:theUIButton];
    
    theUILabel = [[HsbcUILabel alloc]initWithFrame:CGRectMake(10, 300, 300, 40)];
    [theUILabel setBackgroundColor:[UIColor lightGrayColor]];
    [theUILabel setText:@"Testing UILabel"];
    [theUILabel setTextAlignment:NSTextAlignmentCenter];
    [theUILabel setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    [theUILabel setLineBreakMode:NSLineBreakByCharWrapping];
    [theUILabel setNumberOfLines:1];
    [theUILabel.layer setCornerRadius:10.0];
    [theUILabel setClipsToBounds:YES];
    [theUILabel setUserInteractionEnabled:YES];
    //[theUILabel.layer setBorderWidth:2.0f];
    //[theUILabel.layer setBorderColor:[UIColor grayColor].CGColor];
    theUILabel.tag = 3;
    [self.view addSubview:theUILabel];
}

- (void)dismissKeyboard
{
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Invoke any operations that you want to happen every time before the view is visible
    [self createObserverByTag:(int)[theTextField tag]];
    [self createObserverByTag:(int)[theUIButton tag]];
    [self createObserverByTag:(int)[theUILabel tag]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self removeObserverByTag:(int)[theTextField tag]];
    [self removeObserverByTag:(int)[theUIButton tag]];
    [self removeObserverByTag:(int)[theUILabel tag]];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // Dispose of any resources that can be recreated.
    [self removeObserverByTag:(int)[theTextField tag]];
    [self removeObserverByTag:(int)[theUIButton tag]];
    [self removeObserverByTag:(int)[theUILabel tag]];
}

- (void)createObserverByTag:(int)tag
{
    id sender = [self.view viewWithTag:tag];
    
    NSString *className = NSStringFromClass([sender class]);
    NSLog(@"%@ - createObserverByTag - class: %@", NSStringFromClass([self class]), className);
    
    NSArray *keyPath = [NSArray arrayWithArray: [[sender class] getKeyPath]];
    for (id key in keyPath) {
        NSString * theKeyString = (NSString *)key;
        NSLog(@"%@ - createObserverByTag - key: %@", NSStringFromClass([self class]), theKeyString);
        
        [sender addObserver:self forKeyPath:theKeyString options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
}

- (void)removeObserverByTag:(int)tag
{
    id sender = [self.view viewWithTag:tag];
    
    NSString *className = NSStringFromClass([sender class]);
    NSLog(@"%@ - removeObserverByTag - class: %@", NSStringFromClass([self class]), className);
    
    NSArray *keyPath = [NSArray arrayWithArray: [[sender class] getKeyPath]];
    for (id key in keyPath) {
        NSString * theKeyString = (NSString *)key;
        NSLog(@"%@ - removeObserverByTag - key: %@", NSStringFromClass([self class]), theKeyString);
        
        [sender removeObserver:self forKeyPath:theKeyString];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)sender change:(NSDictionary *)change context:(void *)context
{
    NSString *className = NSStringFromClass([sender class]);
    NSLog(@"%@ - observeValueForKeyPath - class: %@", NSStringFromClass([self class]), className);
    NSLog(@"%@ - observeValueForKeyPath - keyPath: %@", NSStringFromClass([self class]), keyPath);
    NSLog(@"%@ - observeValueForKeyPath - value: %@", NSStringFromClass([self class]), [sender valueForKey:keyPath]);
    
    if ([className isEqualToString:@"HsbcUIButton"] && [keyPath isEqualToString:@"clicked"])
    {
        [self loadNewView];
    }
}

- (void)loadNewView
{
    NSBundle *mainBundle = [NSBundle mainBundle];
    HsbcUIViewController *theNewViewController = [[HsbcUIViewController alloc] initWithNibName:@"TestView_1" bundle:mainBundle];
    
    //theNewViewController.modalTransitionStyle =  UIModalTransitionStyleCoverVertical;
    theNewViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    NSLog(@"UIViewController instantiated");
    
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:0.80];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    
    // don't use navigation controller
    [self presentViewController:theNewViewController animated:YES completion:nil];
    
    // use navigation controller to push new view
    // [self.navigationController pushViewController:theNewViewController animated:YES];
    
    [UIView commitAnimations];
}

@end

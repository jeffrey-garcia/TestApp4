//
//  HsbcUISlideWebviewController.m
//  TestApp4
//
//  Created by jeffrey on 9/5/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import "HsbcUISlideWebviewController.h"

@implementation HsbcUISlideWebviewController

// for KVC/KVO support
@synthesize mainViewEnabled;
@synthesize leftViewEnabled;
@synthesize leftViewHidden;
@synthesize rightViewEnabled;
@synthesize rightViewHidden;

@synthesize mainWebviewController;
@synthesize leftWebviewController;
@synthesize rightWebviewController;

@synthesize gestureExceedHalfWay;

+ (NSArray *)getKeyPath
{
    return [[NSArray alloc] initWithObjects:HsbcUISlideWebviewController_kvcPath];
}

- (void)setMainViewEnabled:(NSNumber *) enabled
{
    //NSLog(@"%@ - setMainViewEnabled", NSStringFromClass([self class]));
    if ([enabled intValue] == 1) {
        mainViewEnabled = enabled;
    }
}

- (NSNumber *)isMainViewEnabled
{
    //NSLog(@"%@ - isMainViewEnabled: %d", NSStringFromClass([self class]), [mainViewEnabled intValue]);
    return mainViewEnabled;
}

- (void)setLeftViewEnabled:(NSNumber *) enabled
{
    //NSLog(@"%@ - setLeftViewEnabled", NSStringFromClass([self class]));
    if ([enabled intValue] == 1) {
        leftViewEnabled = enabled;
    }
}

- (NSNumber *)isLeftViewEnabled
{
    //NSLog(@"%@ - isLeftViewEnabled: %d", NSStringFromClass([self class]), [leftViewEnabled intValue]);
    return leftViewEnabled;
}

- (void)setLeftViewHidden:(NSNumber *)hidden
{
    leftViewHidden = hidden;
    [self showLeftPanel];
}

- (NSNumber *)isLeftViewHidden
{
    return leftViewHidden;
}

- (void)setRightViewEnabled:(NSNumber *) enabled
{
    //NSLog(@"%@ - setRightViewEnabled", NSStringFromClass([self class]));
    if ([enabled intValue] == 1) {
        rightViewEnabled = enabled;
    }
}

- (NSNumber *)isRightViewEnabled
{
    //NSLog(@"%@ - isRightViewEnabled: %d", NSStringFromClass([self class]), [leftViewEnabled intValue]);
    return rightViewEnabled;
}

- (void)setRightViewHidden:(NSNumber *)hidden
{
    rightViewHidden = hidden;
    //[self showRightPanel];
}

- (NSNumber *)isRightViewHidden
{
    return rightViewHidden;
}

- (int)tag
{
    return BASE_VIEW_TAG;
}

-(void)viewDidLoad {
    [super viewDidLoad];
}


-(void)initMainView:(HsbcUIWebviewController *)newWebviewController withNibName:(NSString *)nibName
{
    NSLog(@"%@ - initMainView", NSStringFromClass([self class]));
    
    mainWebviewController = newWebviewController;
    mainWebviewController.view.tag = MAIN_VIEW_TAG;
    mainWebviewController.delegate = (id<HsbcUIWebviewController>)self;
    [self.view addSubview:mainWebviewController.view];
    [self addChildViewController:mainWebviewController];
    [mainWebviewController didMoveToParentViewController:self];
    
    // always make sure the main webview is at the top
    [self.view bringSubviewToFront:mainWebviewController.view];
    
    // for KVC/KVO support
    [self setValue:[NSNumber numberWithBool:YES] forKey:@"mainViewEnabled"];
    
    // for support swiping
    [self setupGestures];
}

-(void)initLeftView:(HsbcUIWebviewController *)newWebviewController withNibName:(NSString *)nibName
{
    NSLog(@"%@ - initLeftView", NSStringFromClass([self class]));
    
    leftWebviewController = newWebviewController;
    leftWebviewController.view.tag = LEFT_VIEW_TAG;
    leftWebviewController.delegate = (id<HsbcUIWebviewController>)self;
    [self.view addSubview:leftWebviewController.view];
    [self addChildViewController:leftWebviewController];
    [leftWebviewController didMoveToParentViewController:self];
    
    // setup view shadows
    [self showCenterViewWithShadow:YES withOffset:-2];
    
    // always make sure the main webview is at the top
    [self.view bringSubviewToFront:mainWebviewController.view];
    
    // initialize the default position of the left view
    leftWebviewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width - PANEL_WIDTH, self.view.frame.size.height);
    
    // for KVC/KVO support
    [self setValue:[NSNumber numberWithBool:YES] forKey:@"leftViewEnabled"];
}


-(void) showLeftPanel
{
    NSLog(@"%@ - showLeftPanel", NSStringFromClass([self class]));
    
    if ([leftViewHidden intValue] == 0) {
        // make the left panel visible
        [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            mainWebviewController.view.frame = CGRectMake(self.view.frame.size.width - PANEL_WIDTH, 0, self.view.frame.size.width, self.view.frame.size.height);
        }
                         completion:^(BOOL finished) {
                             if (finished) {
                                 NSLog(@"left panel is now visible: %@", leftViewHidden);
                             }
                         }
         ];
    } else {
        // make the left panel invisible
        [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            mainWebviewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        }
                         completion:^(BOOL finished) {
                             if (finished) {
                                 NSLog(@"left panel is now hidden: %@", leftViewHidden);
                             }
                         }
         ];
    }
}

-(void)setupGestures
{
    NSLog(@"%@ - setupGestures", NSStringFromClass([self class]));
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeView:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    
    [mainWebviewController.view addGestureRecognizer:panRecognizer];
}

-(void)swipeView:(id)sender
{
    [[[(UITapGestureRecognizer*)sender view] layer] removeAllAnimations];
    
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    CGPoint velocity = [(UIPanGestureRecognizer*)sender velocityInView:[sender view]];
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        NSLog(@"%@ swipeView gesture: UIGestureRecognizerStateBegan", NSStringFromClass([self class]));
        UIView *childView = nil;
        
        if(velocity.x > 0) {
            NSLog(@"swipe towards right");
            /* finger swipe towards right:
             * - if right panel is displayed: hide it
             * - otherwise display the left panel
             */
            if ([((NSNumber *) [self valueForKey:@"rightViewHidden"]) intValue] == 1) {
                // right view is hidden so display the left view
                childView = leftWebviewController.view;
            }
        } else {
            NSLog(@"swipe towards left");
            /* finger swipe towards left: 
             * - if left panel is displayed: hide it 
             * - otherwise display the right panel
             */
            if ([((NSNumber *) [self valueForKey:@"leftViewHidden"]) intValue] == 1) {
                // right view is hidden so display the left view
                //childView = rightWebviewController.view;
            }
        }
        
        [self.view bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
    }
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
        NSLog(@"%@ swipeView gesture: UIGestureRecognizerStateChanged", NSStringFromClass([self class]));
     
        // are we more than halfway, if so, show the panel when done dragging by setting this value to YES (1)
        gestureExceedHalfWay = fabs([sender view].center.x - mainWebviewController.view.frame.size.width/2) > mainWebviewController.view.frame.size.width/2;
        NSLog(@"gesture exceed halfway? %d", gestureExceedHalfWay);
        //NSLog(@"point %f", fabs([sender view].center.x - mainWebviewController.view.frame.size.width/2));
        
        // if you needed to check for a change in direction, you could use this code to do so
        bool sameDirection;
        if(velocity.x*_preVelocity.x + velocity.y*_preVelocity.y > 0) {
            NSLog(@"same direction");
            sameDirection = YES;
        } else {
            NSLog(@"opposite direction");
            sameDirection = NO;
        }
        
        // allow dragging only in x coordinates by only updating the x coordinate with translation position
        [sender view].center = CGPointMake([sender view].center.x + translatedPoint.x, [sender view].center.y);
        [(UIPanGestureRecognizer*)sender setTranslation:CGPointMake(0,0) inView:self.view];
        
        _preVelocity = velocity;
    }
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        NSLog(@"%@ swipeView gesture: UIGestureRecognizerStateEnded", NSStringFromClass([self class]));
        
        // if you needed to check the final direction, you could use this code to do so
        if(velocity.x > 0) {
            NSLog(@"gesture went right");
        } else {
            NSLog(@"gesture went left");
        }
        
        if (!gestureExceedHalfWay) {
            // Gesture just on the halfway, resume the main view original position
            [self moveViewToOriginalPosition];
        } else {
            // Gesture more than halfway, proceed completing the movement of main view to the desired position
            [self setValue:[NSNumber numberWithInt:0] forKey:@"leftViewHidden"];
        }
    }
}

-(void)moveViewToOriginalPosition
{
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        mainWebviewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        }
        completion:^(BOOL finished) {
            if (finished) {
                [self resetAllView];
            }
        }
    ];
}

-(void)resetAllView
{
    // remove view shadows
    [self showCenterViewWithShadow:NO withOffset:0];
    
    [self setValue:[NSNumber numberWithInt:1] forKey:@"leftViewHidden"];
    [self setValue:[NSNumber numberWithInt:1] forKey:@"rightViewHidden"];
    
    // remove view shadows
    [self showCenterViewWithShadow:NO withOffset:0];
}

-(void)showCenterViewWithShadow:(BOOL)value withOffset:(double)offset {
    if (value) {
        [mainWebviewController.view.layer setCornerRadius:CORNER_RADIUS];
        [mainWebviewController.view.layer setShadowColor:[UIColor blackColor].CGColor];
        [mainWebviewController.view.layer setShadowOpacity:0.8];
        [mainWebviewController.view.layer setShadowOffset:CGSizeMake(offset, offset)];
        
    } else {
        [mainWebviewController.view.layer setCornerRadius:0.0f];
        [mainWebviewController.view.layer setShadowOffset:CGSizeMake(offset, offset)];
    }
}

-(HsbcUIViewController *)getSubViewControllerByTag:(int)tagValue
{
    switch (tagValue) {
        case BASE_VIEW_TAG:
            return self;
        case MAIN_VIEW_TAG:
            return mainWebviewController;
        case LEFT_VIEW_TAG:
            return leftWebviewController;
        case RIGHT_VIEW_TAG:
            return rightWebviewController;
        default:
            return nil;
    }
}

@end
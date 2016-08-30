//
//  ViewController.m
//  ViewAnimation
//
//  Created by EnzoF on 30.08.16.
//  Copyright © 2016 EnzoF. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    for (UIView *view in self.arrayViews)
    {
        
        [self moveView:(UIView*)view withOptions:[self randomInterpolation]];
    }

}

#pragma mark -metods-

- (void)moveView:(UIView*)view withOptions:(UIViewAnimationOptions)options{
    
    
    
   [UIView animateWithDuration:3.f delay:0
                        options:options | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat
                     animations:^{
                         double x = CGRectGetWidth(self.view.bounds) - CGRectGetWidth(view.frame)/2;
                         double y = CGRectGetMidY(view.frame);
                         view.center = CGPointMake(x, y);
                         view.backgroundColor = [self randomColor];
                        // view.frame.origin.y = y;
                     } completion:^(BOOL finished) {
                         
                     }];
    
}

- (UIViewAnimationOptions)randomInterpolation{
    NSInteger randomInter = arc4random_uniform(4);
    UIViewAnimationOptions interpolation = UIViewAnimationOptionCurveLinear;
    
    switch (randomInter) {
        case 1:
            interpolation = UIViewAnimationOptionCurveEaseInOut;
            break;
        case 2:
            interpolation = UIViewAnimationOptionCurveEaseIn;
            break;

        case 3:
            interpolation = UIViewAnimationOptionCurveEaseOut;
            break;

        case 4:
            interpolation = UIViewAnimationOptionCurveLinear;
            break;
    }
    return interpolation;
}

- (UIColor*)randomColor{
    return [[UIColor alloc] initWithRed:arc4random_uniform(255) green:arc4random_uniform(255) blue:arc4random_uniform(255) alpha:arc4random_uniform(255)];
}

@end

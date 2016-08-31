//
//  ViewController.m
//  ViewAnimation
//
//  Created by EnzoF on 30.08.16.
//  Copyright © 2016 EnzoF. All rights reserved.
//

#import "ViewController.h"

typedef enum
{
    ViewControllerUsuallyViewType = 10,
    ViewControllerCornerViewType = 20
}ViewControllerViewType;

typedef enum
{
    ViewControllerUpLeftCoordinateNumber = 1,
    ViewControllerUpRightCoordinateNumber = 2,
    ViewControllerDownRightCoordinateNumber = 3,
    ViewControllerDownLeftCoordinateNumber = 4,
}ViewControllerCoordinateNumber;

typedef enum
{
    ViewControllerUpLeftReverseCoordinateNumber = 6,
    ViewControllerUpRightReverseCoordinateNumber = 7,
    ViewControllerDownRightReverseCoordinateNumber = 8,
    ViewControllerDownLeftReverseCoordinateNumber = 9,
}ViewControllerReverseCoordinateNumber;



@interface ViewController ()
@property (assign, nonatomic) UIViewAnimationOptions currentOption;
@property (assign, nonatomic) NSInteger clockwise;

@property (strong, nonatomic) UIColor *upLeftViewColor;
@property (strong, nonatomic) UIColor *upRightViewColor;
@property (strong, nonatomic) UIColor *downLeftViewColor;
@property (strong, nonatomic) UIColor *downRightViewColor;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [self setCurrentAllCornerColorsWhithRandom:YES];
    [UIView animateWithDuration:1.f
                          delay:0.f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        [self moveAllView];
    }
                     completion:^(BOOL finished) {
                         self.clockwise = 0;
                           [self setCurrentAllCornerColorsWhithRandom:NO];
                            [UIView animateWithDuration:1.f delay:0.f options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
                                [self moveAllView];
                            } completion:^(BOOL finished) {
                                NSLog(@"second animation finished");
                            }];
        NSLog(@"first animation finished");
    }];

}


#pragma mark -Initialization-

-(NSInteger)clockwise{
    if(!_clockwise)
    {
        _clockwise = arc4random_uniform(1000);
    }
    return _clockwise;
}

#pragma mark -metods-

- (void)moveView:(UIView*)view{
    CGPoint center = CGPointZero;
    CGAffineTransform rotate = CGAffineTransformMakeRotation(0);;
    
    switch (view.tag)
    {
        case ViewControllerUsuallyViewType:
            
            center = CGPointMake(arc4random_uniform(CGRectGetWidth(self.view.bounds)) - CGRectGetWidth(view.frame)/2, arc4random_uniform(CGRectGetHeight(self.view.bounds)) - CGRectGetHeight(view.frame)/2);
            rotate = CGAffineTransformMakeRotation((float)(arc4random() % (int)(M_PI * 20000) / 10000) - M_PI);
            view.center = center;
            view.backgroundColor = [self randomColor];
            break;
        case ViewControllerCornerViewType:
            view = [self getOppositeAngleView:view inView:self.view isClockwise:self.clockwise];
            
            rotate = CGAffineTransformMakeRotation(0);
            break;
    }
                         view.transform = rotate;
}

- (UIColor*)randomColor{
    
    CGFloat red = (float)arc4random_uniform(256) / 255.f;
    CGFloat green = (float)arc4random_uniform(256) / 255.f;
    CGFloat blue = (float)arc4random_uniform(256) / 255.f;
    CGFloat alpha = (float)arc4random_uniform(256) / 255.f;
    return [[UIColor alloc] initWithRed:red green:green blue:blue alpha:alpha];
}


-(UIView*)getOppositeAngleView:(UIView*)subView inView:(UIView*)superView isClockwise:(NSInteger)isClocwise{
    CGPoint subViewCenter = subView.center;
    CGPoint totalCenterAngle = CGPointZero;
    UIColor *color = [[UIColor alloc]init];
    
    double maxX = CGRectGetMaxX(superView.bounds) - CGRectGetWidth(subView.frame)/2;
    double maxY = CGRectGetMaxY(superView.bounds) - CGRectGetHeight(subView.frame)/2;
    double minX = CGRectGetMinX(superView.bounds) + CGRectGetWidth(subView.frame)/2;
    double minY = CGRectGetMinX(superView.bounds) + CGRectGetHeight(subView.frame)/2;
    CGPoint superViewUpLeftAngle = CGPointMake(minX,minY);
    CGPoint superViewUpRightAngle = CGPointMake(maxX,minY);
    CGPoint superViewDownRigthAngle = CGPointMake(maxX,maxY);
    CGPoint superViewDownLeftAngle = CGPointMake(minX,maxY);
    
    NSInteger coordNumber = 0;
    if(CGPointEqualToPoint(subViewCenter, superViewUpLeftAngle))
    {
        coordNumber = 1;
    }
    if(CGPointEqualToPoint(subViewCenter, superViewUpRightAngle))
    {
        coordNumber = 2;
    }
    if(CGPointEqualToPoint(subViewCenter, superViewDownRigthAngle))
    {
        coordNumber = 3;
    }
    if(CGPointEqualToPoint(subViewCenter, superViewDownLeftAngle))
    {
        coordNumber = 4;
    }
    
    
    if(isClocwise > 500)
    {
        coordNumber++;
        if(coordNumber == 5)
        {
            coordNumber = 1;
        }
    }
    else
    {
        coordNumber = coordNumber + 5;
        coordNumber--;
        if(coordNumber == 5)
        {
            coordNumber = 9;
        }
        
    }
        switch (coordNumber)
        {

            case ViewControllerUpLeftCoordinateNumber:
                totalCenterAngle = superViewUpLeftAngle;
                color = self.upLeftViewColor;
                break;
            case ViewControllerUpRightCoordinateNumber:
                totalCenterAngle = superViewUpRightAngle;
                color = self.upRightViewColor;
                break;
            case ViewControllerDownRightCoordinateNumber:
                totalCenterAngle = superViewDownRigthAngle;
                color = self.downRightViewColor;
                break;
            case ViewControllerDownLeftCoordinateNumber:
                totalCenterAngle = superViewDownLeftAngle;
                color = self.downLeftViewColor;
                break;
            case ViewControllerUpLeftReverseCoordinateNumber:
                totalCenterAngle = superViewUpLeftAngle;
                color = self.upLeftViewColor;
                break;
            case ViewControllerUpRightReverseCoordinateNumber:
                totalCenterAngle = superViewUpRightAngle;
                color = self.upRightViewColor;
                break;
            case ViewControllerDownRightReverseCoordinateNumber:
                totalCenterAngle = superViewDownRigthAngle;
                color = self.downRightViewColor;
                break;
            case ViewControllerDownLeftReverseCoordinateNumber:
                totalCenterAngle = superViewDownLeftAngle;
                color = self.downLeftViewColor;
                break;
        }
    UIView *totalView = subView;
    subView.center = totalCenterAngle;
    totalView.backgroundColor = color;
        
    return totalView;
}

-(void)moveAllView{
    
    for (UIView *view in self.arrayViews)
    {
        [self moveView:(UIView*)view];
    }
    
    for (UIView *view in self.arrayCornerViews)
    {
        [self moveView:(UIView*)view];
    }
}


-(void)setCurrentAllCornerColorsWhithRandom:(BOOL)randomColor{
    if(randomColor)
    {
        self.upLeftViewColor = [self randomColor];
        self.upRightViewColor = [self randomColor];
        self.downLeftViewColor = [self randomColor];
        self.downRightViewColor = [self randomColor];
        return;
    }
    UIView *view = [self.arrayCornerViews objectAtIndex:0];
    double maxX = CGRectGetMaxX(self.view.bounds) - CGRectGetWidth(view.frame)/2;
    double maxY = CGRectGetMaxY(self.view.bounds) - CGRectGetHeight(view.frame)/2;
    double minX = CGRectGetMinX(self.view.bounds) + CGRectGetWidth(view.frame)/2;
    double minY = CGRectGetMinX(self.view.bounds) + CGRectGetHeight(view.frame)/2;
    CGPoint superViewUpLeftAngle = CGPointMake(minX,minY);
    CGPoint superViewUpRightAngle = CGPointMake(maxX,minY);
    CGPoint superViewDownRigthAngle = CGPointMake(maxX,maxY);
    CGPoint superViewDownLeftAngle = CGPointMake(minX,maxY);

    for (UIView *view in self.arrayCornerViews)
    {
        
        if(CGPointEqualToPoint(view.center, superViewUpLeftAngle))
        {
            self.upLeftViewColor = view.backgroundColor;
            continue;
        }
        if(CGPointEqualToPoint(view.center, superViewUpRightAngle))
        {
            self.upRightViewColor = view.backgroundColor;
            continue;
        }
        if(CGPointEqualToPoint(view.center, superViewDownRigthAngle))
        {
            self.downRightViewColor = view.backgroundColor;
            continue;
        }
        if(CGPointEqualToPoint(view.center, superViewDownLeftAngle))
        {
            self.downLeftViewColor = view.backgroundColor;
            continue;
        }
    }
}
@end

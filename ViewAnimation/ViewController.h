//
//  ViewController.h
//  ViewAnimation
//
//  Created by EnzoF on 30.08.16.
//  Copyright © 2016 EnzoF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong,nonatomic) IBOutletCollection(UIView) NSArray *arrayViews;

@property (strong,nonatomic) IBOutletCollection(UIView) NSArray *arrayCornerViews;
@end


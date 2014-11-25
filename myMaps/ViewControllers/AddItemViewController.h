//
//  AddItemViewController.h
//  myMaps
//
//  Created by PiHan Hsu on 2014/11/13.
//  Copyright (c) 2014年 PiHan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddItemViewController : UIViewController

@property(nonatomic,strong) UIDynamicAnimator *animator;
@property(nonatomic, strong) UIPanGestureRecognizer *gestureRecognizer;
@property(nonatomic, strong) UISnapBehavior *snapBehavior;
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;

@end

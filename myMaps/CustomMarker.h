//
//  CustomMarker.h
//  myMaps
//
//  Created by PiHan Hsu on 2014/11/14.
//  Copyright (c) 2014年 PiHan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CustomMarker : UIView
@property (weak, nonatomic) IBOutlet UIImageView *markerView;
@property (strong, nonatomic) UIImage *markerImage;

+ (id)customView;
- (UIImage *) imageWithView:(UIView *)view;

@end

//
//  CustomInfoWindow.h
//  myMaps
//
//  Created by PiHan Hsu on 2014/11/10.
//  Copyright (c) 2014年 PiHan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomInfoWindow : UIView
@property (weak, nonatomic) IBOutlet UIImageView *restaurantImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIImageView *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *starButton;

@end

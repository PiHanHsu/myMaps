//
//  CustomInfoWindow.m
//  myMaps
//
//  Created by PiHan Hsu on 2014/11/10.
//  Copyright (c) 2014年 PiHan Hsu. All rights reserved.
//

#import "CustomInfoWindow.h"

@implementation CustomInfoWindow

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




- (IBAction)likeButtonPressed:(id)sender {
    
     self.displayLikeLabel.text =@"Like!";
    NSLog(@"Pressed");
    
    
}

- (IBAction)statButtonPressed:(id)sender {
    self.starButton.tintColor = [UIColor redColor];
}
@end

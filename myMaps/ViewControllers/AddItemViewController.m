//
//  AddItemViewController.m
//  myMaps
//
//  Created by PiHan Hsu on 2014/11/13.
//  Copyright (c) 2014年 PiHan Hsu. All rights reserved.
//

#import "AddItemViewController.h"
#import "CustomInfoWindow.h"





@implementation AddItemViewController
- (IBAction)showInforPressed:(id)sender {
      CustomInfoWindow *view =  [[[NSBundle mainBundle] loadNibNamed:@"InfoWindow" owner:self options:nil] objectAtIndex:0];
    view.center=self.view.center;
    view.nameLabel.text =@"Pihan";
    //view.displayLikeLabel.text=@"Like!";
 
    [self.view addSubview:view];
}

@end

//
//  AddItemViewController.m
//  myMaps
//
//  Created by PiHan Hsu on 2014/11/13.
//  Copyright (c) 2014年 PiHan Hsu. All rights reserved.
//

#import "AddItemViewController.h"
#import "CustomInfoWindow.h"
#import "CustomMarker.h"
#import <Parse/Parse.h>




@implementation AddItemViewController




- (IBAction)showInforPressed:(id)sender {
      CustomInfoWindow * customInfo =  [[[NSBundle mainBundle] loadNibNamed:@"InfoWindow" owner:self options:nil] objectAtIndex:0];
    customInfo.center=self.view.center;
    customInfo.nameLabel.text =@"Pihan";
    
    
  
    
    
    //CustomMarker *marker =[[[NSBundle mainBundle] loadNibNamed:@"CustomMarkerView" owner:self options:nil] objectAtIndex:0];
    //CustomMarker *marker = [[UIView alloc]init];
    
    //marker.center = CGPointMake(100, 450);
    
    //[self.view addSubview:marker];
    [self.view addSubview:customInfo];
}

@end

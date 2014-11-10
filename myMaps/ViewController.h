//
//  ViewController.h
//  myMaps
//
//  Created by PiHan Hsu on 2014/11/4.
//  Copyright (c) 2014年 PiHan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCGeocodingService.h"
#import <GoogleMaps/GoogleMaps.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

@interface ViewController : UIViewController<UITextFieldDelegate, GMSMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (weak, nonatomic) IBOutlet UITextField * addressField;
- (IBAction)geocode:(id)sender;
- (void)addMarker;

@property (strong,nonatomic) GCGeocodingService *gs;

@end


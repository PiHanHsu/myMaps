//
//  ViewController.m
//  myMaps
//
//  Created by PiHan Hsu on 2014/11/4.
//  Copyright (c) 2014年 PiHan Hsu. All rights reserved.
//

#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <Foundation/Foundation.h>
#import "GCGeocodingService.h"


@interface ViewController ()<
UITextFieldDelegate
>



@end

@implementation ViewController{
    GMSMapView *mapView_;
}

@synthesize gs;
@synthesize addressField;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:25.023868
                                                            longitude:121.528976
                                                                 zoom:15];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.frame = CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height);
    mapView_.myLocationEnabled = YES;

      [self.view insertSubview:mapView_ atIndex:0];
    
    // Creates a marker in the center of the map.

    /*
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(25.023868, 121.528976);
    marker.title = @"Pasta Paradise";
    marker.snippet = @"Good restaurant!!";
    marker.icon =[UIImage imageNamed:@"map_marker_Pihan"];
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = mapView_;
    */
    
    gs = [[GCGeocodingService alloc] init];
    self.addressField.delegate = self;
}


-(void)viewWillAppear:(BOOL)animated{
    
}

- (IBAction)geocode:(id)sender {
    [addressField resignFirstResponder];
    [gs geocodeAddress:addressField.text];
    [self addMarker];
    NSLog(@"text: %@", addressField.text);
    NSLog(@"%@", gs);
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [gs geocodeAddress:addressField.text];
    [self addMarker];
    return YES;
}

- (void)addMarker{
    double lat = [[gs.geocode objectForKey:@"lat"] doubleValue];
    double lng = [[gs.geocode objectForKey:@"lng"] doubleValue];
    GMSMarker *options = [[GMSMarker alloc] init];
    options.position = CLLocationCoordinate2DMake(lat, lng);
    options.title = [gs.geocode objectForKey:@"address"];
    options.appearAnimation= kGMSMarkerAnimationPop;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:lat                                                                longitude:lng                                                        zoom:10];
    NSLog(@" %f, %f",lat, lng);
    [mapView_ setCamera:camera];
    options.map=mapView_;
    //[mapView addMarkerWithOptions:options];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate


@end

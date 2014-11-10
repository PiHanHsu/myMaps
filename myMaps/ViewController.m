//
//  ViewController.m
//  myMaps
//
//  Created by PiHan Hsu on 2014/11/4.
//  Copyright (c) 2014年 PiHan Hsu. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/Foundation.h>
#import "GCGeocodingService.h"
#import <Parse/Parse.h>
#import "CustomInfoWindow.h"

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
    PFQuery *query = [PFQuery queryWithClassName:@"userRecommendData"];
    [query whereKey:@"userName" equalTo:@"Pihan"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            //NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                //NSLog(@"%@", object[@"lat"]);
                //NSLog(@"%@", object[@"lng"]);
                double lat = [object[@"lat"] doubleValue];
                double lng = [object[@"lng"] doubleValue];
                
                GMSMarker * markers = [[GMSMarker alloc]init];
                markers.position = CLLocationCoordinate2DMake(lat, lng);
                markers.map = mapView_;
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    // Creates a marker in the center of the map.
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(25.023868, 121.528976);
    //marker.title = @"Pasta Paradise";
    //marker.snippet = @"Good restaurant!!";
    marker.icon =[UIImage imageNamed:@"map_marker_Pihan"];
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = mapView_;
    
    
    gs = [[GCGeocodingService alloc] init];
    self.addressField.delegate = self;
    
    [self _loadData];
    
}

- (void)_loadData {
    // If the user is already logged in, display any previously cached values before we get the latest from Facebook.
    if ([PFUser currentUser]) {
        //[self _updateProfileData];
    }
    
    // Send request to Facebook
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        // handle response
        if (!error) {
            // Parse the data received
            NSDictionary *userData = (NSDictionary *)result;
            
            NSString *facebookID = userData[@"id"];
            
            
            NSMutableDictionary *userProfile = [NSMutableDictionary dictionaryWithCapacity:7];
            
            if (facebookID) {
                userProfile[@"facebookId"] = facebookID;
            }
            
            NSString *name = userData[@"name"];
            if (name) {
                userProfile[@"name"] = name;
            }
            
            NSString *location = userData[@"location"][@"name"];
            if (location) {
                userProfile[@"location"] = location;
            }
            
            NSString *gender = userData[@"gender"];
            if (gender) {
                userProfile[@"gender"] = gender;
            }
            
            NSString *birthday = userData[@"birthday"];
            if (birthday) {
                userProfile[@"birthday"] = birthday;
            }
            
            NSString *relationshipStatus = userData[@"relationship_status"];
            if (relationshipStatus) {
                userProfile[@"relationship"] = relationshipStatus;
            }
            NSString *email =userData[@"email"];
            if(email){
                userProfile[@"email"] = email;
                
            }
            NSString *userFriends =userData[@"user_friends"];
            if(userFriends){
                userProfile[@"user_friends"] = userFriends;
                NSLog(@"%@", userFriends);
            }
            
            userProfile[@"pictureURL"] = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID];
            
            [[PFUser currentUser] setObject:userProfile forKey:@"profile"];
            [[PFUser currentUser] saveInBackground];
            
            //[self _updateProfileData];
        } else if ([[[[error userInfo] objectForKey:@"error"] objectForKey:@"type"]
                    isEqualToString: @"OAuthException"]) { // Since the request failed, we can check if it was due to an invalid session
            NSLog(@"The facebook session was invalidated");
            //[self logoutButtonAction:nil];
        } else {
            NSLog(@"Some other error: %@", error);
        }
    }];
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
    //NSLog(@" %f, %f",lat, lng);
    [mapView_ setCamera:camera];
    options.map=mapView_;
    
}
- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
    
    CustomInfoWindow *view =  [[[NSBundle mainBundle] loadNibNamed:@"InfoWindow" owner:self options:nil] objectAtIndex:0];
    view.nameLabel.text = @"Pasta";
    return view;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate


@end

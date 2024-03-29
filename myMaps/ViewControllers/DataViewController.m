//
//  DataViewController.m
//  myMaps
//
//  Created by PiHan Hsu on 2014/11/5.
//  Copyright (c) 2014年 PiHan Hsu. All rights reserved.
//

#import "DataViewController.h"
#import <Parse/Parse.h>
#import "GCGeocodingService.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "CustomMarker.h"
#import "CustomInfoWindow.h"

#define kOpenDataRestaurantAPI @"http://data.taipei.gov.tw/opendata/apply/json/MDY2RERBMTctQTE4Mi00OEU5LUI2M0YtRTg0NTQ1NUEzM0Mw"
#define kOpenDataRestaurantNewTaipeiAPI @"http://data.ntpc.gov.tw/NTPC/od/data/api/1040400257/?$format=json"

@implementation DataViewController
@synthesize gs;

- (void)viewDidLoad {
    [super viewDidLoad];
     gs = [[GCGeocodingService alloc] init];
    
    NSString *userProfilePhotoURLString = [PFUser currentUser][@"profile"][@"pictureURL"];
    // Download the user's facebook profile picture
    if (userProfilePhotoURLString) {
        NSURL *pictureURL = [NSURL URLWithString:userProfilePhotoURLString];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:pictureURL];
        
        [NSURLConnection sendAsynchronousRequest:urlRequest
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                   if (connectionError == nil && data != nil) {
                                       
                                       self.headImageView.image = [UIImage imageWithData:data];
                                       // Add a nice corner radius to the image
                                       self.headImageView.layer.cornerRadius = 50.0f;
                                       self.headImageView.layer.masksToBounds = YES;
                                       
                                       
                                       //Try to put the head to customMarker, not work yet!
                                       
                                       /*
                                       CustomMarker *userMarker = [CustomMarker customView] ;
                                       userMarker.markerView.image= [UIImage imageWithData:data];
                                       self.headImageView.image =userMarker.markerImage;
                                       */
                                      
                                       //Save FB image to Parse. Done!
                                       /*
                                       NSData *imageData = UIImageJPEGRepresentation(userMarker.markerImage, 0);
                                       PFFile *imageFile = [PFFile fileWithName:@"userMarker.png" data:imageData];
                                       PFUser *currentUser =[PFUser currentUser];
                                       currentUser[@"userMarker"] =imageFile;
                                       [currentUser saveInBackground];
                                       */
                                       
                                   } else {
                                       NSLog(@"Failed to load profile photo.");
                                   }
                               }];
    }

    
    
}

- (IBAction)addToParseButtonPressed:(id)sender {
    
     [gs geocodeAddress:self.addressTextField.text];
    double lat = [[gs.geocode objectForKey:@"lat"] doubleValue];
    double lng = [[gs.geocode objectForKey:@"lng"] doubleValue];
    PFObject *object =[PFObject objectWithClassName:@"userRecommendData"];
    object[@"name"]=self.nameTextField.text;
    object[@"address"] =self.addressTextField.text;
   
    object[@"lat"] = [NSString stringWithFormat:@"%f", lat];
    object[@"lng"] = [NSString stringWithFormat:@"%f", lng];
    [object save];
                  }
- (IBAction)logoutButtonPressed:(id)sender {
    // Logout user, this automatically clears the cache
    [[PFFacebookUtils session] closeAndClearTokenInformation];
    [PFUser logOut];
    
    // Return to login view controller
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)getDataFromParse:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"Restaurant"];
    //[query whereKey:@"userName" equalTo:@"Pihan"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu objects", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSString *address = [[NSString alloc]init];
                address =[object objectForKey:@"Address"] ;
                NSLog(@"address: %@", address);
                
                [gs geocodeAddress:address];
                double lat = [[gs.geocode objectForKey:@"lat"] doubleValue];
                double lng = [[gs.geocode objectForKey:@"lng"] doubleValue];
                //PFObject *object =[PFObject objectWithClassName:@"test"];
                
                object[@"lat"] = [NSString stringWithFormat:@"%f", lat];
                object[@"lng"] = [NSString stringWithFormat:@"%f", lng];
                [object saveInBackground];
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
}


- (IBAction)getDataButtonPressed:(id)sender {
    
    //臺北市政府資料平台
    /*
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kOpenDataRestaurantAPI] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            NSError *error = nil;
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (!error) {
     
                for (NSDictionary *eachItem in jsonArray) {
                    PFObject * restaurantData = [PFObject objectWithClassName:@"restaurantData"];
                    restaurantData[@"name"]=[eachItem objectForKey:@"name"];
                    restaurantData[@"certification_category"]=[eachItem objectForKey:@"certification_category"];
                    restaurantData[@"tel"]=[eachItem objectForKey:@"tel"];
                    restaurantData[@"traffic_info"]=[eachItem objectForKey:@"traffic_info"];
                    restaurantData[@"display_addr"]=[eachItem objectForKey:@"display_addr"];
                    restaurantData[@"poi_addr"]=[eachItem objectForKey:@"poi_addr"];
                    restaurantData[@"X"]=[eachItem objectForKey:@"X"];
                    restaurantData[@"Y"]=[eachItem objectForKey:@"Y"];
                    [restaurantData saveInBackground];
                    }
     
            } else {
                NSLog(@"Error with: %@", error);
            }
        } else {
            NSLog(@"Connection with: %@", connectionError);
        }
    }];
    */
    
    NSURLRequest *request2 = [NSURLRequest requestWithURL:[NSURL URLWithString:kOpenDataRestaurantNewTaipeiAPI] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    
    [NSURLConnection sendAsynchronousRequest:request2 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            NSError *error = nil;
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (!error) {
                NSLog(@"%lu",jsonArray.count);
                
                for (NSDictionary *eachItem in jsonArray) {
                    
                    PFObject * restaurantData = [PFObject objectWithClassName:@"restaurantData"];
                    restaurantData[@"Id"]=[eachItem objectForKey:@"Id"];
                    restaurantData[@"name"]=[eachItem objectForKey:@"Name"];
                    restaurantData[@"tel"]=[eachItem objectForKey:@"Tel"];
                    restaurantData[@"Opentime"]=[eachItem objectForKey:@"Opentime"];
                    restaurantData[@"Parkinginfo"]=[eachItem objectForKey:@"Parkinginfo"];
                    restaurantData[@"Picdescribe1"]=[eachItem objectForKey:@"Picdescribe1"];
                    restaurantData[@"Picdescribe2"]=[eachItem objectForKey:@"Picdescribe2"];
                    restaurantData[@"Picdescribe3"]=[eachItem objectForKey:@"Picdescribe3"];
                    restaurantData[@"Picture1"]=[eachItem objectForKey:@"Picture1"];
                    restaurantData[@"Picture2"]=[eachItem objectForKey:@"Picture2"];
                    restaurantData[@"Picture3"]=[eachItem objectForKey:@"Picture3"];
                    restaurantData[@"Px"]=[eachItem objectForKey:@"Px"];
                    restaurantData[@"Py"]=[eachItem objectForKey:@"Py"];
                    restaurantData[@"Website"]=[eachItem objectForKey:@"Website"];
                    restaurantData[@"Zipcode"]=[eachItem objectForKey:@"Zipcode"];
                 [restaurantData saveInBackground];
                                }
                 
            } else {
                NSLog(@"Error with: %@", error);
            }
        } else {
            NSLog(@"Connection with: %@", connectionError);
        }
    }];
}


@end

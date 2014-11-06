//
//  DataViewController.m
//  myMaps
//
//  Created by PiHan Hsu on 2014/11/5.
//  Copyright (c) 2014年 PiHan Hsu. All rights reserved.
//

#import "DataViewController.h"
#import <Parse/Parse.h>

#define kOpenDataRestaurantAPI @"http://data.taipei.gov.tw/opendata/apply/json/MDY2RERBMTctQTE4Mi00OEU5LUI2M0YtRTg0NTQ1NUEzM0Mw"
#define kOpenDataRestaurantNewTaipeiAPI @"http://data.ntpc.gov.tw/NTPC/od/data/api/1040400257/?$format=json"

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
}



- (IBAction)getDataButtonPressed:(id)sender {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kOpenDataRestaurantAPI] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            NSError *error = nil;
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (!error) {
                /*
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
                */
            } else {
                NSLog(@"Error with: %@", error);
            }
        } else {
            NSLog(@"Connection with: %@", connectionError);
        }
    }];
    
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

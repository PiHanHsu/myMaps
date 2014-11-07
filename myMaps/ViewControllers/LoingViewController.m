//
//  LoingViewController.m
//  myMaps
//
//  Created by PiHan Hsu on 2014/11/5.
//  Copyright (c) 2014年 PiHan Hsu. All rights reserved.
//

#import "LoingViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <FacebookSDK/FacebookSDK.h>

@implementation LoingViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Facebook Profile";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //FBLoginView *loginView = [[FBLoginView alloc] init];
    //loginView.center = self.view.center;
    //[self.view addSubview:loginView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Check if user is cached and linked to Facebook, if so, bypass login
    //if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
      //  [self _presentUserDetailsViewControllerAnimated:NO];
   // }
}


- (IBAction)loginButtonTouchHandler:(id)sender  {
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location", @"user_friends", @"email"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        [_activityIndicator stopAnimating]; // Hide loading indicator
        
        if (!user) {
            NSString *errorMessage = nil;
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                errorMessage = @"Uh oh. The user cancelled the Facebook login.";
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                errorMessage = [error localizedDescription];
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error"
                                                            message:errorMessage
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"Dismiss", nil];
            [alert show];
        } else {
            if (user.isNew) {
                NSLog(@"User with facebook signed up and logged in!");
                
            } else {
                NSLog(@"User with facebook logged in!");
                NSLog(@" user info %@", user.description);
                user.email=[PFUser currentUser][@"profile"][@"email"];
                user[@"name"]=[PFUser currentUser][@"profile"][@"name"];
                user[@"gender"]=[PFUser currentUser][@"profile"][@"gender"];
                user[@"birthday"]=[PFUser currentUser][@"profile"][@"birthday"];
                
                
            }
            [self _presentUserDetailsViewControllerAnimated:YES];
        }
    }];
    
    [_activityIndicator startAnimating]; // Show loading indicator until login is finished
}

#pragma mark -
#pragma mark UserDetailsViewController

- (void)_presentUserDetailsViewControllerAnimated:(BOOL)animated {
    //UserDetailsViewController *detailsViewController = [[UserDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    //[self.navigationController pushViewController:detailsViewController animated:animated];
}

@end

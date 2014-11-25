//
//  CustomMarker.m
//  myMaps
//
//  Created by PiHan Hsu on 2014/11/14.
//  Copyright (c) 2014年 PiHan Hsu. All rights reserved.
//

#import "CustomMarker.h"

@implementation CustomMarker


+ (id)customView
{
    CustomMarker *customView = [[[NSBundle mainBundle] loadNibNamed:@"CustomMarkerView" owner:nil options:nil] lastObject];
    
    // make sure customView is not nil or the wrong class!
    if ([customView isKindOfClass:[CustomMarker class]])
        return customView;
    else
        return nil;
}

- (UIImage *) imageWithView:(UIView *)view
{
   
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0f);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    UIImage * snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshotImage;
}

-(UIImage *) markerImage{
    
    UIImage *img= [self imageWithView:self];
    return img;
    
}

/*
-(UIImageView *) markerView{
    
    UIImageView *currentImageView =[[UIImageView alloc]init];
    
    
 NSString *userProfilePhotoURLString = [PFUser currentUser][@"profile"][@"pictureURL"];
 // Download the user's facebook profile picture
 if (userProfilePhotoURLString) {
 NSURL *pictureURL = [NSURL URLWithString:userProfilePhotoURLString];
 NSURLRequest *urlRequest = [NSURLRequest requestWithURL:pictureURL];
 
 [NSURLConnection sendAsynchronousRequest:urlRequest
 queue:[NSOperationQueue mainQueue]
 completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
 if (connectionError == nil && data != nil) {
 currentImageView.image = [UIImage imageWithData:data];
 
 // Add a nice corner radius to the image
 currentImageView.layer.cornerRadius = 30.0f;
 currentImageView.layer.masksToBounds = YES;
 } else {
 NSLog(@"Failed to load profile photo.");
 }
 }];
 }
    return currentImageView;
}
 */

@end


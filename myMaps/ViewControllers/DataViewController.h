//
//  DataViewController.h
//  myMaps
//
//  Created by PiHan Hsu on 2014/11/5.
//  Copyright (c) 2014年 PiHan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "GCGeocodingService.h"

@interface DataViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (strong,nonatomic) GCGeocodingService *gs;

@end

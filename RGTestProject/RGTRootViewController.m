//
//  RGTRootViewController.m
//  RGTestProject
//
//  Created by Ramil Garaev on 20.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import "RGTRootViewController.h"
#import "RGTAssistantViewController.h"

static NSString* RGT_FIRST_LAUNCH_KEY = @"RGT_FIRST_LAUNCH_CHECK_KEY";

@implementation RGTRootViewController

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    BOOL isLaunchedBefore = [[[NSUserDefaults standardUserDefaults] valueForKey: RGT_FIRST_LAUNCH_KEY] boolValue];
    if (!isLaunchedBefore)
    {
        // show assistant
        RGTAssistantViewController* assistantVC = [[RGTAssistantViewController alloc] initWithNibName: NSStringFromClass([RGTAssistantViewController class])
                                                                                               bundle: [NSBundle mainBundle]];
        [self presentViewController: assistantVC
                           animated: YES
                         completion: ^{
                             [[NSUserDefaults standardUserDefaults] setBool: YES
                                                                     forKey: RGT_FIRST_LAUNCH_KEY];
                         }];
    }

}

@end

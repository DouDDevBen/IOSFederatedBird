//
//  ReadingListTableViewController.m
//  Federated Bird
//
//  Created by BENSOUSSAN on 17/02/2016.
//  Copyright © 2016 BENSOUSSAN. All rights reserved.
//

#import "ReadingListTableViewController.h"
#import "FBDataProvider.h"
#import "FBSession.h"

@interface ReadingListTableViewController ()

@property NSString *token;
@property NSString *handle;
@property NSString *password;

@end

@implementation ReadingListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NSString *staticUser = @"edwin04";
    //NSString *staticPassword = @"edwin04";
    //NSString *staticHandle = [staticUser stringByAppendingString:@"@sio.lab.corp.abelionni.com"];
    
    //FBSession *staticSession = [FBSession prepareSessionForHandle:staticHandle];
    
    // créer user
//    [FBSession createAccountWithHandle:staticHandle
//                           andPassword:staticPassword
//                 withCompletionHandler:^(NSDictionary *result, NSError *error) {
//    
//                     NSString *token = [result valueForKey:@"token"];
//                     
//                     if ([token length] > 0) {
//                         NSLog(@"Compte créé , token = %@",token);
//                     } else {
//                         NSLog(@"error");
//                     }
//                 }
//     ];

    
    [[FBDataProvider sharedInstance].session readingListWithCompletionHandler:^(NSArray *result, NSError *error) {
        NSLog(@"Reading list%@", result);
        
        self.tweets = result;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
        });

    }];
    
                                  
                                  //                                  [staticSession follow:@"yoann"
//                                  withCompletionHandler:^(NSDictionary *result, NSError *error) {
//                                      NSLog(@"-----follow\n%@", result);
//                                  }];
                                  
//                                  [staticSession postPublicMessage:@"Hello world!"
//                                             withCompletionHandler:^(NSError *error) {
//                                                NSLog(@"message posté");
//                                             }];
//                                  
//                                  [staticSession postPublicMessage:@"Hello world2!"
//                                             withCompletionHandler:^(NSError *error) {
//                                                  NSLog(@"message posté");
//                                             }];
//                                  
//                                  [staticSession postPublicMessage:@"Hello world3!"
//                                             withCompletionHandler:^(NSError *error) {
//                                                  NSLog(@"message posté");
//                                             }];
    
    
//    self.tweets = @[
//    @{@"by": @"edwin", @"content": @"readinglist1"},
//    @{@"by": @"seb", @"content": @"readinglist2"},
//    @{@"by": @"ahahaha", @"content": @"readinglist3"},
//    @{@"by": @"r1", @"content": @"readinglist4"},
//    @{@"by": @"ios", @"content": @"readinglist5"},
//    @{@"by": @"android", @"content": @"readinglist6"},
//    ];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

@end

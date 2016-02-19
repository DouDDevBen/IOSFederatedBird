//
//  AllTweetsTableViewController.m
//  Federated Bird
//
//  Created by BENSOUSSAN on 17/02/2016.
//  Copyright © 2016 BENSOUSSAN. All rights reserved.
//

#import "AllTweetsTableViewController.h"

#import "FBDataProvider.h"

@interface AllTweetsTableViewController ()

//@property NSString *token;
//@property NSString *handle;
//@property NSString *password;

@end

@implementation AllTweetsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NSString *staticUser = @"edwin04";
    //NSString *staticHandle = [staticUser stringByAppendingString:@"@sio.lab.corp.abelionni.com"];
    //NSString *server = @"@sio.lab.corp.abelionni.com";
    
    //FBSession *staticSession = [FBSession prepareSessionForHandle:staticHandle];
    
//    [FBSession publicMessagesForHandle:staticHandle withCompletionHandler:^(NSArray *result, NSError *error) {
//        self.tweets = result;
//        //self.tableView.reloadData;
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.tableView reloadData];
//            NSLog(@"%@",error);
//            NSLog(@"%@",result);
//        });
//        
//
//    }];
    
    [FBSession allPublicMessagesFromServer:[FBDataProvider sharedInstance].session.servername
                     withCompletionHandler:^(NSArray *result, NSError *error) {
         self.tweets = result;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            NSLog(@"%@",error);
            NSLog(@"%@",result);
        });
        
    }];
    
//    self.tweets = @[
//                    @{@"by": @"edwin", @"content": @"youpi"},
//                    @{@"by": @"seb", @"content": @"louekcnfzf"},
//                    @{@"by": @"ahahaha", @"content": @"mfdsgs"},
//                    @{@"by": @"r1", @"content": @"neiieie"},
//                    @{@"by": @"ios", @"content": @"je suis trop fort"},
//                    @{@"by": @"android", @"content": @"je suis nul"},
//                    ];


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}






@end

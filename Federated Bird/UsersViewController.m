//
//  UsersViewController.m
//  Federated Bird
//
//  Created by BENSOUSSAN on 18/02/2016.
//  Copyright © 2016 BENSOUSSAN. All rights reserved.
//

#import "UsersViewController.h"
#import "FBDataProvider.h"


@interface UsersViewController ()

@end

@implementation UsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [FBSession usernamesFromServer: [FBDataProvider sharedInstance].session.servername withCompletionHandler:^(NSArray *result, NSError *error) {
           NSLog(@"icicicicidjbfrf")   ;
        NSMutableArray *newResult = [[NSMutableArray alloc] init];
        for (NSString *item in result) {
            NSDictionary *dict = @{@"by": item, @"content": item};
            [newResult addObject: dict];
             NSLog(@"%@",[dict valueForKey:@"by"]);
        }
        self.tweets = newResult;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
        });
        
    }];
    
//     authenticateWithPassword:staticUser
//                      withCompletionHandler:^(NSError *error) {
//                          if (error) {
//                              NSLog(@"Unable to login\n%@", error);
//                          } else {
//                              NSLog(@"Authentification OK");
//                              [staticSession readingListWithCompletionHandler:^(NSArray *result, NSError *error) {
//                                  NSLog(@"Reading list for static user \n%@", result);
//                                  
//                                  [staticSession readingListWithCompletionHandler:^(NSArray *result, NSError *error) {
//                                      NSLog(@"-----readingListWithCompletionHandler après unfollow\n%@", result);
//                                      
//                                      dispatch_async(dispatch_get_main_queue(), ^{
//                                          self.tweets = result;
//                                          [self.tableView reloadData];
//                                      });
//                                      
//                                  }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

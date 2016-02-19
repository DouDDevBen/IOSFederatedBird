//
//  CommonTableViewController.m
//  Federated Bird
//
//  Created by BENSOUSSAN on 17/02/2016.
//  Copyright © 2016 BENSOUSSAN. All rights reserved.
//

#import "CommonTableViewController.h"
#import "FBDataProvider.h"
#import "UIColor+ColorExtensions.h"
#import "DetailMessageViewController.h"

@interface CommonTableViewController ()

@property NSMutableArray *names;
@property NSMutableDictionary *avatars;
@property id notificationCenterObject;
@end

@implementation CommonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    //[refreshControl addTarget:self action:@selector(reaload) forControlEvents:UIControlEventValueChanged];
    
    //reload method
    //[self.refreshControl endRefreshing];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;


}

-(void)viewDidAppear:(BOOL)animated {
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.notificationCenterObject = [[NSNotificationCenter defaultCenter] addObserverForName:kFBDataProviderAuthenticated
                                                                                      object:nil
                                                                                       queue:nil
                                                                                  usingBlock:^(NSNotification * _Nonnull note) {
                                                            
                                                                        }];
    
    for (NSDictionary* tweet in self.tweets) {
        NSString *name = [tweet objectForKey:@"by"];
        if (![self.names containsObject:name]) {
            [self.names addObject:name];
        }
    }
    for (NSString *name in self.names) {
        NSURL *urlAvatar = [NSURL URLWithString:[NSString stringWithFormat:@"https://robohash.org/%@?size=20x20", name]];
        NSData *data = [[NSData alloc] initWithContentsOfURL:urlAvatar];
        //[self.avatars setValue:data forUndefinedKey:name];
        //[self.avatars setObject:data forKey:name];
        //[self.avatars setObject:data forKey:name];
        NSString *stringData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [self.avatars setObject:stringData forKey:name];
        
        NSLog(@"%@ --- %@", name, stringData);
    }

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _tweets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"stdCell" forIndexPath:indexPath];
    // Configure the cell...
    
    NSDictionary *user = [self.tweets objectAtIndex:indexPath.row];
    NSString *name = [user valueForKey:@"by"];
    NSString *content = [user valueForKey:@"content"];
    
    if([content isEqual:[NSNull null]] || [name isEqual:[NSNull null]]){
        
        content = @"null message";
        name = @"null message";
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",content];
    cell.textLabel.textColor = [UIColor darkSlateColor];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"write by %@", name];
    cell.detailTextLabel.textColor = [UIColor mintGreenColor];
    //cell.messageText.text = [NSString stringWithFormat:@"%@",content];
    //cell.authorText.text = [NSString stringWithFormat:@"write by %@", name];
    
    //NSURL *urlAvatar = [NSURL URLWithString:[NSString stringWithFormat:@"https://robohash.org/%@?size=20x20", name]];
    //NSData *data = [[NSData alloc] initWithContentsOfURL:urlAvatar];
    //cell.imageView.image = [UIImage imageWithData:data];
    
 
    //NSData *dataa = [self.avatars objectForKey:name];
    //NSLog(@"%@", dataa);
    //cell.imageView.image = [UIImage imageWithData:dataa];
    //NSInteger *index = [self.names indexOfObject:name];
    //NSData *data = [[NSData alloc ] ini];
    //cell.imageView.image = [UIImage imageWithData:data];
    
    NSLog(@"%@ --", [self.avatars objectForKey:name]);
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"stdsegue"]) {
        DetailMessageViewController *detailViewControleur = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        //detailViewControleur.delegate = self;
        NSDictionary *user = [self.tweets objectAtIndex:indexPath.row];
        detailViewControleur.message = [user valueForKey:@"content"];
        detailViewControleur.title = [user valueForKey:@"by"];;
        
        
    }
    
}


@end

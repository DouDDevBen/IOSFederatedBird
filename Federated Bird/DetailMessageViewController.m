//
//  DetailMessageViewController.m
//  Federated Bird
//
//  Created by BENSOUSSAN on 18/02/2016.
//  Copyright © 2016 BENSOUSSAN. All rights reserved.
//

#import "DetailMessageViewController.h"

@interface DetailMessageViewController ()

@end

@implementation DetailMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self.navigationController setTitle: self.message];
    self.messageTextLabel.text = self.message;
    
    
    
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

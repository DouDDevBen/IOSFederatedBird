//
//  PostMessageViewController.m
//  Federated Bird
//
//  Created by BENSOUSSAN on 17/02/2016.
//  Copyright © 2016 BENSOUSSAN. All rights reserved.
//

#import "PostMessageViewController.h"
#import "FBDataProvider.h"
#import "FBSession.h"
#import <UIKit/UIKit.h>
#import "UIColor+ColorExtensions.h"

@interface PostMessageViewController ()
@property id notificationCenterObject;

@property (weak, nonatomic) IBOutlet UITextView *textField;
@property CGFloat heightKeyboard;
@property UIEdgeInsets oriInset;
@property BOOL contentInsetStored;

@end

@implementation PostMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction) postButtonAction: (id)sender {
   
    [[NSNotificationCenter defaultCenter] removeObserver:self.notificationCenterObject];
    self.notificationCenterObject = nil;

    //[self.textField resignFirstResponder];
    [self resignFirstResponder];
    
    self.textField.contentInset = self.oriInset;
    self.textField.scrollIndicatorInsets = self.oriInset;
    

    [[FBDataProvider sharedInstance].session postPublicMessage:self.textField.text withCompletionHandler:^(NSError *error) {
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIAlertController *alert = [UIAlertController
                                            alertControllerWithTitle:@"Message"
                                            message:@"Le message est bien posté"
                                            preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okAction = [UIAlertAction
                                           actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action)
                                           {
                                               NSLog(@"OK action");
                                           }];
                
                [alert addAction:okAction];
                [self presentViewController:alert animated:true completion:nil];
                [self.navigationController popViewControllerAnimated:YES];
                
            });
        }
    
        
        
    }];
    
    //[FBSession allPublicMessagesFromServer:server withCompletionHandler:^(NSArray *result, NSError *error) {
        //self.tweets = result;
    
}

- (void)viewWillAppear:(BOOL)animated  {
    
    // add keyboard notification
    [[NSNotificationCenter defaultCenter] addObserver:self     selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification  object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self      selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    
    UIBarButtonItem *postButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(postButtonAction:)];
    self.navigationItem.rightBarButtonItem = postButton;
    
    self.oriInset = self.textField.contentInset;
    
    self.textField.textColor = [UIColor darkSlateColor];
    

}

- (void)keyboardDidShow:(NSNotification *)notification {
    
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue] ;
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    if (!self.contentInsetStored) {
        self.oriInset = self.textField.contentInset;
        self.contentInsetStored = YES;
    }
    
    //UIEdgeInsets newInset = self.textField.contentInset;
    //self.textField.contentInset =
    UIEdgeInsets newInset = UIEdgeInsetsMake(self.oriInset.top, self.oriInset.left, self.oriInset.bottom + keyboardRect.size.height - (self.view.window.frame.size.height - self.view.frame.size.height - self.view.frame.origin.y), self.oriInset.right);
    
    self.textField.scrollIndicatorInsets = newInset;
    self.textField.contentInset = newInset;
    self.heightKeyboard = keyboardRect.size.height;
    
    
   }

- (void)keyboardDidHide:(NSNotification *)notification {

    self.textField.scrollIndicatorInsets = self.oriInset;
    self.textField.contentInset = self.oriInset;
    
    
    //    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
//    CGRect newframe = CGRectMake(self.textField.frame.origin.x, self.textField.frame.origin.y, self.textField.frame.size.width, self.textField.frame.size.height + self.heightKeyboard);
//    [self.textField setFrame:newframe];
}

-(void)viewDidDisappear:(BOOL)animated {
//    CGRect newframe = CGRectMake(self.textField.frame.origin.x, self.textField.frame.origin.y, self.textField.frame.size.width, self.textField.frame.size.height + self.heightKeyboard);
//    [self.textField setFrame:newframe];
//    
    [[NSNotificationCenter defaultCenter] removeObserver:self.notificationCenterObject];
//    self.notificationCenterObject = nil;
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

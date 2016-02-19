//
//  DetailMessageViewController.h
//  Federated Bird
//
//  Created by BENSOUSSAN on 18/02/2016.
//  Copyright © 2016 BENSOUSSAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailMessageViewController : UIViewController

@property NSString *message;


@property (weak, nonatomic) IBOutlet UITextView *messageTextLabel;

@end

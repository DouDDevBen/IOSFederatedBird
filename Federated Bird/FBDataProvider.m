//
//  FBDataProvider.m
//  Federated Birds
//
//  Created by Yoann Gini on 17/02/2016.
//  Copyright © 2016 Yoann Gini. All rights reserved.
//

#import "FBDataProvider.h"

@implementation FBDataProvider


- (void)authenticateWithHandle:(NSString*)handle andPassword:(NSString*)password {
    self.session = [FBSession prepareSessionForHandle:handle];
    
    [self.session authenticateWithPassword:password
                     withCompletionHandler:^(NSError *error) {
                         if (!error) {
                             [[NSNotificationCenter defaultCenter] postNotificationName:kFBDataProviderAuthenticated
                                                                                 object:nil];
                         }
                         
                     }];
}


+ (instancetype)sharedInstance {
//    static FBDataProvider* test = nil;
    
//    if (!test) {
//        test = [[FBDataProvider alloc] init];
//    }
//    OK mais pas multithread
    
    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        test = [[FBDataProvider alloc] init];
//    });
//    OK et multithread
    
    
    static id sharedInstanceFBDataProvider = nil;
    static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstanceFBDataProvider = [self new];
	});
    return sharedInstanceFBDataProvider;
}

@end

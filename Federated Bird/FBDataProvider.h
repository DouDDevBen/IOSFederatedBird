//
//  FBDataProvider.h
//  Federated Birds
//
//  Created by Yoann Gini on 17/02/2016.
//  Copyright © 2016 Yoann Gini. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FBSession.h"

#define kFBDataProviderAuthenticated @"kFBDataProviderAuthenticated"

@interface FBDataProvider : NSObject

@property FBSession *session;

+ (instancetype)sharedInstance;

- (void)authenticateWithHandle:(NSString*)handle andPassword:(NSString*)password;

@end

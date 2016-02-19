//
//  FBSession.h
//  DataTest
//
//  Created by Yoann Gini on 16/02/2016.
//  Copyright © 2016 Yoann Gini. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FBSessionCompletionHandlerWithArray)(NSArray* result, NSError *error);
typedef void(^FBSessionCompletionHandlerWithDictionary)(NSDictionary* result, NSError *error);
typedef void(^FBSessionCompletionHandler)(NSError *error);

// handle -> alice@server.example.com
// username -> alice
// servername -> server.example.com

// URL API -> http://<servername>/api

@interface FBSession : NSObject

#pragma mark Toolbox

+ (NSString*)serverNameForHandle:(NSString*)handle;
+ (NSString*)usernameForHandle:(NSString*)handle;

#pragma mark Unauthenticated actions
+ (void)followersForHandle:(NSString*)handle withCompletionHandler:(FBSessionCompletionHandlerWithArray)completionHandler;
+ (void)followingsForHandle:(NSString*)handle withCompletionHandler:(FBSessionCompletionHandlerWithArray)completionHandler;

+ (void)publicMessagesForHandle:(NSString*)handle withCompletionHandler:(FBSessionCompletionHandlerWithArray)completionHandler;

+ (void)createAccountWithHandle:(NSString*)handle andPassword:(NSString*)password withCompletionHandler:(FBSessionCompletionHandlerWithDictionary)completionHandler;

+ (void)usernamesFromServer:(NSString*)servername withCompletionHandler:(FBSessionCompletionHandlerWithArray)completionHandler;
+ (void)allPublicMessagesFromServer:(NSString*)servername withCompletionHandler:(FBSessionCompletionHandlerWithArray)completionHandler;

#pragma mark User session related
@property (readonly) BOOL authenticated;
@property (readonly) NSString *username;
@property (readonly) NSString *servername;
+ (instancetype)prepareSessionForHandle:(NSString*)handle;
- (instancetype)initForHandle:(NSString*)handle;
+ (instancetype)sessionForHandle:(NSString*)handle withToken:(NSString*)token;

- (void)authenticateWithPassword:(NSString*)password withCompletionHandler:(FBSessionCompletionHandler)completionHandler;

- (void)follow:(NSString*)username withCompletionHandler:(FBSessionCompletionHandlerWithDictionary)completionHandler;
- (void)unfollow:(NSString*)username withCompletionHandler:(FBSessionCompletionHandler)completionHandler;

- (void)postPublicMessage:(NSString*)message withCompletionHandler:(FBSessionCompletionHandler)completionHandler;

- (void)readingListWithCompletionHandler:(FBSessionCompletionHandlerWithArray)completionHandler;

@end

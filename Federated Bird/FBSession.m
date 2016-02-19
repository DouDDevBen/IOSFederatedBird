//
//  FBSession.m
//  DataTest
//
//  Created by Yoann Gini on 16/02/2016.
//  Copyright © 2016 Yoann Gini. All rights reserved.
//

#import "FBSession.h"

@interface FBSession ()
@property (readwrite) BOOL authenticated;
@property (readwrite) NSString *username;
@property (readwrite) NSString *servername;
@property (readwrite) NSString *token;
@end

@implementation FBSession

#pragma mark Toolbox

+ (NSString*)serverNameForHandle:(NSString*)handle {
    return [[handle componentsSeparatedByString:@"@"] lastObject];
}

+ (NSString*)usernameForHandle:(NSString*)handle {
    return [[handle componentsSeparatedByString:@"@"] firstObject];
}

+ (NSMutableURLRequest*)requestWithMethod:(NSString*)method forServer:(NSString*)servername withContent:(NSDictionary*)content andPath:(NSString*)path {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/api/%@", servername, path]]];
    request.HTTPMethod = method;
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    if (content) {
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:content
                                                           options:0
                                                             error:nil];
        request.HTTPBody = jsonData;
        //    [request setHTTPBody:jsonData];
    }

    
    
    return request;
}

+ (NSURLRequest*)getRequestForServer:(NSString*)server andPath:(NSString*)path {
    return [FBSession requestWithMethod:@"GET" forServer:server withContent:nil andPath:path];
}

+ (NSURLRequest*)getRequestForServer:(NSString*)server withToken:(NSString*)token andPath:(NSString*)path {
    NSMutableURLRequest *request = [FBSession requestWithMethod:@"GET" forServer:server withContent:nil andPath:path];
    
    [request setValue:token forHTTPHeaderField:@"X-Token"];
    
    return request;
}

+ (NSURLRequest*)postRequestForServer:(NSString*)server withContent:(NSDictionary*)content andPath:(NSString*)path {
    return [FBSession requestWithMethod:@"POST" forServer:server withContent:content andPath:path];
}

+ (NSURLRequest*)deleteRequestForServer:(NSString*)server withContent:(NSDictionary*)content andPath:(NSString*)path {
    return [FBSession requestWithMethod:@"DELETE" forServer:server withContent:content andPath:path];
}

+ (void)startJSONTaskWithRequest:(NSURLRequest*)request andCompletionHandler:(FBSessionCompletionHandlerWithDictionary)completionHandler {
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                                                                                                          
                                                                     if (error) {
                                                                         completionHandler(nil, error);
                                                                     } else if (data) {
                                                                         // ... transformer le json en dict
                                                                         NSError *jsonError = nil;
                                                                         NSDictionary *info = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                              options:0
                                                                                                                                error:&jsonError];
                                                                         
                                                                         if (jsonError) {
                                                                             completionHandler(nil, jsonError);
                                                                         } else {
                                                                             completionHandler(info, nil);
                                                                         }
                                                                         
                                                                     } else {
                                                                         // pas d'erreurs et pas de données
                                                                         completionHandler(nil, nil);
                                                                     }
                                                                 }];
    
    
    [task resume];
    
}

#pragma mark Unauthenticated actions
+ (void)followersForHandle:(NSString*)handle withCompletionHandler:(FBSessionCompletionHandlerWithArray)completionHandler {
    NSString *username = [FBSession usernameForHandle:handle];
    NSString *servername = [FBSession serverNameForHandle:handle];
    
    NSURLRequest *request = [FBSession getRequestForServer:servername andPath:[NSString stringWithFormat:@"%@/followers.json", username]];
    
    [FBSession startJSONTaskWithRequest:request
                   andCompletionHandler:^(NSDictionary *result, NSError *error) {
                       if (error) {
                           completionHandler(nil, error);
                       } else {
                           NSArray *followers = [result valueForKey:@"followers"];
                           
                           completionHandler(followers, nil);
                       }
                   }];
}

+ (void)followingsForHandle:(NSString*)handle withCompletionHandler:(FBSessionCompletionHandlerWithArray)completionHandler {
    NSString *username = [FBSession usernameForHandle:handle];
    NSString *servername = [FBSession serverNameForHandle:handle];
    
    NSURLRequest *request = [FBSession getRequestForServer:servername andPath:[NSString stringWithFormat:@"%@/followings.json", username]];
    
    [FBSession startJSONTaskWithRequest:request
                   andCompletionHandler:^(NSDictionary *result, NSError *error) {
                       if (error) {
                           completionHandler(nil, error);
                       } else {
                           NSArray *followings = [result valueForKey:@"followings"];
                           
                           completionHandler(followings, nil);
                       }
                   }];
}


+ (void)publicMessagesForHandle:(NSString*)handle withCompletionHandler:(FBSessionCompletionHandlerWithArray)completionHandler {
    NSString *username = [FBSession usernameForHandle:handle];
    NSString *servername = [FBSession serverNameForHandle:handle];
    
    NSURLRequest *request = [FBSession getRequestForServer:servername andPath:[NSString stringWithFormat:@"%@/tweets.json", username]];
    
    [FBSession startJSONTaskWithRequest:request
                   andCompletionHandler:^(NSDictionary *result, NSError *error) {
                       if (error) {
                           completionHandler(nil, error);
                       } else {
                           NSArray *tweets = [result valueForKey:@"tweets"];
                           
                           completionHandler(tweets, nil);
                       }
                   }];
}


+ (void)usernamesFromServer:(NSString*)servername withCompletionHandler:(FBSessionCompletionHandlerWithArray)completionHandler {
    NSURLRequest *request = [FBSession getRequestForServer:servername andPath:@"users.json"];
    
    [FBSession startJSONTaskWithRequest:request
                   andCompletionHandler:^(NSDictionary *result, NSError *error) {
                       if (error) {
                           completionHandler(nil, error);
                       } else {
                           NSArray *users = [result valueForKey:@"users"];
                           
                           completionHandler(users, nil);
                       }
                   }];
}

+ (void)allPublicMessagesFromServer:(NSString*)servername withCompletionHandler:(FBSessionCompletionHandlerWithArray)completionHandler {
    NSURLRequest *request = [FBSession getRequestForServer:servername andPath:@"tweets.json"];
    
    [FBSession startJSONTaskWithRequest:request
                   andCompletionHandler:^(NSDictionary *result, NSError *error) {
                       if (error) {
                           completionHandler(nil, error);
                       } else {
                           NSArray *tweets = [result valueForKey:@"tweets"];
                           
                           completionHandler(tweets, nil);
                       }
                   }];
}


+ (void)createAccountWithHandle:(NSString*)handle andPassword:(NSString*)password withCompletionHandler:(FBSessionCompletionHandlerWithDictionary)completionHandler {
    NSString *servername = [FBSession serverNameForHandle:handle];
    NSString *username = [FBSession usernameForHandle:handle];
    
    NSURLRequest *request = [FBSession postRequestForServer:servername
                                                withContent:@{@"handle": username, @"password": password}
                                                    andPath:@"users.json"];
    
    [FBSession startJSONTaskWithRequest:request
                   andCompletionHandler:completionHandler];
}


#pragma mark User session related

+ (instancetype)prepareSessionForHandle:(NSString*)handle {
    FBSession *session = [[FBSession alloc] init];
    
    session.username = [FBSession usernameForHandle:handle];
    session.servername = [FBSession serverNameForHandle:handle];
    
    
    
    //    juste, mais pas adapté à un niveau scolaire (self pour les classes)
    //    session.username = [self usernameForHandle:handle];
    //    session.servername = [self serverNameForHandle:handle];
    
    return session;
}

- (instancetype)initForHandle:(NSString*)handle
{
    self = [super init];
    if (self) {
        //self.username = [FBSession usernameForHandle:handle];
        // Pas recommandé dans un init (== appel de setter avec notification des observer etc.)
        
        // _var == assignation de valeur en mémoire à l'ivar réelle
        _username = [FBSession usernameForHandle:handle];
        _servername = [FBSession serverNameForHandle:handle];
    }
    return self;
}

+ (instancetype)sessionForHandle:(NSString*)handle withToken:(NSString*)token {
    FBSession *session = [[FBSession alloc] init];
    
    session.username = [FBSession usernameForHandle:handle];
    session.servername = [FBSession serverNameForHandle:handle];
    session.token = token;
    session.authenticated = YES;
    
    return session;
}


- (void)authenticateWithPassword:(NSString*)password withCompletionHandler:(FBSessionCompletionHandler)completionHandler {
    
    NSURLRequest *request = [FBSession postRequestForServer:self.servername
                                                withContent:@{@"handle": self.username, @"password": password}
                                                    andPath:@"sessions.json"];
    
    [FBSession startJSONTaskWithRequest:request
                   andCompletionHandler:^(NSDictionary *result, NSError *error) {
                       
                       if (error) {
                           completionHandler(error);
                       } else {
                           self.token = [result valueForKey:@"token"];
                           
                           if ([self.token length] > 0) {
                               self.authenticated = YES;
                               
                               completionHandler(nil);
                           } else {
                               completionHandler([[NSError alloc] initWithDomain:@"no token and no error"
                                                                            code:0
                                                                        userInfo:nil]);
                           }
                       }
                       
                       
                   }];
}


- (void)follow:(NSString*)username withCompletionHandler:(FBSessionCompletionHandlerWithDictionary)completionHandler {
    if ([self.token length] > 0) {
        NSURLRequest *request = [FBSession postRequestForServer:self.servername
                                                    withContent:@{@"handle": username, @"token": self.token}
                                                        andPath:[NSString stringWithFormat:@"%@/followings.json", self.username]];
        
        [FBSession startJSONTaskWithRequest:request
                       andCompletionHandler:completionHandler];
    } else {
        completionHandler(nil, [[NSError alloc] initWithDomain:@"no token, no post"
                                                     code:0
                                                 userInfo:nil]);
    }
}

- (void)unfollow:(NSString*)username withCompletionHandler:(FBSessionCompletionHandler)completionHandler {
    if ([self.token length] > 0) {
        NSURLRequest *request = [FBSession deleteRequestForServer:self.servername
                                                      withContent:@{@"handle": username, @"token": self.token}
                                                          andPath:[NSString stringWithFormat:@"%@/followings.json", self.username]];
        
        [FBSession startJSONTaskWithRequest:request
                       andCompletionHandler:^(NSDictionary *result, NSError *error) {
                           completionHandler(error);
                       }];
    } else {
        completionHandler([[NSError alloc] initWithDomain:@"no token, no post"
                                                     code:0
                                                 userInfo:nil]);
    }
}


- (void)postPublicMessage:(NSString*)message withCompletionHandler:(FBSessionCompletionHandler)completionHandler {
    
    if ([self.token length] > 0) {
        NSURLRequest *request = [FBSession postRequestForServer:self.servername
                                                    withContent:@{@"content": message, @"token": self.token}
                                                        andPath:[NSString stringWithFormat:@"%@/tweets.json", self.username]];
        
        [FBSession startJSONTaskWithRequest:request
                       andCompletionHandler:^(NSDictionary *result, NSError *error) {
                           completionHandler(error);
                       }];
    } else {
        completionHandler([[NSError alloc] initWithDomain:@"no token, no post"
                                                     code:0
                                                 userInfo:nil]);
    }
    
    

}


- (void)readingListWithCompletionHandler:(FBSessionCompletionHandlerWithArray)completionHandler {
    if ([self.token length] > 0) {
        NSURLRequest *request = [FBSession getRequestForServer:self.servername
                                                     withToken:self.token
                                                       andPath:[NSString stringWithFormat:@"%@/reading_list.json", self.username]];
        
        [FBSession startJSONTaskWithRequest:request
                       andCompletionHandler:^(NSDictionary *result, NSError *error) {
                           NSArray *tweets = [result valueForKey:@"tweets"];
                           
                           completionHandler(tweets, nil);
                       }];
    } else {
        completionHandler(nil, [[NSError alloc] initWithDomain:@"no token, no post"
                                                          code:0
                                                      userInfo:nil]);
    }
}



@end

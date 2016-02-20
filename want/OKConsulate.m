//
//  OKConsulate.m
//  want
//
//  Created by Omer Karisman on 20/02/16.
//  Copyright © 2016 Omer Karisman. All rights reserved.
//

#import "OKConsulate.h"
#import "AFNetworking.h"
#import "OKConstants.h"
#import "OKUser.h"
#import "UICKeyChainStore.h"

@implementation OKConsulate

+ (BOOL) loginUserWithUsername: (NSString *) username andPassword: (NSString *) password withCompletionBlock: (void (^)(BOOL succeeded, NSError *error))completionBlock
{
    
    NSURL *URL = [NSURL URLWithString:@"/login"];
        
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseAPIUrl]];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSDictionary *params = @ {@"username":username, @"password":password};

    [manager POST:URL.absoluteString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        OKUser *currentUser = [OKUser currentUser];
        currentUser.userSessionToken = responseObject[@"access_token"];
        
        UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithServer:[NSURL URLWithString:kBaseAPIUrl] protocolType:UICKeyChainStoreProtocolTypeHTTPS];
        
        [keychain setString:currentUser.userSessionToken
                     forKey:@"sessionToken"
                      label:@"Session Token)"
                    comment:@"It's not just a session token. It is a token of love."];
        
        completionBlock(YES,nil);

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
    return YES;
}

@end

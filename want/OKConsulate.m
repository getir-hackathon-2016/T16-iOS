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

@implementation OKConsulate

+ (BOOL) loginUserWithUsername: (NSString *) username andPassword: (NSString *) password withCompletionBlock: (void (^)(BOOL succeeded, NSError *error))completionBlock
{
    
    NSURL *URL = [NSURL URLWithString:@"/user/login"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseAPIUrl]];
    
    [manager.requestSerializer setValue:@"vZu-YUFWLzIdFIn7VDoA6hV9IhrYe-BimkC1ncRdojU" forHTTPHeaderField:@"X-CSRF-Token"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary *params = @ {@"username":username, @"password":password};

    [manager POST:URL.absoluteString parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    completionBlock(YES,nil);
    
    return YES;
}

@end

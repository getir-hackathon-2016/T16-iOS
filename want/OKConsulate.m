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
#import "OKProductCategory.h"

@implementation OKConsulate

+ (BOOL) loginUserWithUsername: (NSString *) username andPassword: (NSString *) password withCompletionBlock: (void (^)(BOOL succeeded, NSError *error))completionBlock
{
    
    NSURL *URL = [NSURL URLWithString:@"/login"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseAPIUrl]];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSLog(@"u:%@,p%@",username,password);
    
    NSDictionary *params = @ {@"username":username, @"password":password};

    [manager POST:URL.absoluteString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (!responseObject[@"error"]) {
            
            OKUser *currentUser = [OKUser currentUser];
            currentUser.userSessionToken = responseObject[@"token"];
            
            UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithServer:[NSURL URLWithString:kBaseAPIUrl] protocolType:UICKeyChainStoreProtocolTypeHTTPS];
            
            [keychain setString:currentUser.userSessionToken
                         forKey:@"sessionToken"
                          label:@"Session Token)"
                        comment:@"It's not just a session token. It is a token of affection."];
            
            completionBlock(YES,nil);

        }else{
            NSInteger errorCode = [responseObject[@"code"] integerValue];
            completionBlock(NO,[NSError errorWithDomain:@"" code:errorCode userInfo:nil]);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionBlock(NO,error);

    }];   
    
       return YES;
}

+ (NSArray *) fetchProductCategoriesWithCompletionBlock: (void (^)(BOOL succeeded, NSError *error, NSArray *result))completionBlock
{
    NSURL *URL = [NSURL URLWithString:@"/getir-hackathon/Category"];
    
    __block NSArray *results = nil;
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseAPIUrl]];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    OKUser *currentUser = [OKUser currentUser];
    
    NSDictionary *params = @ {@"token":currentUser.userSessionToken};
    
    [manager GET:URL.absoluteString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        
            if (![responseObject isKindOfClass:[NSDictionary class]]) {

                NSArray *resultArray = responseObject;
                
                NSMutableArray *enumeratedObjects = [[NSMutableArray alloc] init];
                
                [resultArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *catObj = obj;
                    OKProductCategory *category = [[OKProductCategory alloc] init];
                    NSLog(@"ID:%@",catObj[@"_id"]);
                    category.categoryId = [catObj[@"_id"] intValue];
                    category.categoryName = catObj[@"name"];
                    category.categoryImageURL = catObj[@"categoryImageName"];
                    [enumeratedObjects addObject:category];
                }];
                
                results = [NSArray arrayWithArray:enumeratedObjects];
                
                completionBlock(YES,nil, results);
                
            }else{
                NSInteger errorCode = [responseObject[@"code"] integerValue];
                completionBlock(NO,[NSError errorWithDomain:@"" code:errorCode userInfo:nil],nil);
            }

            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            completionBlock(NO,error,nil);

        }];
    
    return results;
    
}

@end

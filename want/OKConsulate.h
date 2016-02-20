//
//  OKConsulate.h
//  want
//
//  Created by Omer Karisman on 20/02/16.
//  Copyright © 2016 Omer Karisman. All rights reserved.
//

//  OKConsulate is developed to do all the talking with
//  backend. It contains methods that might be used over
//  and over again.

#import <UIKit/UIKit.h>

@interface OKConsulate : UIViewController

+ (BOOL) loginUserWithUsername: (NSString *) username andPassword: (NSString *) password withCompletionBlock: (void (^)(BOOL succeeded, NSError *error))completionBlock;

+ (BOOL) logoutWithCompletionBlock: (void (^)(BOOL succeeded, NSError *error))completionBlock;

+ (NSDictionary *) fetchProductCategoriesWithCompletionBlock: (void (^)(BOOL succeeded, NSError *error, NSArray *result))completionBlock;

+ (NSArray *) fetchAllProductsAndSkip: (int)skip withCompletionBlock: (void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (NSArray *) fetchProductsWithCategory:(int)categoryId withCompletionBlock: (int)skip withCompletionBlock: (void (^)(BOOL succeeded, NSError *error))completionBlock;

+ (BOOL) addProductToCart:(int)productId withCompletionBlock: (void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (BOOL) incrementProductInCart:(int)productId withCompletionBlock: (void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (BOOL) decrementProductInCart:(int)productId withCompletionBlock: (void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (BOOL) removeProductFromCart:(int)productId withCompletionBlock: (void (^)(BOOL succeeded, NSError *error))completionBlock;

+ (BOOL) addAddress:(NSString *)addressName andAddressStreetAddress:(NSString *) addressStreetAddress andAddressDescription:(NSString *) addressDescription andAddressLocation:(NSString *) addressLocation withCompletionBlock: (void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (BOOL) updateAddress:(int)addressId andAddressName:(NSString *)addressName andAddressStreetAddress:(NSString *) addressStreetAddress andAddressDescription:(NSString *) addressDescription andAddressLocation:(NSString *) addressLocation withCompletionBlock: (void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (BOOL) removeAddress:(int)addressId withCompletionBlock: (void (^)(BOOL succeeded, NSError *error))completionBlock;

+ (BOOL) addCard:(NSString *)cardName andCardOwnerName:(NSString *) ownerName andCardNumber:(NSString *)cardNumber andCardExpirationDate:(NSString *)cardExpirationDate andCVC2:(NSString *)cardCVC2 withCompletionBlock: (void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (BOOL) updateCard:(int) cardId andCardName:(NSString *)cardName andCardOwnerName:(NSString *) ownerName andCardNumber:(NSString *)cardNumber andCardExpirationDate:(NSString *)cardExpirationDate andCVC2:(NSString *)cardCVC2 withCompletionBlock: (void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (BOOL) removeCard:(int)cardId withCompletionBlock: (void (^)(BOOL succeeded, NSError *error))completionBlock;

+ (BOOL) cancelOrder:(int)cartId withCompletionBlock: (void (^)(BOOL succeeded, NSError *error))completionBlock;


@end

//
//  GTTCardController.m
//  DeckOfOneCardObjectiveC
//
//  Created by Chris Gottfredson on 3/24/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

#import "GTTCardController.h"

static NSString * const baseURLString = @"https://deckofcardsapi.com/api/deck/new/draw/";

@implementation GTTCardController

+ (GTTCardController *)shared
{
    static GTTCardController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [GTTCardController new];
    });
    return shared;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cards = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)drawANewCard:(NSInteger)numOfCards completion:(void (^)(NSArray<GTTCard *> * _Nullable, NSError * _Nullable))completion
{
    NSString *cardCount = [@(numOfCards) stringValue];
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *numberOfCards = [NSURLQueryItem queryItemWithName:@"count" value:cardCount];
    urlComponents.queryItems = @[numberOfCards];
    
    NSURL *finalURL = urlComponents.URL;
    NSLog(@"%@",finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"Error in fetching card: %@", error);
            completion(nil, error);
            return;
        }
        
        if (!data)
        {
            NSLog(@"Error in fetching card: %@", error);
            completion(nil, error);
            return;
        }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]])
        {
            NSLog(@"Error in fetching dictionary: %@", error);
            completion(nil, error);
            return;
        }
        
        NSArray *cardsArray = jsonDictionary[@"cards"];
        NSMutableArray *cardsPlaceholder = [NSMutableArray array];
        
        for (NSDictionary *cardsDictionary in cardsArray)
        {
            GTTCard *card = [[GTTCard alloc] initWithDictionary:cardsDictionary];
            [cardsPlaceholder addObject:card];
        }
        
        completion(cardsPlaceholder, nil);
        
    }] resume];
}

-(void)getCardImage:(GTTCard *)card completion:(void (^)(UIImage * _Nullable, NSError * _Nullable))completion
{
    NSURL *imageURL = [NSURL URLWithString:card.imageString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"There was an error fetching the image: %@", error);
            completion(nil, error);
            return;
        }
        
        if (!data)
        {
            NSLog(@"There was an error fetching the image: %@", error);
            completion(nil, error);
            return;
        }
        
        UIImage *cardImage = [UIImage imageWithData:data];
        completion(cardImage, nil);
        
    }] resume];
}

@end

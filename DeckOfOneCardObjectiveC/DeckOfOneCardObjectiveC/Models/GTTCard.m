//
//  GTTCard.m
//  DeckOfOneCardObjectiveC
//
//  Created by Chris Gottfredson on 3/24/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

#import "GTTCard.h"

static NSString * const SuiteKey = @"suit";
static NSString * const ValueKey = @"value";
static NSString * const Imagekey = @"image";

@implementation GTTCard

- (instancetype)initWithSuit:(NSString *)suit value: (NSString *)value imageString:(NSString *)imageString
{
    self = [super init];
    if (self)
    {
        _suit = suit;
        _value = value;
        _imageString = imageString;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *suit = dictionary[@"suit"];
    NSString *value = dictionary[@"value"];
    NSString *imageName = dictionary[@"image"];
    
    return [self initWithSuit:suit value: value imageString:imageName];
}

@end

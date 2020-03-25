//
//  GTTCard.h
//  DeckOfOneCardObjectiveC
//
//  Created by Chris Gottfredson on 3/24/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTTCard : NSObject

@property (nonatomic) NSString *suit;
@property (nonatomic) NSString *value;
@property (nonatomic) NSString *imageString;

- (instancetype) initWithSuit: (NSString *)suit value: (NSString *)value imageString: (NSString *)imageString;

@end

@interface GTTCard (JSONConvertable)

- (instancetype) initWithDictionary: (NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END

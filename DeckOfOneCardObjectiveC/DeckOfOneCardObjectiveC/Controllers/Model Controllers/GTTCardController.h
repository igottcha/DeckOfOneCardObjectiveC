//
//  GTTCardController.h
//  DeckOfOneCardObjectiveC
//
//  Created by Chris Gottfredson on 3/24/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTTCard.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTTCardController : NSObject

+ (GTTCardController *) shared;
@property (nonatomic) NSArray<GTTCard *> *cards;

- (void) drawANewCard: (NSInteger)numOfCards completion: (void(^) (NSArray<GTTCard *> *cards, NSError *error))completion;
- (void) getCardImage: (GTTCard *)card completion: (void(^) (UIImage *image, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END

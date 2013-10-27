//
//  GeneratedPubsList.h
//  PubCrawler
//
//  Created by Stoica Alexandru on 10/27/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeneratedPubsList : NSObject

+(GeneratedPubsList*)getInstance;
@property (strong,nonatomic) NSArray * generatedPubsList ;

- (void) parseGeneratedPubListWithCompletion:(void (^)(BOOL success)) completionBlock;

@end

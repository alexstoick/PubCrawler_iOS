//
//  PubListDataSource.h
//  PubCrawler
//
//  Created by Stoica Alexandru on 10/26/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PubListDataSource : NSObject

+(PubListDataSource*)getInstance;
@property (strong,nonatomic) NSArray * pubList ;

- (void) parsePubListWithCompletion:(void (^)(BOOL success)) completionBlock;

@end

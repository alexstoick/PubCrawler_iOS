//
//  GeneratedPubsList.m
//  PubCrawler
//
//  Created by Stoica Alexandru on 10/27/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import "GeneratedPubsList.h"
#import "AFNetworking.h"
#import "Pub.h"

static GeneratedPubsList * _generatedPubList ;

@interface GeneratedPubsList()

@property (strong,nonatomic) AFHTTPRequestOperationManager* manager ;

@end

@implementation GeneratedPubsList

+(GeneratedPubsList *) getInstance {
    if ( ! _generatedPubList  )
    {
        _generatedPubList = [[GeneratedPubsList alloc] init];
    }
    return _generatedPubList ;
}

-(AFHTTPRequestOperationManager *) manager {
    if ( ! _manager  )
    {
        _manager = [AFHTTPRequestOperationManager manager];
    }
    return _manager ;
}

-(void) parseGeneratedPubListWithCompletion:(void (^)(BOOL))completionBlock
{
    
    [self.manager GET:@"http://pubcrawl.uclr.org/map/generate" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray * jsonArray = [NSMutableArray arrayWithArray:responseObject];
        
        NSMutableArray * pubArray = [[NSMutableArray alloc] init] ;
        
        for ( NSArray * pub in jsonArray )
        {
            Pub * pubFromJson = [[Pub alloc]init] ;
            pubFromJson.name = pub[0] ;
            pubFromJson.latitude = pub[1] ;
            pubFromJson.longitude = pub[2] ;
            [pubArray addObject:pubFromJson];
        }
        
        self.generatedPubsList = pubArray ;
        
        completionBlock(YES);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        completionBlock(NO);
    }];
    
}

@end

//
//  PubListDataSource.m
//  PubCrawler
//
//  Created by Stoica Alexandru on 10/26/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import "PubListDataSource.h"
#import "AFNetworking.h"
#import "Pub.h"

static PubListDataSource * _pubListDataSource ;

@interface PubListDataSource()

@property (strong,nonatomic) AFHTTPRequestOperationManager* manager ;

@end

@implementation PubListDataSource

+(PubListDataSource *) getInstance {
    if ( ! _pubListDataSource  )
    {
        _pubListDataSource = [[PubListDataSource alloc] init];
    }
    return _pubListDataSource ;
}

-(AFHTTPRequestOperationManager *) manager {
    if ( ! _manager  )
    {
        _manager = [AFHTTPRequestOperationManager manager];
    }
    return _manager ;
}

-(void) parsePubListWithCompletion:(void (^)(BOOL))completionBlock
{
    
    [self.manager GET:@"http://pubcrawl.uclr.org/services/pub" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *jsonArray = [NSMutableArray arrayWithArray:responseObject];
        
        NSMutableArray *pubArray = [[NSMutableArray alloc] init] ;
        
        for ( NSDictionary * pub in jsonArray )
        {
            
            Pub * pubFromJson = [[Pub alloc]init] ;
            pubFromJson.name = [pub valueForKey:@"pub_name"] ;
            pubFromJson.latitude = [pub valueForKey:@"pub_location_latitude"] ;
            pubFromJson.longitude = [pub valueForKey:@"pub_location_longitude"] ;
            [pubArray addObject:pubFromJson];
        }
        
        self.pubList = pubArray ;
        
        completionBlock(YES);        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        completionBlock(NO);
    }];
    
}

@end

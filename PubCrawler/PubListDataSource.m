//
//  PubListDataSource.m
//  PubCrawler
//
//  Created by Stoica Alexandru on 10/26/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import "PubListDataSource.h"
#import "AFNetworking.h"

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
        _manager = [[AFHTTPRequestOperationManager alloc] init];
    }
    return _manager ;
}

-(void) parsePubListWithCompletion:(void (^)(BOOL))completionBlock
{
    
    [self.manager GET:@"http://pubcrawl.uclr.org/services/pub" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"JSON: %@", responseObject);
        
        NSMutableArray *jsonArray = [NSMutableArray arrayWithArray:responseObject];
        
        NSLog( @"%@" , jsonArray[1] ) ;
        NSLog( @"%@" , [jsonArray[1] valueForKey:@"pub_id"] ) ;
        
        completionBlock(YES);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        completionBlock(NO);
    }];
    
}

@end

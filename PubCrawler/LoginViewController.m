//
//  comFirstViewController.m
//  PubCrawler
//
//  Created by Stoica Alexandru on 10/26/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import "AFNetworking.h"
#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"uat") ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    
    NSLog(@"%@ , %@", _username.text , _password.text );
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://37.139.26.80/newssource/" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData: [responseObject dataUsingEncoding:NSUTF8StringEncoding]
                                                                           options: NSJSONReadingMutableContainers
                                                                             error: nil];
        
            NSDictionary * categories = [jsonDictionary valueForKey:@"categories"];
                                             
            NSLog ( @"Categories: @%" , categories ) ;
            NSLog ( @"uat" ) ;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}



@end

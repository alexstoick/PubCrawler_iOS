//
//  LoginViewController.m
//  PubCrawler
//
//  Created by Stoica Alexandru on 10/26/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import "AFNetworking.h"
#import "LoginViewController.h"
#import "PubListDataSource.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    
    //NSLog(@"%@ , %@", _username.text , _password.text );
    [[PubListDataSource getInstance] parsePubListWithCompletion:^(BOOL success) {
        if ( success)
        {
            [self performSegueWithIdentifier:@"changeToPubList" sender:self] ;
        }
        else
        {
            NSLog ( @"uat" ) ;
        }
    }] ;

    NSLog ( @"uat" ) ;
}

@end

//
//  MainViewController.m
//  PubCrawler
//
//  Created by Stoica Alexandru on 10/27/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import "MainViewController.h"
#import "AFNetworking.h"
#import "GeneratedPubsList.h"
#import "MapViewController.h"

@interface MainViewController ()

@property (strong,nonatomic) AFHTTPRequestOperationManager* manager ;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(AFHTTPRequestOperationManager *) manager {
    if ( ! _manager  )
    {
        _manager = [AFHTTPRequestOperationManager manager];
    }
    return _manager ;
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

-(IBAction)buttonPressed:(id)sender {
    
    GeneratedPubsList * pubList = [GeneratedPubsList getInstance ] ;
    [pubList parseGeneratedPubListWithCompletion:^(BOOL success) {
        
        [self performSegueWithIdentifier:@"mainToMap" sender:self] ;
        
    }];
}



@end

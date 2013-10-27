//
//  MapViewController.m
//  PubCrawler
//
//  Created by Stoica Alexandru on 10/26/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import "MapViewController.h"
#import "PubListDataSource.h"
#import "Pub.h"

@interface MapViewController ()

@end

@implementation MapViewController

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
    self.mapView.showsUserLocation = YES;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    MKCoordinateRegion mapRegion;
    mapRegion.center = mapView.userLocation.coordinate;
    mapRegion.span.latitudeDelta = 0.01;
    mapRegion.span.longitudeDelta = 0.01;
    [mapView setRegion:mapRegion animated: YES];
    
    [[PubListDataSource getInstance] parsePubListWithCompletion:^(BOOL success) {
        if ( success)
        {
            NSArray * pubList = [PubListDataSource getInstance].pubList ;
            for ( Pub * pub in pubList )
            {
                MKPointAnnotation *annot = [[MKPointAnnotation alloc] init];
                
                CLLocationCoordinate2D coordinate ;
                coordinate.latitude = [pub.latitude doubleValue] ;
                coordinate.longitude = [pub.longitude doubleValue] ;
                
                annot.coordinate = coordinate;
                [self.mapView addAnnotation:annot];
            }
            
            MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
            
            [request setSource: [MKMapItem mapItemForCurrentLocation]];
            
            CLLocationCoordinate2D coordinate ;
            Pub * pub = pubList[1];
            coordinate.latitude = [pub.latitude doubleValue] ;
            coordinate.longitude = [pub.longitude doubleValue] ;
            
            MKPlacemark * mapPlacemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary: nil] ;
            MKMapItem *mapItem_destination = [[MKMapItem alloc] initWithPlacemark: mapPlacemark] ;
            
            [request setDestination:mapItem_destination ];
            
            request.requestsAlternateRoutes = YES;
            MKDirections *directions =
            [[MKDirections alloc] initWithRequest:request];
            
            [directions calculateDirectionsWithCompletionHandler:
             ^(MKDirectionsResponse *response, NSError *error) {
                 if (error) {
                     // Handle Error
                     NSLog ( @"%@" , error ) ;
                 } else {
                     NSLog ( @"uat" ) ; 
                     [self showRoute:response];
                 }
             }];
            
            
        }
        else
        {
            NSLog ( @"uat" ) ;
        }
    }] ;
    
}

-(void)showRoute:(MKDirectionsResponse *)response
{
    MKRoute *route =  response.routes[0] ;

    for (MKRouteStep *step in route.steps)
    {
        NSLog(@"%@", step.instructions);
    }
    
    [ self.mapView
     addOverlay:route.polyline level:MKOverlayLevelAboveRoads];

}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    MKPolylineRenderer *renderer =
    [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor blueColor];
    renderer.lineWidth = 5.0;
    return renderer;
}

@end

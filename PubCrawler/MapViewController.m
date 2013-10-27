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
#import "GeneratedPubsList.h"

static MapViewController * _mapViewController ;
static Boolean * _setupMap = false ;

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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:false];
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
    if ( ! _setupMap )
    {
        MKCoordinateRegion mapRegion;
        mapRegion.center = mapView.userLocation.coordinate;
        mapRegion.span.latitudeDelta = 0.01;
        mapRegion.span.longitudeDelta = 0.01;
        [mapView setRegion:mapRegion animated: YES];
        [self createRouteFromGeneratedPubList];
        _setupMap = true ;
    }
}

-(void)createRouteFromGeneratedPubList {
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    [request setSource: [MKMapItem mapItemForCurrentLocation]];
   
    GeneratedPubsList * pubListInstance = [GeneratedPubsList getInstance ] ;
    NSArray * pubList = pubListInstance.generatedPubsList ;
    
    for ( Pub * pub in pubList )
    {
        MKPointAnnotation *annot = [[MKPointAnnotation alloc] init];
        
        CLLocationCoordinate2D coordinate ;
        coordinate.latitude = [pub.latitude doubleValue] ;
        coordinate.longitude = [pub.longitude doubleValue] ;
     
        annot.coordinate = coordinate;
        [self.mapView addAnnotation:annot];
        
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
                 NSLog ( @"Error calculating directions: %@" , error ) ;
             } else {
                 [self showRoute:response];
             }
         }];
        
        [request setSource: mapItem_destination];
    }
}

-(void)showRoute:(MKDirectionsResponse *)response
{
    MKRoute *route =  response.routes[0] ;
//
//    for (MKRouteStep *step in route.steps)
//    {
//        NSLog(@"%@", step.instructions);
//    }
    
    [ self.mapView
     addOverlay:route.polyline level:MKOverlayLevelAboveRoads];

}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    MKPolylineRenderer *renderer =
    [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    renderer.strokeColor = color;
    renderer.lineWidth = 5.0;
    return renderer;
}

@end

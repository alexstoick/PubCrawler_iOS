//
//  BasicSlider.m
//  PubCrawler
//
//  Created by Stoica Alexandru on 10/27/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import "BasicSlider.h"

@interface BasicSlider ()

@end

@implementation BasicSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(float)value {
    return super.value ;
}

- (void)viewDidLoad {
}

-(IBAction)valueChanged:(BasicSlider *)sender {
    // This determines which "step" the slider should be on. Here we're taking
    //   the current position of the slider and dividing by the `self.stepValue`
    //   to determine approximately which step we are on. Then we round to get to
    //   find which step we are closest to.

    // Convert "steps" back to the context of the sliders values.

    NSLog( @"%f" , sender.value ) ;
    sender.value = roundf ( sender.value ) ;
    
    _textField.text = [NSString stringWithFormat:@"%.0f" , sender.value ] ;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

//
//  SHSlidingNavVC.m
//  SlideNav
//
//  Created by subhajit halder on 29/02/16.
//  Copyright © 2016 regor. All rights reserved.
//

/*
 
 

 ####    #####   ####    ####      ###   #	 #  #####			####	#		#####	#### 	#####	####
 #   #     #     #   #   #   #    #   #  #	 #    #			   #	#	#		  #		#   #	#   	#   #
 #   #     #     #   #   #   #    #   #	 #	 #    #			   #		#		  #		#   #	#   	#   #
 ####      #     #   #   ####     #   #  #####    #				####	#		  #		#   #	####  	####
 #   #     #     #   #   #   #    #   #	 #	 #    #			   		#	#		  #		#   #	#   	#   #
 #   #     #     #   #   #    #   #   #	 #	 #    #			   #	#	#		  #		#   #	#   	#    #
 ####    #####   ####    #     #   ###	 #	 #  #####			####	#####	#####	#### 	#####	#     #




*/


#import "SHSlidingNavVC.h"
///////-------------------------------- Nav Drawer size
#define HALF 0.75                  /////// width
#define HEIGHT_PERCENT 0.0f   /////// height

//------------------------------------- gestures movement
#define TRANSLATION_PARENT 0.f        //  translation.x / TRANSLATION_PARENT
#define VELOCITY_MAX 1000.f            //  max speed after which animations will be done

//------------------------------------- BackGround View Alpha values
#define ALPHA_INCREMENT 0.002f          // increment speed in relation to translation ..... for good visualiztion keep value < .009f
#define ALPHA_MAX .45f                   // max alpha of the background

//------------------------------------- Animation Durations Self Explaining Charecteristics
#define DURATION_MAX 0.5f
#define DURATION_MIN 0.1f
#define DURATION_EQUAL 0.35f

//------------------------------------- Shadow controls of NAV Drawer
#define SHADOW_WIDTH -6.f
#define SHADOW_HEIGHT 12.f
#define SHADOW_RADUIS 6.f
#define SHADOW_OPACITY_MAX 0.8f
#define SHADOW_OPACITY_MIN 0.f

#define ORIGIN_Y 0.f

@interface SHSlidingNavVC ()<UIGestureRecognizerDelegate>

@end

@implementation SHSlidingNavVC
{
    BOOL isOpen;
    UIView *backGroundDarkView;
    CGFloat velocityCurrent;
    
    UIScreenEdgePanGestureRecognizer *leftEdgePan;
    UIPanGestureRecognizer *panGesture;
    UITapGestureRecognizer *tapGesture;
}
//@synthesize _parentVC;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// -----------------------------------------------------------------------------------sets parent of this Nav

- (id)init {
    self = [super init];
    return self;
}

-(void)setParent:(UIViewController *)parent onCompletion:(CompletionHandler)handler
{
    completionHandler = handler;
    _parentVC = parent;
    backGroundDarkView = [[UIView alloc]initWithFrame:CGRectMake(0, ORIGIN_Y, _parentVC.view.frame.size.width, _parentVC.view.frame.size.height - ORIGIN_Y)];
    backGroundDarkView.backgroundColor = [UIColor blackColor];
    backGroundDarkView.alpha = 0.f;
    [_parentVC.view addSubview:backGroundDarkView];
    [self setFrame];
    [self setGesturesOnParent];
    [self.view setHidden:YES];
}




//-------------------------- set Frames of Nav Drawer

-(void)setFrame
{
    self.width = (_parentVC.view.frame.size.width * 151) / 207;
    self.height = _parentVC.view.frame.size.height; //- (_parentVC.view.frame.size.height * HEIGHT_PERCENT);
    [self.view setFrame:CGRectMake(-self.width, ORIGIN_Y , self.width, self.height)];
    self.view.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.view.layer.shadowOpacity = SHADOW_OPACITY_MIN;
    self.view.layer.shadowOffset = CGSizeMake(SHADOW_WIDTH, SHADOW_HEIGHT);
    self.view.layer.shadowRadius = SHADOW_RADUIS;
    [_parentVC.view addSubview:self.view];
    [_parentVC.view bringSubviewToFront:self.view];
    
    [self.view layoutIfNeeded];
    
}



//---------------------------- sets gesture for its parent VC

-(void)setGesturesOnParent
{
    
    leftEdgePan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(handleScreenEdgePanGesture:)];
    leftEdgePan.edges = UIRectEdgeLeft;
    leftEdgePan.delegate = self;
    [_parentVC.view addGestureRecognizer:leftEdgePan];
    
    panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    panGesture.delegate = self;
    [backGroundDarkView addGestureRecognizer:panGesture];
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGesture.delegate = self;
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    [backGroundDarkView addGestureRecognizer:tapGesture];
    
}


//---------------------------------------------------- screen edge pan gesture handler for opening slide
-(void)handleScreenEdgePanGesture:(UIScreenEdgePanGestureRecognizer *)gesture
{
    CGPoint translation = [gesture translationInView:gesture.view];
    
    CGFloat width = self.view.frame.size.width;
    CGFloat percent = MAX(translation.x, 0) / width;
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{
            if (isOpen) {
                return;
            }
        }
            self.view.layer.shadowOpacity = SHADOW_OPACITY_MAX;
            break;
            
        case UIGestureRecognizerStateChanged:
            if (isOpen) {
                return;
            }
            //NSLog(@"kelo : %f", translation.x);
            if (self.view.frame.origin.x < 0 /*/ TRANSLATION_PARENT*/ ) {
//                _parentVC.view.frame = CGRectMake(translation.x / TRANSLATION_PARENT,  0 , _parentVC.view.frame.size.width, _parentVC.view.frame.size.height);
                self.view.frame = CGRectMake(-self.view.frame.size.width + translation.x , ORIGIN_Y, self.view.frame.size.width, self.view.frame.size.height);
                backGroundDarkView.alpha = 0 + (ALPHA_INCREMENT * translation.x);
                
            }
            
            [self.view setUserInteractionEnabled:NO];
            [_parentVC.view setUserInteractionEnabled:NO];
            
            break;
            
        case UIGestureRecognizerStateEnded:
            if (isOpen) {
                return;
            }
            [self animateParentToCenter];
            velocityCurrent = fabs([gesture velocityInView:self.view].x);
            if (percent > 0.5 || fabs([gesture velocityInView:self.view].x) > VELOCITY_MAX) {
                [self slideIn];
            }
            else
            {
                [self slideOut];
            }
            
            [self.view setUserInteractionEnabled:YES];
            [_parentVC.view setUserInteractionEnabled:YES];
            
            break;
            
        default:
            break;
    }
    
}


//---------------------------------------------------- pan gesture handler for closing slide

-(void)handlePan:(UIPanGestureRecognizer *)gesture
{
    CGPoint translation = [gesture translationInView:gesture.view];
    
    CGFloat width = self.view.frame.size.width;
    CGFloat percent = 0.0;
    if (translation.x < 0) {
        percent = MAX(fabs(translation.x), 0) / width;
    }
    
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{
            if (!isOpen) {
                return;
            }
        }
            break;
            
        case UIGestureRecognizerStateChanged:
            if (!isOpen || translation.x > 0) {
                return;
            }
            //NSLog(@"kelo : %f", translation.x);
//            if (translation.x <= self.width ) {
//                _parentVC.view.frame = CGRectMake(translation.x / TRANSLATION_PARENT,  0 , _parentVC.view.frame.size.width, _parentVC.view.frame.size.height);
                self.view.frame = CGRectMake(0 + translation.x, ORIGIN_Y, self.view.frame.size.width, self.view.frame.size.height);
                backGroundDarkView.alpha = ALPHA_MAX + (ALPHA_INCREMENT * translation.x);
//            }
            
            [self.view setUserInteractionEnabled:NO];
            [_parentVC.view setUserInteractionEnabled:NO];
            
            break;
            
        case UIGestureRecognizerStateEnded:
            if (!isOpen) {
                return;
            }
            [self animateParentToCenter];
            velocityCurrent = fabs([gesture velocityInView:self.view].x);
            // NSLog(@"percent: %f  velocity: %f",percent, [gesture velocityInView:self.view].x);
            if (percent > 0.5 || [gesture velocityInView:self.view].x < -VELOCITY_MAX ) {
                [self slideOut];
               
            }
            else
            {
                [self slideIn];
//                self.view.layer.shadowOpacity = 0.0f;
            }
            
            [self.view setUserInteractionEnabled:YES];
            [_parentVC.view setUserInteractionEnabled:YES];
            
            break;
            
        default:
            break;
    }

}

-(void)handleTap:(UITapGestureRecognizer *)gesture {
    if (isOpen) {
        [self slideOut];
    }
}

// Sliding in Animation

-(void)slideIn
{
    [self.view setHidden:NO];
    CGFloat animationDuration = velocityCurrent ? (0.5 / velocityCurrent) * 100: DURATION_EQUAL;
    if(animationDuration > DURATION_MAX)
    {
        animationDuration = DURATION_MAX;
    }
    else if (animationDuration < DURATION_MIN)
    {
        animationDuration = DURATION_MIN;
    }
    
        [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
            self.view.frame = CGRectMake(0, ORIGIN_Y, self.view.frame.size.width, self.view.frame.size.height);
            backGroundDarkView.alpha = ALPHA_MAX;
        }completion:^(BOOL finished){
            isOpen = YES;
            velocityCurrent = 0.f;
            
        }];
    
}

//----------------------- Sliding out Animation

-(void)slideOut
{
    CGFloat animationDuration = velocityCurrent ? (0.5 / velocityCurrent) * 100: DURATION_EQUAL;
    if(animationDuration > DURATION_MAX)
    {
        animationDuration = DURATION_MAX;
    }
    else if (animationDuration < DURATION_MIN)
    {
        animationDuration = DURATION_MIN;
    }
        [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.view.frame = CGRectMake(-self.view.frame.size.width, ORIGIN_Y, self.view.frame.size.width, self.view.frame.size.height);
            backGroundDarkView.alpha = 0.f;
        }completion:^(BOOL finished){
            isOpen = NO;
            completionHandler(nil);
             self.view.layer.shadowOpacity = SHADOW_OPACITY_MIN;
            velocityCurrent = 0.f;
            [self.view setHidden:YES];
        }];
    
}

//----------------------------- Animate the Parent Bounce
-(void)animateParentToCenter
{
    [UIView animateWithDuration:DURATION_EQUAL delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        _parentVC.view.frame = CGRectMake(0, _parentVC.view.frame.origin.y, _parentVC.view.frame.size.width, _parentVC.view.frame.size.height);
       // backGroundDarkView.alpha = 0.f;
    }completion:^(BOOL finished){
    
    }];

}
//---------------------------------toggle slide open close
-(void)toggleSlide
{
    if (!isOpen) {
        [self.view setHidden:NO];
        [self slideIn];
    }
    else
    {
        [self.view setHidden:YES];
        [self slideOut];
    }
}


#pragma mark - Gesture Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (gestureRecognizer == leftEdgePan && touch.view == _parentVC.view) {
        
        return YES;
        
    }
    else if (gestureRecognizer == panGesture && touch.view == backGroundDarkView) {
        
        return YES;
        
    }
    else if (gestureRecognizer == tapGesture && touch.view == backGroundDarkView) {
        
        return YES;
        
    }
    return NO;
}








@end

//
//  SHSlidingNavVC.h
//  SlideNav
//
//  Created by subhajit halder on 29/02/16.
//  Copyright © 2016 regor. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CompletionHandler) (NSIndexPath *indexPath);
@interface SHSlidingNavVC : UIViewController
{
    
    CompletionHandler completionHandler;
    @protected
    
    
}

@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;
@property (nonatomic) UIViewController *parentVC;

/*!
 * @discussion Use this method to set ur ViewController as this controllers parent
 * @param parent  Send self object from the view did load of your calling viewController
 * @param handler Invokes When slide closes
 */-(void)setParent:(UIViewController *)parent onCompletion:(CompletionHandler)handler;


/*!
 * @discussion Single method to solve all you problems. Call this in your Menu button action and your close button action both. If you have no close button then also it will close on tapping in its background or by sliding. Even it implements edgepan gesture in you parent's view, sliding from left to right opens the slider and viceversa.
 */
-(void)toggleSlide;

- (id)init;
@end

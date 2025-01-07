//
//  AddViewController.h
//  ToDoApp
//
//  Created by Andrew Emad on 30/12/2024.
//

#import <UIKit/UIKit.h>
#import "TaskDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddViewController : UIViewController
@property id<TaskDelegate> taskDelegate;
@end

NS_ASSUME_NONNULL_END

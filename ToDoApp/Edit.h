//
//  Edit.h
//  ToDoApp
//
//  Created by Andrew Emad on 30/12/2024.
//

#import <UIKit/UIKit.h>
#import "TaskDelegate.h"
#import "TaskDetails.h"
NS_ASSUME_NONNULL_BEGIN

@interface Edit : UIViewController
@property id<TaskDelegate> taskDelegate;
@property TaskDetails *task;
@property NSInteger index;
@end

NS_ASSUME_NONNULL_END

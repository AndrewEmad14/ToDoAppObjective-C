//
//  TaskDelegate.h
//  ToDoApp
//
//  Created by Andrew Emad on 30/12/2024.
//

#import <Foundation/Foundation.h>
#import "TaskDetails.h"
NS_ASSUME_NONNULL_BEGIN

@protocol TaskDelegate <NSObject>
-(void) addTask :(TaskDetails *) task;
-(void) editTaskWithIndex:(TaskDetails*) task Index:(NSInteger) number;
@end

NS_ASSUME_NONNULL_END

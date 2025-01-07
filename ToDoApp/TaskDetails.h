//
//  TaskDetails.h
//  ToDoApp
//
//  Created by Andrew Emad on 30/12/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskDetails : NSObject <NSCoding,NSSecureCoding>
@property NSString *name;
@property NSString *desc;
@property NSString *prio;
@property NSString *stateOfTask;
@property NSDate *date;
@end

NS_ASSUME_NONNULL_END

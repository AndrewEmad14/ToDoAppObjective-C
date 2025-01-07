//
//  TaskDetails.m
//  ToDoApp
//
//  Created by Andrew Emad on 30/12/2024.
//

#import "TaskDetails.h"

@implementation TaskDetails

- (void)encodeWithCoder:(nonnull NSCoder *)coder { 
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_desc forKey:@"desc"];
    [coder encodeObject:_prio forKey:@"prio"];
    [coder encodeObject:_stateOfTask forKey:@"state"];
    [coder encodeObject:_date forKey:@"date"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder { 
    self=[super init];
    if(self){
        self.name=[coder decodeObjectOfClass:[NSString class] forKey:@"name"];
        self.desc=[coder decodeObjectOfClass:[NSString class] forKey:@"desc"];
        self.prio=[coder decodeObjectOfClass:[NSString class] forKey:@"prio"];
        self.stateOfTask=[coder decodeObjectOfClass:[NSString class] forKey:@"state"];
        self.date=[coder decodeObjectOfClass:[NSDate class] forKey:@"date"];
    }
    return self;
}
+ (BOOL)supportsSecureCoding{
    return YES;
}

@end

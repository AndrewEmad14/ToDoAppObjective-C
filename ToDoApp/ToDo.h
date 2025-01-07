//
//  ToDo.h
//  ToDoApp
//
//  Created by Andrew Emad on 30/12/2024.
//

#import <UIKit/UIKit.h>
#import "ToDoTableViewCell.h"
#import "TaskDetails.h"
#import "TaskDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface ToDo : UIViewController <UITableViewDataSource,UITableViewDelegate,TaskDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table_view;
@property TaskDetails *task;

@end

NS_ASSUME_NONNULL_END

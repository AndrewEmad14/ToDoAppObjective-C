//
//  ToDoTableViewCell.h
//  ToDoApp
//
//  Created by Andrew Emad on 30/12/2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToDoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *myImage;

@property (weak, nonatomic) IBOutlet UILabel *task_title;

@end

NS_ASSUME_NONNULL_END

//
//  AddViewController.m
//  ToDoApp
//
//  Created by Andrew Emad on 30/12/2024.
//

#import "AddViewController.h"
#import "TaskDetails.h"
@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name_text_field;
@property (weak, nonatomic) IBOutlet UITextField *description_text_field;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segementController;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateFIeld;
@property TaskDetails *task;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _task=[TaskDetails new];
    
    _task.date=_dateFIeld.date;
    _task.stateOfTask=@"ToDo";
    _task.prio=@"low";
}
- (IBAction)confirmAdd:(id)sender {
    _task.name=_name_text_field.text;
    _task.desc=_description_text_field.text;
    [_taskDelegate addTask:_task];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)priorityPicker:(id)sender{
    switch(_segementController.selectedSegmentIndex){
        case 0:
            _task.prio=@"low";
            break;
        case 1:
            _task.prio=@"medium";
            break;
        default :
            _task.prio=@"high";
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

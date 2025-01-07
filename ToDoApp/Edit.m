//
//  Edit.m
//  ToDoApp
//
//  Created by Andrew Emad on 30/12/2024.
//

#import "Edit.h"

@interface Edit ()
@property (weak, nonatomic) IBOutlet UITextField *name_textField;
@property (weak, nonatomic) IBOutlet UITextField *description_textField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segement_priority;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segement_state;

@property (weak, nonatomic) IBOutlet UIDatePicker *date_picker;

@end

@implementation Edit

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _name_textField.text=_task.name;
    _description_textField.text=_task.desc;
    if([_task.prio isEqualToString:@"low"]){
        _segement_priority.selectedSegmentIndex=0;
        
    }else if([_task.prio isEqualToString:@"medium"]){
        _segement_priority.selectedSegmentIndex=1;

    }else{
        _segement_priority.selectedSegmentIndex=2;
    }
    if([_task.stateOfTask isEqualToString:@"ToDo"]){
        _segement_state.selectedSegmentIndex=0;
    }else if([_task.stateOfTask isEqualToString:@"Doing"]){
        _segement_state.selectedSegmentIndex=1;
    }else{
        _segement_state.selectedSegmentIndex=2;
    }
    _date_picker.date=_task.date;
}
- (IBAction)priorityChange:(id)sender {
    switch(_segement_priority.selectedSegmentIndex){
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
- (IBAction)stateChange:(id)sender {
    switch(_segement_state.selectedSegmentIndex){
        case 0:
            _task.stateOfTask=@"ToDo";
            break;
        case 1:
            _task.stateOfTask=@"Doing";
            break;
        default :
            _task.stateOfTask=@"Done";
            break;
    }
}

- (IBAction)conformEdit:(id)sender {
    UIAlertController *alreadyRegistered=[UIAlertController alertControllerWithTitle:@"" message:@"Are you sure you want to Edit" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *oK=[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        self->_task.name=self->_name_textField.text;
        self->_task.desc=self->_description_textField.text;
        self->_task.date=self->_date_picker.date;
        [self->_taskDelegate editTaskWithIndex:self->_task Index:self->_index];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alreadyRegistered addAction:oK];
    [alreadyRegistered addAction:cancel];
    [self presentViewController:alreadyRegistered animated:YES completion:nil];
    
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

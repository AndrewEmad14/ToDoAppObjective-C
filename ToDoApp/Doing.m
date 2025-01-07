//
//  Doing.m
//  ToDoApp
//
//  Created by Andrew Emad on 30/12/2024.
//

#import "Doing.h"

#import "Edit.h"
@interface Doing ()
@property (weak, nonatomic) IBOutlet UITableView *table_view;
@property NSUserDefaults *defaults;
@property NSMutableArray *taskReloadArrayDoing;
@property NSMutableArray *taskReloadArrayDone;
@end

@implementation Doing

- (void)viewDidLoad {
    [super viewDidLoad];
    _taskReloadArrayDoing=[NSMutableArray new];
    _taskReloadArrayDone=[NSMutableArray new];
    _defaults=[NSUserDefaults standardUserDefaults];
    _table_view.delegate=self;
    _table_view.dataSource=self;
    _task=[TaskDetails new];
    //_table_view.backgroundColor=[UIColor colorWithRed:62 green:123 blue:39 alpha:1];
    _taskReloadArrayDoing=[self reloadDataDefaultsWithType:@"doing"];
    
    
   
   
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    _taskReloadArrayDoing=[self reloadDataDefaultsWithType :@"Doing"];
    [_table_view reloadData];
    //self.tabBarController.navigationItem.rightBarButtonItem.hidden=true;
    //self.tabBarController.navigationItem.titleView.hidden=true;
}
-(NSMutableArray*) reloadDataDefaultsWithType :(NSString *) type{
        NSData *data=[_defaults objectForKey:type];
        NSMutableArray *temp = [NSKeyedUnarchiver unarchiveObjectWithData:data];
      
        return temp;
}

-(void) setDataWithType : (NSMutableArray*) temp Type: (NSString*) type{
    NSError *error;
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:temp requiringSecureCoding:YES error:&error];
    [_defaults setObject:data forKey:type];
}
//
-(void)addTask:(TaskDetails *)task{
  
    
    
}
-(void)editTaskWithIndex:(TaskDetails *)task Index:(NSInteger)index{

 //   temp=[self reloadDataDefaults];
   // _taskReloadArray=[self filteredDefault:temp];
      //  [_taskReloadArray replaceObjectAtIndex:index withObject:task];
    _taskReloadArrayDoing=[self reloadDataDefaultsWithType:@"Doing"];
    if(![task.stateOfTask isEqualToString:@"Doing"]){
        [_taskReloadArrayDoing removeObjectAtIndex:index];
        [self setDataWithType:_taskReloadArrayDoing Type:@"Doing"];
         if([task.stateOfTask isEqualToString:@"Done"]){
             _taskReloadArrayDone=[self reloadDataDefaultsWithType:task.stateOfTask];
             if(_taskReloadArrayDone.count==0)
                 _taskReloadArrayDone=[NSMutableArray new];
            [_taskReloadArrayDone addObject:task];
            [self setDataWithType:_taskReloadArrayDone Type:task.stateOfTask];
            
         }else{
             task.stateOfTask=@"Doing";
             [_taskReloadArrayDoing replaceObjectAtIndex:index withObject:task];
             [self setDataWithType:_taskReloadArrayDoing Type:@"Doing"];
         }
        
    }else{
        [_taskReloadArrayDoing replaceObjectAtIndex:index withObject:task];
        [self setDataWithType:_taskReloadArrayDoing Type:@"Doing"];
    }
   
    _taskReloadArrayDoing=[self reloadDataDefaultsWithType:@"Doing"];
        [_table_view reloadData];
    
}
    -(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
        return 1;
    }

    - (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        if(_taskReloadArrayDoing!=nil)
             return [_taskReloadArrayDoing count];
        return 0;
        
    }
 
    


    - (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath { 
        ToDoTableViewCell *cell=[self.table_view dequeueReusableCellWithIdentifier:@"cell1"];
      
        UIImage *img=[UIImage imageNamed:[_taskReloadArrayDoing[indexPath.row] prio]];
        [cell.myImage setImage:img];
        cell.task_title.text=[_taskReloadArrayDoing[indexPath.row] name];
        return cell;
    }
- (void)tableView:(UITableView *)tableView performPrimaryActionForRowAtIndexPath:(NSIndexPath *)indexPath{
    Edit *edit=[self.storyboard instantiateViewControllerWithIdentifier:@"4"];
  
    
    _taskReloadArrayDoing=[self reloadDataDefaultsWithType:@"Doing"];
    edit.task=[_taskReloadArrayDoing objectAtIndex:indexPath.row];
    edit.taskDelegate=self;
    edit.index=indexPath.row;
    [edit setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:edit animated:YES completion:nil];
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [_taskReloadArrayDoing removeObjectAtIndex:indexPath.row];
        [self setDataWithType:_taskReloadArrayDoing Type:@"Doing"];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:YES];
       
        [tableView reloadData];
    }
    
}

    @end

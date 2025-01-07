//
//  Done.m
//  ToDoApp
//
//  Created by Andrew Emad on 30/12/2024.
//

#import "Done.h"
#import "Edit.h"
@interface Done ()
@property (weak, nonatomic) IBOutlet UITableView *table_view;
@property NSUserDefaults *defaults;
@property NSMutableArray *taskReloadArray;

@end

@implementation Done


- (void)viewDidLoad {
    [super viewDidLoad];
    _taskReloadArray=[NSMutableArray new];
    _defaults=[NSUserDefaults standardUserDefaults];
    _table_view.delegate=self;
    _table_view.dataSource=self;
    _task=[TaskDetails new];
    //_table_view.backgroundColor=[UIColor colorWithRed:62 green:123 blue:39 alpha:1];
    _taskReloadArray=[self reloadDataDefaults];
   
   
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    _taskReloadArray=[self reloadDataDefaults];
    [_table_view reloadData];
   // self.tabBarController.navigationItem.rightBarButtonItem.hidden=true;
}
-(NSMutableArray*) reloadDataDefaults{
        NSData *data=[_defaults objectForKey:@"Done"];
        NSMutableArray *temp = [NSKeyedUnarchiver unarchiveObjectWithData:data];
      
        return temp;
}

-(void) setData : (NSMutableArray*) temp{
    NSError *error;
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:temp requiringSecureCoding:YES error:&error];
    [_defaults setObject:data forKey:@"Done"];
}
//
-(void)addTask:(TaskDetails *)task{
  
    
    
}
-(void)editTaskWithIndex:(TaskDetails *)task Index:(NSInteger)index{
    task.stateOfTask=@"Done";
    _taskReloadArray=[self reloadDataDefaults];
        [_taskReloadArray replaceObjectAtIndex:index withObject:task];
        [self setData:_taskReloadArray];
        _taskReloadArray=[self reloadDataDefaults];
        [_table_view reloadData];
    
}
    -(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
        return 1;
    }

    - (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        if(_taskReloadArray!=nil)
             return [_taskReloadArray count];
        return 0;
        
    }
 
    


    - (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
        ToDoTableViewCell *cell=[self.table_view dequeueReusableCellWithIdentifier:@"cell2"];
      
        UIImage *img=[UIImage imageNamed:[_taskReloadArray[indexPath.row] prio]];
        [cell.myImage setImage:img];
        cell.task_title.text=[_taskReloadArray[indexPath.row] name];
        return cell;
    }
- (void)tableView:(UITableView *)tableView performPrimaryActionForRowAtIndexPath:(NSIndexPath *)indexPath{
    Edit *edit=[self.storyboard instantiateViewControllerWithIdentifier:@"4"];
  
  
    _taskReloadArray=[self reloadDataDefaults];
    edit.task=[_taskReloadArray objectAtIndex:indexPath.row];
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
        [_taskReloadArray removeObjectAtIndex:indexPath.row];
        [self setData:_taskReloadArray ];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:YES];
       
        [tableView reloadData];
    }
    
}


@end

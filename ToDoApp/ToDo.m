//
//  ToDo.m
//  ToDoApp
//
//  Created by Andrew Emad on 30/12/2024.
//

#import "ToDo.h"
#import "AddViewController.h"
#import "Edit.h"
#import "Doing.h"
@interface ToDo ()
@property NSUserDefaults *defaults;
@property NSMutableArray *taskReloadArrayTodo;
@property NSMutableArray *taskReloadArrayDoing;
@property NSMutableArray *taskReloadArrayDone;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@end

@implementation ToDo

- (void)viewDidLoad {
    [super viewDidLoad];
    _taskReloadArrayTodo=[NSMutableArray new];
    _taskReloadArrayDoing=[NSMutableArray new];
    _taskReloadArrayDone=[NSMutableArray new];
    _defaults=[NSUserDefaults standardUserDefaults];
    self.table_view.delegate=self;
     self.table_view.dataSource=self;
    _task=[TaskDetails new];
    _table_view.backgroundColor=[UIColor colorWithRed:62 green:123 blue:39 alpha:1];
    UIBarButtonItem *addButton=[UIBarButtonItem new];
    addButton.title=@"+";
    addButton.target=self;
    addButton.style=UIBarButtonItemStylePlain;
    addButton.action=@selector(addTaskButton);
   
    self.tabBarController.navigationItem.rightBarButtonItem=addButton;
    _searchBar.delegate=self;
    
    
    self.tabBarController.navigationItem.titleView=_searchBar;

    
    _taskReloadArrayTodo=[self reloadDataDefaultsWithType:@"ToDo"];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSMutableArray *temp=[NSMutableArray new];
    _taskReloadArrayTodo=[self reloadDataDefaultsWithType:@"ToDo"];
    if(searchText.length!=0){
        for(int i=0;i<_taskReloadArrayTodo.count;i++){
           
            if([searchText isEqualToString:[_taskReloadArrayTodo[i] name]]){
                
                [temp addObject:_taskReloadArrayTodo[i]];
                
            }
        }
        _taskReloadArrayTodo=temp;
        [_table_view reloadData];
        
    }else{
        _taskReloadArrayTodo=[self reloadDataDefaultsWithType:@"ToDo"];
        [_table_view reloadData];
    }
}
-(void)viewWillAppear:(BOOL)animated{



    _taskReloadArrayTodo=[self reloadDataDefaultsWithType:@"ToDo"];
    [_table_view reloadData];
}


//_taskReloadArray=[NSKeyedUnarchiver unarchiveObjectWithData:data];
-(void) addTaskButton{
    AddViewController *add=[self.storyboard instantiateViewControllerWithIdentifier:@"add"];
    add.taskDelegate=self;
    [add setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:add animated:YES completion:nil];
   
}
-(NSMutableArray*) reloadDataDefaultsWithType : (NSString*) type{
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
    self.task =task;
  
  
    _taskReloadArrayTodo=[self reloadDataDefaultsWithType:task.stateOfTask];
    if(_taskReloadArrayTodo.count==0)
        _taskReloadArrayTodo=[NSMutableArray new];
    [_taskReloadArrayTodo addObject:_task];
   
    [self setDataWithType:_taskReloadArrayTodo Type:task.stateOfTask ];
    [_table_view reloadData];
    
    
}
-(void)editTaskWithIndex:(TaskDetails *)task Index:(NSInteger)index{

 //   temp=[self reloadDataDefaults];
   // _taskReloadArray=[self filteredDefault:temp];
      //  [_taskReloadArray replaceObjectAtIndex:index withObject:task];
    _taskReloadArrayTodo=[self reloadDataDefaultsWithType:@"ToDo"];
    if(![task.stateOfTask isEqualToString:@"ToDo"]){
        [_taskReloadArrayTodo removeObjectAtIndex:index];
        [self setDataWithType:_taskReloadArrayTodo Type:@"ToDo"];
        if([task.stateOfTask isEqualToString:@"Doing"]){
            _taskReloadArrayDoing=[self reloadDataDefaultsWithType:task.stateOfTask];
            if(_taskReloadArrayDoing.count==0)
                _taskReloadArrayDoing=[NSMutableArray new];
            [_taskReloadArrayDoing addObject:task];
            [self setDataWithType:_taskReloadArrayDoing Type:task.stateOfTask];
        }else if([task.stateOfTask isEqualToString:@"Done"]){
            _taskReloadArrayDone=[self reloadDataDefaultsWithType:task.stateOfTask];
            if(_taskReloadArrayDone.count==0)
                _taskReloadArrayDone=[NSMutableArray new];
            [_taskReloadArrayDone addObject:task];
            [self setDataWithType:_taskReloadArrayDone Type:task.stateOfTask];
           
       }
        
    }else{
        [_taskReloadArrayTodo replaceObjectAtIndex:index withObject:task];
        [self setDataWithType:_taskReloadArrayTodo Type:@"ToDo"];
    }
   

    
      
   
       
    _taskReloadArrayTodo=[self reloadDataDefaultsWithType:@"ToDo"];
        [_table_view reloadData];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    if(_taskReloadArrayTodo!=nil)
         return [_taskReloadArrayTodo count];
    return 0;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ToDoTableViewCell *cell=[self.table_view dequeueReusableCellWithIdentifier:@"cell"];
  
    UIImage *img=[UIImage imageNamed:[_taskReloadArrayTodo[indexPath.row] prio]];
    [cell.myImage setImage:img];
    cell.task_title.text=[_taskReloadArrayTodo[indexPath.row] name];
    return cell;
}
- (void)tableView:(UITableView *)tableView performPrimaryActionForRowAtIndexPath:(NSIndexPath *)indexPath{
    Edit *edit=[self.storyboard instantiateViewControllerWithIdentifier:@"4"];
 
    _taskReloadArrayTodo=[self reloadDataDefaultsWithType:@"ToDo"];
    edit.task=[_taskReloadArrayTodo objectAtIndex:indexPath.row];
    edit.taskDelegate=self;
    edit.index=indexPath.row;
    [edit setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:edit animated:YES completion:nil];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertController *alreadyRegistered=[UIAlertController alertControllerWithTitle:@"" message:@"Are you sure you want to delete" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *oK=[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        if(editingStyle == UITableViewCellEditingStyleDelete){
            [self->_taskReloadArrayTodo removeObjectAtIndex:indexPath.row];
            [self setDataWithType:self->_taskReloadArrayTodo Type:@"ToDo"];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:YES];
           
            [tableView reloadData];
        }
    }];
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       
    }];
    [alreadyRegistered addAction:oK];
    [alreadyRegistered addAction:cancel];
    [self presentViewController:alreadyRegistered animated:YES completion:nil];
    
    
    
}










@end

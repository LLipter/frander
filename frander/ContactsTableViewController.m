//
//  ContactsTableViewController.m
//  frander
//
//  Created by irran on 2018/6/14.
//  Copyright © 2018 LLipter. All rights reserved.
//

#import "ContactsTableViewController.h"
#import "DatabaseUtility.h"
#import "DetailContactsViewController.h"
#import "NewContactsViewController.h"

@interface ContactsTableViewController ()
@property (nonatomic,strong) NSArray* contactList;
@property (nonatomic,strong) NSArray* searchResult;
@property (nonatomic,strong) UISearchController* searchController;



@end

@implementation ContactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DatabaseUtility* dbmanager = [DatabaseUtility shareInstance];
    [dbmanager openDB];
    [dbmanager creatTable];
    //[dbmanager insertInitContact];
    
    
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.placeholder = @"name of contact";
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    [self.searchController.searchBar sizeToFit];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.contactList = [Contact allContactFromDB];
    self.searchResult = [NSMutableArray arrayWithArray: self.contactList];
    NSLog(@"%@",self.contactList);
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.searchResult count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell" forIndexPath:indexPath];
    
    NSUInteger row = [indexPath row];
    Contact* contact = [self.searchResult objectAtIndex:row];
    cell.textLabel.text = contact.name;
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"ShowDetail"]){
        NSInteger row = [[self.tableView indexPathForSelectedRow]row];
        DetailContactsViewController* contactController = segue.destinationViewController;
        contactController.currentContact = self.searchResult[row];
    }
}

-(void) updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString* searchText = searchController.searchBar.text;
    if(searchText.length > 0){
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
        self.searchResult = [NSMutableArray arrayWithArray:[self.contactList filteredArrayUsingPredicate:predicate]];
    }else{
        self.searchResult = [NSMutableArray arrayWithArray:self.contactList];
    }
    [self.tableView reloadData];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.searchController setActive:FALSE];
}



@end

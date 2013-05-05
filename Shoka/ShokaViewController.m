//
//  ShokaViewController.m
//  Shoka
//
//  Created by AquarHEAD L. on 4/12/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "ShokaViewController.h"
#import "ShokaResult.h"
#import "ShokaWebpacAPI.h"

@interface ShokaViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property ShokaResult *cn_result, *en_result;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ShokaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.cn_result = [ShokaResult new];
    self.en_result = [ShokaResult new];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"clicked");
    [ShokaWebpacAPI searchChineseDepositoryWithKey:searchBar.text success:^(ShokaResult *result) {
        self.cn_result = result;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
    }];
    [ShokaWebpacAPI searchForeignDepositoryWithKey:searchBar.text success:^(ShokaResult *result) {
        self.en_result = result;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) return [self.cn_result count];
    else return [self.en_result count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    
    ShokaBook *bk;
    if (indexPath.section == 1)
        bk = [self.cn_result bookAtIndex:indexPath.row];
    else
        bk = [self.en_result bookAtIndex:indexPath.row];
    
    cell.textLabel.text = bk.title;
    
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) return @"中文文献库";
    else return @"西文文献库";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"book" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.m
//  sectionModel
//
//  Created by Lovina on 10/05/18.
//  Copyright © 2018 Lovina. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
   
@property (weak, nonatomic) IBOutlet UITableView *SectioTable;
@property (strong, nonatomic) NSMutableArray *categoriesArray;

@property (strong, nonatomic) NSMutableArray *titleNAme;
@property (strong, nonatomic) NSMutableArray *price;
@property(strong,nonatomic) NSString  *URLL;
@property float widthIs;


@property(strong,nonatomic) NSMutableDictionary *value;
@property(strong,nonatomic) NSMutableDictionary *tableData;
@property(strong,nonatomic) NSArray *sectionValue;
@property(strong,nonatomic) NSArray *sectionValueforparse;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.SectioTable.delegate = self;
    self.SectioTable.dataSource = self;
     self.categoriesArray = [[NSMutableArray alloc]init];
    self.URLL = @"http://mapp.esselworld.com/services/getEntryrate";
    [self entryRatesWebservice];
    [self.SectioTable setSeparatorInset:UIEdgeInsetsZero];
   // tableView.layoutMargins = UIEdgeInsets.zero
   [self.SectioTable setLayoutMargins:UIEdgeInsetsZero];
    
    
 // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)entryRatesWebservice {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://mapp.esselworld.com/services/getEntryrate"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//        });
        if (data != nil) {
            
            NSDictionary * json  = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSLog(@"%@", json);
           
            if ([json[@"Response"][@"status"]  isEqualToString:@"true"]) {
                self.value = [NSMutableDictionary dictionaryWithDictionary:json[@"Response"][@"Result"]];

              
                self.tableData = [[NSMutableDictionary alloc]init];
                self.sectionValueforparse = [[self.value allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
                self.titleNAme = [[NSMutableArray alloc]init];
                self.price = [[NSMutableArray alloc]init];
                for (int i =0;i< self.sectionValueforparse.count;i++)
                {
                    if([self.value valueForKey:@"combine"])
                    {
                        
                        NSArray *arr = [[NSArray alloc]init];
                        
                        arr = [self.value valueForKey:@"combine"];
                        
                        
                        
                        if(arr.count==0)
                        {
                            [self.value removeObjectForKey:@"combine"];
                        }
                        else
                        {
                            [self.tableData setValue:arr forKey:@"combine"];
                            
                        }
                        
                        
                        
                    }
                    if([self.value valueForKey:@"downtown"])
                    {
                        
                        NSArray *arr = [[NSArray alloc]init];
                        
                        arr = [self.value valueForKey:@"downtown"];
                        
                        if(arr.count==0)
                        {
                            [self.value removeObjectForKey:@"downtown"];
                        }
                        else
                        {
                             [self.tableData setValue:arr forKey:@"downtown"];
                        }
                        
                        
                        
                    }
                    if([self.value valueForKey:@"esselworld"])
                    {
                        
                        NSArray *arr = [[NSArray alloc]init];
                        
                        arr = [self.value valueForKey:@"esselworld"];
                        
                        if(arr.count==0)
                        {
                            [self.value removeObjectForKey:@"esselworld"];
                        }
                        else
                        {
                            
                            [self.tableData setValue:arr forKey:@"EsselWorld"];
                         //   [self.value setValue:arr forKey:@"EsselWorld"];
                    //     [ [self.value valueForKey:@"esselworld"] isEqualToString:@"INDIA"];
                      ////
                        }
                        
                        
                        
                    }
                    if([self.value valueForKey:@"passport"])
                    {
                        
                        NSArray *arr = [[NSArray alloc]init];
                        
                        arr = [self.value valueForKey:@"passport"];
                        
                        if(arr.count==0)
                        {
                            [self.value removeObjectForKey:@"passport"];
                        }
                        else
                        {
                            
                             [self.tableData setValue:arr forKey:@"passport"];
                            
    
                            
                        }
                        
                        
                        
                    }
                    if([self.value valueForKey:@"waterkingdom"])
                    {
                        
                        NSArray *arr = [[NSArray alloc]init];
                        
                        arr = [self.value valueForKey:@"waterkingdom"];
                        
                        if(arr.count==0)
                        {
                            [self.value removeObjectForKey:@"waterkingdom"];
                        }
                        else
                        {

                            [self.tableData setValue:arr forKey:@"waterkingdom"];
                           // [self.value setValue:arr forKey:@"WaterKingdom"];
                            
                            
                                }
                        
                    }
                    
                }
                
              
             
        self.sectionValue = [[self.value allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
                
                
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.SectioTable reloadData];
                });
            }
            
        }
        
    }];
    
    [postDataTask resume];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *sectionTitle = [self.sectionValue objectAtIndex:section];
    NSArray *sectionAnimals = [self.value objectForKey:sectionTitle];
    //NSInteger *c = [sectionAnimals count] + 1;
    return [sectionAnimals count] + 1;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.

    return [self.sectionValue count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tablecell"];
    
   NSString *sectionTitle = [self.sectionValue objectAtIndex:indexPath.section];
   
    
    NSArray *sectionrowvalue = [self.value objectForKey:sectionTitle];
    
    

    NSString *s;
    
    if(indexPath.row == 0)
    {
//       s = [sectionrowvalue valueForKey:@"1"];
//   cell.Title.text = @"Adult";
        
       s = @"Price";
        cell.Title.text =@"Visitors";
        cell.subtitle.hidden = YES;
        cell.backgroundColor = [UIColor colorWithRed:47.0f/255.0f
    green:164.0f/255.0f
    blue:235.0f/255.0f
    alpha:1.0f];
        cell.Title.textColor = [UIColor whiteColor];
        cell.value.textColor = [UIColor whiteColor];

    }
    else if(indexPath.row == 1)
    {
          s = [sectionrowvalue valueForKey:@"1"];
        cell.Title.text = @"Adult";
        cell.subtitle.text = @"( height above 4'6 ft )";
        cell.value.textColor = [UIColor redColor];
        
        [ self myMethod:(cell.subtitle.text) two:(cell.subtitle)];
         NSLog(@"the width of yourLabel is11 %f", self.widthIs);
        
        CGRect currentLabelFrame = cell.subtitle.frame;
        
        currentLabelFrame.size.width = self.widthIs;
        
          cell.subtitle.frame = currentLabelFrame;

        
        
    }
    else if(indexPath.row == 2)
    {
        
         cell.Title.text = @"Child";
        cell.subtitle.text = @"( height between 3'6 & 4'6 ft )";
          s = [sectionrowvalue valueForKey:@"2"];
        cell.value.textColor = [UIColor redColor];
        [ self myMethod:(cell.subtitle.text) two:(cell.subtitle)];
        NSLog(@"the width of yourLabel is22 %f", self.widthIs);
        
       CGRect currentLabelFrame = cell.subtitle.frame;

       currentLabelFrame.size.width = self.widthIs;

        cell.subtitle.frame = currentLabelFrame;
        
    }
    else if(indexPath.row == 3)
    {
        
        cell.Title.text = @"Sr. Citizen";
        cell.subtitle.text = @"( age above 60 years )";
        s = [sectionrowvalue valueForKey:@"3"];
        cell.value.textColor = [UIColor redColor];
        [ self myMethod:(cell.subtitle.text) two:(cell.subtitle)];
        NSLog(@"the width of yourLabel is33 %f", self.widthIs);
        CGRect currentLabelFrame = cell.Title.frame;

        currentLabelFrame.size.width = self.widthIs;

        cell.Title.frame = currentLabelFrame;
    }
    
    cell.value.text = s;
    
    

    return cell;
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return [self.sectionValue objectAtIndex:section];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *headerLabel = [[UILabel alloc]init];
    headerLabel.text =  [self.sectionValue objectAtIndex:section];
    headerLabel.textAlignment = UITextAlignmentCenter;
    headerLabel.textColor = [UIColor redColor];
  //  headerLabel.textAlignment = kCTTextAlignmentCenter;
    return headerLabel;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGFloat width = screenBounds.size.width;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 1)];
    view.backgroundColor = [UIColor blackColor];
    
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;
}

-(double) myMethod: (NSString*) one two:(UILabel*)two {
    
  self.widthIs =
            [one
             boundingRectWithSize:two.frame.size
             options:NSStringDrawingUsesLineFragmentOrigin
             attributes:@{ NSFontAttributeName:two.font }
             context:nil]
            .size.width;
    
         //   NSLog(@"the width of yourLabel is %f", self.widthIs);
    
    return self.widthIs ;
}

@end

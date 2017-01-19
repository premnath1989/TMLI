//
//  ProductInformation.m
//  BLESS
//
//  Created by Erwin on 01/03/2016.
//  Copyright © 2016 InfoConnect Sdn Bhd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductInformation.h"
#import "CarouselViewController.h"
#import "ReaderViewController.h"
#import "ColumnHeaderStyle.h"
#import "Reachability.h"
#import "ProgressBar.h"
#import "ChangePassword.h"
#import "UIView+viewRecursion.h"
#import "User Interface.h"
#import "WebServiceUtilities.h"
#import "XMLParser.h"
#import "DTCustomColoredAccessory.h"

@implementation ProductInformation

@synthesize btnHome;
@synthesize btnPDF;
@synthesize myTableView;
@synthesize navigationBar;
@synthesize moviePlayer;
@synthesize segmentScrollView;
@synthesize txtFind;

BOOL NavShow2;

- (void)viewDidLoad{
    [super viewDidLoad];
    
    segment = @"ProductInformation";
    
    NavShow2 = NO;
    arrayContainer = [[NSMutableArray alloc] init];
    collapsedRow = [[NSMutableArray alloc] init];
    recordedCollapsedRow = [[NSMutableArray alloc] init];
    serverTransferMode = kBRHTTPMode;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Brochures"];
    FTPItemsList = [[NSMutableArray alloc]init];
    
    [self createDirectory:filePath];
    
    if([self connected]){
        
        UIView *spinnerHolder = [[UIView alloc]initWithFrame:CGRectMake(150, 80, 500, 500)];
        spinnerHolder.tag = 501;
        [self.view addSubview:spinnerHolder];
        
        spinnerLoading = [[SpinnerUtilities alloc]init];
        [spinnerLoading startLoadingSpinner:spinnerHolder label:@"Loading Informasi Produk"];
        [self getDirectoryListing];
    }else{
        [self listDirFile];
        [self changeSegment:arrayContainerSegmentDefault];
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Koneksi ke Server Gagal" message:[NSString stringWithFormat:@"Pastikan perangkat terhubung ke internet yang stabil untuk mengakses Server"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
    themeColour = [UIColor colorWithRed:72.0f/255.0f green:98.0f/255.0f blue:108.0f/255.0f alpha:1];
    fontType = [UIFont fontWithName:@"NewJuneRegular" size:16.0f];
    
    [self setupTableColumn];
    
    [btnHome addTarget:self action:@selector(goHome:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)getDirectoryListing{
    if(serverTransferMode == kBRHTTPMode){
        WebServiceUtilities *webservice = [[WebServiceUtilities alloc]init];
        [webservice getProductInformation:self];
    }else if(serverTransferMode == kBRFTPMode){
        [self FTPFileListing];
    }
}

- (void)changeSegment:(NSMutableArray *)arraySegment{
    
    NSMutableArray *dictSectionToDeleted = [[NSMutableArray alloc] init];
    arrayContainerSegmentActive = [[NSMutableArray alloc]init];
    arrayContainerSegmentActive = arraySegment;
    
    [FTPItemsList removeAllObjects];
    for(NSMutableDictionary *dict in arraySegment){
        if([[[dict allKeys] firstObject] compare:segment] != NSOrderedSame){
            [dictSectionToDeleted addObject: dict];
        }
    }
    
    NSMutableArray *stringKeys = [[NSMutableArray alloc] init];
    for(NSMutableDictionary *tempDict in arraySegment){
        NSString *keyTempDict = [[tempDict allKeys] objectAtIndex:0];
        if(![stringKeys containsObject:keyTempDict]){
            [self insertIntoTableData:keyTempDict size:@"" index:1 fileURL:@"" objectIndex:111111];
            [stringKeys addObject:keyTempDict];
        }
    }
    
    [myTableView reloadData];
}

//here is our function for every response from webservice
- (void) operation:(AgentWSSoapBindingOperation *)operation
completedWithResponse:(AgentWSSoapBindingResponse *)response
{
    NSArray *responseBodyParts = response.bodyParts;
    if([[response.error localizedDescription] caseInsensitiveCompare:@""] != NSOrderedSame){
     
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Periksa lagi koneksi internet anda" message:@"" delegate:self cancelButtonTitle:@"OK"otherButtonTitles: nil];
        [alert show];
        [spinnerLoading stopLoadingSpinner];
        
    }
    for(id bodyPart in responseBodyParts) {
        
        /****
         * SOAP Fault Error
         ****/
        if ([bodyPart isKindOfClass:[SOAPFault class]]) {
            
            //You can get the error like this:
            NSString* errorMesg = ((SOAPFault *)bodyPart).simpleFaultString;
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Periksa lagi koneksi internet anda" message:errorMesg delegate:self cancelButtonTitle:@"OK"otherButtonTitles: nil];
            [alert show];
            [spinnerLoading stopLoadingSpinner];
        }
        
        else if([bodyPart isKindOfClass:[AgentWS_GetAllProductInfoResponse class]]) {
            [spinnerLoading stopLoadingSpinner];
            AgentWS_GetAllProductInfoResponse* rateResponse = bodyPart;
            
            // create XMLDocument object
            DDXMLDocument *xml = [[DDXMLDocument alloc] initWithXMLString:
                                  rateResponse.GetAllProductInfoResult.xmlDetails options:0 error:nil];
            
            // Get root element - DataSetMenu for your XMLfile
            DDXMLElement *root = [xml rootElement];
            WebResponObj *returnObj = [[WebResponObj alloc]init];
            [[[XMLParser alloc]init] parseXML:root objBuff:returnObj index:0];
            NSMutableArray *fileCompilation = [[NSMutableArray alloc]init];
            NSMutableArray *fileURL = [[NSMutableArray alloc]init];

            for(dataCollection *data in [returnObj getDataWrapper]){
                
                NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
                NSString* FilePath = [data.dataRows valueForKey:@"FilePath"];
                NSString* FileSize = [data.dataRows valueForKey:@"FileSize"];
                [tempDict setValue:[[[FilePath componentsSeparatedByString: @"../"] lastObject] stringByReplacingOccurrencesOfString:@"\\" withString:@"/"] forKey:@"fileURL"];
                [tempDict setValue:FileSize forKey:@"fileSize"];
                [fileURL addObject:tempDict];
                
                if([FilePath compare:@""] != NSOrderedSame){
                    NSArray*  FilePathParser= [[[FilePath componentsSeparatedByString: @"../"] lastObject] componentsSeparatedByString: @"\\"];
                    FilePath = [FilePathParser lastObject];
                    
                    NSString *appendedPath = @"";
                    for(NSString *localPathCreation in FilePathParser){
                        if(![localPathCreation containsString:@"."]){
                            if([[FilePathParser firstObject] compare:localPathCreation] != NSOrderedSame){
                                for(int i = 0; i<= [FilePathParser indexOfObject:localPathCreation]; i++ ){
                                    appendedPath = [appendedPath stringByAppendingPathComponent:[FilePathParser objectAtIndex:i]];
                                }
                            }else{
                                appendedPath = localPathCreation;
                            }
                            
                            //we create directory as return of the webservices
                            NSLog(@"appendedPath = %@",appendedPath);
                            [self createDirectory:[filePath stringByAppendingPathComponent:appendedPath]];
                            appendedPath = @"";
                        }
                    }
                    
                    if([FilePath containsString:@"."]){
                        
                        NSMutableDictionary *itemInfo = [[NSMutableDictionary alloc]init];
                        [itemInfo setValue:FileSize forKey:FilePath];
                        [fileCompilation addObject:itemInfo];
                    }
                }
            }
            
            //we sync folder and files structure on below function
            [self removeLocalFiles:fileURL];
            [FTPItemsList removeAllObjects];
            
            fileURL = [self constructPreTreeDictForm:fileURL];
            
            //we convert the paths received from the returns to folder
            //and show it to table
            [self convertFullPathToFolder:fileURL];
            [myTableView reloadData];
            
            [self changeSegment:arrayContainerSegmentDefault];
        }
    }
}

- (NSMutableArray *)constructPreTreeDictForm:(NSMutableArray *)urlsFromServer{
    NSMutableArray *TreeFormArray = [[NSMutableArray alloc]init];
    for(NSDictionary *mainDict in urlsFromServer){
        NSString *fileURLCombined = [mainDict valueForKey:@"fileURL"];
        fileURLCombined = [[fileURLCombined componentsSeparatedByString:@"ProductRoot/"] lastObject];
        if([fileURLCombined compare:@""] != NSOrderedSame){
            NSMutableArray *separatedStrings = [fileURLCombined componentsSeparatedByString:@"/"];
            NSString *tempPathString = @"ProductRoot/";
            for(NSString *eachPath in separatedStrings){
                if([eachPath compare:@""] != NSOrderedSame){
                    if([TreeFormArray count] == 0){
                        NSMutableDictionary *eachPathDict = [[NSMutableDictionary alloc]init];
                        NSString *eachPathWithSeparator = [NSString stringWithFormat:@"%@%@/",tempPathString, eachPath];
                        [eachPathDict setValue:eachPathWithSeparator forKey:@"fileURL"];
                        if([eachPath containsString:@"."]){
                            [eachPathDict setValue:[mainDict valueForKey:@"fileSize"]  forKey:@"fileSize"];
                        }else{
                            [eachPathDict setValue:@"0"  forKey:@"fileSize"];
                        }
                        [TreeFormArray addObject:eachPathDict];
                        tempPathString = eachPathWithSeparator;
                    }else{
                        BOOL exist = FALSE;
                        NSString *eachPathWithSeparator = @"";
                        if([eachPath containsString:@"."]){
                            eachPathWithSeparator = [NSString stringWithFormat:@"%@%@"
                                                           ,tempPathString, eachPath];
                        }else{
                            eachPathWithSeparator = [NSString stringWithFormat:@"%@%@/"
                                                     ,tempPathString, eachPath];
                        }
                        tempPathString = eachPathWithSeparator;
                        for(NSMutableDictionary *tempDictOnTreeFormArray in TreeFormArray){
                            if([[tempDictOnTreeFormArray valueForKey:@"fileURL"] compare:eachPathWithSeparator] == NSOrderedSame)
                                exist = TRUE;
                        }
                        
                        if(!exist){
                            NSMutableDictionary *eachPathDict = [[NSMutableDictionary alloc]init];
                            [eachPathDict setValue:eachPathWithSeparator forKey:@"fileURL"];
                            if([eachPath containsString:@"."]){
                                [eachPathDict setValue:[mainDict valueForKey:@"fileSize"]  forKey:@"fileSize"];
                            }else{
                                [eachPathDict setValue:@"0"  forKey:@"fileSize"];
                            }
                            [TreeFormArray addObject:eachPathDict];
                        }
                    }
                }
            }
        }
    }
    return TreeFormArray;
}

//foldering function
- (void)convertFullPathToFolder:(NSMutableArray *)fullPath{
    for (NSMutableDictionary *tempDict in fullPath) {
        NSString *pathName = [[[tempDict valueForKey:@"fileURL"] componentsSeparatedByString: @"ProductRoot/"] lastObject];
        if([pathName compare:@""] != NSOrderedSame){
            [self foldedFolder:tempDict];
        }
    }
    
    if([arrayContainer count ] > 0){
        arrayContainerSegmentDefault = [[NSMutableArray alloc]init];
        [arrayContainerSegmentDefault addObject:[arrayContainer objectAtIndex:0]];
        
        float yPosition = 20.0;
        NSMutableArray *stringKeys = [[NSMutableArray alloc] init];
        for(NSMutableDictionary *tempDict in arrayContainer){
            NSString *keyTempDict = [[tempDict allKeys] objectAtIndex:0];
            if(![stringKeys containsObject:keyTempDict]){
                [self insertIntoTableData:keyTempDict size:@"" index:1 fileURL:@"" objectIndex:111111];
                
                //we create segment button of the scrollview here
                [self createSegmentedButtons:keyTempDict yPosition:yPosition];
                yPosition = yPosition + 60.0;
                [stringKeys addObject:keyTempDict];
            }
        }
    }
}

- (void) createSegmentedButtons:(NSString *)segmentName yPosition:(float)yPosition{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:segmentName forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeSegmentButtonAction:)forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(10.0, yPosition, 150, 50.0);
    button.titleLabel.textColor = [UIColor clearColor];
    button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    button.layer.cornerRadius = 10.0f;
    button.clipsToBounds = YES;
    button.backgroundColor = [UIColor colorWithRed:(201/255.0) green:(212/255.0) blue:(0/255.0) alpha:1];
    [segmentScrollView addSubview:button];
}

- (void)changeSegmentButtonAction:(UIButton*)sender{
    [recordedCollapsedRow removeAllObjects];
    [collapsedRow removeAllObjects];
    segment = sender.currentTitle;
    
    for(NSMutableDictionary *tempDict in arrayContainer){
        NSString *keyTempDict = [[tempDict allKeys] objectAtIndex:0];
        if([segment compare:keyTempDict] == NSOrderedSame){
            NSMutableArray *segmentArray = [[NSMutableArray alloc]init];
            [segmentArray addObject:tempDict];
            [self changeSegment:segmentArray];
            return;
        }
    }
}

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}


- (void)FTPFileListing{
    FTPitems = [[ProductInfoItems alloc]init];
    [FTPitems listDirectory];
    FTPitems.ftpDelegate = self;
}

- (void)createDirectory:(NSString *)localDir{
    //create Directory
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:localDir])	//Does directory already exist?
    {
        if (![[NSFileManager defaultManager] createDirectoryAtPath:localDir
                                       withIntermediateDirectories:NO
                                                        attributes:nil
                                                             error:&error])
        {
            NSLog(@"Create directory error: %@", error);
        }
    }
    
}

- (NSMutableArray *)getLocalPaths{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *directoryURL = [NSURL fileURLWithPath:filePath isDirectory:YES];
    NSArray *keys = [NSArray arrayWithObject:NSURLIsDirectoryKey];
    NSDirectoryEnumerator *enumerator = [fileManager
                                         enumeratorAtURL:directoryURL
                                         includingPropertiesForKeys:keys
                                         options:0
                                         errorHandler:^(NSURL *url, NSError *error) {
                                             // Handle the error.
                                             // Return YES if the enumeration should continue after the error.
                                             return YES;
                                         }];
    NSMutableArray *fileURL = [[NSMutableArray alloc]init];
    for (NSURL *url in enumerator) {
        
        //we create the dictionary to store our data of the file
        NSMutableDictionary *fileData = [[NSMutableDictionary alloc]init];
        [fileData setValue:[[url.absoluteString componentsSeparatedByString:@"Brochures/"] lastObject] forKey:@"fileURL"];
        
        // Enumerate each file in directory
        NSNumber *fileSizeNumber = nil;
        NSError *sizeError = nil;
        [url getResourceValue:&fileSizeNumber
                       forKey:NSURLFileSizeKey
                        error:&sizeError];
        [fileData setValue:[fileSizeNumber stringValue] forKey:@"fileSize"];
        
        //we append the info inside an array
        [fileURL addObject:fileData];
        
    }
    return fileURL;
}

- (BOOL)listDirFile{
    
    //we convert the paths from local to folder
    //and show it to the table
    [self convertFullPathToFolder:[self getLocalPaths]];
    
    return false;
}

- (void)directoryFileListing
{
    NSURL *directoryURL = [NSURL fileURLWithPath:filePath
                                     isDirectory:YES];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *contentsError = nil;
    NSArray *contents = [fm contentsOfDirectoryAtURL:directoryURL
                          includingPropertiesForKeys:@[NSURLFileSizeKey, NSURLIsDirectoryKey]
                                             options:0
                                               error:&contentsError];
    NSMutableArray *fileURL = [[NSMutableArray alloc]init];
    for (NSURL *url in contents) {
        
        //we create the dictionary to store our data of the file
        NSMutableDictionary *fileData = [[NSMutableDictionary alloc]init];
        [fileData setValue:url.absoluteString forKey:@"fileURL"];
        
        // Enumerate each file in directory
        NSNumber *fileSizeNumber = nil;
        NSError *sizeError = nil;
        [url getResourceValue:&fileSizeNumber
                           forKey:NSURLFileSizeKey
                            error:&sizeError];
        [fileData setValue:[fileSizeNumber stringValue] forKey:@"fileSize"];
        
        //we append the info inside an array
        [fileURL addObject:fileData];
    }
    
    //we convert the paths from local to folder
    //and show it to the table
    [self convertFullPathToFolder:fileURL];
    
    [spinnerLoading stopLoadingSpinner];
    for(UIView *v in [self.view allSubViews]){
        if(v.tag == 501)
            v.hidden = YES;
    }
}

- (void)setupTableColumn{
    //we call the table management to design the table
    ColumnHeaderStyle *nama = [[ColumnHeaderStyle alloc]init:@"Nama" alignment:NSTextAlignmentCenter button:TRUE width:0.65];
    ColumnHeaderStyle *type = [[ColumnHeaderStyle alloc]init:@"Kategori" alignment:NSTextAlignmentCenter button:TRUE width:0.15];
    ColumnHeaderStyle *size = [[ColumnHeaderStyle alloc]init:@"Ukuran" alignment:NSTextAlignmentCenter button:TRUE width:0.10];
    ColumnHeaderStyle *download = [[ColumnHeaderStyle alloc]init:downloadMacro alignment:NSTextAlignmentCenter button:TRUE width:0.10];
    
    //add it to array
    columnHeadersContent = [NSArray arrayWithObjects:nama, type, size, download, nil];
    tableManagement = [[TableManagement alloc]init:self.view themeColour:themeColour themeFont:fontType];
    TableHeader =[tableManagement TableHeaderSetupXY:columnHeadersContent
                                         positionY:170.0f positionX:176.0f];
    
    [self.view addSubview:TableHeader];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)myTableView numberOfRowsInSection:(NSInteger)section {
    return [FTPItemsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }else{
        for (UIView* textLabel in cell.contentView.subviews)
        {
            [textLabel removeFromSuperview];
        }
    }
    NSLog(@"insert : %d",indexPath.row);
    
    if([FTPItemsList count] != 0){

        NSMutableArray *itemCell =  [FTPItemsList objectAtIndex:indexPath.row];
        NSString *FileName = [itemCell objectAtIndex:0];
        NSString *FileType = [itemCell objectAtIndex:1];
        
        if([FileType caseInsensitiveCompare:brochureLabel] == NSOrderedSame){
            FileName = [NSString stringWithFormat: @"%@.%@",FileName, brochureExt];
        }else if([FileType caseInsensitiveCompare:videoLabel] == NSOrderedSame){
            FileName = [NSString stringWithFormat: @"%@.%@",FileName, videoExt];
        }else{
//            if([recordedCollapsedRow count] > 0){
//                if(indexPath.row == [self collapsedRows:FileName collapsedRows:recordedCollapsedRow]){
                    cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeDown];
//                }else{
//                    cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeDown];
//                }
//            }
        }
        NSLog(@"filename : %@", FileName);
        //simply we check whether the file exist in brochure folder or not.
        if ([self searchFile:FileName]){
            [[FTPItemsList objectAtIndex:indexPath.row] replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@""]];
        }
    }
    
    [tableManagement TableRowInsert:[FTPItemsList objectAtIndex:indexPath.row] index:indexPath.row table:cell color:[UIColor colorWithRed:128.0f/255.0f green:130.0f/255.0f blue:133.0f/255.0f alpha:1]];
    
    return cell;
}


// BHIMBIM'S QUICK FIX - Start

- (IBAction)actionFind:(id)sender
{
    [FTPItemsList removeAllObjects];
    
    NSMutableArray *containerArrayFind = [[NSMutableArray alloc]init];
    for(NSMutableDictionary *dict in arrayContainerSegmentActive){
        [self FindDict:[txtFind text] dict:dict arrayContainer:containerArrayFind];
    }
    [self changeSegment:containerArrayFind];
}

// BHIMBIM'S QUICK FIX - End


- (IBAction)goHome:(id)sender{
    UIStoryboard *carouselStoryboard = [UIStoryboard storyboardWithName:@"CarouselStoryboard" bundle:Nil];
    CarouselViewController* carouselPage = [carouselStoryboard instantiateViewControllerWithIdentifier:@"carouselView"];
    [self presentViewController:carouselPage animated:YES completion:Nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"click : %d",indexPath.row);
    NSString *fileName = [[FTPItemsList objectAtIndex:indexPath.row] objectAtIndex:0];
    NSString *fileType = [[FTPItemsList objectAtIndex:indexPath.row] objectAtIndex:1];
    NSString *unduhLabel = [[FTPItemsList objectAtIndex:indexPath.row] objectAtIndex:3];
    NSLog(@"file : %@.%@", fileName,fileType);
    
    NSBundle *myLibraryBundle = [NSBundle bundleWithURL:[[NSBundle mainBundle]
                                                         URLForResource:@"xibLibrary" withExtension:@"bundle"]];
    
    if([fileType caseInsensitiveCompare:brochureLabel] == NSOrderedSame){
        if([unduhLabel caseInsensitiveCompare:downloadMacro] == NSOrderedSame){
              ProgressBar *progressBar = [[ProgressBar alloc]initWithNibName:@"ProgressBar" bundle:myLibraryBundle];
            progressBar.TitleFileName = [NSString stringWithFormat: @"%@.%@",fileName, brochureExt];
            progressBar.TitleProgressBar=[NSString stringWithFormat: @"%@.%@",fileName, brochureExt];
            progressBar.progressDelegate = self;
            progressBar.modalPresentationStyle = UIModalPresentationFormSheet;
            progressBar.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            progressBar.preferredContentSize = CGSizeMake(600, 200);
            progressBar.TransferFunction = @"download";
            
            if(serverTransferMode == kBRFTPMode){
                progressBar.TransferMode = kBRFTPMode;
            }else if(serverTransferMode == kBRHTTPMode){
                progressBar.TransferMode = kBRHTTPMode;
                progressBar.HTTPURLFilePath = [NSString stringWithFormat:@"https://tmconnect.tokiomarine-life.co.id/%@",
                                               [[FTPItemsList objectAtIndex:indexPath.row] objectAtIndex:4]];
                progressBar.HTTPLocalFilePath = [[FTPItemsList objectAtIndex:indexPath.row] objectAtIndex:4];
            }
            
            [self presentViewController:progressBar animated:YES completion:nil];
        }else{
            [self seePDF:[[FTPItemsList objectAtIndex:indexPath.row] objectAtIndex:4]];
        }
    }else if([fileType caseInsensitiveCompare:videoLabel] == NSOrderedSame){
        if([unduhLabel caseInsensitiveCompare:downloadMacro] == NSOrderedSame){
            
            ProgressBar *progressBar = [[ProgressBar alloc]initWithNibName:@"ProgressBar" bundle:myLibraryBundle];
            progressBar.TitleFileName = [NSString stringWithFormat: @"%@.%@",fileName, videoExt];
            progressBar.TitleProgressBar = [NSString stringWithFormat: @"%@.%@",fileName, videoExt];
            progressBar.progressDelegate = self;
            progressBar.modalPresentationStyle = UIModalPresentationFormSheet;
            progressBar.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            progressBar.preferredContentSize = CGSizeMake(600, 200);
            progressBar.TransferFunction = @"download";
            
            if(serverTransferMode == kBRFTPMode){
                progressBar.TransferMode = kBRFTPMode;
            }else if(serverTransferMode == kBRHTTPMode){
                progressBar.TransferMode = kBRHTTPMode;
                progressBar.HTTPURLFilePath = [NSString stringWithFormat:@"https://tmconnect.tokiomarine-life.co.id/%@",
                                               [[FTPItemsList objectAtIndex:indexPath.row] objectAtIndex:4]];
                progressBar.HTTPLocalFilePath = [[FTPItemsList objectAtIndex:indexPath.row] objectAtIndex:4];
            }
            [self presentViewController:progressBar animated:YES completion:nil];
        }else{
            [self seeVideo:[[FTPItemsList objectAtIndex:indexPath.row] objectAtIndex:4]];
        }
    }else if([[[FTPItemsList objectAtIndex:indexPath.row] objectAtIndex:1] caseInsensitiveCompare:folderLabel] == NSOrderedSame){
//        fileName = [fileName stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        [self modifyTableList:fileName row:indexPath.row];
        [myTableView reloadData];
    }
}

- (void)modifyTableList:(NSString *)folderName row:(NSInteger)row{
    NSMutableArray *modifyTempArray = [[NSMutableArray alloc] init];
    BOOL expandBool = TRUE;
    int i = 1;
    
    int currentLevel = 0;
    int level = (int)[[[FTPItemsList objectAtIndex:row] objectAtIndex:5]floatValue];
    for(NSMutableDictionary *dict in arrayContainerSegmentActive){
        modifyTempArray = [self searchDict:folderName dict:dict level:level currentLevel:currentLevel];
        if([modifyTempArray count] > 0){
            break;
        }
    }
    
    //this is for recorded collapsed rows
    NSMutableDictionary *preRecordedCollapsedRowDict = [[NSMutableDictionary alloc]init];
    NSMutableArray *preRecordedCollapsedRowArr = [[NSMutableArray alloc]init];
    
    if([modifyTempArray count] > 0){
        for(NSMutableDictionary *modifyTempDict in modifyTempArray){
            if(![collapsedRow containsObject:folderName]){
                if([[[modifyTempDict allKeys] firstObject] compare:@""] != NSOrderedSame){
                    
                    [preRecordedCollapsedRowArr addObject:[[modifyTempDict allKeys] lastObject]];

                    if([[modifyTempDict allKeys] containsObject:@"fileName"]){
                        [self insertIntoTableData:[modifyTempDict valueForKey:@"fileName"] size:[modifyTempDict valueForKey:@"fileSize"] index:1 fileURL:[modifyTempDict valueForKey:@"fileURL"] objectIndex:row+i];
                    }else{
                        [self insertIntoTableData:[[modifyTempDict allKeys] lastObject] size:@"0" index:1                         fileURL:@"" objectIndex:row+i];
                    }
                    expandBool = TRUE;
                    i++;
                }
            }else{
                expandBool = FALSE;
            }
        }
        if(expandBool){
            [preRecordedCollapsedRowDict setValue:preRecordedCollapsedRowArr forKey:folderName];
            [recordedCollapsedRow addObject:preRecordedCollapsedRowDict];
            [collapsedRow addObject:folderName];
        }else{
            int rows = [self collapsedRows:folderName collapsedRows:recordedCollapsedRow];
            
            for(int i = 0; i < rows; i++){
                [FTPItemsList removeObjectAtIndex:row+1];
            }
            NSMutableArray *rowsToBeDeleted = [[NSMutableArray alloc]init];
            [recordedCollapsedRow removeObjectsInArray:rowsToBeDeleted];
        }
        
    }
}

- (int)collapsedRows:(NSString *)folderName collapsedRows:(NSMutableArray *)collapsedRows{
    int child = 0;
    for(NSMutableDictionary *tempDict in collapsedRows){
        if([folderName compare:[[tempDict allKeys]lastObject]]== NSOrderedSame){
            child = [[tempDict valueForKey:folderName] count];
            for(NSString *childName in [tempDict valueForKey:folderName]){
                NSMutableArray *tempArray = collapsedRows;
                if([collapsedRows count]>0){
                    [tempArray removeObjectAtIndex:0];
                    [collapsedRow removeObject:folderName];
                }
                child = child + [self collapsedRows:childName collapsedRows:tempArray];
            }
        }
    }
    return child;
}

//we search through all the array to get list of the parent's child/ren
- (NSMutableArray *)searchDict:(NSString *)fileName dict:(NSMutableDictionary *)dict
                         level:(int)level currentLevel:(int)CurrentLevel{
    for(NSString *key in [dict allKeys]){
        if([key compare:fileName] == NSOrderedSame && CurrentLevel == level){
            return [dict valueForKey:key];
        }else{
            if(![key containsString:@"."]){
                if([[dict valueForKey:key] count] > 0){
                    for(NSMutableDictionary *wrapperDict in [dict valueForKey:key]){
                        if([[wrapperDict allKeys] count] == 1){
                            NSMutableArray *tempDict =  [self searchDict:fileName dict:wrapperDict
                                              level:level currentLevel:CurrentLevel+1];
                            if(tempDict != nil){
                                return tempDict;
                            }
                        }
                    }
                }
            }
        }
    }
    return nil;
}

//we search through all the array to get list of the name contained with the text
- (void)FindDict:(NSString *)searchName dict:(NSMutableDictionary *)dict
                    arrayContainer:(NSMutableArray *)arrayCointainer{
    for(NSString *key in [dict allKeys]){
        if([key containsString:searchName]){
            [arrayCointainer addObject:dict];
        }
        if(![key containsString:@"."]){
            if([[dict valueForKey:key] count] > 0){
                for(NSMutableDictionary *wrapperDict in [dict valueForKey:key]){
                    if([[wrapperDict allKeys] count] == 1){
                        [self FindDict:searchName dict:wrapperDict
                               arrayContainer:arrayCointainer];
                    }
                }
            }
        }
    }
}


- (BOOL)searchFile:(NSString *)fileName{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *directoryURL = [NSURL fileURLWithPath:filePath isDirectory:YES];
    NSArray *keys = [NSArray arrayWithObject:NSURLIsDirectoryKey];
    NSDirectoryEnumerator *enumerator = [fileManager
                                         enumeratorAtURL:directoryURL
                                         includingPropertiesForKeys:keys
                                         options:0
                                         errorHandler:^(NSURL *url, NSError *error) {
                                             // Handle the error.
                                             // Return YES if the enumeration should continue after the error.
                                             return YES;
                                         }];
    
    for (NSURL *url in enumerator) {
        NSError *error;
        NSNumber *isDirectory = nil;
        if (! [url getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:&error]) {
            // handle error
        }
        else if (![isDirectory boolValue]) {
            // No error and it’s not a directory; do something with the file
            if([url.absoluteString containsString:fileName])
                return true;
        }else if ([isDirectory boolValue]) {
        }
        
    }
    return false;
}

- (void)treeFromArray:(NSMutableArray *)path tempArray:(NSMutableArray *)tempArray
              fileURL:(NSString *)fileURL fileSize:(NSString *)fileSize{
    if([path count] == 1){
        NSMutableDictionary *parentDict = [[NSMutableDictionary alloc]init];
        if([[path firstObject] containsString:@"."]){
            [parentDict setValue:[path firstObject] forKey:@"fileName"];
            [parentDict setValue:fileURL forKey:@"fileURL"];
            [parentDict setValue:fileSize forKey:@"fileSize"];
        }else{
            NSMutableArray *childArray = [[NSMutableArray alloc] init];
            [parentDict setValue:childArray forKey:[path firstObject]];
        }
        [tempArray addObject:parentDict];
        return;
    }
    if([tempArray count] >0){
        for(NSMutableDictionary *wrapperDict in tempArray){
            for(NSString *key in [wrapperDict allKeys]){
                if([key compare:[path firstObject]] == NSOrderedSame){
                    [path removeObjectAtIndex:0];
                    [self treeFromArray:path
                              tempArray:[wrapperDict valueForKey:key]
                            fileURL:fileURL fileSize:fileSize];
                    return;
                }
            }
        }
    }
}

- (NSMutableDictionary *)foldedFolder:(NSMutableDictionary *)pathData{
    NSString *url = [pathData valueForKey:@"fileURL"];
    NSString *fileSize = [pathData valueForKey:@"fileSize"];
    NSString *path = [[url componentsSeparatedByString: @"ProductRoot/"] lastObject];
    NSMutableArray *tempArray = [path componentsSeparatedByString:@"/"];
    if([[tempArray lastObject] compare:@""] == NSOrderedSame){
        [tempArray removeLastObject];
    }
    NSMutableDictionary *tempDict = [[NSMutableDictionary alloc]init];
    [self treeFromArray:tempArray tempArray:arrayContainer fileURL:url fileSize:fileSize];
    
//    for(NSString *tempPath in tempArray){
//        if([tempArray indexOfObject:tempPath] > 0){
//            NSMutableDictionary *containerDict = [[NSMutableDictionary alloc]init];
//            
//            //we treat file different to fill in the data of the file
//            //for folder the value should be empty to be filled in by
//            //other folder/file below it
//            if([tempPath containsString:@"."]){
//                [containerDict setValue:tempPath forKey:@"fileName"];
//                [containerDict setValue:url forKey:@"fileURL"];
//                [containerDict setValue:fileSize forKey:@"fileSize"];
//            }else{
//                [containerDict setValue:@"" forKey:tempPath];
//            }
//            
//            [tempDict setValue:containerDict forKey:[tempArray
//                                                objectAtIndex:[tempArray indexOfObject:tempPath]-1]];
//        }else{
//            [tempDict setValue:@"" forKey:tempPath];
//        }
//    }
    return tempDict;
}


- (IBAction)seePDF:(NSString *)fileName{
    NSString *file = [NSString stringWithFormat: @"%@/%@",filePath, fileName];
    
    ReaderDocument *document = [ReaderDocument withDocumentFilePath:file password:nil];
    
    if (document != nil)
    {
        ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
        readerViewController.delegate = self;
        BOOL illustrationSigned = 1;
        readerViewController.illustrationSignature = illustrationSigned;
        readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        
        [self presentViewController:readerViewController animated:YES completion:Nil];
    }
}

- (IBAction)ShowNavigation:(id)sender {

    if (!NavShow2) {
        UserInterface *_objectUserInterface = [[UserInterface alloc] init];
        [_objectUserInterface navigationShow:self];

    }
    else {
        UserInterface *_objectUserInterface = [[UserInterface alloc] init];
        [_objectUserInterface navigationHide:self];
    }

    NavShow2 = !NavShow2;
}

- (IBAction)GoBack:(id)sender {
    UIStoryboard *_storyboardMain = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [self presentViewController:[_storyboardMain instantiateViewControllerWithIdentifier:@"HomePage"] animated:YES completion: nil];
}

- (IBAction)seeVideo:(NSString *)fileName{
    NSString*thePath=[NSString stringWithFormat: @"%@/%@",filePath, fileName];
    NSURL*theurl=[NSURL fileURLWithPath:thePath];
    
    moviePlayer=[[MPMoviePlayerController alloc] initWithContentURL:theurl];
    [moviePlayer.view setFrame:self.view.bounds];
    [moviePlayer prepareToPlay];
    [moviePlayer setShouldAutoplay:NO]; // And other options you can look through the documentation.
    moviePlayer.view.tag = MOVIEPLAYER_TAG;
    [self.view addSubview:moviePlayer.view];
    [moviePlayer setFullscreen:YES animated:YES];
    [moviePlayer play];
    
    // Remove the movie player view controller from the "playback did finish" notification observers
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:moviePlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieFinishedCallback:)
                                                 name:MPMoviePlayerWillExitFullscreenNotification
                                               object:moviePlayer];

}

- (void)movieFinishedCallback:(NSNotification*)aNotification
{
    // Obtain the reason why the movie playback finished
    NSNumber *finishReason = [[aNotification userInfo] objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    
    // Dismiss the view controller ONLY when the reason is not "playback ended"
    if ([finishReason intValue] != MPMovieFinishReasonUserExited)
    {
        // Remove this class from the observers
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:MPMoviePlayerPlaybackDidFinishNotification
                                                      object:moviePlayer];
        [moviePlayer stop];
        // Dismiss the view controller
        for (UIView *subview in [self.view subviews]) {
            if (subview.tag == MOVIEPLAYER_TAG) {
                [subview removeFromSuperview];
            }
        }
    }
}

//for brochure
- (void)dismissReaderViewController:(ReaderViewController *)viewController {
    [self dismissModalViewControllerAnimated:YES];
}


//delegate for list dir completion of FTP mode
- (void)itemsList:(NSMutableArray *)ftpItems{
    NSLog(@"ftp itemlist");
    int index = 1;
    
    //we remove any files if local if not listed in FTP
    [self removeLocalFiles:ftpItems];
    
    [FTPItemsList removeAllObjects];
    for(NSMutableDictionary *itemInfo in ftpItems){
        for(NSString *key in [itemInfo allKeys]){
            [self insertIntoTableData:key size:[itemInfo objectForKey:key] index:index fileURL:@"" objectIndex:111111];
            index++;
        }
    }
    [myTableView reloadData];
}

- (void)removeLocalFiles:(NSMutableArray *)ftpItems{
    
    NSMutableArray *localPathsArray = [self getLocalPaths];
    
    for(NSDictionary *tempLocalDict in localPathsArray){
        BOOL exist = FALSE;
        for(NSDictionary *tempServerDict in ftpItems){
            NSString *serverFileURL = [tempServerDict valueForKey:@"fileURL"];
            NSString *localFileURL = [tempLocalDict valueForKey:@"fileURL"];
//            serverFileURL = [serverFileURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            if([serverFileURL containsString:localFileURL]){
                exist = TRUE;
                break;
            }
        }
        if(!exist){
            NSError *error = nil;
            if ([[NSFileManager defaultManager] removeItemAtPath:
                 [filePath stringByAppendingPathComponent:[tempLocalDict valueForKey:@"fileURL"]] error:&error]){
            }
        }
    }
//    for(NSMutableArray *itemCell in FTPItemsList){
//        NSString *FileName = [itemCell objectAtIndex:1];
//        NSString *FileType = [itemCell objectAtIndex:2];
//        
//        if([FileType caseInsensitiveCompare:brochureLabel] == NSOrderedSame){
//            FileName = [NSString stringWithFormat: @"%@.%@",FileName, brochureExt];
//        }else if([FileType caseInsensitiveCompare:videoLabel] == NSOrderedSame){
//            FileName = [NSString stringWithFormat: @"%@.%@",FileName, videoExt];
//        }
//        
//        BOOL exist = FALSE;
//        for(NSMutableDictionary *itemInfo in ftpItems){
//            for(NSString *key in [itemInfo allKeys]){
//                if([key caseInsensitiveCompare:FileName] == NSOrderedSame){
//                    exist = TRUE;
//                }
//            }
//        }
//        
//        //after checking, if the files not listed in FTP. we delete the file in local.
//        if(!exist){
//            NSError *error = nil;
//            if ([[NSFileManager defaultManager] removeItemAtPath:
//                 [NSString stringWithFormat:@"%@/%@",filePath,FileName] error:&error]){
//            }
//        }
//    }
}

- (void)insertIntoTableData:(NSString *)fileNameParam size:(NSString *)fileSizeParam index:(int)fileIndex
                    fileURL:(NSString *)fileURL objectIndex:(int)objectIndex{
    
    NSArray* fullFileNameTemp = [fileNameParam componentsSeparatedByString: @"."];
    NSString *fileFormat = folderLabel;
    NSString *fileName = fileNameParam;
    NSString *fileExist = @"";
    NSString *fileSize = @"";
    if([fullFileNameTemp count] > 1){
        fileName = [fullFileNameTemp objectAtIndex:0];
        NSString *fileExt = [fullFileNameTemp objectAtIndex:1];
        if([fileExt caseInsensitiveCompare:videoExt] == NSOrderedSame){
            fileFormat = videoLabel;
        }else if([fileExt caseInsensitiveCompare:brochureExt] == NSOrderedSame){
            fileFormat = brochureLabel;
        }
        fileExist = downloadMacro;
        fileSize = [NSByteCountFormatter stringFromByteCount:[fileSizeParam longLongValue] countStyle:NSByteCountFormatterCountStyleFile];
    }
    
    NSLog(@"index: %d, file %@", fileIndex, fileFormat);
    if(objectIndex == 111111){
        [FTPItemsList addObject:[NSMutableArray arrayWithObjects:fileName, fileFormat,fileSize,fileExist,fileURL,@"0",nil]];
    }else{
        [FTPItemsList insertObject:[NSMutableArray arrayWithObjects:fileName, fileFormat,fileSize,fileExist,fileURL,@"1", nil] atIndex:objectIndex];
    }
    
    [spinnerLoading stopLoadingSpinner];
    for(UIView *v in [self.view allSubViews]){
        if(v.tag == 501)
            v.hidden = YES;
    }
}

- (void)downloadisFinished{
    [myTableView reloadData];
}

- (void)percentCompletedfromFTP:(float)percent{
    //left this blank
}

- (void)downloadisError{
    [spinnerLoading stopLoadingSpinner];
    for(UIView *v in [self.view allSubViews]){
        if(v.tag == 501)
            v.hidden = YES;
    }
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Koneksi ke FTP Gagal" message:[NSString stringWithFormat:@"Pastikan perangkat terhubung ke internet yang stabil untuk mengakses FTP"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (void)failedConnectToFTP{
    [spinnerLoading stopLoadingSpinner];
    for(UIView *v in [self.view allSubViews]){
        if(v.tag == 501)
            v.hidden = YES;
    }
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Koneksi ke FTP Gagal" message:[NSString stringWithFormat:@"Pastikan perangkat terhubung ke internet yang stabil untuk mengakses FTP"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}


@end

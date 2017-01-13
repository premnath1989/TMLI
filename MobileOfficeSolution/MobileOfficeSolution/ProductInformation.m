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

@implementation ProductInformation

@synthesize btnHome;
@synthesize btnPDF;
@synthesize myTableView;
@synthesize navigationBar;
@synthesize moviePlayer;

BOOL NavShow2;

- (void)viewDidLoad{
    [super viewDidLoad];
    
    NavShow2 = NO;
    serverTransferMode = kBRHTTPMode;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Brochures"];
    
    [self createDirectory:filePath];
    [self directoryFileListing];
    [self listDirFile];
    
    if([self connected]){
        
        UIView *spinnerHolder = [[UIView alloc]initWithFrame:CGRectMake(150, 80, 500, 500)];
        spinnerHolder.tag = 501;
        [self.view addSubview:spinnerHolder];
        
        spinnerLoading = [[SpinnerUtilities alloc]init];
        [spinnerLoading startLoadingSpinner:spinnerHolder label:@"Loading Informasi Produk"];
        [self getDirectoryListing];
    }else{
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Koneksi ke Server Gagal" message:[NSString stringWithFormat:@"Pastikan perangkat terhubung ke internet yang stabil untuk mengakses Server"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
    NSMutableDictionary *newAttributes = [[NSMutableDictionary alloc] init];
    [newAttributes setObject:[UIFont systemFontOfSize:18] forKey:UITextAttributeFont];
    
    themeColour = [UIColor colorWithRed:0.0f/255.0f green:160.0f/255.0f blue:180.0f/255.0f alpha:1];
    fontType = [UIFont fontWithName:@"BPreplay" size:16.0f];
    
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
                
                NSString* FilePath = [data.dataRows valueForKey:@"FilePath"];
                NSString* FileSize = [data.dataRows valueForKey:@"FileSize"];
                [fileURL addObject:[[[FilePath componentsSeparatedByString: @"../"] lastObject] stringByReplacingOccurrencesOfString:@"\\" withString:@"/"]];
                
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
            
            [self removeLocalFiles:fileCompilation];
            [FTPItemsList removeAllObjects];
            
            int index = 1;
            for(NSMutableDictionary *itemInfo in fileCompilation){
                for(NSString *key in [itemInfo allKeys]){
                    [self insertIntoTableData:key size:[itemInfo objectForKey:key] index:index fileURL:[fileURL objectAtIndex:index]];
                    index++;
                }
            }
            [myTableView reloadData];

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

- (void)directoryFileListing
{
    FTPItemsList = [[NSMutableArray alloc]init];
    NSURL *directoryURL = [NSURL fileURLWithPath:filePath
                                     isDirectory:YES];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *contentsError = nil;
    NSArray *contents = [fm contentsOfDirectoryAtURL:directoryURL
                          includingPropertiesForKeys:@[NSURLFileSizeKey, NSURLIsDirectoryKey]
                                             options:0
                                               error:&contentsError];
    
    int index = 1;
    for (NSURL *fileURL in contents) {
        // Enumerate each file in directory
        NSNumber *fileSizeNumber = nil;
        NSError *sizeError = nil;
        [fileURL getResourceValue:&fileSizeNumber
                              forKey:NSURLFileSizeKey
                               error:&sizeError];
        
        if([fileURL.absoluteString containsString:@"."]){
            [self insertIntoTableData:[fileURL lastPathComponent] size:[fileSizeNumber stringValue] index:index fileURL:@""];
        }
        
        
        
        index++;
    }
    [spinnerLoading stopLoadingSpinner];
    for(UIView *v in [self.view allSubViews]){
        if(v.tag == 501)
            v.hidden = YES;
    }
}

- (void)setupTableColumn{
    //we call the table management to design the table
    ColumnHeaderStyle *ilustrasi = [[ColumnHeaderStyle alloc]init:@" No. " alignment:NSTextAlignmentCenter button:FALSE width:0.25];
    ColumnHeaderStyle *nama = [[ColumnHeaderStyle alloc]init:@"Nama" alignment:NSTextAlignmentCenter button:TRUE width:0.40];
    ColumnHeaderStyle *type = [[ColumnHeaderStyle alloc]init:@"Kategori" alignment:NSTextAlignmentCenter button:TRUE width:0.15];
    ColumnHeaderStyle *size = [[ColumnHeaderStyle alloc]init:@"Ukuran" alignment:NSTextAlignmentCenter button:TRUE width:0.10];
    ColumnHeaderStyle *download = [[ColumnHeaderStyle alloc]init:downloadMacro alignment:NSTextAlignmentCenter button:TRUE width:0.10];
    
    //add it to array
    columnHeadersContent = [NSArray arrayWithObjects:ilustrasi, nama, type, size, download, nil];
    tableManagement = [[TableManagement alloc]init:self.view themeColour:themeColour themeFont:fontType];
    TableHeader =[tableManagement TableHeaderSetupXY:columnHeadersContent
                                         positionY:252.0f positionX:0.0f];
    
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
        NSString *FileName = [itemCell objectAtIndex:1];
        NSString *FileType = [itemCell objectAtIndex:2];
        
        if([FileType caseInsensitiveCompare:brochureLabel] == NSOrderedSame){
            FileName = [NSString stringWithFormat: @"%@.%@",FileName, brochureExt];
        }else if([FileType caseInsensitiveCompare:videoLabel] == NSOrderedSame){
            FileName = [NSString stringWithFormat: @"%@.%@",FileName, videoExt];
        }
        NSLog(@"filename : %@", FileName);
        //simply we check whether the file exist in brochure folder or not.
        if ([self searchFile:FileName]){
            [[FTPItemsList objectAtIndex:indexPath.row] replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@""]];
        }
    }
    
    [tableManagement TableRowInsert:[FTPItemsList objectAtIndex:indexPath.row] index:indexPath.row table:cell color:[UIColor colorWithRed:128.0f/255.0f green:130.0f/255.0f blue:133.0f/255.0f alpha:1]];
    
    return cell;
}

- (IBAction)ActionSegChange:(id)sender{

    [self FTPFileListing];
    NSLog(@"test");
    
}


// BHIMBIM'S QUICK FIX - Start

- (IBAction)actionFind:(id)sender
{
    [FTPItemsList removeAllObjects];
    
    for (int i = 0; i < arrayListRAW.count; i++)
    {
        [[arrayListRAW objectAtIndex:i] objectAtIndex:1];
        NSLog(@"actionFind -> name = %@, at index -> %d", [[arrayListRAW objectAtIndex:i] objectAtIndex:1], i);
    }
    
    [myTableView reloadData];
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
    UILabel *fileName = (UILabel *)[cell.contentView viewWithTag:(indexPath.row*1000)+1];
    UILabel *fileType = (UILabel *)[cell viewWithTag:(indexPath.row*1000)+2];
    UILabel *unduhLabel = (UILabel *)[cell viewWithTag:(indexPath.row*1000)+4];
    NSLog(@"file : %@.%@", fileName.text,fileType.text);
    
    
    NSBundle *myLibraryBundle = [NSBundle bundleWithURL:[[NSBundle mainBundle]
                                                         URLForResource:@"xibLibrary" withExtension:@"bundle"]];
    
    if([fileType.text caseInsensitiveCompare:brochureLabel] == NSOrderedSame){
        if([unduhLabel.text caseInsensitiveCompare:downloadMacro] == NSOrderedSame){
              ProgressBar *progressBar = [[ProgressBar alloc]initWithNibName:@"ProgressBar" bundle:myLibraryBundle];
            progressBar.TitleFileName = [NSString stringWithFormat: @"%@.%@",fileName.text, brochureExt];
            progressBar.TitleProgressBar=[NSString stringWithFormat: @"%@.%@",fileName.text, brochureExt];
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
                                               [[FTPItemsList objectAtIndex:indexPath.row] lastObject]];
                progressBar.HTTPLocalFilePath = [[FTPItemsList objectAtIndex:indexPath.row] lastObject];
            }
            
            [self presentViewController:progressBar animated:YES completion:nil];
        }else{
            [self seePDF:[[FTPItemsList objectAtIndex:indexPath.row] lastObject]];
        }
    }else if([fileType.text caseInsensitiveCompare:videoLabel] == NSOrderedSame){
        if([unduhLabel.text caseInsensitiveCompare:downloadMacro] == NSOrderedSame){
            
            ProgressBar *progressBar = [[ProgressBar alloc]initWithNibName:@"ProgressBar" bundle:myLibraryBundle];
            progressBar.TitleFileName = [NSString stringWithFormat: @"%@.%@",fileName.text, videoExt];
            progressBar.TitleProgressBar = [NSString stringWithFormat: @"%@.%@",fileName.text, videoExt];
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
                                               [[FTPItemsList objectAtIndex:indexPath.row] lastObject]];
                progressBar.HTTPLocalFilePath = [[FTPItemsList objectAtIndex:indexPath.row] lastObject];
            }
            [self presentViewController:progressBar animated:YES completion:nil];
        }else{
            [self seeVideo:[[FTPItemsList objectAtIndex:indexPath.row] lastObject]];
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
            NSLog(@"Directory Recursive : %@", url.absoluteString);
        }
        else if (![isDirectory boolValue]) {
            // No error and it’s not a directory; do something with the file
            NSLog(@"Directory Recursive : %@", url.absoluteString);
            if([url.absoluteString containsString:fileName])
                return true;
        }else if ([isDirectory boolValue]) {
            NSLog(@"Directory Recursive : %@", url.absoluteString);
        }
        
    }
    return false;
}

- (BOOL)listDirFile{
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
            NSLog(@"All Directory Recursive : %@", [[url.absoluteString componentsSeparatedByString: @"Brochures/"] lastObject]);
        }
        else if (![isDirectory boolValue]) {
            // No error and it’s not a directory; do something with the file
            NSLog(@"All Directory Recursive : %@", [[url.absoluteString componentsSeparatedByString: @"Brochures/"] lastObject]);
        }else if ([isDirectory boolValue]) {
            NSLog(@"All Directory Recursive : %@", [[url.absoluteString componentsSeparatedByString: @"Brochures/"] lastObject]);
        } 
    }
    return false;
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


//delegate for list dir completion
- (void)itemsList:(NSMutableArray *)ftpItems{
    NSLog(@"ftp itemlist");
    int index = 1;
    
    //we remove any files if local if not listed in FTP
    [self removeLocalFiles:ftpItems];
    
    [FTPItemsList removeAllObjects];
    for(NSMutableDictionary *itemInfo in ftpItems){
        for(NSString *key in [itemInfo allKeys]){
            [self insertIntoTableData:key size:[itemInfo objectForKey:key] index:index fileURL:@""];
            index++;
        }
    }
    [myTableView reloadData];
}

- (void)removeLocalFiles:(NSMutableArray *)ftpItems{
    for(NSMutableArray *itemCell in FTPItemsList){
        NSString *FileName = [itemCell objectAtIndex:1];
        NSString *FileType = [itemCell objectAtIndex:2];
        
        if([FileType caseInsensitiveCompare:brochureLabel] == NSOrderedSame){
            FileName = [NSString stringWithFormat: @"%@.%@",FileName, brochureExt];
        }else if([FileType caseInsensitiveCompare:videoLabel] == NSOrderedSame){
            FileName = [NSString stringWithFormat: @"%@.%@",FileName, videoExt];
        }
        
        BOOL exist = FALSE;
        for(NSMutableDictionary *itemInfo in ftpItems){
            for(NSString *key in [itemInfo allKeys]){
                if([key caseInsensitiveCompare:FileName] == NSOrderedSame){
                    exist = TRUE;
                }
            }
        }
        
        //after checking, if the files not listed in FTP. we delete the file in local.
        if(!exist){
            NSError *error = nil;
            if ([[NSFileManager defaultManager] removeItemAtPath:
                 [NSString stringWithFormat:@"%@/%@",filePath,FileName] error:&error]){
            }
        }
    }
}

- (void)insertIntoTableData:(NSString *)fileNameParam size:(NSString *)fileSizeParam index:(int)fileIndex
              fileURL:(NSString *)fileURL{
    
    NSArray* fullFileNameTemp = [fileNameParam componentsSeparatedByString: @"."];
    NSString *fileName = [fullFileNameTemp objectAtIndex:0];
    NSString *fileExt = [fullFileNameTemp objectAtIndex:1];
    NSString *fileSize = [NSByteCountFormatter stringFromByteCount:[fileSizeParam longLongValue] countStyle:NSByteCountFormatterCountStyleFile];
    NSString *fileFormat = @"";
    NSString *fileExist = downloadMacro;
    if([fileExt caseInsensitiveCompare:videoExt] == NSOrderedSame){
        fileFormat = videoLabel;
    }else if([fileExt caseInsensitiveCompare:brochureExt] == NSOrderedSame){
        fileFormat = brochureLabel;
    }
    
    
    NSLog(@"index: %d, file %@", fileIndex, fileFormat);
    [FTPItemsList addObject:[NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%d",fileIndex],fileName, fileFormat,fileSize,fileExist,fileURL,nil]];
    
    
    
    
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

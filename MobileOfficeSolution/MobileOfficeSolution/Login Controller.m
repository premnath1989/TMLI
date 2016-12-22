//
//  ViewController.m
//  TMConnect
//
//  Created by Ibrahim Aziz Tejokusumo on 10/27/16.
//  Copyright © 2016 Ibrahim Aziz Tejokusumo. All rights reserved.
//


// IMPORT

#import "Login Controller.h"
#import "Descriptor Controller.h"
#import <AdSupport/ASIdentifierManager.h>
#import "SynchdaysCounter.h"
#import "DDXMLDocument.h"
#import "DDXMLElementAdditions.h"
#import "DDXMLNode.h"


// INTERFACE

@interface LoginController ()

@end


// IMPLEMENTATION

@implementation LoginController

@synthesize textFieldUserCode;
@synthesize textFieldUserPassword;

/* VIEW DID LOAD */

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self DBInitialized];
    
    // DECLARATION
    
    _objectUserInterface = [[UserInterface alloc] init];
    _storyboardMain = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    firstLogin = false;
    if([loginDB AgentRecord] == AGENT_IS_NOT_FOUND){
        [self FirstTimeAlert:@"Selamat"];
        firstLogin = true;
    }
    
    UserProfileView = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePwd"];
    
    // LAYOUT
    
    [_imageViewBackground setImage:[UIImage imageNamed:@"photo_login_tertiary"]];
    
    /* INCLUDE */
    
    DescriptorController *viewDescriptorController = [[DescriptorController alloc] initWithNibName:@"Descriptor View" bundle:nil];
    viewDescriptorController.view.frame = _viewDescriptor.bounds;
    [self addChildViewController:viewDescriptorController];
    [_viewDescriptor addSubview:viewDescriptorController.view];
    
    
    // LOCALIZABLE
    
    _labelSectionInformation.text = NSLocalizedString(@"FORM_SECTION_INFORMATION", nil);
    _labelSectionLogin.text = NSLocalizedString(@"FORM_SECTION_LOGIN", nil);
    
    NSString *appInformation = [NSString stringWithFormat:@"Online Login Terakhir : 23/11/2016 \n Sisa Waktu Online Login : 0 hari \n TMConnect Client 6.8 b2016 UAT \n B5CDFC2A-8543-447A-AD97-63F078C4FB4"];
    _labelParagraphInformation.text = appInformation;
    
    [_buttonLogin setTitle:NSLocalizedString(@"BUTTON_FORM_LOGIN", nil) forState:UIControlStateNormal];
    [_buttonForgotPassword setTitle:NSLocalizedString(@"BUTTON_PHOTO_FORGOTPASSWORD", nil) forState:UIControlStateNormal];
    
    textFieldUserCode.text = NSLocalizedString(@"PLACEHOLDER_TEXTFIELD_USERCODE", nil);
    textFieldUserPassword.text = NSLocalizedString(@"PLACEHOLDER_TEXTFIELD_PASSWORD", nil);
    
    AppDelegate *delegate= (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if(![[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] containsString:@"UAT"])
    {
        delegate.serverURL = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"Prod_Webservices"];
    }else{
        delegate.serverURL = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"UAT_Webservices"];
    }

    ONLINE_PROCESS = FALSE;
    OFFLINE_PROCESS = FALSE;
    encryptWrapper = [[EncryptDecryptWrapper alloc]init];
}

- (void)DBInitialized{
    loginDB = [[LoginDBManagement alloc]init];
    [loginDB makeDBCopy];
    
    DBMigration *migration = [[DBMigration alloc]init];
    [migration updateDatabaseUseNewDB:@"MOSDDB.sqlite"];
    [migration hardUpdateDatabase:@"TMLI_Rates.sqlite" versionNumber:[NSString stringWithFormat:
                                                                     @"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"dbVersion"]]];
    [migration hardUpdateDatabase:@"DataReferral.sqlite"versionNumber:[NSString stringWithFormat:
                                                                       @"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"dbReferralVersion"]]];
}

//here is our function for every response from webservice
- (void) operation:(AgentWSSoapBindingOperation *)operation
completedWithResponse:(AgentWSSoapBindingResponse *)response
{
    NSArray *responseBodyParts = response.bodyParts;
    if([[response.error localizedDescription] caseInsensitiveCompare:@""] != NSOrderedSame){
        if(ONLINE_PROCESS){
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Server sedang bermasalah, anda di arahkan ke offline login" message:@"" delegate:self cancelButtonTitle:@"OK"otherButtonTitles: nil];
            [alert show];
            OFFLINE_PROCESS = TRUE;
            [self loginAction];
        }else{
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Periksa lagi koneksi internet anda" message:@"" delegate:self cancelButtonTitle:@"OK"otherButtonTitles: nil];
            [alert show];
            [spinnerLoading stopLoadingSpinner];
        }
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
        
        else if([bodyPart isKindOfClass:[AgentWS_VersionCheckerResponse class]]) {
            [spinnerLoading stopLoadingSpinner];
            AgentWS_VersionCheckerResponse* rateResponse = bodyPart;
            
            if([(NSString *)rateResponse.VersionCheckerResult caseInsensitiveCompare:@"TRUE"]== NSOrderedSame){
                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Informasi" message:@"Harap Download applikasi versi terbaru" delegate:self cancelButtonTitle:@"Download" otherButtonTitles:@"Cancel", nil];
                [alert show];
                alert.tag = 100;
            }
        }
        
        else if([bodyPart isKindOfClass:[AgentWS_AdminLoginResponse class]]) {
            [spinnerLoading stopLoadingSpinner];
            AgentWS_AdminLoginResponse* rateResponse = bodyPart;
            
            if([(NSString *)rateResponse.AdminLoginResult caseInsensitiveCompare:@"TRUE"]== NSOrderedSame){
                [self openHome];
            }else{
                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Informasi" message:@"Username/Password yang Anda masukkan salah" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }
        
        /****
         * is it AgentWS_SendForgotPasswordResponse
         ****/
        else if([bodyPart isKindOfClass:[AgentWS_SendForgotPasswordResponse class]]) {
            [spinnerLoading stopLoadingSpinner];
            AgentWS_SendForgotPasswordResponse* rateResponse = bodyPart;
            if([(NSString *)rateResponse.SendForgotPasswordResult caseInsensitiveCompare:@"TRUE"]== NSOrderedSame){
                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Sukses!"message:[NSString stringWithFormat:@"Password baru telah di kirimkan ke email anda"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }else{
                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Gagal!" message:[NSString stringWithFormat:@"Periksa lagi koneksi internet anda"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
        }
        
        /****
         * is it AgentWS_ChangeUDIDResponse
         ****/
        else if([bodyPart isKindOfClass:[AgentWS_ChangeUDIDResponse class]]) {
            [spinnerLoading stopLoadingSpinner];
            AgentWS_ChangeUDIDResponse* rateResponse = bodyPart;
            if([(NSString *)rateResponse.ChangeUDIDResult caseInsensitiveCompare:@"TRUE"]== NSOrderedSame){
                
                NSString *encryptedPass = [encryptWrapper encrypt:textFieldUserPassword.text];
                WebServiceUtilities *webservice = [[WebServiceUtilities alloc]init];
                [webservice ValidateLogin:textFieldUserCode.text password:encryptedPass UUID:[[[UIDevice currentDevice] identifierForVendor] UUIDString] delegate:self];
            }else{
                
                NSString *appName=[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
                [SSKeychain setPassword:nil forService:appName account:@"incodingLogin"];
                
                [spinnerLoading stopLoadingSpinner];
                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"Periksa lagi koneksi internet anda"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
        }
        
        else if([bodyPart isKindOfClass:[AgentWS_SupervisorLoginResponse class]]) {
            AgentWS_SupervisorLoginResponse* rateResponse = bodyPart;
            if([rateResponse.strStatus caseInsensitiveCompare:@"True"] == NSOrderedSame){
                
                // create XMLDocument object
                DDXMLDocument *xml = [[DDXMLDocument alloc] initWithXMLString:
                                      rateResponse.SupervisorLoginResult.xmlDetails options:0 error:nil];
                
                // Get root element - DataSetMenu for your XMLfile
                DDXMLElement *root = [xml rootElement];
                WebResponObj *returnObj = [[WebResponObj alloc]init];
                [self parseXML:root objBuff:returnObj index:0];
                if([loginDB fullSyncTable:returnObj]){
                    [spinnerLoading stopLoadingSpinner];
                    if([self validToLogin] && [self CredentialChecking:TRUE])
                        [self openHome];
                }
            }else if([rateResponse.strStatus caseInsensitiveCompare:@"False"] == NSOrderedSame){
                
                [spinnerLoading stopLoadingSpinner];
                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"Username/Password yang Anda masukkan salah"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                
                
            }
        }
        
        /****
         * is it AgentWS_ValidateLoginResponse
         ****/
        else if([bodyPart isKindOfClass:[AgentWS_ValidateLoginResponse class]]) {
            AgentWS_ValidateLoginResponse* rateResponse = bodyPart;
            if([rateResponse.strStatus caseInsensitiveCompare:@"True"] == NSOrderedSame){
                
                // create XMLDocument object
                DDXMLDocument *xml = [[DDXMLDocument alloc] initWithXMLString:
                                      rateResponse.ValidateLoginResult.xmlDetails options:0 error:nil];
                
                // Get root element - DataSetMenu for your XMLfile
                DDXMLElement *root = [xml rootElement];
                WebResponObj *returnObj = [[WebResponObj alloc]init];
                [self parseXML:root objBuff:returnObj index:0];
                if([loginDB fullSyncTable:returnObj]){
                    [spinnerLoading stopLoadingSpinner];
                    if([self validToLogin] && [self CredentialChecking:FALSE])
                        [self openHome];
                }
            }else if([rateResponse.strStatus caseInsensitiveCompare:@"False"] == NSOrderedSame){
                
                [spinnerLoading stopLoadingSpinner];
                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"Username/Password yang Anda masukkan salah"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
        }
    }
}


- (void) parseXML:(DDXMLElement *)root objBuff:(WebResponObj *)obj index:(int)index{
    // go through all elements in root element (DataSetMenu element)
    for (DDXMLElement *DataSetMenuElement in [root children]) {
        // if the element name's is MenuCategories then do something
        if([[DataSetMenuElement children] count] <= 0){
            if([[DataSetMenuElement name] caseInsensitiveCompare:@"xs:element"]==NSOrderedSame){
                //                DDXMLNode *name = [DataSetMenuElement attributeForName: @"name"];
                //                DDXMLNode *type = [DataSetMenuElement attributeForName: @"type"];
                //                NSLog(@"%@ : %@", [name stringValue], [type stringValue]);
                //
                //                DDXMLNode *tableName = [[[DataSetMenuElement parent] parent] parent];
                //                [obj addRow:[tableName ] columnNames:[name stringValue] data:@""];
            }else{
                NSArray *elements = [root elementsForName:[DataSetMenuElement name]];
                if([[[elements objectAtIndex:0]stringValue] caseInsensitiveCompare:@""] != NSOrderedSame){
                    NSLog(@"%d %@ = %@", index,[[DataSetMenuElement parent]name], [[elements objectAtIndex:0]stringValue]);
                    NSString *tableName = [NSString stringWithFormat:@"%@&%d",[[[DataSetMenuElement parent] parent]name], index];
                    [obj addRow:tableName columnNames:[[DataSetMenuElement parent]name] data:[[elements objectAtIndex:0]stringValue]];
                }else{
                    NSLog(@"%d %@ = %@",index, [DataSetMenuElement name], [[elements objectAtIndex:0]stringValue]);
                    NSString *tableName = [NSString stringWithFormat:@"%@&%d",[[DataSetMenuElement parent]name], index];
                    [obj addRow:tableName columnNames:[DataSetMenuElement name] data:[[elements objectAtIndex:0]stringValue]];
                }
            }
        }else{
            DDXMLNode *name = [DataSetMenuElement attributeForName: @"diffgr:id"];
            if(name != nil){
                NSLog(@"diffgr : %@",[[DataSetMenuElement attributeForName:@"diffgr:id"] stringValue]);
                index++;
            }
        }
        [self parseXML:DataSetMenuElement objBuff:obj index:index];
    }
}

- (IBAction)btnLogin:(id)sender {
    
    if (textFieldUserCode.text.length <= 0 && textFieldUserPassword.text.length <=0 ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Username dan password harap diisi" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = USERNAME_PASSWORD_VALIDATION;
        [alert show];
    }else if(textFieldUserCode.text.length <= 0 && textFieldUserPassword.text.length != 0 ){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Username harap diisi" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = USERNAME_PASSWORD_VALIDATION;
        [alert show];
    }else if(textFieldUserCode.text.length != 0 && textFieldUserPassword.text.length <= 0 ){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Password harap diisi" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = USERNAME_PASSWORD_VALIDATION;
        [alert show];
    }else{
        if(firstLogin && ![self connected]){
            [self FirstTimeAlert:@"Informasi"];
        }else{
            [self loginAction];
        }
    }
}


- (void)loginAction;
{
    //check the agentstatus and expiry date
    if(!firstLogin)
    {
        NSString *encryptedPass = [encryptWrapper encrypt:textFieldUserPassword.text];
        //online login
        int dateDifference = [self syncDaysLeft];
        if(dateDifference>0)
        {
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"Mohon kembalikan waktu anda ke semula"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }else{
            [spinnerLoading startLoadingSpinner:self.view label:@"Loading"];
            if([self connected] && !OFFLINE_PROCESS){
                ONLINE_PROCESS = TRUE;
                int usernameTemp = [self UsernameUDIDChecking];
                if(usernameTemp != 0){
                    switch (usernameTemp) {
                        case USERNAME_IS_AGENT:{
                            [self getUDIDLogin];
                            break;
                        }
                        case USERNAME_IS_SPV:{
                            
                            if([loginDB SpvStatus:textFieldUserCode.text] == AGENT_IS_ACTIVE){
                                WebServiceUtilities *webservice = [[WebServiceUtilities alloc]init];
                                [webservice spvLogin:[loginDB AgentCodeLocal] delegate:self spvCode:textFieldUserCode.text spvPass:encryptedPass];
                            }else{
                                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"Status Agen adalah inactive"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                                [alert show];
                                ONLINE_PROCESS = FALSE;
                            }
                            break;
                        }
                        case USERNAME_IS_ADMIN:{
                            
                            WebServiceUtilities *webservice = [[WebServiceUtilities alloc]init];
                            [webservice adminLogin:[loginDB AgentCodeLocal] delegate:self adminCode:textFieldUserCode.text  adminPass:encryptedPass];
                            break;
                        }
                        default:
                            break;
                    }
                }else{
                    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"Username/password yang Anda masukkan salah"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                    [spinnerLoading stopLoadingSpinner];
                }
            }else{
                //offline login
                if([self validToLogin]){
                    ONLINE_PROCESS = FALSE;
                    OFFLINE_PROCESS = FALSE;
                    [self doOfflineLoginCheck];
                }else{
                    [spinnerLoading stopLoadingSpinner];
                }
            }
        }
    }
}

- (IBAction)btnForgotPassword:(id)sender{
    
}


- (void) doOfflineLoginCheck
{
    int dateDifference = [self syncDaysLeft];
    
    if(dateDifference<0)
    {
        dateDifference = dateDifference * -1;
    }
    
    if(dateDifference > 7)
    {
        if(dateDifference > 14){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Informasi"
                                                            message:@"Anda tidak melakukan online login selama 14 hari, semua data nasabah telah terhapus."
                                                           delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Informasi"
                                                            message:@"Anda tidak melakukan online login selama 7 hari, pastikan perangkat terhubung ke internet untuk login."
                                                           delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        [spinnerLoading stopLoadingSpinner];
    }else
    {
        
        if ([self OfflineLogin]) {
            [self openHome];
        }
        [spinnerLoading stopLoadingSpinner];
    }
}

- (void) openHome
{
    [self presentViewController:[_storyboardMain instantiateViewControllerWithIdentifier:@"HomePage"] animated:YES completion: nil];
}

- (void)FirstTimeAlert:(NSString *)title{
    
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:title message:[NSString stringWithFormat:@"Pastikan perangkat terhubung ke internet untuk melakukan login perdana (dapat berlangsung hingga 3 menit)"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}


-(BOOL) OfflineLogin
{
    return [self CredentialChecking:FALSE];
}

-(BOOL) CredentialChecking:(BOOL)spvAdminBypass
{
    BOOL successLog = FALSE;
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"MOSDDB.sqlite"]];
    NSString *AgentName;
    NSString *AgentPassword;
    NSString *SupervisorCode;
    NSString *SupervisorPass;
    NSString *Admin;
    NSString *AdminPassword;
    
    AgentName = [[loginDB getAgentCodeLevel] valueForKey:@"AgentCode"];
    AgentPassword = [[loginDB getAgentCodeLevel] valueForKey:@"AgentPassword"];
    
    SupervisorCode = [[loginDB getAgentCodeLevel] valueForKey:@"DirectSupervisorCode"];
    SupervisorPass = [[loginDB getAgentCodeLevel] valueForKey:@"DirectSupervisorPassword"];
    
    Admin = [[loginDB getAgentCodeLevel] valueForKey:@"Admin"];
    AdminPassword = [[loginDB getAgentCodeLevel] valueForKey:@"AdminPassword"];
    
    NSString *encryptedPass = [encryptWrapper encrypt:textFieldUserPassword.text];
    if(!spvAdminBypass){
        if ([textFieldUserCode.text isEqualToString:AgentName]) {
            if ([encryptedPass isEqualToString:AgentPassword]) {
                successLog = TRUE;
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Username/Password yang Anda masukkan salah" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                successLog = FALSE;
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Username/Password yang Anda masukkan salah" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            successLog = FALSE;
        }
    }else{
        if([textFieldUserCode.text isEqualToString:AgentName] || [textFieldUserCode.text isEqualToString:SupervisorCode] || [textFieldUserCode.text isEqualToString:Admin]){
            if (([textFieldUserCode.text isEqualToString:AgentName] && [encryptedPass isEqualToString:AgentPassword])
                ||([textFieldUserCode.text isEqualToString:SupervisorCode] && [encryptedPass isEqualToString:SupervisorPass])
                || ([textFieldUserCode.text isEqualToString:Admin] && [encryptedPass isEqualToString:AdminPassword])) {
                successLog = TRUE;
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Username/Password yang Anda masukkan salah" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                successLog = FALSE;
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Username/Password yang Anda masukkan salah" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            successLog = FALSE;
        }
    }
    
    return successLog;
}



- (BOOL) validToLogin{
    
    //need to check again the date format
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"];
    
    BOOL validFlag = true;
    
    
    NSString *encryptedPass = [encryptWrapper encrypt:textFieldUserPassword.text];
    if(![loginDB SpvAdmValidation:textFieldUserCode.text password:encryptedPass]){
        switch ([loginDB AgentStatus:textFieldUserCode.text]) {
            case AGENT_IS_INACTIVE:
            {
                [spinnerLoading stopLoadingSpinner];
                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"Status Agen adalah inactive"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                validFlag = false;
                break;
            }
            case AGENT_IS_NOT_FOUND:
            {
                [spinnerLoading stopLoadingSpinner];
                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"Username/Password yang di masukan salah"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                validFlag = false;
                break;
            }
            case AGENT_IS_TERMINATED:
            {
                [spinnerLoading stopLoadingSpinner];
                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"Status Agen adalah terminated"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                validFlag = false;
                break;
            }
            default:
                break;
        }
        switch ([[dateFormatter dateFromString:[loginDB expiryDate:textFieldUserCode.text]] compare:[NSDate date]]) {
            case NSOrderedAscending:
            {
                [spinnerLoading stopLoadingSpinner];
                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"Lisensi Agen telah expired"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                validFlag = false;
                break;
            }
            default:
                break;
        }
    }
    
    if([[loginDB localDBUDID] caseInsensitiveCompare:[self getUniqueDeviceIdentifierAsString]]!= NSOrderedSame){
        [spinnerLoading stopLoadingSpinner];
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"Agen login di device yang tidak terdaftar"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        validFlag = false;
    }
    
    switch ([loginDB DeviceStatus:textFieldUserCode.text]) {
        case DEVICE_IS_INACTIVE:
        {
            [spinnerLoading stopLoadingSpinner];
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"Status Perangkat anda tidak aktif"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            validFlag = false;
            break;
        }
        case DEVICE_IS_TERMINATED:
        {
            [spinnerLoading stopLoadingSpinner];
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"Status Perangkat anda telah di terminate"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            validFlag = false;
            break;
        }
        default:
            break;
    }
    
    return validFlag;
}

//we store the UDID into the Keychain
-(NSString *)getUniqueDeviceIdentifierAsString
{
    NSString *appName=[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
    
    NSString *strApplicationUUID = [SSKeychain passwordForService:appName account:@"incoding"];
    if (strApplicationUUID == nil)
    {
        strApplicationUUID  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [SSKeychain setPassword:strApplicationUUID forService:appName account:@"incoding"];
        
    }
    return strApplicationUUID;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    spinnerLoading = [[SpinnerUtilities alloc]init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardDidHideNotification object:nil];
    
    if(firstLogin){
        UserProfileView.modalPresentationStyle = UIModalPresentationFormSheet;
        UserProfileView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [UserProfileView setDelegate:self firstLogin:firstLogin];
        UserProfileView.preferredContentSize = CGSizeMake(600, 500);
        [self presentViewController:UserProfileView animated:YES completion:nil];
    }
    
    //we do some version checker over here
    [self appVersionChecker];
    [self dataVersionChecker];
}


//just a flag of login udid
-(NSString *)getUDIDLogin
{
    
    NSString *appName=[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
    
    NSString *strApplicationUUID = [SSKeychain passwordForService:appName account:@"incodingLogin"];
    WebServiceUtilities *webservice = [[WebServiceUtilities alloc]init];
    if (strApplicationUUID == nil)
    {
        strApplicationUUID  = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        [SSKeychain setPassword:strApplicationUUID forService:appName account:@"incodingLogin"];
        
        //change the udid
        [webservice changeUDID:textFieldUserCode.text udid:[SSKeychain passwordForService:appName account:@"incoding"] delegate:self];
        
    }else{
        NSString *encryptedPass = [encryptWrapper encrypt:textFieldUserPassword.text];
        [webservice ValidateLogin:textFieldUserCode.text password:encryptedPass UUID:strApplicationUUID delegate:self];
    }
    return strApplicationUUID;
}

-(int) UsernameUDIDChecking
{
    int statusUsername = 0;
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"MOSDDB.sqlite"]];
    
    NSString *AgentName;
    NSString *AgentPassword;
    NSString *SupervisorCode;
    NSString *SupervisorPass;
    NSString *Admin;
    NSString *AdminPassword;
    NSString *UDID;
    
    
    AgentName = [[loginDB getAgentCodeLevel] valueForKey:@"AgentCode"];
    AgentPassword = [[loginDB getAgentCodeLevel] valueForKey:@"AgentPassword"];
    
    SupervisorCode = [[loginDB getAgentCodeLevel] valueForKey:@"DirectSupervisorCode"];
    SupervisorPass = [[loginDB getAgentCodeLevel] valueForKey:@"DirectSupervisorPassword"];;
    
    Admin = [[loginDB getAgentCodeLevel] valueForKey:@"Admin"];
    AdminPassword = [[loginDB getAgentCodeLevel] valueForKey:@"AdminPassword"];
    UDID = [[loginDB getAgentCodeLevel] valueForKey:@"UDID"];

    
    if([textFieldUserCode.text isEqualToString:AgentName] ){
        
        statusUsername = USERNAME_IS_AGENT;
        
    }else if([textFieldUserCode.text isEqualToString:SupervisorCode]){
        
        statusUsername = USERNAME_IS_SPV;
        
    }else if([textFieldUserCode.text isEqualToString:Admin]){
        statusUsername = USERNAME_IS_ADMIN;
    }
    
    return statusUsername;
}

- (int)syncDaysLeft{
    NSString *todaysDate = [self getTodayDate];
    NSString *lastSyncDate = [self getLastSyncDate];
    
    NSLog(@"lastSyncDate %@", lastSyncDate);
    if([lastSyncDate compare:@""] == NSOrderedSame){
        lastSyncDate = todaysDate;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"];
    
    return [SynchdaysCounter daysBetweenDate:[formatter dateFromString:todaysDate] andDate:[dateFormatter dateFromString:lastSyncDate]];
}

-(NSString *) getLastSyncDate
{
    return [loginDB checkingLastLogout];
}

/* DID RECEIVE MEMORY WARNING */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *) getTodayDate
{
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd/MM/YYYY"];
    
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    
    NSLog(@"%@",dateString);
    
    return dateString;
}

/* VIEW WILL APPEAR */

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}


/* VIEW WILL DISSAPEAR */

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (IBAction)navigationShow:(id)sender
{
    [_objectUserInterface navigationShow:self];
}

- (IBAction)navigationHide:(id)sender
{
    [_objectUserInterface navigationHide:self];
}

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

- (void)appVersionChecker{
    if([self connected]){
        [spinnerLoading startLoadingSpinner:self.view label:@"Periksa Versi Aplikasi"];
        NSString *version= [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        WebServiceUtilities *webservice = [[WebServiceUtilities alloc]init];
        [webservice AppVersionChecker:version delegate:self];
    }
}

- (void)dataVersionChecker{
    if([self connected]){
        [spinnerLoading startLoadingSpinner:self.view label:@"Periksa Versi Data"];
        NSString *version= [loginDB dataVersion];
        WebServiceUtilities *webservice = [[WebServiceUtilities alloc]init];
        [webservice checkDataVersion:version delegate:self];
    }
}

/* KEYBOARD */

- (void) keyboardShow: (NSNotification *) notificationKeyboard
{
    [_objectUserInterface keyboardShow:notificationKeyboard viewMain:_viewMain];
}

- (void) keyboardHide: (NSNotification *) notificationKeyboard
{
    [_objectUserInterface keyboardHide:notificationKeyboard viewMain:_viewMain];
}

@end

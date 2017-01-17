//
//  ModelProspectProfile.m
//  MPOS
//
//  Created by Faiz Umar Baraja on 29/01/2016.
//  Copyright © 2016 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ModelProspectProfile.h"
#import "ProspectProfile.h"
#import "String.h"

@implementation ModelProspectProfile
int newAge;

-(NSMutableArray *)getProspectProfile{
    NSString *ProspectID = @"";
    NSString *NickName = @"";
    NSString *ProspectName = @"";
    NSString *ProspectDOB = @"" ;
    NSString *ProspectGender = @"";
    NSString *ResidenceAddress1 = @"";
    NSString *ResidenceAddress2 = @"";
    NSString *ResidenceAddress3 = @"";
    NSString *ResidenceAddressTown = @"";
    NSString *ResidenceAddressState = @"";
    NSString *ResidenceAddressPostCode = @"";
    NSString *ResidenceAddressCountry = @"";
    NSString *OfficeAddress1 = @"";
    NSString *OfficeAddress2 = @"";
    NSString *OfficeAddress3 = @"";
    NSString *OfficeAddressTown = @"";
    NSString *OfficeAddressState = @"";
    NSString *OfficeAddressPostCode = @"";
    NSString *OfficeAddressCountry = @"";
    NSString *ProspectEmail = @"";
    NSString *ProspectOccupationCode = @"";
    NSString *ExactDuties = @"";
    NSString *ProspectRemark = @"";
    //basvi added
    NSString *DateCreated = @"";
    NSString *CreatedBy = @"";
    NSString *DateModified = @"";
    NSString *ModifiedBy = @"";
    //
    NSString *ProspectGroup = @"";
    NSString *ProspectTitle = @"";
    NSString *IDTypeNo = @"";
    NSString *OtherIDType = @"";
    NSString *OtherIDTypeNo = @"";
    NSString *Smoker = @"";
    
    NSString *Race = @"";
    
    NSString *Nationality = @"";
    NSString *MaritalStatus = @"";
    NSString *Religion = @"";
    
    NSString *AnnIncome = @"";
    NSString *BussinessType = @"";
    
    NSString *registration = @"";
    NSString *registrationNo = @"";
    NSString *registrationDate = @"";
    NSString *exempted = @"";
    NSString *isGrouping = @"";
    NSString *COB = @"";
    
    NSString* NIP;
    NSString* BranchCode;
    NSString* BranchName;
    NSString* KCU;
    NSString* ReferralSource;
    NSString* ReferralName;
    NSString* IdentitySubmitted;
    NSString* IDExpirityDate;
    NSString* NPWPNo;
    NSString* Kanwil;
    NSString* HomeVillage;
    NSString* HomeDistrict;
    NSString* HomeProvicne;
    NSString* OfficeVillage;
    NSString* OfficeDistrict;
    NSString* OfficeProvicne;
    NSString* SourceIncome;
    NSString* ClientSegmentation;
    NSString* tScore;
    
    NSString *ProspectLastName;
    NSString *ProspectAge;
    NSString* PhoneHomeNo;
    NSString* PhoneNoHP;
    NSString* Address4;
    NSString* Kelurahan;
    NSString* Kecamatan;
    NSString* CallStartTime;
    NSString* CallEndTime;
    NSString* isForeignAdd;
    NSString* ProspectStatus;
    NSString* Favorite;
    
    
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *docsPath = [paths objectAtIndex:0];
    //NSString *path = [docsPath stringByAppendingPathComponent:DATABASE_MAIN_NAME];
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    NSMutableArray* ProspectTableData=[[NSMutableArray alloc]init];
    //results = [database executeQuery:@"SELECT * FROM prospect_profile WHERE QQFlag = 'false'  order by LOWER(ProspectName) ASC LIMIT 20)", Nil];
    //FMResultSet *s = [database executeQuery:@"SELECT * FROM prospect_profile WHERE QQFlag = 'false'  order by DateModified DESC LIMIT 20"];
    // NSString *query = [NSString stringWithFormat:@"SELECT pp.*,ep.* FROM prospect_profile pp left join %@ ep on pp.OtherIDType=ep.IdentityCode or pp.OtherIDType=ep.DataIdentifier  WHERE QQFlag = 'false' order by isFavorite DESC, Score DESC,  DateModified DESC ",TABLE_IDENTIFICATION];
    
    
    // BHIMBIM'S QUICK FIX - Start, to escape dupplicate query.
    
    NSString *query = [NSString stringWithFormat:@"SELECT pp.*,ep.* FROM prospect_profile pp left join %@ ep on pp.OtherIDType=ep.DataIdentifier  WHERE QQFlag = 'false' order by isFavorite DESC, Score DESC,  DateModified DESC ",TABLE_IDENTIFICATION];
    
    Boolean booleanColumnEmpty = false;
    NSString *stringIDType = @"";
    NSString *stringIDText = @"";
    NSString *stringQuery = @"";
    
    // BHIMBIM'S QUICK FIX - End
    
    
    FMResultSet *s = [database executeQuery:query];
    while ([s next]) {
        //occpToEnableSection = [results stringForColumn:@"OccpCode"];
        int ID = [s intForColumn:@"IndexNo"];
        ProspectID = [NSString stringWithFormat:@"%i",ID];
        NickName = [s stringForColumn:@"PreferredName"];
        ProspectName = [s stringForColumn:@"ProspectName"];
        ProspectDOB = [s stringForColumn:@"ProspectDOB"];
        ProspectGender = [s stringForColumn:@"ProspectGender"];
        ResidenceAddress1 = [s stringForColumn:@"ResidenceAddress1"];
        ResidenceAddress2 = [s stringForColumn:@"ResidenceAddress2"];
        ResidenceAddress3 = [s stringForColumn:@"ResidenceAddress3"];
        ResidenceAddressTown = [s stringForColumn:@"ResidenceAddressTown"];;
        ResidenceAddressState = [s stringForColumn:@"ResidenceAddressState"];;
        ResidenceAddressPostCode = [s stringForColumn:@"ResidenceAddressPostCode"];;
        ResidenceAddressCountry = [s stringForColumn:@"ResidenceAddressCountry"];;
        OfficeAddress1 = [s stringForColumn:@"OfficeAddress1"];;
        OfficeAddress2 = [s stringForColumn:@"OfficeAddress2"];;
        OfficeAddress3 = [s stringForColumn:@"OfficeAddress3"];;
        OfficeAddressTown = [s stringForColumn:@"OfficeAddressTown"];;
        OfficeAddressState = [s stringForColumn:@"OfficeAddressState"];;
        OfficeAddressPostCode = [s stringForColumn:@"OfficeAddressPostCode"];;
        OfficeAddressCountry = [s stringForColumn:@"OfficeAddressCountry"];;
        ProspectEmail = [s stringForColumn:@"ProspectEmail"];;
        ProspectOccupationCode = [s stringForColumn:@"ProspectOccupationCode"];;
        ExactDuties = [s stringForColumn:@"ExactDuties"];;
        ProspectRemark = [s stringForColumn:@"ProspectRemark"];;
        //basvi added
        DateCreated = [s stringForColumn:@"DateCreated"];;
        CreatedBy = [s stringForColumn:@"CreatedBy"];;
        DateModified = [s stringForColumn:@"DateModified"];;
        ModifiedBy = [s stringForColumn:@"ModifiedBy"];;
        //
        ProspectGroup = [s stringForColumn:@"ProspectGroup"];;
        ProspectTitle = [s stringForColumn:@"ProspectTitle"];;
        IDTypeNo = [s stringForColumn:@"IDTypeNo"];;
        //OtherIDType = [s stringForColumn:@"OtherIDType"];;
        //OtherIDType = [s stringForColumn:@"IdentityDesc"];
        
        
        // BHIMBIM'S QUICK FIX - Start
        
        /* INITIALIZATION */
        
        booleanColumnEmpty = [s columnIsNull:@"OtherIDType"];
        stringIDType = @"";
        stringIDText = @"";
        
        if (booleanColumnEmpty == true)
        {
            NSLog(@"Search Prospect Profile By Name - Other id type | code -> null");
        }
        else
        {
            /* GET ID TYPE */
            
            stringIDType = [s stringForColumn:@"OtherIDType"];
            NSLog(@"Search Prospect Profile By Name - Other id type | code -> %@", stringIDType);
            
            /* QUERY TO TABLE IDENTIFICATION - not used */
            
            //            stringQuery = [NSString stringWithFormat:@"SELECT IdentityDesc FROM '%@' WHERE DataIdentifier = '%@'", TABLE_IDENTIFICATION, stringIDType];
            //            resultQuery = [database executeQuery:stringQuery];
            //
            //            while ([resultQuery next])
            //            {
            //                booleanColumnEmpty = [resultQuery columnIsNull:@"IdentityDesc"];
            //
            //                if (booleanColumnEmpty == true)
            //                {
            //                    NSLog(@"Search Prospect Profile By Name - Other id type | text -> null");
            //                }
            //                else
            //                {
            //                    /* GET ID TEXT */
            //
            //                    stringIDText = [resultQuery stringForColumn:@"IdentityDesc"];
            //                    NSLog(@"Search Prospect Profile By Name - Other id type | text -> %@", stringIDText);
            //                }
            //            }
        }
        
        /* RESULT */
        
        OtherIDType = stringIDType;
        
        
        OtherIDTypeNo = [s stringForColumn:@"OtherIDTypeNo"];;
        Smoker = [s stringForColumn:@"Smoker"];;
        
        Race = [s stringForColumn:@"Race"];;
        
        Nationality = [s stringForColumn:@"Nationality"];;
        MaritalStatus = [s stringForColumn:@"MaritalStatus"];;
        Religion = [s stringForColumn:@"Religion"];;
        
        AnnIncome = [s stringForColumn:@"AnnualIncome"];;
        BussinessType = [s stringForColumn:@"BussinessType"];;
        
        registration = [s stringForColumn:@"GST_registered"];;
        registrationNo = [s stringForColumn:@"GST_registrationNo"];;
        registrationDate = [s stringForColumn:@"GST_registrationDate"];;
        exempted = [s stringForColumn:@"GST_exempted"];
        
        isGrouping = [s stringForColumn:@"Prospect_IsGrouping"];
        COB = [s stringForColumn:@"CountryOfBirth"];
        
        NIP = [s stringForColumn:@"NIP"];
        BranchCode = [s stringForColumn:@"BranchCode"];
        BranchName = [s stringForColumn:@"BranchName"];
        KCU = [s stringForColumn:@"KCU"];
        ReferralSource = [s stringForColumn:@"ReferralSource"];
        ReferralName = [s stringForColumn:@"ReferralName"];
        IdentitySubmitted = [s stringForColumn:@"IdentitySubmitted"];
        IDExpirityDate = [s stringForColumn:@"IDExpiryDate"];
        NPWPNo = [s stringForColumn:@"NPWPNo"];
        Kanwil = [s stringForColumn:@"Kanwil"];
        HomeVillage = [s stringForColumn:@"ResidenceVillage"];
        HomeDistrict = [s stringForColumn:@"ResidenceDistrict"];
        HomeProvicne = [s stringForColumn:@"ResidenceProvince"];
        OfficeVillage = [s stringForColumn:@"OfficeVillage"];
        OfficeDistrict = [s stringForColumn:@"OfficeDistrict"];
        OfficeVillage = [s stringForColumn:@"OfficeVillage"];
        OfficeProvicne = [s stringForColumn:@"OfficeProvince"];
        SourceIncome = [s stringForColumn:@"SourceIncome"];
        ClientSegmentation = [s stringForColumn:@"ClientSegmentation"];
        
        tScore = [NSString stringWithFormat:@"%d",[s intForColumn:@"Score"]];
        ProspectLastName = [s stringForColumn:@"ProspectLastName"];
        ProspectAge = [s stringForColumn:@"ProspectAge"];
        PhoneHomeNo = [s stringForColumn:@"PhoneNoHome"];
        PhoneNoHP = [s stringForColumn:@"PhoneNoHP"];
        Address4 = [s stringForColumn:@"ResidenceAddress4"];
        Kelurahan = [s stringForColumn:@"ResidenceKelurahan"];
        Kecamatan = [s stringForColumn:@"ResidenceKecamatan"];
        CallStartTime = [s stringForColumn:@"CallTimeStart"];
        CallEndTime = [s stringForColumn:@"CallTimeEnd"];
        isForeignAdd = [s stringForColumn:@"IsForeignAddress"];
        ProspectStatus = [s stringForColumn:@"ProspectStatus"];
        Favorite = [s stringForColumn:@"isFavorite"];
        NSString* RTRW;
        RTRW = [s stringForColumn:@"RTRW"];
        
        
        
        [ProspectTableData addObject:[[ProspectProfile alloc] initWithName:NickName AndProspectID:ProspectID AndProspectName:ProspectName
                                                          AndProspecGender:ProspectGender AndResidenceAddress1:ResidenceAddress1
                                                      AndResidenceAddress2:ResidenceAddress2 AndResidenceAddress3:ResidenceAddress3
                                                   AndResidenceAddressTown:ResidenceAddressTown AndResidenceAddressState:ResidenceAddressState
                                               AndResidenceAddressPostCode:ResidenceAddressPostCode AndResidenceAddressCountry:ResidenceAddressCountry
                                                         AndOfficeAddress1:OfficeAddress1 AndOfficeAddress2:OfficeAddress2 AndOfficeAddress3:OfficeAddress3 AndOfficeAddressTown:OfficeAddressTown
                                                     AndOfficeAddressState:OfficeAddressState AndOfficeAddressPostCode:OfficeAddressPostCode
                                                   AndOfficeAddressCountry:OfficeAddressCountry AndProspectEmail:ProspectEmail AndProspectRemark:ProspectRemark AndDateCreated:DateCreated AndDateModified:DateModified AndCreatedBy:CreatedBy AndModifiedBy:ModifiedBy
                                                 AndProspectOccupationCode:ProspectOccupationCode AndProspectDOB:ProspectDOB
                                                            AndExactDuties:ExactDuties AndGroup:ProspectGroup AndTitle:ProspectTitle AndIDTypeNo:IDTypeNo AndOtherIDType:OtherIDType AndOtherIDTypeNo:OtherIDTypeNo AndSmoker:Smoker AndAnnIncome:AnnIncome AndBussType:BussinessType AndRace:Race AndMaritalStatus:MaritalStatus AndReligion:Religion AndNationality:Nationality AndRegistrationNo:registrationNo AndRegistration:registration AndRegistrationDate:registrationDate AndRegistrationExempted:exempted AndProspect_IsGrouping:isGrouping AndCountryOfBirth:COB AndNIP:NIP AndBranchCode:BranchCode AndBranchName:BranchName AndKCU:KCU AndReferralSource:ReferralSource AndReferralName:ReferralName AndIdentitySubmitted:IdentitySubmitted AndIDExpirityDate:IDExpirityDate AndNPWPNo:NPWPNo AndKanwil:Kanwil AndHomeVillage:HomeVillage AndHomeDistrict:HomeDistrict AndHomeProvince:HomeProvicne AndOfficeVillage:OfficeVillage AndOfficeDistrict:OfficeDistrict AndOfficePorvince:OfficeProvicne AndSourceIncome:SourceIncome AndClientSegmentation:ClientSegmentation
                                                                AndtScore:tScore AndProspectLastName:ProspectLastName AndProspectAge:ProspectAge AndPhoneHomeNo:PhoneHomeNo AndPhoneNoHP:PhoneNoHP AndAddress4:Address4 AndKelurahan:Kelurahan AndKecamatan:Kecamatan AndCallStartTime:CallStartTime AndCallEndTime:CallEndTime AndisForeignAdd:isForeignAdd AndProspectStatus:ProspectStatus AndFavorite:Favorite AndRTRW:RTRW
                                      ]];
        
        NSLog(@"Model Prospect Profile - Get prospect profile | id -> %d", ID);
    }
    [results close];
    [database close];
    return ProspectTableData;
}

-(NSMutableArray *)getDataMobileAndPrefix:(NSString *)DataToReturn ProspectTableData:(NSMutableArray *)prospectTableData
{
    NSMutableArray* dataIndex = [[NSMutableArray alloc] init];
    NSMutableArray* dataMobile = [[NSMutableArray alloc] init];
    NSMutableArray* dataPrefix = [[NSMutableArray alloc] init];
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    for (int a=0; a<prospectTableData.count; a++) {
        ProspectProfile *pp = [prospectTableData objectAtIndex:a];
        NSString *querySQL = [NSString stringWithFormat:@"SELECT IndexNo, ContactCode, ContactNo, Prefix FROM contact_input where indexNo = %@ AND ContactCode = 'CONT008'", pp.ProspectID];
        NSLog(@"query %@",querySQL);
        FMResultSet *s = [database executeQuery:querySQL];
        NSLog(@"query q %@",querySQL);
        while ([s next]) {
            NSLog(@"datamobile %@",[s stringForColumn:@"ContactNo"]);
            [dataMobile addObject: [s stringForColumn:@"ContactNo"]];
            [dataPrefix addObject:[s stringForColumn:@"Prefix"]];
            [dataIndex addObject:[s stringForColumn:@"IndexNo"]];
        }
        //[s close];
    }
    [database close];
    if ([DataToReturn isEqualToString:@"Prefix"]){
        return dataPrefix;
    }
    else if ([DataToReturn isEqualToString:@"ContactNo"]){
        return dataMobile;
    }
    else if ([DataToReturn isEqualToString:@"Index"]){
        return dataIndex;
    }

    return dataPrefix;
}

-(NSString *)getDataMobileAndPrefix:(NSString *)ContactCode IndexNo:(NSString *)IndexNo
{
    NSString *MobileNo;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *s = [database executeQuery:@"SELECT IndexNo, ContactCode, ContactNo, Prefix FROM contact_input where indexNo = ? AND ContactCode = ?", IndexNo, ContactCode, Nil];
    
    while ([s next]) {
        if ([[s stringForColumn:@"ContactNo"] length]>0){
            MobileNo = [NSString stringWithFormat:@"%@-%@",[s stringForColumn:@"Prefix"],[s stringForColumn:@"ContactNo"]];
        }
        else{
            MobileNo = [NSString stringWithFormat:@"%@%@",[s stringForColumn:@"Prefix"],[s stringForColumn:@"ContactNo"]];
        }
    }
    
    [results close];
    [database close];
    return MobileNo;
}

-(NSMutableArray *)searchProspectProfileByName:(NSString *)searchName LastName:(NSString *)LastName DOB:(NSString *)dateOfBirth HPNo:(NSString *)HPNo Order:(NSString *)orderBy Method:(NSString *)method ID:(NSString *)IDNumber{
    
    NSString *ProspectID = @"";
    NSString *NickName = @"";
    NSString *ProspectName = @"";
    NSString *ProspectDOB = @"" ;
    NSString *ProspectGender = @"";
    NSString *ResidenceAddress1 = @"";
    NSString *ResidenceAddress2 = @"";
    NSString *ResidenceAddress3 = @"";
    NSString *ResidenceAddressTown = @"";
    NSString *ResidenceAddressState = @"";
    NSString *ResidenceAddressPostCode = @"";
    NSString *ResidenceAddressCountry = @"";
    NSString *OfficeAddress1 = @"";
    NSString *OfficeAddress2 = @"";
    NSString *OfficeAddress3 = @"";
    NSString *OfficeAddressTown = @"";
    NSString *OfficeAddressState = @"";
    NSString *OfficeAddressPostCode = @"";
    NSString *OfficeAddressCountry = @"";
    NSString *ProspectEmail = @"";
    NSString *ProspectOccupationCode = @"";
    NSString *ExactDuties = @"";
    NSString *ProspectRemark = @"";
    //basvi added
    NSString *DateCreated = @"";
    NSString *CreatedBy = @"";
    NSString *DateModified = @"";
    NSString *ModifiedBy = @"";
    //
    NSString *ProspectGroup = @"";
    NSString *ProspectTitle = @"";
    NSString *IDTypeNo = @"";
    NSString *OtherIDType = @"";
    NSString *OtherIDTypeNo = @"";
    NSString *Smoker = @"";
    
    NSString *Race = @"";
    
    NSString *Nationality = @"";
    NSString *MaritalStatus = @"";
    NSString *Religion = @"";
    
    NSString *AnnIncome = @"";
    NSString *BussinessType = @"";
    
    NSString *registration = @"";
    NSString *registrationNo = @"";
    NSString *registrationDate = @"";
    NSString *exempted = @"";
    NSString *isGrouping = @"";
    NSString *COB = @"";
    
    NSString* NIP;
    NSString* BranchCode;
    NSString* BranchName;
    NSString* KCU;
    NSString* ReferralSource;
    NSString* ReferralName;
    NSString* IdentitySubmitted;
    NSString* IDExpirityDate;
    NSString* NPWPNo;
    NSString* Kanwil;
    NSString* HomeVillage;
    NSString* HomeDistrict;
    NSString* HomeProvicne;
    NSString* OfficeVillage;
    NSString* OfficeDistrict;
    NSString* OfficeProvicne;
    NSString* SourceIncome;
    NSString* ClientSegmentation;
    
    NSString *ProspectLastName;
    NSString *ProspectAge;
    NSString* PhoneHomeNo;
    NSString* PhoneNoHP;
    NSString* Address4;
    NSString* Kelurahan;
    NSString* Kecamatan;
    NSString* CallStartTime;
    NSString* CallEndTime;
    NSString* isForeignAdd;
    NSString* ProspectStatus;
    

    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    NSMutableArray* ProspectTableData=[[NSMutableArray alloc]init];
    //results = [database executeQuery:@"SELECT * FROM prospect_profile WHERE QQFlag = 'false'  order by LOWER(ProspectName) ASC LIMIT 20)", Nil];
    FMResultSet *s, *resultQuery;

    NSString *strQuery;
    NSString *addWhere;
    NSString *addAnd;
    BOOL iswhere = NO;
    
    strQuery = @"SELECT * FROM prospect_profile";
    addWhere = @" where";
    addAnd = @" and";
    
    if (![searchName isEqualToString:@""]){
        strQuery = [strQuery stringByAppendingFormat: @"%@", addWhere];
        strQuery = [strQuery stringByAppendingFormat:@" ProspectName like \"%%%@%%\"",searchName];
        iswhere = YES;
    }
    if (![LastName isEqualToString:@""]){
        if (!iswhere) {
            strQuery = [strQuery stringByAppendingFormat: @"%@", addWhere];
            strQuery = [strQuery stringByAppendingFormat:@" ProspectLastName like \"%%%@%%\"",LastName];
            iswhere = YES;
        }
        else {
            strQuery = [strQuery stringByAppendingFormat: @"%@", addAnd];
            strQuery = [strQuery stringByAppendingFormat:@" ProspectLastName like \"%%%@%%\"",LastName];
            iswhere = YES;
        }
    }
    if (![dateOfBirth isEqualToString:@""]){
        if (!iswhere) {
            strQuery = [strQuery stringByAppendingFormat: @"%@", addWhere];
            strQuery = [strQuery stringByAppendingFormat:@" ProspectDOB like \"%%%@%%\"",dateOfBirth];
            iswhere = YES;
        }
        else {
            strQuery = [strQuery stringByAppendingFormat: @"%@", addAnd];
            strQuery = [strQuery stringByAppendingFormat:@" ProspectDOB like \"%%%@%%\"",dateOfBirth];
            iswhere = YES;
        }
    }
    if (![HPNo isEqualToString:@""]){
        if (!iswhere) {
            strQuery = [strQuery stringByAppendingFormat: @"%@", addWhere];
            strQuery = [strQuery stringByAppendingFormat:@" PhoneNoHP like \"%%%@%%\"",HPNo];
            iswhere = YES;
        }
        else {
            strQuery = [strQuery stringByAppendingFormat: @"%@", addAnd];
            strQuery = [strQuery stringByAppendingFormat:@" PhoneNoHP like \"%%%@%%\"",HPNo];
            iswhere = YES;
        }
    }
    
    if (!iswhere) {
        strQuery = [strQuery stringByAppendingFormat: @"%@", addWhere];
        strQuery = [strQuery stringByAppendingFormat:@" QQFlag = 'false'"];
        iswhere = YES;
    }
    else {
        strQuery = [strQuery stringByAppendingFormat: @"%@", addAnd];
        strQuery = [strQuery stringByAppendingFormat:@" QQFlag = 'false'"];
        iswhere = YES;
    }
    
    if ([orderBy isEqualToString:@"DateCreated"]||[orderBy isEqualToString:@"DateModified"]){
         strQuery = [strQuery stringByAppendingFormat: @" order by datetime(%@) %@", orderBy, method];
    }
    else if ([orderBy isEqualToString:@"PhoneNoHP"]){
        strQuery = [strQuery stringByAppendingFormat: @" ORDER BY CAST(`PhoneNoHP` as integer) %@", method];
    }
    else {
         strQuery = [strQuery stringByAppendingFormat: @" order by \"%@\" %@", orderBy, method];
    }
   

    NSLog(@"%@",strQuery);
    
    
    // BHIMBIM'S QUICK FIX - Start
    
    Boolean booleanColumnEmpty = false;
    NSString *stringIDType = @"";
    NSString *stringIDText = @"";
    NSString *stringQuery = @"";
    
    // BHIMBIM'S QUICK FIX - End
    
    
    s = [database executeQuery:[NSString stringWithFormat:@"%@",strQuery]];
    
    while ([s next]) {
        //occpToEnableSection = [results stringForColumn:@"OccpCode"];
        int ID = [s intForColumn:@"IndexNo"];
        ProspectID = [NSString stringWithFormat:@"%i",ID];
        NickName = [s stringForColumn:@"PreferredName"];
        ProspectName = [s stringForColumn:@"ProspectName"];
        ProspectDOB = [s stringForColumn:@"ProspectDOB"]; ;
        ProspectGender = [s stringForColumn:@"ProspectGender"];;
        ResidenceAddress1 = [s stringForColumn:@"ResidenceAddress1"];;
        ResidenceAddress2 = [s stringForColumn:@"ResidenceAddress2"];;
        ResidenceAddress3 = [s stringForColumn:@"ResidenceAddress3"];;
        ResidenceAddressTown = [s stringForColumn:@"ResidenceAddressTown"];;
        ResidenceAddressState = [s stringForColumn:@"ResidenceAddressState"];;
        ResidenceAddressPostCode = [s stringForColumn:@"ResidenceAddressPostCode"];;
        ResidenceAddressCountry = [s stringForColumn:@"ResidenceAddressCountry"];;
        OfficeAddress1 = [s stringForColumn:@"OfficeAddress1"];;
        OfficeAddress2 = [s stringForColumn:@"OfficeAddress2"];;
        OfficeAddress3 = [s stringForColumn:@"OfficeAddress3"];;
        OfficeAddressTown = [s stringForColumn:@"OfficeAddressTown"];;
        OfficeAddressState = [s stringForColumn:@"OfficeAddressState"];;
        OfficeAddressPostCode = [s stringForColumn:@"OfficeAddressPostCode"];;
        OfficeAddressCountry = [s stringForColumn:@"OfficeAddressCountry"];;
        ProspectEmail = [s stringForColumn:@"ProspectEmail"];;
        ProspectOccupationCode = [s stringForColumn:@"ProspectOccupationCode"];;
        ExactDuties = [s stringForColumn:@"ExactDuties"];;
        ProspectRemark = [s stringForColumn:@"ProspectRemark"];;
        //basvi added
        DateCreated = [s stringForColumn:@"DateCreated"];;
        CreatedBy = [s stringForColumn:@"CreatedBy"];;
        DateModified = [s stringForColumn:@"DateModified"];;
        ModifiedBy = [s stringForColumn:@"ModifiedBy"];;
        //
        ProspectGroup = [s stringForColumn:@"ProspectGroup"];;
        ProspectTitle = [s stringForColumn:@"ProspectTitle"];;
        IDTypeNo = [s stringForColumn:@"IDTypeNo"];;
        //OtherIDType = [s stringForColumn:@"OtherIDType"];;
        //OtherIDType = [s stringForColumn:@"IdentityDesc"];
        OtherIDTypeNo = [s stringForColumn:@"OtherIDTypeNo"];;
        
        
        // BHIMBIM'S QUICK FIX - Start
        
        /* INITIALIZATION */
        
        booleanColumnEmpty = [s columnIsNull:@"OtherIDType"];
        stringIDType = @"";
        stringIDText = @"";
        
        if (booleanColumnEmpty == true)
        {
            NSLog(@"Search Prospect Profile By Name - Other id type | code -> null");
        }
        else
        {
            /* GET ID TYPE */
            
            stringIDType = [s stringForColumn:@"OtherIDType"];
            NSLog(@"Search Prospect Profile By Name - Other id type | code -> %@", stringIDType);
            
            /* QUERY TO TABLE IDENTIFICATION - not used */
            
//            stringQuery = [NSString stringWithFormat:@"SELECT IdentityDesc FROM '%@' WHERE DataIdentifier = '%@'", TABLE_IDENTIFICATION, stringIDType];
//            resultQuery = [database executeQuery:stringQuery];
//            
//            while ([resultQuery next])
//            {
//                booleanColumnEmpty = [resultQuery columnIsNull:@"IdentityDesc"];
//                
//                if (booleanColumnEmpty == true)
//                {
//                    NSLog(@"Search Prospect Profile By Name - Other id type | text -> null");
//                }
//                else
//                {
//                    /* GET ID TEXT */
//                    
//                    stringIDText = [resultQuery stringForColumn:@"IdentityDesc"];
//                    NSLog(@"Search Prospect Profile By Name - Other id type | text -> %@", stringIDText);
//                }
//            }
        }
        
        /* RESULT */
        
        OtherIDType = stringIDType;
        
        // BHIMBIM'S QUICK FIX - End
        
        
        Smoker = [s stringForColumn:@"Smoker"];;
        
        Race = [s stringForColumn:@"Race"];;
        
        Nationality = [s stringForColumn:@"Nationality"];;
        MaritalStatus = [s stringForColumn:@"MaritalStatus"];;
        Religion = [s stringForColumn:@"Religion"];;
        
        AnnIncome = [s stringForColumn:@"AnnualIncome"];;
        BussinessType = [s stringForColumn:@"BussinessType"];;
        
        registration = [s stringForColumn:@"GST_registered"];;
        registrationNo = [s stringForColumn:@"GST_registrationNo"];;
        registrationDate = [s stringForColumn:@"GST_registrationDate"];;
        exempted = [s stringForColumn:@"GST_exempted"];
        
        isGrouping = [s stringForColumn:@"Prospect_IsGrouping"];
        COB = [s stringForColumn:@"CountryOfBirth"];
        
        NIP = [s stringForColumn:@"NIP"];
        BranchCode = [s stringForColumn:@"BranchCode"];
        BranchName = [s stringForColumn:@"BranchName"];
        KCU = [s stringForColumn:@"KCU"];
        ReferralSource = [s stringForColumn:@"ReferralSource"];
        ReferralName = [s stringForColumn:@"ReferralName"];
        IdentitySubmitted = [s stringForColumn:@"IdentitySubmitted"];
        IDExpirityDate = [s stringForColumn:@"IDExpirityDate"];
        NPWPNo = [s stringForColumn:@"NPWPNo"];
        Kanwil = [s stringForColumn:@"Kanwil"];
        HomeVillage = [s stringForColumn:@"ResidenceVillage"];
        HomeDistrict = [s stringForColumn:@"ResidenceDistrict"];
        HomeProvicne = [s stringForColumn:@"ResidenceProvince"];
        OfficeVillage = [s stringForColumn:@"OfficeVillage"];
        OfficeDistrict = [s stringForColumn:@"OfficeDistrict"];
        OfficeVillage = [s stringForColumn:@"OfficeProvince"];
        SourceIncome = [s stringForColumn:@"SourceIncome"];
        ClientSegmentation = [s stringForColumn:@"ClientSegmentation"];
        NSString* tScore;
        tScore = [s stringForColumn:@"Score"];
        ProspectLastName = [s stringForColumn:@"ProspectLastName"];
        ProspectAge = [s stringForColumn:@"ProspectAge"];
        PhoneHomeNo = [s stringForColumn:@"PhoneHomeNo"];
        PhoneNoHP = [s stringForColumn:@"PhoneNoHP"];
        Address4 = [s stringForColumn:@"ResidenceAddress4"];
        Kelurahan = [s stringForColumn:@"ResidenceKelurahan"];
        Kecamatan = [s stringForColumn:@"ResidenceKecamatan"];
        CallStartTime = [s stringForColumn:@"CallStartTime"];
        CallEndTime = [s stringForColumn:@"CallEndTime"];
        isForeignAdd = [s stringForColumn:@"isForeignAdd"];
        ProspectStatus = [s stringForColumn:@"ProspectStatus"];
        NSString* Favorite;
        Favorite = [s stringForColumn:@"isFavorite"];
        NSString* RTRW;
        RTRW = [s stringForColumn:@"RTRW"];
        

        [ProspectTableData addObject:[[ProspectProfile alloc] initWithName:NickName AndProspectID:ProspectID AndProspectName:ProspectName
                                                          AndProspecGender:ProspectGender AndResidenceAddress1:ResidenceAddress1
                                                      AndResidenceAddress2:ResidenceAddress2 AndResidenceAddress3:ResidenceAddress3
                                                   AndResidenceAddressTown:ResidenceAddressTown AndResidenceAddressState:ResidenceAddressState
                                               AndResidenceAddressPostCode:ResidenceAddressPostCode AndResidenceAddressCountry:ResidenceAddressCountry
                                                         AndOfficeAddress1:OfficeAddress1 AndOfficeAddress2:OfficeAddress2 AndOfficeAddress3:OfficeAddress3 AndOfficeAddressTown:OfficeAddressTown
                                                     AndOfficeAddressState:OfficeAddressState AndOfficeAddressPostCode:OfficeAddressPostCode
                                                   AndOfficeAddressCountry:OfficeAddressCountry AndProspectEmail:ProspectEmail AndProspectRemark:ProspectRemark AndDateCreated:DateCreated AndDateModified:DateModified AndCreatedBy:CreatedBy AndModifiedBy:ModifiedBy
                                                 AndProspectOccupationCode:ProspectOccupationCode AndProspectDOB:ProspectDOB
                                                            AndExactDuties:ExactDuties AndGroup:ProspectGroup AndTitle:ProspectTitle AndIDTypeNo:IDTypeNo AndOtherIDType:OtherIDType AndOtherIDTypeNo:OtherIDTypeNo AndSmoker:Smoker AndAnnIncome:AnnIncome AndBussType:BussinessType AndRace:Race AndMaritalStatus:MaritalStatus AndReligion:Religion AndNationality:Nationality AndRegistrationNo:registrationNo AndRegistration:registration AndRegistrationDate:registrationDate AndRegistrationExempted:exempted AndProspect_IsGrouping:isGrouping AndCountryOfBirth:COB AndNIP:NIP AndBranchCode:BranchCode AndBranchName:BranchName AndKCU:KCU AndReferralSource:ReferralSource AndReferralName:ReferralName AndIdentitySubmitted:IdentitySubmitted AndIDExpirityDate:IDExpirityDate AndNPWPNo:NPWPNo AndKanwil:Kanwil AndHomeVillage:HomeVillage AndHomeDistrict:HomeDistrict AndHomeProvince:HomeProvicne AndOfficeVillage:OfficeVillage AndOfficeDistrict:OfficeDistrict AndOfficePorvince:OfficeProvicne AndSourceIncome:SourceIncome AndClientSegmentation:ClientSegmentation
                                                                AndtScore:(NSString *)tScore AndProspectLastName:ProspectLastName AndProspectAge:ProspectAge AndPhoneHomeNo:PhoneHomeNo AndPhoneNoHP:PhoneNoHP AndAddress4:Address4 AndKelurahan:Kelurahan AndKecamatan:Kecamatan AndCallStartTime:CallStartTime AndCallEndTime:CallEndTime AndisForeignAdd:isForeignAdd AndProspectStatus:ProspectStatus AndFavorite:Favorite AndRTRW:RTRW
                                      ]];
    }
    [results close];
    [database close];
    return ProspectTableData;
}

-(NSString *)checkDuplicateData:(NSString *)IDType IDNo:(NSString *)IDNo Gender:(NSString *)gender DOB:(NSString *)dob{
    NSString *SINo;
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select IndexNo from prospect_profile where  OtherIDType = \"%@\" and   OtherIDTypeNo = \"%@\" and ProspectDOB = \"%@\" and ProspectGender = \"%@\"",IDType, IDNo,  dob , gender]];
    
    NSLog(@"query %@",[NSString stringWithFormat:@"select IndexNo from prospect_profile where  OtherIDType = \"%@\" and   OtherIDTypeNo = \"%@\" and ProspectDOB = \"%@\" and ProspectGender = \"%@\"",IDType, IDNo,  dob , gender]);
    
    SINo = [NSString stringWithFormat:@"%@",[s stringForColumn:@"IndexNo"]];
    while ([s next]) {
        SINo = [NSString stringWithFormat:@"%@",[s stringForColumn:@"IndexNo"]];
    }
    [results close];
    [database close];
    return SINo;

}

-(BOOL)checkExistingData:(NSString *)FrontName  Gender:(NSString *)gender DOB:(NSString *)dob{
    NSString *SINo;
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    BOOL exist = NO;
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select IndexNo from prospect_profile where  ProspectName like \"%@\"  and ProspectDOB = \"%@\" and ProspectGender = \"%@\"", FrontName,  dob , gender]];
    
    NSLog(@"query %@",[NSString stringWithFormat:@"select IndexNo from prospect_profile where  ProspectName like \"%@\"  and ProspectDOB = \"%@\" and ProspectGender = \"%@\"", FrontName,  dob , gender]);
    
    SINo = [NSString stringWithFormat:@"%@",[s stringForColumn:@"IndexNo"]];
    while ([s next]) {
        SINo = [NSString stringWithFormat:@"%@",[s stringForColumn:@"IndexNo"]];
        exist = YES;
    }
    [results close];
    [database close];
    return exist;
    
}

-(NSMutableArray *)searchProspectProfileByID:(int)prospectID{
    NSString *ProspectID = @"";
    NSString *NickName = @"";
    NSString *ProspectName = @"";
    NSString *ProspectDOB = @"" ;
    NSString *ProspectGender = @"";
    NSString *ResidenceAddress1 = @"";
    NSString *ResidenceAddress2 = @"";
    NSString *ResidenceAddress3 = @"";
    NSString *ResidenceAddressTown = @"";
    NSString *ResidenceAddressState = @"";
    NSString *ResidenceAddressPostCode = @"";
    NSString *ResidenceAddressCountry = @"";
    NSString *OfficeAddress1 = @"";
    NSString *OfficeAddress2 = @"";
    NSString *OfficeAddress3 = @"";
    NSString *OfficeAddressTown = @"";
    NSString *OfficeAddressState = @"";
    NSString *OfficeAddressPostCode = @"";
    NSString *OfficeAddressCountry = @"";
    NSString *ProspectEmail = @"";
    NSString *ProspectOccupationCode = @"";
    NSString *ExactDuties = @"";
    NSString *ProspectRemark = @"";
    //basvi added
    NSString *DateCreated = @"";
    NSString *CreatedBy = @"";
    NSString *DateModified = @"";
    NSString *ModifiedBy = @"";
    //
    NSString *ProspectGroup = @"";
    NSString *ProspectTitle = @"";
    NSString *IDTypeNo = @"";
    NSString *OtherIDType = @"";
    NSString *OtherIDTypeNo = @"";
    NSString *Smoker = @"";
    
    NSString *Race = @"";
    
    NSString *Nationality = @"";
    NSString *MaritalStatus = @"";
    NSString *Religion = @"";
    
    NSString *AnnIncome = @"";
    NSString *BussinessType = @"";
    
    NSString *registration = @"";
    NSString *registrationNo = @"";
    NSString *registrationDate = @"";
    NSString *exempted = @"";
    NSString *isGrouping = @"";
    NSString *COB = @"";
    
    NSString* NIP;
    NSString* BranchCode;
    NSString* BranchName;
    NSString* KCU;
    NSString* ReferralSource;
    NSString* ReferralName;
    NSString* IdentitySubmitted;
    NSString* IDExpirityDate;
    NSString* NPWPNo;
    NSString* Kanwil;
    NSString* HomeVillage;
    NSString* HomeDistrict;
    NSString* HomeProvicne;
    NSString* OfficeVillage;
    NSString* OfficeDistrict;
    NSString* OfficeProvicne;
    NSString* SourceIncome;
    NSString* ClientSegmentation;
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    NSMutableArray* ProspectTableData=[[NSMutableArray alloc]init];
    FMResultSet *s;
        s = [database executeQuery:[NSString stringWithFormat:@"SELECT * FROM prospect_profile WHERE IndexNo = %i and QQFlag = 'false'",prospectID]];
    
    while ([s next]) {
        //occpToEnableSection = [results stringForColumn:@"OccpCode"];
        int ID = [s intForColumn:@"IndexNo"];
        ProspectID = [NSString stringWithFormat:@"%i",ID];
        NickName = [s stringForColumn:@"PreferredName"];
        ProspectName = [s stringForColumn:@"ProspectName"];
        ProspectDOB = [s stringForColumn:@"ProspectDOB"]; ;
        ProspectGender = [s stringForColumn:@"ProspectGender"];;
        ResidenceAddress1 = [s stringForColumn:@"ResidenceAddress1"];;
        ResidenceAddress2 = [s stringForColumn:@"ResidenceAddress2"];;
        ResidenceAddress3 = [s stringForColumn:@"ResidenceAddress3"];;
        ResidenceAddressTown = [s stringForColumn:@"ResidenceAddressTown"];;
        ResidenceAddressState = [s stringForColumn:@"ResidenceAddressState"];;
        ResidenceAddressPostCode = [s stringForColumn:@"ResidenceAddressPostCode"];;
        ResidenceAddressCountry = [s stringForColumn:@"ResidenceAddressCountry"];;
        OfficeAddress1 = [s stringForColumn:@"OfficeAddress1"];;
        OfficeAddress2 = [s stringForColumn:@"OfficeAddress2"];;
        OfficeAddress3 = [s stringForColumn:@"OfficeAddress3"];;
        OfficeAddressTown = [s stringForColumn:@"OfficeAddressTown"];;
        OfficeAddressState = [s stringForColumn:@"OfficeAddressState"];;
        OfficeAddressPostCode = [s stringForColumn:@"OfficeAddressPostCode"];;
        OfficeAddressCountry = [s stringForColumn:@"OfficeAddressCountry"];;
        ProspectEmail = [s stringForColumn:@"ProspectEmail"];;
        ProspectOccupationCode = [s stringForColumn:@"ProspectOccupationCode"];;
        ExactDuties = [s stringForColumn:@"ExactDuties"];;
        ProspectRemark = [s stringForColumn:@"ProspectRemark"];;
        //basvi added
        DateCreated = [s stringForColumn:@"DateCreated"];;
        CreatedBy = [s stringForColumn:@"CreatedBy"];;
        DateModified = [s stringForColumn:@"DateModified"];;
        ModifiedBy = [s stringForColumn:@"ModifiedBy"];;
        //
        ProspectGroup = [s stringForColumn:@"ProspectGroup"];;
        ProspectTitle = [s stringForColumn:@"ProspectTitle"];;
        IDTypeNo = [s stringForColumn:@"IDTypeNo"];;
        OtherIDType = [s stringForColumn:@"OtherIDType"];;
        OtherIDTypeNo = [s stringForColumn:@"OtherIDTypeNo"];;
        Smoker = [s stringForColumn:@"Smoker"];;
        
        Race = [s stringForColumn:@"Race"];;
        
        Nationality = [s stringForColumn:@"Nationality"];;
        MaritalStatus = [s stringForColumn:@"MaritalStatus"];;
        Religion = [s stringForColumn:@"Religion"];;
        
        AnnIncome = [s stringForColumn:@"AnnualIncome"];;
        BussinessType = [s stringForColumn:@"BussinessType"];;
        
        registration = [s stringForColumn:@"GST_registered"];;
        registrationNo = [s stringForColumn:@"GST_registrationNo"];;
        registrationDate = [s stringForColumn:@"GST_registrationDate"];;
        exempted = [s stringForColumn:@"GST_exempted"];
        
        isGrouping = [s stringForColumn:@"Prospect_IsGrouping"];
        COB = [s stringForColumn:@"CountryOfBirth"];
        
        NIP = [s stringForColumn:@"NIP"];
        BranchCode = [s stringForColumn:@"BranchCode"];
        BranchName = [s stringForColumn:@"BranchName"];
        KCU = [s stringForColumn:@"KCU"];
        ReferralSource = [s stringForColumn:@"ReferralSource"];
        ReferralName = [s stringForColumn:@"ReferralName"];
        IdentitySubmitted = [s stringForColumn:@"IdentitySubmitted"];
        IDExpirityDate = [s stringForColumn:@"IDExpirityDate"];
        NPWPNo = [s stringForColumn:@"NPWPNo"];
        Kanwil = [s stringForColumn:@"Kanwil"];
        HomeVillage = [s stringForColumn:@"ResidenceVillage"];
        HomeDistrict = [s stringForColumn:@"ResidenceDistrict"];
        HomeProvicne = [s stringForColumn:@"ResidenceProvince"];
        OfficeVillage = [s stringForColumn:@"OfficeVillage"];
        OfficeDistrict = [s stringForColumn:@"OfficeDistrict"];
        OfficeVillage = [s stringForColumn:@"OfficeProvince"];
        SourceIncome = [s stringForColumn:@"SourceIncome"];
        ClientSegmentation = [s stringForColumn:@"ClientSegmentation"];
        
        NSString* tScore;
        NSString *ProspectLastName;
        NSString *ProspectAge;
        NSString* PhoneHomeNo;
        NSString* PhoneNoHP;
        NSString* Address4;
        NSString* Kelurahan;
        NSString* Kecamatan;
        NSString* CallStartTime;
        NSString* CallEndTime;
        NSString* isForeignAdd;
        NSString* ProspectStatus;
        
        tScore = [s stringForColumn:@"Score"];
        ProspectLastName = [s stringForColumn:@"ProspectLastName"];
        ProspectAge = [s stringForColumn:@"ProspectAge"];
        PhoneHomeNo = [s stringForColumn:@"PhoneHomeNo"];
        PhoneNoHP = [s stringForColumn:@"PhoneNoHP"];
        Address4 = [s stringForColumn:@"ResidenceAddress4"];
        Kelurahan = [s stringForColumn:@"ResidenceKelurahan"];
        Kecamatan = [s stringForColumn:@"ResidenceKecamatan"];
        CallStartTime = [s stringForColumn:@"CallStartTime"];
        CallEndTime = [s stringForColumn:@"CallEndTime"];
        isForeignAdd = [s stringForColumn:@"isForeignAdd"];
        ProspectStatus = [s stringForColumn:@"ProspectStatus"];
        NSString* Favorite;
        Favorite = [s stringForColumn:@"isFavorite"];
        NSString* RTRW;
        RTRW = [s stringForColumn:@"RTRW"];

        
        
        [ProspectTableData addObject:[[ProspectProfile alloc] initWithName:NickName AndProspectID:ProspectID AndProspectName:ProspectName
                                                          AndProspecGender:ProspectGender AndResidenceAddress1:ResidenceAddress1
                                                      AndResidenceAddress2:ResidenceAddress2 AndResidenceAddress3:ResidenceAddress3
                                                   AndResidenceAddressTown:ResidenceAddressTown AndResidenceAddressState:ResidenceAddressState
                                               AndResidenceAddressPostCode:ResidenceAddressPostCode AndResidenceAddressCountry:ResidenceAddressCountry
                                                         AndOfficeAddress1:OfficeAddress1 AndOfficeAddress2:OfficeAddress2 AndOfficeAddress3:OfficeAddress3 AndOfficeAddressTown:OfficeAddressTown
                                                     AndOfficeAddressState:OfficeAddressState AndOfficeAddressPostCode:OfficeAddressPostCode
                                                   AndOfficeAddressCountry:OfficeAddressCountry AndProspectEmail:ProspectEmail AndProspectRemark:ProspectRemark AndDateCreated:DateCreated AndDateModified:DateModified AndCreatedBy:CreatedBy AndModifiedBy:ModifiedBy
                                                 AndProspectOccupationCode:ProspectOccupationCode AndProspectDOB:ProspectDOB
                                                            AndExactDuties:ExactDuties AndGroup:ProspectGroup AndTitle:ProspectTitle AndIDTypeNo:IDTypeNo AndOtherIDType:OtherIDType AndOtherIDTypeNo:OtherIDTypeNo AndSmoker:Smoker AndAnnIncome:AnnIncome AndBussType:BussinessType AndRace:Race AndMaritalStatus:MaritalStatus AndReligion:Religion AndNationality:Nationality AndRegistrationNo:registrationNo AndRegistration:registration AndRegistrationDate:registrationDate AndRegistrationExempted:exempted AndProspect_IsGrouping:isGrouping AndCountryOfBirth:COB AndNIP:NIP AndBranchCode:BranchCode AndBranchName:BranchName AndKCU:KCU AndReferralSource:ReferralSource AndReferralName:ReferralName AndIdentitySubmitted:IdentitySubmitted AndIDExpirityDate:IDExpirityDate AndNPWPNo:NPWPNo AndKanwil:Kanwil AndHomeVillage:HomeVillage AndHomeDistrict:HomeDistrict AndHomeProvince:HomeProvicne AndOfficeVillage:OfficeVillage AndOfficeDistrict:OfficeDistrict AndOfficePorvince:OfficeProvicne AndSourceIncome:SourceIncome AndClientSegmentation:ClientSegmentation
                                                                AndtScore:tScore AndProspectLastName:ProspectLastName AndProspectAge:ProspectAge AndPhoneHomeNo:PhoneHomeNo AndPhoneNoHP:PhoneNoHP AndAddress4:Address4 AndKelurahan:Kelurahan AndKecamatan:Kecamatan AndCallStartTime:CallStartTime AndCallEndTime:CallEndTime AndisForeignAdd:isForeignAdd AndProspectStatus:ProspectStatus AndFavorite:Favorite AndRTRW:RTRW
                                                                ]];
    }
    [results close];
    [database close];
    return ProspectTableData;
}

-(NSMutableArray *)getColumnNames:(NSString *)stringTableName{
    NSMutableArray *arrayColumnNames = [[NSMutableArray alloc]init];
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *s;
    s = [database executeQuery:[NSString stringWithFormat:@"PRAGMA table_info(%@)",stringTableName]];
    
    while ([s next]) {
        //occpToEnableSection = [results stringForColumn:@"OccpCode"];
        [arrayColumnNames addObject:[s stringForColumn:@"name"]];
    }
    [results close];
    [database close];
    return arrayColumnNames;
}

-(NSMutableArray *)getColumnValue:(NSString *)stringProspectID ColumnCount:(int)intColumnCount{
    NSMutableArray *arrayColumnValue = [[NSMutableArray alloc]init];
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *s;
    s = [database executeQuery:[NSString stringWithFormat:@"select * from prospect_profile where IndexNo=%i",[stringProspectID intValue]]];
    
    while ([s next]) {
        //[arrayColumnNames addObject:[s stringForColumn:@"name"]];
        for (int i=0;i<intColumnCount;i++){
            NSString* stringResult  = [s stringForColumnIndex:i];
            if ([stringResult isEqualToString:@"(null)"]){
                stringResult = @"";
            }
            [arrayColumnValue addObject:stringResult?stringResult:@""];
            NSLog(@"column %i value %@",i,[s stringForColumnIndex:i]);
        }
    }
    [results close];
    [database close];
    return arrayColumnValue;
}

-(NSString *)selectProspectData:(NSString *)stringColumnName ProspectIndex:(int)intIndexNo{
    NSString *stringReturn;
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select %@ from prospect_profile where IndexNo = %i",stringColumnName,intIndexNo]];
    while ([s next]) {
        stringReturn = [s stringForColumn:stringColumnName];
    }
    
    [results close];
    [database close];
    return stringReturn;
}

-(NSString *)RecalculateScore {
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: DATABASE_MAIN_NAME];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    NSString *ProspectID;
    NSString *ProspectDOB;
    NSString *ProspectAge;
    int oldAge;
    int Score;
    int NewScore;
    
    NSString *query = [NSString stringWithFormat:@"SELECT IndexNo, ProspectDOB, prospectAge, Score FROM prospect_profile  WHERE QQFlag = 'false'"];
    FMResultSet *s = [database executeQuery:query];
    while ([s next]) {

        int ID = [s intForColumn:@"IndexNo"];
        ProspectID = [NSString stringWithFormat:@"%i",ID];
//        Age = [s intForColumn:]
        ProspectDOB = [s stringForColumn:@"ProspectDOB"];
        Score = [s intForColumn:@"Score"];
        ProspectAge = [s stringForColumn:@"ProspectAge"];
        oldAge = [ProspectAge intValue];
        
        NewScore = 0;
        newAge = 0;
        
        if (![ProspectDOB isEqualToString:@""]) {
            NewScore = [self calculateAge:ProspectDOB OldAge:oldAge OldScore:Score];
//            NSLog(@"%d, oldScore %d", NewScore, Score);
            if (NewScore != Score) {
                NSString *queryB = [NSString stringWithFormat:@"UPDATE prospect_profile SET prospectAge = '%d', Score = '%d' WHERE IndexNo = '%@'", newAge, NewScore, ProspectID];
                [database executeUpdate:queryB];
                
            }
        }
        
    }
    
   return @"";
}

-(int)calculateAge:(NSString *)DOBdate OldAge:(int)OldAge OldScore:(int)OldScore
{
//    BOOL toUpdate = NO;
    
    
    int newScore;
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *DOB2 = [dateFormatter dateFromString:DOBdate];
    int time = [todayDate timeIntervalSinceDate:DOB2];
    int allDays = (((time/60)/60)/24);
    int days = allDays%365;
    int years = (allDays-days)/365;
    newAge = years;
    
    if (newAge == OldAge) {
        newScore = OldScore;
    }
    else {
        newScore = [self CheckNewScore:newAge OldAge:OldAge score:OldScore];
        if (newScore == OldScore) {
            newScore = OldScore;
        }
    }
    
    return newScore;
}

-(int)CheckNewScore:(int)newAge OldAge:(int)OldAge score:(int)score {
    
//    NSLog(@"%d, oldScore %d", NewScore, Score);
   //minus old score
    if (OldAge > 35 && OldAge < 46) {
        score = score - 5;
    }
    else if (OldAge > 45 && OldAge < 56) {
        score = score - 4;
    }
    else if (OldAge > 55) {
        score = score - 3;
    }
    else if (OldAge >25 && OldAge < 36) {
        score = score - 2;
    }
    else if (OldAge > 17 && OldAge < 26) {
        score = score - 1;
    }
    
    //Add new score
    
    if (newAge > 35 && newAge < 46) {
        score = score + 5;
    }
    else if (newAge > 45 && newAge < 56) {
        score = score + 4;
    }
    else if (newAge > 55) {
        score = score + 3;
    }
    else if (newAge >25 && newAge < 36) {
        score = score + 2;
    }
    else if (newAge > 17 && newAge < 26) {
        score = score + 1;
    }
    
   
    return score;
}


// BHIMBIM'S QUICK FIX - Start

-(int) calculateAge:(NSString *)DOBdate
{
    /* NSDate *todayDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *DOB2 = [dateFormatter dateFromString:DOBdate];
    int time = [todayDate timeIntervalSinceDate:DOB2];
    int allDays = (((time/60)/60)/24);
    int days = allDays%365;
    int years = (allDays-days)/365; */
    
    // NSLog(@"You live since %i years and %i days",years,days);
    
    
    // BHIMBIM'S QUICK FIX - Start, i don't know whose code before, but it detect via second, which is theres a limit fonr integer.
    
    NSDate* dateNow = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *dateBirth = [dateFormatter dateFromString:DOBdate];
    
    NSDateComponents* dateComponentsYear =
    [
        [NSCalendar currentCalendar]
        components:NSCalendarUnitYear
        fromDate:dateBirth
        toDate:dateNow
        options:0
    ];
    
    NSDateComponents* dateComponentsMonth =
    [
        [NSCalendar currentCalendar]
        components:NSCalendarUnitMonth
        fromDate:dateBirth
        toDate:dateNow
        options:0
    ];
    
    int intAge = [dateComponentsYear year];
    int intMonth = [dateComponentsMonth month];
    
    if(intMonth%12 > 5)
    {
        intAge += 1;
    }
    else
    {
        
    }
    
    // BHIMBIM'S QUICK FIX - End
    
    
    // age = years;
    return intAge;
}

-(NSArray *) calculateScore:(ProspectProfile *)prospectProfile
{
    // BHIMBIM'S QUICK FIX - Start, I don't know whose code is this, but i add some protection regarding dupplicate data and missformated value and i didn't change your current variable name, i also add some log to easily detect the scoring mistake.
    // UPDATE -> i rewrite the function.
    
    /* INITIALIZATION */
    
    NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *stringDirectoryPath = [arrayPaths objectAtIndex:0];
    NSString *stringDatabasePath = [stringDirectoryPath stringByAppendingPathComponent:DATABASE_MAIN_NAME];
    FMDatabase *database = [FMDatabase databaseWithPath:stringDatabasePath];
    [database open];
    FMResultSet *result;
    
    Boolean booleanColumnEmpty = false;
    NSString *stringInputValue = @"";
    NSString *stringQuery = @"";
    NSString *stringStatus = @"";
    int intAccumulatePoin = 0;
    int intPoin = 0;
    int intAge = 0;
    int intComplete = 0;
    
    
    /* AGE */
    
    if (![prospectProfile.ProspectDOB isEqualToString:@""] || prospectProfile.ProspectDOB != NULL || prospectProfile.ProspectDOB != nil)
    {
        /* INITIALIZATION */
        
        intAge = [self calculateAge:prospectProfile.ProspectDOB];
        intPoin = 0;
        stringInputValue = @"";
        intComplete += 1;
        
        /* CONDITION */
        
        if (intAge > 35 && intAge < 46)
        {
            intPoin = 5;
            stringInputValue = @"35 < age < 45";
        }
        else if (intAge >45 && intAge < 56)
        {
            intPoin = 4;
            stringInputValue = @"45 < age < 56";
        }
        else if (intAge > 55)
        {
            intPoin =  3;
            stringInputValue = @"35 < age < 45";
        }
        else if (intAge > 25 && intAge < 36)
        {
            intPoin = 2;
            stringInputValue = @"25 < age < 36";
        }
        else if (intAge > 16 && intAge < 26)
        {
            intPoin = 1;
            stringInputValue = @"17 < age < 26";
        }
        else
        {
            intComplete -= 1;
        }
        
        /* RESULT */
        
        intAccumulatePoin += intPoin;
        NSLog(@"Calculate Score - Age | name -> %@, point -> %d, accumulate point -> %d, complete -> %d", stringInputValue, intPoin, intAccumulatePoin, intComplete);
    }
    
    
    /* GENDER */
    
    stringInputValue = @"";
    intPoin = 0;
    
    /* CONDITION */
    
    if (![prospectProfile.ProspectGender isEqualToString:@""] || prospectProfile.ProspectGender != NULL || prospectProfile.ProspectGender != nil)
    {
        if ([prospectProfile.ProspectGender isEqualToString:@"FEMALE"] == true)
        {
            intPoin = 1;
            stringInputValue = prospectProfile.ProspectGender;
        }
        else
        {
            intPoin = 2;
            stringInputValue = prospectProfile.ProspectGender;
        }
        
        intComplete += 1;
    }
    else
    {
        
    }
    
    /* RESULT */
    
    intAccumulatePoin += intPoin;
    NSLog(@"Calculate Score - Gender | name -> %@, point -> %d, accumulate point -> %d, complete -> %d", stringInputValue, intPoin, intAccumulatePoin, intComplete);
    
    
    /* MARITAL STATUS */
    
    if (![prospectProfile.MaritalStatus isEqualToString:@""] || prospectProfile.MaritalStatus != NULL || prospectProfile.MaritalStatus != nil)
    {
        /* INITIALIZATION */
        
        booleanColumnEmpty = false;
        result = nil;
        
        /* QUERY */
        
        stringQuery = [NSString stringWithFormat:@"SELECT Poin FROM '%@' WHERE MSDesc = '%@'", TABLE_MARITAL_STATUS, prospectProfile.MaritalStatus];
        result = [database executeQuery:stringQuery];
        intPoin = 0;
        
        while ([result next])
        {
            booleanColumnEmpty = [result columnIsNull:@"Poin"];
            
            if (booleanColumnEmpty == true)
            {
                NSLog(@"Calculate Score - Marital status | poin -> null");
            }
            else
            {
                intPoin = [[result objectForColumnName:@"Poin"] intValue];
                NSLog(@"Calculate Score - Marital status | poin -> %d", intPoin);
                intComplete += 1;
                break;
            }
        }
        
        /* RESULT */
        
        intAccumulatePoin += intPoin;
        NSLog(@"Calculate Score - Marital status | name -> %@, point -> %d, accumulate point -> %d, complete -> %d", prospectProfile.MaritalStatus, intPoin, intAccumulatePoin, intComplete);
    }
    
    
    /* ANNUAL INCOME */
    
    if (![prospectProfile.AnnualIncome isEqualToString:@""] || prospectProfile.AnnualIncome != NULL || prospectProfile.AnnualIncome != nil)
    {
        /* INITIALIZATION */
        
        booleanColumnEmpty = false;
        result = nil;
        
        /* QUERY */
        
        stringQuery = [NSString stringWithFormat:@"SELECT Poin FROM '%@' WHERE AnnDesc = '%@'",  TABLE_EPROPOSAL_ANNUALINCOME,prospectProfile.AnnualIncome];
        result = [database executeQuery: stringQuery];
        intPoin = 0;
        
        while ([result next])
        {
            booleanColumnEmpty = [result columnIsNull:@"Poin"];
            
            if (booleanColumnEmpty == true)
            {
                NSLog(@"Calculate Score - Annual income | poin -> null");
            }
            else
            {
                intPoin = [[result objectForColumnName:@"Poin"] intValue];
                NSLog(@"Calculate Score - Annual income | poin -> %d", intPoin);
                intComplete += 1;
                break;
            }
        }
        
        /* RESULT */
        
        intAccumulatePoin += intPoin;
        NSLog(@"Calculate Score - Annual income | name -> %@, point -> %d, accumulate point -> %d, complete -> %d", prospectProfile.AnnualIncome, intPoin, intAccumulatePoin, intComplete);
    }
    
    
    /* SOURCE INCOME */
    
    if (![prospectProfile.SourceIncome isEqualToString:@""] || prospectProfile.SourceIncome != NULL || prospectProfile.SourceIncome != nil)
    {
        /* INITIALIZATION */
        
        booleanColumnEmpty = false;
        result = nil;
        
        /* QUERY */
        
        stringQuery = [NSString stringWithFormat:@"SELECT Poin FROM '%@' WHERE SourceDesc = '%@'",  TABLE_SOURCEINCOME, prospectProfile.SourceIncome];
        result = [database executeQuery: stringQuery];
        intPoin = 0;
        
        while ([result next])
        {
            booleanColumnEmpty = [result columnIsNull:@"Poin"];
            
            if (booleanColumnEmpty == true)
            {
                NSLog(@"Calculate Score - Source income | poin -> null");
            }
            else
            {
                intPoin = [[result objectForColumnName:@"Poin"] intValue];
                NSLog(@"Calculate Score - Source income | poin -> %d", intPoin);
                intComplete += 1;
                break;
            }
        }
        
        /* RESULT */
        
        intAccumulatePoin += intPoin;
        NSLog(@"Calculate Score - Source income | name -> %@, point -> %d, accumulate point -> %d, complete -> %d", prospectProfile.SourceIncome, intPoin, intAccumulatePoin, intComplete);
    }
    
    
    /* OCUUPATION */
    
    if (![prospectProfile.ProspectOccupationCode isEqualToString:@""] || prospectProfile.ProspectOccupationCode != NULL || prospectProfile.ProspectOccupationCode != nil)
    {
        /* INITIALIZATION */
        
        booleanColumnEmpty = false;
        result = nil;
        
        /* QUERY */
        
        stringQuery = [NSString stringWithFormat:@"SELECT Poin FROM '%@' WHERE Occp_Code = '%@'", TABLE_OCCP, prospectProfile.ProspectOccupationCode];
        result = [database executeQuery: stringQuery];
        intPoin = 0;
        
        while ([result next])
        {
            booleanColumnEmpty = [result columnIsNull:@"Poin"];
            
            if (booleanColumnEmpty == true)
            {
                NSLog(@"Calculate Score - Occupation | poin -> null");
            }
            else
            {
                intPoin = [[result objectForColumnName:@"Poin"] intValue];
                NSLog(@"Calculate Score - Occupation | poin -> %d", intPoin);
                intComplete += 1;
                break;
            }
        }
        
        /* RESULT */
        
        intAccumulatePoin += intPoin;
        NSLog(@"Calculate Score - Occupation | name -> %@, point -> %d, accumulate point -> %d, complete -> %d", prospectProfile.ProspectOccupationCode, intPoin, intAccumulatePoin, intComplete);
    }
    
    
    /* REFERENCE */
    
    if (![prospectProfile.ReferralName isEqualToString:@""] || prospectProfile.ReferralName != NULL || prospectProfile.ReferralName != nil)
    {
        /* INITIALIZATION */
        
        booleanColumnEmpty = false;
        result = nil;
        
        /* QUERY */
        
        stringQuery = [NSString stringWithFormat:@"SELECT Poin FROM '%@' WHERE ReferDesc = '%@'", TABLE_REFERRALSOURCE, prospectProfile.ReferralName];
        result = [database executeQuery: stringQuery];
        intPoin = 0;
        
        while ([result next])
        {
            booleanColumnEmpty = [result columnIsNull:@"Poin"];
            
            if (booleanColumnEmpty == true)
            {
                NSLog(@"Calculate Score - Referral name | poin -> null");
            }
            else
            {
                intPoin = [[result objectForColumnName:@"Poin"] intValue];
                NSLog(@"Calculate Score - Referral name | poin -> %d", intPoin);
                intComplete += 1;
                break;
            }
        }
        
        /* RESULT */
        
        intAccumulatePoin += intPoin;
        NSLog(@"Calculate Score - Referral name | name -> %@, point -> %d, accumulate point -> %d, complete -> %d", prospectProfile.ReferralName, intPoin, intAccumulatePoin, intComplete);
    }
    else
    {
        
    }
    
    
    /* NEW PROSPECT */
    
    intAccumulatePoin += 1;
    intComplete += 1;
    
    NSLog(@"Calculate Score - New prospect | accumulate point -> %d, complete -> %d", intAccumulatePoin, intComplete);
    
    
    /* COMPLETE CHECK */
    
    if (intComplete == 8)
    {
        stringStatus = @"Complete";
    }
    else
    {
        stringStatus = @"Incomplete";
    }
    
    NSLog(@"Calculate Score - Status | complete status -> %@", stringStatus);
    
    
    /* RESULT */
    
    [result close];
    [database close];
    NSArray *arrayResult = @[[NSString stringWithFormat:@"%i", intAccumulatePoin], stringStatus];
    
    // BHIMBIMS'S QUICK FIX - End
    
    
    return arrayResult;
}

// BHIMBIM'S QUICK FIX - End


- (void) recalculateScore
{
    // BHIMBIM'S QUICK FIX - Start, I don't know whose code is this, but i add some protection regarding dupplicate data and missformated value and i didn't change your current variable name, i also add some log to easily detect the scoring mistake.
    // UPDATE -> i rewrite the function.
    
    /* INITIALIZATION */
    
    NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *stringDirectoryPath = [arrayPaths objectAtIndex:0];
    NSString *stringDatabasePath = [stringDirectoryPath stringByAppendingPathComponent:DATABASE_MAIN_NAME];
    FMDatabase *database = [FMDatabase databaseWithPath:stringDatabasePath];
    [database open];
    FMResultSet *result;
    
    Boolean booleanColumnEmpty = false;
    NSString *stringQuerySelect = @"";
    NSString *stringValue = @"";
    NSString *stringQueryUpdate = @"";
    
    
    /* QUERY */
    
    stringQuerySelect = [NSString stringWithFormat:@"SELECT * FROM '%@'", TABLE_PROSPECT];
    result = [database executeQuery: stringQuerySelect];

    while ([result next])
    {
        ProspectProfile *prospectProfile = [[ProspectProfile alloc] init];
        
        /* ID */
        
        booleanColumnEmpty = [result columnIsNull:@"IndexNo"];
        [prospectProfile setProspectID: @""];
        
        if (booleanColumnEmpty == true)
        {
            NSLog(@"Recalculate Score - Prospect profile | id -> null");
        }
        else
        {
            stringValue = [result stringForColumn:@"IndexNo"];
            NSLog(@"Recalculate Score - Prospect profile | id -> %@", stringValue);
        }
        
        [prospectProfile setProspectID:stringValue];
        
        /* DATE OF BIRTH */
        
        booleanColumnEmpty = [result columnIsNull:@"ProspectDOB"];
        stringValue = @"";
        
        if (booleanColumnEmpty == true)
        {
            NSLog(@"Recalculate Score - Prospect profile | date of birth -> null");
        }
        else
        {
            stringValue = [result stringForColumn:@"ProspectDOB"];
            NSLog(@"Recalculate Score - Prospect profile | date of birth -> %@", stringValue);
        }
        
        [prospectProfile setProspectDOB:stringValue];
        
        /* GENDER */
        
        booleanColumnEmpty = [result columnIsNull:@"ProspectGender"];
        stringValue = @"";
        
        if (booleanColumnEmpty == true)
        {
            NSLog(@"Recalculate Score - Prospect profile | gender -> null");
        }
        else
        {
            stringValue = [result stringForColumn:@"ProspectGender"];
            NSLog(@"Recalculate Score - Prospect profile | gender -> %@", stringValue);
        }
        
        [prospectProfile setProspectGender:stringValue];
        
        /* MARITAL STATUS */
        
        booleanColumnEmpty = [result columnIsNull:@"MaritalStatus"];
        stringValue = @"";
        
        if (booleanColumnEmpty == true)
        {
            NSLog(@"Recalculate Score - Prospect profile | marital status -> null");
        }
        else
        {
            stringValue = [result stringForColumn:@"MaritalStatus"];
            NSLog(@"Recalculate Score - Prospect profile | marital status -> %@", stringValue);
        }
        
        [prospectProfile setMaritalStatus:stringValue];
        
        /* ANNUAL INCOME */
        
        booleanColumnEmpty = [result columnIsNull:@"AnnualIncome"];
        stringValue = @"";
        
        if (booleanColumnEmpty == true)
        {
            NSLog(@"Recalculate Score - Prospect profile | annual income -> null");
        }
        else
        {
            stringValue = [result stringForColumn:@"AnnualIncome"];
            NSLog(@"Recalculate Score - Prospect profile | annual income -> %@", stringValue);
        }
        
        [prospectProfile setAnnualIncome:stringValue];
        
        /* SOURCE INCOME */
        
        booleanColumnEmpty = [result columnIsNull:@"SourceIncome"];
        stringValue = @"";
        
        if (booleanColumnEmpty == true)
        {
            NSLog(@"Recalculate Score - Prospect profile | source income -> null");
        }
        else
        {
            stringValue = [result stringForColumn:@"SourceIncome"];
            NSLog(@"Recalculate Score - Prospect profile | source income -> %@", stringValue);
        }
        
        [prospectProfile setSourceIncome:stringValue];
        
        /* OCCUPATION */
        
        booleanColumnEmpty = [result columnIsNull:@"ProspectOccupationCode"];
        stringValue = @"";
        
        if (booleanColumnEmpty == true)
        {
            NSLog(@"Recalculate Score - Prospect profile | occupation -> null");
        }
        else
        {
            stringValue = [result stringForColumn:@"ProspectOccupationCode"];
            NSLog(@"Recalculate Score - Prospect profile | occupation -> %@", stringValue);
        }
        
        [prospectProfile setProspectOccupationCode:stringValue];
        
        /* REFERRAL */
        
        booleanColumnEmpty = [result columnIsNull:@"ReferralName"];
        stringValue = @"";
        
        if (booleanColumnEmpty == true)
        {
            NSLog(@"Recalculate Score - Prospect profile | referral name -> null");
        }
        else
        {
            stringValue = [result stringForColumn:@"ReferralName"];
            NSLog(@"Recalculate Score - Prospect profile | referral name -> %@", stringValue);
        }
        
        [prospectProfile setReferralName:stringValue];
        
        /* RESULT */
        
        [prospectProfile setTScore: [[self calculateScore:prospectProfile] objectAtIndex:0]];
        [prospectProfile setProspectAge: [NSString stringWithFormat:@"%i", [self calculateAge:prospectProfile.ProspectDOB]]];
        
        stringQueryUpdate =
        [NSString stringWithFormat:
         @"UPDATE '%@' set \"ProspectAge\"=\'%@\', \"Score\"=\"%@\" where IndexNo = \"%@\"", TABLE_PROSPECT, prospectProfile.ProspectAge, prospectProfile.tScore, prospectProfile.ProspectID];
        NSLog(@"Recalculate Score - Update SQL | query -> %@", stringQueryUpdate);
        
        [database executeUpdate:stringQueryUpdate];
    }
    
    
    /* CLOSING */

    [result close];
    [database close];
    
    // BHIMBIMS'S QUICK FIX - End
}


@end

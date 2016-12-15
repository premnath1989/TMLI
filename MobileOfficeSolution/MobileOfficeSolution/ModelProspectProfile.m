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
    //NSString *path = [docsPath stringByAppendingPathComponent:@"MOSDB.sqlite"];
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    NSMutableArray* ProspectTableData=[[NSMutableArray alloc]init];
    //results = [database executeQuery:@"SELECT * FROM prospect_profile WHERE QQFlag = 'false'  order by LOWER(ProspectName) ASC LIMIT 20)", Nil];
    //FMResultSet *s = [database executeQuery:@"SELECT * FROM prospect_profile WHERE QQFlag = 'false'  order by DateModified DESC LIMIT 20"];
    NSString *query = [NSString stringWithFormat:@"SELECT pp.*,ep.* FROM prospect_profile pp left join %@ ep on pp.OtherIDType=ep.IdentityCode or pp.OtherIDType=ep.DataIdentifier  WHERE QQFlag = 'false' order by isFavorite DESC, Score DESC,  DateModified DESC ",TABLE_IDENTIFICATION];
    FMResultSet *s = [database executeQuery:query];
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
        OtherIDType = [s stringForColumn:@"IdentityDesc"];
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
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
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
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
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
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    NSMutableArray* ProspectTableData=[[NSMutableArray alloc]init];
    //results = [database executeQuery:@"SELECT * FROM prospect_profile WHERE QQFlag = 'false'  order by LOWER(ProspectName) ASC LIMIT 20)", Nil];
    FMResultSet *s;

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
        OtherIDType = [s stringForColumn:@"IdentityDesc"];
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

-(NSString *)checkDuplicateData:(NSString *)Name Gender:(NSString *)gender DOB:(NSString *)dob{
    NSString *SINo;
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *s = [database executeQuery:[NSString stringWithFormat:@"select IndexNo from prospect_profile where ProspectName = \"%@\"and ProspectDOB = \"%@\" and ProspectGender = \"%@\"",Name,dob,gender]];
    
    NSLog(@"query %@",[NSString stringWithFormat:@"select IndexNo from prospect_profile where ProspectName = \"%@\"and ProspectDOB = \"%@\" and ProspectGender = \"%@\"",Name,dob,gender]);
    
    SINo = [NSString stringWithFormat:@"%@",[s stringForColumn:@"IndexNo"]];
    while ([s next]) {
        SINo = [NSString stringWithFormat:@"%@",[s stringForColumn:@"IndexNo"]];
    }
    [results close];
    [database close];
    return SINo;

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
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
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
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
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
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
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
    NSString *path = [docsDir stringByAppendingPathComponent: @"MOSDB.sqlite"];
    
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

@end

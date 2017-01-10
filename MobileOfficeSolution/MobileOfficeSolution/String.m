//
//  Rule.m
//  Practice
//
//  Created by Ibrahim on 20/05/2016.
//  Copyright © 2016 Ibrahim. All rights reserved.
//


// IMPORT

#import "String.h"


// IMPLEMENTATION

    // CHARACTER

    NSString* const CHARACTER_DASH = @" ";
    NSString* const CHARACTER_KRES = @"#";
    NSString* const CHARACTER_DOUBLEDOT = @" : ";

    // ENTITY

    NSString* const SPAJHEADER_PRODUCT_HERITAGE = @"Heritage";
    NSString* const SPAJHEADER_PRODUCT_KELUARGAKU = @"Keluargaku";
    NSString* const SPAJHEADER_STATE_PENDING = @"Pending";
    NSString* const SPAJHEADER_STATE_SUBMITTED = @"Submitted";
    NSString* const SPAJHEADER_STATE_COMPLETED = @"Completed";
    NSString* const SPAJHEADER_STATE_ONPROGRESS = @"On Progress";
    NSString* const SPAJHEADER_STATE_READY = @"Ready";

    // COREDATA

    NSString* const COREDATA_SEPARATOR = @" // ";
    NSString* const COREDATA_EQUALS = @" == %@";
    NSString* const COREDATA_CONTAINS = @" CONTAINS[cd] %@";

    NSString* const TABLE_NAME_SPAJHEADER = @"SPAJHeader";
    NSString* const COLUMN_SPAJHEADER_ID = @"id";
    NSString* const COLUMN_SPAJHEADER_NAME = @"name";
    NSString* const COLUMN_SPAJHEADER_SOCIALNUMBER = @"socialnumber";
    NSString* const COLUMN_SPAJHEADER_EAPPLICATIONNUMBER = @"eapplicationnumber";
    NSString* const COLUMN_SPAJHEADER_SPAJNUMBER = @"spajnumber";
    NSString* const COLUMN_SPAJHEADER_PRODUCTID = @"productid";
    NSString* const COLUMN_SPAJHEADER_ILLUSTRATIONID = @"illustrationid";
    NSString* const COLUMN_SPAJHEADER_CREATEDBY = @"createdby";
    NSString* const COLUMN_SPAJHEADER_CREATEDON = @"createdon";
    NSString* const COLUMN_SPAJHEADER_UPDATEDBY = @"updatedby";
    NSString* const COLUMN_SPAJHEADER_UPDATEDON = @"updatedon";
    NSString* const COLUMN_SPAJHEADER_SUBMITTEDBY = @"submittedby";
    NSString* const COLUMN_SPAJHEADER_SUBMITTEDON = @"submittedon";
    NSString* const COLUMN_SPAJHEADER_STATE = @"state";

    // Database Name
    NSString* const DATABASE_MAIN_NAME = @"MOSDB.sqlite";

    // Tables Name
    NSString* const TABLE_AGENT_PROFILE = @"TMLI_Agent_profile";
    NSString* const TABLE_CHANNEL = @"TMLI_Channel";
    NSString* const TABLE_DATA_CABANG = @"TMLI_Data_Cabang";
    NSString* const TABLE_DATA_VERSION = @"TMLI_Data_Version";
    NSString* const TABLE_CREDIT_CARD_BANK = @"TMLI_eProposal_Credit_Card_Bank";
    NSString* const TABLE_IDENTIFICATION = @"TMLI_eProposal_Identification";
    NSString* const TABLE_LA_DETAILS = @"TMLI_eProposal_LA_Details";
    NSString* const TABLE_MARITAL_STATUS = @"TMLI_eProposal_Marital_Status";
    NSString* const TABLE_NATIONALITY = @"TMLI_eProposal_Nationality";
    NSString* const TABLE_OCCP = @"TMLI_eProposal_OCCP";
    NSString* const TABLE_REFERRALSOURCE = @"TMLI_eProposal_ReferralSource";
    NSString* const TABLE_RELATION = @"TMLI_eProposal_Relation";
    NSString* const TABLE_RELIGION = @"TMLI_eProposal_Religion";
    NSString* const TABLE_SOURCEINCOME = @"TMLI_eProposal_SourceIncome";
    NSString* const TABLE_TITLE = @"TMLI_eProposal_Title";
    NSString* const TABLE_VIPCLASS = @"TMLI_eProposal_VIPClass";
    NSString* const TABLE_ZIPCODE = @"TMLI_kodepos";
    NSString* const TABLE_MASTER_INFO = @"TMLI_Master_Info";
    NSString* const TABLE_ERRORCODE = @"TMLI_Ref_ErrorCode";
    NSString* const TABLE_EPROPOSAL_ANNUALINCOME = @"eProposal_AnnualIncome";

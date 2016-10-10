//ver1.8

var AttachHMM = false;
var AttachHSP = false;
var AttachMG2 = false;
var AttachMG4 = false;

function loadRptVers()
{ 
	version = gdata.SI[0].SI_Version.version;
	update = gdata.SI[0].SI_Version.update;
	misc = gdata.SI[0].SI_Version.misc;
	
	$('.rptVersion').html(version+" "+update+" "+misc);
}

function setPage(){
    loadRptVers();
	
	var now = new Date();	
	var displayDate = now.getDate() + '/' + (now.getMonth() + 1) + '/' + now.getFullYear();
	
	var hours = now.getHours();
	var minutes = now.getMinutes();
	var second = now.getSeconds();
	var ampm = hours >= 12 ? 'PM' : 'AM';
	hours = hours % 12;
	hours = hours ? hours : 12; // the hour '0' should be '12'
	minutes = minutes < 10 ? '0'+minutes : minutes;
	second = second < 10 ? '0'+second : second;
	var strTime = hours + ':' + minutes + ':' + second + ' ' + ampm;
	
	var displayDateFull = now.getDate() + '/' + (now.getMonth() + 1) + '/' + now.getFullYear() + ' ' + strTime;
    
    $('.dateModified').html(displayDateFull);
	$('.PrintDate2').html(displayDate);
		
	$('.agentName').html(gdata.SI[0].agentName); //set agent name
    $('.agentCode').html(gdata.SI[0].agentCode); //set agent code
    $('.SICode').html(gdata.SI[0].SINo);
    $('.totalPages').html(gdata.SI[0].TotalPages); //set total pages    	
	$('.planName').html(gdata.SI[0].PlanName);
    
	$('.LAName1').html(gdata.SI[0].SI_Temp_trad_LA.data[0].Name);    
    $('.policyPercentage').html(gdata.SI[0].Trad_Details.data[0].PolicyPercentage);
    
	
    
    $('.BasicSA').html(formatCurrency(gdata.SI[0].Trad_Details.data[0].BasicSA));
    
    $('.GYIPurchased').html(formatCurrency(gdata.SI[0].Trad_Details.data[0].BasicSA));
    
    if(gdata.SI[0].PlanCode == "HLAWP")
    {
        $('.policyTerm').html(gdata.SI[0].SI_Temp_Trad_Details.data[0].col3);
        $('.premPayOpt').html(gdata.SI[0].SI_Temp_Trad_Details.data[0].col4);
    } 
    else if (gdata.SI[0].PlanCode == "S100") 
    {
    	s100text = "";
    	s100years = gdata.SI[0].SI_Temp_Trad_Details.data[0].col4;
    	// not dynamic (hardcode for now)
    	if ((s100years == "10") || (s100years == "15") || (s100years == "20")) {
    		if (gdata.SI[0].QuotationLang == "Malay") {
    			s100text = "terhad kepada "+ s100years + " tahun sahaja";
    		} else {
    			s100text = "limited to "+ s100years + " years only";
    		}
    	} else {
    		if (gdata.SI[0].QuotationLang == "Malay") {
    			s100text = "sehingga umur 100";
    		} else {
    			s100text = "up to age 100";
    		}
    	}
    	
        $('.S100PolicyTerm').html(s100text);
        $('.covPeriod').html(s100years);
    }
    else
    {
        $('.covPeriod').html(gdata.SI[0].SI_Temp_Trad_Details.data[0].col4);
    }
    
    $.each(gdata.SI[0].SI_Temp_Pages_PDS.data, function(index, row) {           
        $("#" + row.PageDesc + " .currentPage").html(row.PageNum);
    });
    
}

function writeFootnote(){
    var a = 1;
    var fnPage35_ACIR = 0;
    var SecondOrPayorRider = [];     
    
    $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, row) {
        
        if(row.RiderCode == 'ACIR_MPP'){
            if (fnPage35_ACIR == 0){
            	fnPage35_ACIR = a;
            }
			$('.fnPage35_ACIR').html('[' + fnPage35_ACIR + ']');
			a++;
        } else if(row.RiderCode == 'CIR') {
        	if (fnPage35_ACIR == 0) {
        		fnPage35_ACIR = a;
          	  	a++;
        	}
            $('.fnPage35_CIR').html('[' + fnPage35_ACIR + ']');
        } else if(row.RiderCode == 'CIWP') {
            $('.fnPage35_CIWP').html('[' + a + ']');
            $('.CIWPPC').html('(' + CurrencyNoCents(row.SumAssured) + '%)');
            a++;
        } else if(row.RiderCode == 'ICR') {
            $('.fnPage35_ICR').html('[' + a + ']');
             a++;
        } else if(row.RiderCode == 'LCPR') {
            $('.fnPage35_LCPR').html('[' + a + ']');
             a++;
        } else if(row.RiderCode == 'PLCP') {
            $('.fnPage35_PLCP').html('[' + a + ']');
             a++;
        } else if(row.RiderCode == 'LCWP') {
            SecondOrPayorRider.push('LCWP');   
            $('.LCWPSA').html('(' + CurrencyNoCents(row.SumAssured) + '%)'); 
        } else if(row.RiderCode == 'SP_PRE') {
        	SecondOrPayorRider.push('SP_PRE');
            $('.SP_PRESA').html('(' + CurrencyNoCents(row.SumAssured) + '%)');
        } else if(row.RiderCode == 'SP_STD') {
            $('.SP_STDSA').html('(' + CurrencyNoCents(row.SumAssured) + '%)');
        } else if(row.RiderCode == 'PR') {
            $('.PRSA').html('(' + CurrencyNoCents(row.SumAssured) + '%)');
        }
        
    });
    
    $('.OCCPClass').html('(Class '+gdata.SI[0].OCCPClass+')');
    if(SecondOrPayorRider.length > 0){
		if(SecondOrPayorRider[0] == 'LCWP'){
            $('.fnPage35_LCWP').html('[' + a + ']');
            a++;             
        }
        else if(SecondOrPayorRider[0] == 'SP_PRE'){
			$('.fnPage35_SPPRE').html('[' + a + ']');
			a++;
        }
     }
	
	if(AttachHSP == true){
		$('.fnPageHSP_1').html('[' + a + ']');
		a++;
		$('.fnPageHSP_2').html('[' + a + ']');
		a++;	
	}
	
	if(AttachMG2 == true){
		$('.fnCharges').html('[' + a + ']');
		a++;
		$('.fnPageMG2').html('[' + a + ']');
		a++;	
	}
	
	if(AttachMG4 == true){	
		if(AttachMG2 == false){
			$('.fnCharges').html('[' + a + ']');
			a++;
		}
	
		$('.fnHighway').html('[' + a + ']');
		a++;	
	} else if(AttachHMM == true) {		
		if(AttachMG2 == false){
			$('.fnCharges').html('[' + a + ']');
			a++;
		}
		
		$('.fnHighway').html('[' + a + ']');
		a++;	
	}
    
}

function writeSummary1_HLCP()
{
	$.each(gdata.SI[0].SI_Temp_Trad_Basic.data, function(index, row) {
	   //change col22
	   $('#table-Summary1 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' +
		   formatCurrency(row.col2) + '</td><td>' + formatCurrency(row.col22) + '</td><td>' + formatCurrency(row.col23) + '</td><td>' +
		   CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) +
		   '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' +
		   CurrencyNoCents(row.col7) + '</td><td>' + CurrencyNoCents(row.col8) + '</td><td>' + CurrencyNoCents(row.col9) +
		   '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + formatCurrency(row.col11) + '</td></tr>');	
	});
	
	//total premium paid
	$('.TotPremPaid').html(formatCurrency(gdata.SI[0].SI_Temp_Trad.data[0].TotPremPaid));
	$('.SurrenderValueHigh').html(formatCurrency(gdata.SI[0].SI_Temp_Trad.data[0].SurrenderValueHigh));
    $('.SurrenderValueLow').html(formatCurrency(gdata.SI[0].SI_Temp_Trad.data[0].SurrenderValueLow));
    $('.TotalYearlyIncome').html(formatCurrency(gdata.SI[0].SI_Temp_Trad.data[0].TotalYearlylncome));
	
	//entire policy (including all riders)
	$('.TotPremPaid1').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].TotPremPaid1));
	$('.SurrenderValueHigh1').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].SurrenderValueHigh1));
    $('.SurrenderValueLow1').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].SurrenderValueLow1));
    $('.TotalYearlyIncome1').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].TotYearlyIncome1));
    
    //advanced yearly income
    if (parseInt(gdata.SI[0].Trad_Details.data[0].AdvanceYearlyIncome) == 0){ //Cash promise. Only 1 title
		$('.advanceYearlyIncome').html('Illustration of HLA Cash Promise Plan&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i>Ilustrasi HLA Cash Promise</i>');
	}
	
	if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC')//payment description
    {
        $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Accumulate)<br/><i>' +
        	gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)</i>');
        
		if (parseInt(gdata.SI[0].Trad_Details.data[0].CashPayment_PO) == 100)
        {
			$('.totalSurrenderValue').html('(6)=(3)+(10)+(11)');
        	$('.tpdBenefit').html('(7)=(4B)+(10)+(12)');
            $('.accumulationYearlyIncome').hide(); //# description. Cash Promise
        }
        else
        {
        	$('.totalSurrenderValue').html('(6)=(3)+(10)+(11)+(12)');
        	$('.tpdBenefit').html('(7)=(4B)+(10)+(12)+(13)');
            $('.cashPayment1').html('#');
            $('.cashPayment2').html('#');
        }
    }
	else if (gdata.SI[0].Trad_Details.data[0].CashDividend == 'POF')
    {
    	$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Payout)&nbsp;<i>' +
    		gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)</i>');
        
        if (parseInt(gdata.SI[0].Trad_Details.data[0].CashPayment_PO) == 100)
        {
        	$('.totalSurrenderValue').html('(6)=(3)+(10)');
            $('.tpdBenefit').html('(7)=(4B)+(11)');
            $('.accumulationYearlyIncome').hide(); //# description. Cash Promise
        }
        else
        {
        	$('.totalSurrenderValue').html('(6)=(3)+(10)+(11)');
            $('.tpdBenefit').html('(7)=(4B)+(10)+(12)');
            $('.cashPayment1').html('#');
            $('.cashPayment2').html('#');
        }
    }    
}

function writeSummary2_HLCP()
{
	var colType = 0;
    if (parseInt(gdata.SI[0].Trad_Details.data[0].AdvanceYearlyIncome) == 0){ //Cash promise. Only 1 title
		$('.advanceYearlyIncome').html('Illustration of HLA Cash Promise Plan&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i>Ilustrasi HLA Cash Promise</i>');
	}
	
	if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC')//payment description
    {
        $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Accumulate)<br/><i>' +
        	gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)</i>');
        
        $('#table-Summary2 #col1').html('Accumulated Cash Dividend<br/><br/><i>Dividen Tunai Terkumpul<br/>(10)</i>');
        
        if (gdata.SI[0].Trad_Details.data[0].YearlyIncome == "POF")
        {
        	$('#table-Summary2 #col2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(11)</i>');
            $('#table-Summary2 #col3').html('Special Terminal Dividend Payable on<br/>Death<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian<br/>(12)</i>');
        	$('#table-Summary2 #col4').html('-');
            $('#table-Summary2 #col4A').html('-');
            $('#table-Summary2 #col4B').html('-');
            
            $('#table-Summary2 #col4').hide();
            $('#table-Summary2 #col4A').hide();
            $('#table-Summary2 #col4B').hide();
         	colType = 1;
        }
        else
        {
        	$('#table-Summary2 #col2').html('Accumulated Yearly Income *<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(11)</i>');
            $('#table-Summary2 #col3').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(12)</i>');
            $('#table-Summary2 #col4').html('Special Terminal Dividend Payable on<br/>Death<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian<br/>(13)</i>');
        	$('.ShowGYI').show();
        	colType = 2;
        }
    }
    else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF')//payment description
    {
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Payout)<br/><i>' +
			gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)</i>');
        
    	if (gdata.SI[0].Trad_Details.data[0].YearlyIncome == "POF")
    	{
        	$('#table-Summary2 #col1').html('Terminal Dividend Payable<br/>on Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(10)</i>');
        	$('#table-Summary2 #col2').html('Special Terminal Dividend Payable on<br/>Death<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian<br/>(11)</i>');
        	$('#table-Summary2 #col3').html('--');
        	$('#table-Summary2 #col4').html('--');
        	$('#table-Summary2 #col3A').html('-');
        	$('#table-Summary2 #col3B').html('-');
        	$('#table-Summary2 #col4A').html('-');
        	$('#table-Summary2 #col4B').html('-');
            
        	$('#table-Summary2 #col3').hide();
        	$('#table-Summary2 #col4').hide();
        	$('#table-Summary2 #col3A').hide();
        	$('#table-Summary2 #col3B').hide();
        	$('#table-Summary2 #col4A').hide();
        	$('#table-Summary2 #col4B').hide();
            
        	colType = 3;
        }
        else
        {
        	$('#table-Summary2 #col1').html('Accumulated Yearly Income *<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(10)</i>');
            $('#table-Summary2 #col2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(11)</i>');
            $('#table-Summary2 #col3').html('Special Terminal Dividend Payable on<br/>Death<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian<br/>(12)</i>');
            $('#table-Summary2 #col4').html('-');
            $('#table-Summary2 #col4A').html('-');
            $('#table-Summary2 #col4B').html('-');
            
            $('#table-Summary2 #col4').hide();
            $('#table-Summary2 #col4A').hide();
            $('#table-Summary2 #col4B').hide();
            
            $('.ShowGYI').show();
            colType = 4;
        }
    }
    
	$.each(gdata.SI[0].SI_Temp_Trad_Basic.data, function(index, row) {	           
    	if (colType == 1){
        	$('#table-Summary2 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + CurrencyNoCents(row.col12) + '</td><td>' + 
           		CurrencyNoCents(row.col13) + '</td><td>' + CurrencyNoCents(row.col14) + '</td><td>' + CurrencyNoCents(row.col15) + '</td><td>' + 
           		CurrencyNoCents(row.col18) + '</td><td>' + CurrencyNoCents(row.col19) + '</td><td>' + CurrencyNoCents(row.col20) + '</td><td>' + 
           		CurrencyNoCents(row.col21) + '</td></tr>' );
		} else if (colType == 2) {
			$('#table-Summary2 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + CurrencyNoCents(row.col12) + '</td><td>' +
				CurrencyNoCents(row.col13) + '</td><td>' + CurrencyNoCents(row.col14) + '</td><td>' + CurrencyNoCents(row.col15) + '</td><td>' + 
				CurrencyNoCents(row.col16) + '</td><td>' + CurrencyNoCents(row.col17) + '</td><td>' + CurrencyNoCents(row.col18) + '</td><td>' + 
				CurrencyNoCents(row.col19) + '</td><td>' + CurrencyNoCents(row.col20) + '</td><td>' + CurrencyNoCents(row.col21) + '</td></tr>');
        } else if (colType == 3) {
        	$('#table-Summary2 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + CurrencyNoCents(row.col12) + '</td><td>' +
        		CurrencyNoCents(row.col13) + '</td><td>' + CurrencyNoCents(row.col18) + '</td><td>' + CurrencyNoCents(row.col19) + '</td><td>' + 
        		CurrencyNoCents(row.col20) + '</td><td>' + CurrencyNoCents(row.col21) + '</td></tr>');
        } else if (colType == 4) {
        	$('#table-Summary2 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + CurrencyNoCents(row.col12) + '</td><td>' +
        		CurrencyNoCents(row.col13) + '</td><td>' + CurrencyNoCents(row.col16) + '</td><td>' + CurrencyNoCents(row.col17) + '</td><td>' + 
        		CurrencyNoCents(row.col18) + '</td><td>' + CurrencyNoCents(row.col19) + '</td><td>' + CurrencyNoCents(row.col20) + '</td><td>' + 
        		CurrencyNoCents(row.col21) + '</td></tr>');
        }
	});    
    writeInvestmentScenarios();
}

function writeRiderPage1_HLCP()
{
	if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC'){
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Accumulate)<br/><i>' +
			gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)</i>');
    } else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF') {
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Payout)<br/><i>' + 
			gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)</i>');
	}
	
	if(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data.length > 0){
		$('#rider1Page1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[0].col1);
    	$('#rider2Page1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[0].col5);
    	$('#rider3Page1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[0].col9);
    	
    	$('#col0_1_EPage1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[1].col0_1 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[2].col0_1 + "</i>");
    	$('#col0_2_EPage1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[1].col0_2 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[2].col0_2 + "</i>");
	}
	
	for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[i];
        	row2 = gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[i+1];
        	if(eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)") {
            	$('#col' + j + '_EPage1').html(eval('row.col' + j) + "<br/><i>" + eval('row2.col' + j) + "</i>");
            } else {
            	$('#col' + j + '_EPage1').html(eval('row.col' + j) + "<br/><br/><i>" + eval('row2.col' + j) + "</i>");
            }
        }
    }
    
    for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data.length; i++) {//row data
    	row = gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[i];
        $('#table-Rider1 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + 
        	CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + 
        	formatCurrency(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' +
        	formatCurrency(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' + 
        	CurrencyNoCents(row.col12) +'</td></tr>');
    }
}

function writeRiderPage2_HLCP()
{
	if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC'){
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Accumulate)<br/><i>' + 
			gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)</i>');
    } else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF') {
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Payout)<br/><i>' +
			gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)</i>');
	}
	
	if(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data.length > 0){
		$('#rider1Page2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[0].col1);
    	$('#rider2Page2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[0].col5);
    	$('#rider3Page2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[0].col9);
    	
    	$('#col0_1_EPage2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[1].col0_1 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[2].col0_1 + "</i>");
    	$('#col0_2_EPage2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[1].col0_2 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[2].col0_2 + "</i>");
	}
	for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[i];
        	row2 = gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[i+1];
        	if(eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)") {
            	$('#col' + j + '_EPage2').html(eval('row.col' + j) + "<br/><i>" + eval('row2.col' + j) + "</i>");
            } else {
            	$('#col' + j + '_EPage2').html(eval('row.col' + j) + "<br/><br/><i>" + eval('row2.col' + j) + "</i>");
            }
        }
    }
    
    for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data.length; i++) {//row data
    	row = gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[i];
        $('#table-Rider1 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + 
        	CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' +
        	formatCurrency(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' +
        	formatCurrency(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' + 
        	CurrencyNoCents(row.col12) +'</td></tr>');
    }
}

function writeRiderPage3_HLCP()
{
	if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC'){
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Accumulate)<br/><i>' +
			gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)</i>');
    }
    else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF'){
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Payout)<br/><i>' + 
			gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)</i>');
	}
	
	if(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data.length > 0) {
		$('#rider1Page3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[0].col1);
    	$('#rider2Page3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[0].col5);
    	$('#rider3Page3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[0].col9);
    	
    	$('#col0_1_EPage3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[1].col0_1 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[2].col0_1 + "</i>");
    	$('#col0_2_EPage3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[1].col0_2 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[2].col0_2 + "</i>");
	}
	
	for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[i];
        	row2 = gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[i+1];
        	if(eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)") {
            	$('#col' + j + '_EPage3').html(eval('row.col' + j) + "<br/><i>" + eval('row2.col' + j) + "</i>");
            }
            else{
            	$('#col' + j + '_EPage3').html(eval('row.col' + j) + "<br/><br/><i>" + eval('row2.col' + j) + "</i>");
            }
        }
    }
    
    for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data.length; i++) {//row data
    	row = gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[i];
        $('#table-Rider3 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' +
        	CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + formatCurrency(row.col5) +
        	'</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + formatCurrency(row.col9) + '</td><td>' +
        	CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' + CurrencyNoCents(row.col12) +'</td></tr>');
    }
}

function writeRiderPage4_HLCP()
{
	if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC') {
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Accumulate)<br/><i>' + 
			gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)</i>');
    } else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF') {
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Payout)<br/><i>' + 
			gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)</i>');
	}
	
	if(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data.length > 0){
		$('#rider1Page4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[0].col1);
    	$('#rider2Page4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[0].col5);
    	$('#rider3Page4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[0].col9);
    	
    	$('#col0_1_EPage4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[1].col0_1 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[2].col0_1 + "</i>");
    	$('#col0_2_EPage4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[1].col0_2 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[2].col0_2 + "</i>");
	}
	for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[i];
        	row2 = gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[i+1];
        	if(eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)") {
            	$('#col' + j + '_EPage4').html(eval('row.col' + j) + "<br/><i>" + eval('row2.col' + j) + "</i>");
            }
            else{
            	$('#col' + j + '_EPage4').html(eval('row.col' + j) + "<br/><br/><i>" + eval('row2.col' + j) + "</i>");
            }
        }
    }
    for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data.length; i++) {//row data
    	row = gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[i];
        $('#table-Rider4 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' +
        	CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' +
        	formatCurrency(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + 
        	formatCurrency(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' +
        	CurrencyNoCents(row.col12) +'</td></tr>');
    }
}

function writeRiderPage5_HLCP()
{
	if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC') {
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Accumulate)<br/><i>' +
			gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)</i>');
    } else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF') {
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Payout)<br/><i>' +
			gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)</i>');
	}
	
	if(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data.length > 0){
		$('#rider1Page5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[0].col1);
    	$('#rider2Page5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[0].col5);
    	$('#rider3Page4').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[0].col9);
    	
    	$('#col0_1_EPage5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[1].col0_1 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[2].col0_1 + "</i>");
    	$('#col0_2_EPage5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[1].col0_2 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[2].col0_2 + "</i>");
	}
	for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[i];
        	row2 = gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[i+1];
        	if(eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)"){
            	$('#col' + j + '_EPage5').html(eval('row.col' + j) + "<br/><i>" + eval('row2.col' + j) + "</i>");
            }
            else{
            	$('#col' + j + '_EPage5').html(eval('row.col' + j) + "<br/><br/><i>" + eval('row2.col' + j) + "</i>");
            }
        }
    }
    for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data.length; i++) {//row data
    	row = gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[i];
        $('#table-Rider5 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' +
        	CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + 
        	formatCurrency(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' +
        	formatCurrency(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' + CurrencyNoCents(row.col12) +'</td></tr>');
    }
}

function writeRiderPage6_HLCP()
{
	if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC') {
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Accumulate)<br/><i>' + 
			gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)</i>');
    } else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF') {
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Payout)<br/><i>' + 
			gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)</i>');
	}
	
	if(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data.length > 0){
		$('#rider1Page6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[0].col1);
    	$('#rider2Page6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[0].col5);
    	$('#rider3Page6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[0].col9);
    	
    	$('#col0_1_EPage6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[1].col0_1 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[2].col0_1 + "</i>");
    	$('#col0_2_EPage6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[1].col0_2 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[2].col0_2 + "</i>");
	}
	for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[i];
        	row2 = gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[i+1];
        	if(eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)"){
            	$('#col' + j + '_EPage6').html(eval('row.col' + j) + "<br/><i>" + eval('row2.col' + j) + "</i>");
            }
            else{
            	$('#col' + j + '_EPage6').html(eval('row.col' + j) + "<br/><br/><i>" + eval('row2.col' + j) + "</i>");
            }
        }
    }
    for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data.length; i++) {//row data
    	row = gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[i];
        $('#table-Rider6 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' +
        	CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + 
        	formatCurrency(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' +
        	formatCurrency(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' + 
        	CurrencyNoCents(row.col12) +'</td></tr>');
    }
}

function writeRiderPage7_HLCP()
{
	if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC'){
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Accumulate)<br/><i>' +
			gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)</i>');
    }
    else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF'){
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Payout)<br/><i>' + 
			gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)</i>');
	}
	
	if(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data.length > 0){
		$('#rider1Page7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[0].col1);
    	$('#rider2Page7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[0].col5);
    	$('#rider3Page7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[0].col9);
    	
    	$('#col0_1_EPage7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[1].col0_1 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[2].col0_1 + "</i>");
    	$('#col0_2_EPage7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[1].col0_2 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[2].col0_2 + "</i>");
	}
	for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[i];
        	row2 = gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[i+1];
        	if(eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)"){
            	$('#col' + j + '_EPage7').html(eval('row.col' + j) + "<br/><i>" + eval('row2.col' + j) + "</i>");
            }
            else{
            	$('#col' + j + '_EPage7').html(eval('row.col' + j) + "<br/><br/><i>" + eval('row2.col' + j) + "</i>");
            }
        }
    }
    for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data.length; i++) {//row data
    	row = gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[i];
        $('#table-Rider7 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' +
        	CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' +
        	formatCurrency(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' +
        	formatCurrency(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' + 
        	CurrencyNoCents(row.col12) +'</td></tr>');
    }
}

function writeRiderPage8_HLCP()
{
	if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC'){
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Accumulate)<br/><i>' + 
			gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)</i>');
    }
    else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF'){
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Payout)<br/><i>' + 
			gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)</i>');
	}
	
	if(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data.length > 0){
		$('#rider1Page8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[0].col1);
    	$('#rider2Page8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[0].col5);
    	$('#rider3Page8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[0].col9);
    	
    	$('#col0_1_EPage8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[1].col0_1 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[2].col0_1 + "</i>");
    	$('#col0_2_EPage8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[1].col0_2 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[2].col0_2 + "</i>");
	}
	for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[i];
        	row2 = gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[i+1];
        	if(eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)"){
            	$('#col' + j + '_EPage8').html(eval('row.col' + j) + "<br/><i>" + eval('row2.col' + j) + "</i>");
            }
            else{
            	$('#col' + j + '_EPage8').html(eval('row.col' + j) + "<br/><br/><i>" + eval('row2.col' + j) + "</i>");
            }
        }
    }
    for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data.length; i++) {//row data
    	row = gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[i];
        $('#table-Rider8 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' +
        	CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + 
        	formatCurrency(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' +
        	formatCurrency(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' +
        	CurrencyNoCents(row.col12) +'</td></tr>');
    }
}


function writeRiderDescription_EN()
{
	var textExist = false;
	
	$.each(gdata.SI[0].SI_Temp_Pages.data, function(index, row) {
		if (row.riders != "" && row.riders != "(null)"){
			if(row.riders.charAt(row.riders.length-1) == ";"){
				rider = row.riders.slice(0, -1).split(";");
			} else {
				rider = row.riders.split(";");
			}
			
			for (i=0;i<rider.length;i++) {
				if (rider[i] == "C+"){
					rider[i] = "C";
				}
				else if (rider[i] == 'tblHeader' && textExist == false )
				{
					tblHeader = "#" + row.PageDesc + " #riderInPage";
					$(tblHeader).css('display','inline');
					textExist = true;
				}
				
				tblRider = "#" + row.PageDesc + " #table-design1 tr." + rider[i];
				$(tblRider).css('display','table-row');
				
				if (rider[i] == "C"){
					rider[i] = "C+";
					$("#" + row.PageDesc + " #table-design2Wide tr").css('display','table-row');
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "C+"){
							$("#" + row.PageDesc + " .CRiderTerm").html(rowRider.RiderTerm);
							$("#" + row.PageDesc + " .cVeryEarly").html(formatCurrency((parseFloat(formatCurrency(rowRider.SumAssured).replace(",","")) * 50) / 100));
							$("#" + row.PageDesc + " .cEarly").html(formatCurrency((parseFloat(formatCurrency(rowRider.SumAssured).replace(",","")) * 150) / 100));
							$("#" + row.PageDesc + " .cAdvance").html(formatCurrency((parseFloat(formatCurrency(rowRider.SumAssured).replace(",","")) * 250) / 100));
							$("#" + row.PageDesc + " .cNursingCareAllowance").html('RM ' + formatCurrency((parseFloat(formatCurrency(rowRider.SumAssured).replace(",","")) * 25) / 100));
						
							if (rowRider.PlanOption == "L"){
								$("#" + row.PageDesc + ' .cPlanOption').html('Level Cover');
								$("#" + row.PageDesc + ' .cGuaranteedIncreasingSumAssured').html('');
								$("#" + row.PageDesc + ' .cNoClaimBenefit').html('');
							}
							else if (rowRider.PlanOption == "I")
							{ 
								$("#" + row.PageDesc + ' .cPlanOption').html('Increasing Cover');
								$("#" + row.PageDesc + ' .cNoClaimBenefit').html('');
								$("#" + row.PageDesc + ' .cGuaranteedIncreasingSumAssured').html("<u>Guaranteed Increasing Sum Assured</u><br/>" + 
								"-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Rider's Sum Assured shall increase by 10% every 2 years with the first such increase staring on 2nd Anniversary of the Commencement Date of this<br/> " +
								"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Rider and the last on the 20th Anniversary of this Rider and remains level thereafter.<br/><br/>");
							}
							else if (rowRider.PlanOption == "B")
							{
								$("#" + row.PageDesc + ' .cPlanOption').html('Level Cover with NCB');
								$("#" + row.PageDesc + ' .cGuaranteedIncreasingSumAssured').html('');
								$('#cNoClaimBenefit').html("<u>No Claim Benefit</u><br/> " +
									"-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Upon survival of the Life Assured on the Expiry Date of this Rider and provided that no claim has been admitted prior to this date, the company will pay the<br/>" +
									"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Policy Owner a No Claim benefit equivalent to RM" + formatCurrency(rowRider.SumAssured) + "<br/><br/>");
							}
							else if (rowRider.PlanOption == "N")
							{
								$("#" + row.PageDesc + ' .cPlanOption').html('Increasing Cover with NCB');
								$("#" + row.PageDesc + ' .cGuaranteedIncreasingSumAssured').html("<u>Guaranteed Increasing Sum Assured</u><br/>" + 
									"-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Rider's Sum Assured shall increase by 10% every 2 years with the first such increase staring on 2nd Anniversary of the Commencement Date of this<br/> " +
									"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Rider and the last on the 20th Anniversary of this Rider and remains level thereafter.<br/><br/>");
								$('#cNoClaimBenefit').html("<u>No Claim Benefit</u><br/> " +
									"-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Upon survival of the Life Assured on the Expiry Date of this Rider and provided that no claim has been admitted prior to this date, the company will pay the<br/>" +
									"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Policy Owner a No Claim benefit equivalent to RM" + formatCurrency(rowRider.SumAssured) + "<br/><br/>");
								
								$("#" + row.PageDesc + " .cVeryEarlyTD").html('50% of Rider Sum Assured');
								$("#" + row.PageDesc + " .cEarlyTD").html('150% of Rider Sum Assured');
								$("#" + row.PageDesc + " .cAdvanceTD").html('250% of Rider Sum Assured');
								$("#" + row.PageDesc + " .cNursingCareAllowance").html('25% of Rider Sum Assured');
							}
						}
					});
				}
				else if (rider[i] == "CCTR")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "CCTR") {
							$("#" + row.PageDesc + " .CCTRRiderTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .CCTRGYI").html(formatCurrency(rowRider.SumAssured)+"");
						}
					});
				}
				else if (rider[i] == "CIR")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "CIR"){
							$("#" + row.PageDesc + " .CIRRiderTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .CIRGYI").html(formatCurrency(rowRider.SumAssured)+"");
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
						}
					});
				}
				else if (rider[i] == "CIWP")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "CIWP"){
							$("#" + row.PageDesc + " .CIWPRiderTerm").html(rowRider.RiderTerm);
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
						}
					});
					
					$.each(gdata.SI[0].SI_Temp_Trad_Details.data, function(rowIndex, rowTemp) {
						if (rowTemp.RiderCode == "CIWP"){
							$("#" + row.PageDesc + " .CIWPRiderGYI").html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Details.data[rowIndex+1].col2));
						}
					});
				}
				else if (rider[i] == "CPA")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "CPA"){
							$("#" + row.PageDesc + " .CPARiderTerm").html(rowRider.RiderTerm);
						}
					});
				}
				else if (rider[i] == "EDB")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "EDB"){
							$("#" + row.PageDesc + " .EDBRiderTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .EDBGYI").html(formatCurrency(rowRider.SumAssured)+"");
						}
					});
				}
				else if (rider[i] == "TPDYLA")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "TPDYLA"){
							$("#" + row.PageDesc + " .ETPDRiderTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .ETPDGYI").html(formatCurrency(rowRider.SumAssured)+"");
						}
					});
				}
				else if (rider[i] == "ETPDB")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "ETPDB"){
							$("#" + row.PageDesc + " .ETPDBRiderTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .ETPDBGYI").html(formatCurrency(rowRider.SumAssured)+"");
						}
					});
				}
				else if (rider[i] == "HB") 
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "HB"){
							$("#" + row.PageDesc + " .HBRiderTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .HBBenefit").html(formatCurrency(parseInt(rowRider.Units) * 45)+".00");
						}
					});
				}
				else if (rider[i] == "HMM")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "HMM"){
							$("#" + row.PageDesc + " .HMMRiderTerm").html(rowRider.RiderTerm);
						}
					});
				}
				else if (rider[i] == "HSP_II")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "HSP_II"){
							$("#" + row.PageDesc + " .HSP_IIRiderTerm").html(rowRider.RiderTerm);	
						}
					});
				}
				else if (rider[i] == "ICR")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "ICR"){
							$("#" + row.PageDesc + " .ICRRiderTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .ICRGYI").html(formatCurrency(rowRider.SumAssured)+"");
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
						}
					});
				}
				else if (rider[i] == "LCPR")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "LCPR"){
							$("#" + row.PageDesc + " .LCPRRiderTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .LCPRGYI").html(formatCurrency(rowRider.SumAssured)+"");					
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
						}
					});
				}
				else if (rider[i] == "MG_II")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "MG_II"){
							$("#" + row.PageDesc + " .MG_IIRiderTerm").html(rowRider.RiderTerm);	
						}
					});
				}
				else if (rider[i] == "MG_IV")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "MG_IV"){
							$("#" + row.PageDesc + " .MG_IVRiderTerm").html(rowRider.RiderTerm);	
						}
					});
				}
				else if (rider[i] == "PA")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "PA"){
							$("#" + row.PageDesc + " .PARiderTerm").html(rowRider.RiderTerm);	
						}
					});
				}
				else if (rider[i] == "LCWP")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "LCWP"){
							$("#" + row.PageDesc + " .LCWPRiderTerm").html(rowRider.RiderTerm);					
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');

							//please check the PTypeCode......
							if(rowRider.PTypeCode == "LA"){
								$("#" + row.PageDesc + " .LCWPInsuredLives").html('2nd Life Assured');
							}
							else if (rowRider.PTypeCode == "PY")
							{
								$("#" + row.PageDesc + " .LCWPInsuredLives").html('Policy Owner');
								$("#" + row.PageDesc + " .LCWPInsuredLives_BM").html('Pemunya<br/>Polisi');
							}
							else
							{
								$("#" + row.PageDesc + " .LCWPInsuredLives").html('Payor');
							}
						}
					});
				}
				else if (rider[i] == "PLCP")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "PLCP"){
							$("#" + row.PageDesc + " .PLCPRiderTerm").html(rowRider.RiderTerm);
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
							$("#" + row.PageDesc + " .PLCPGYI").html(formatCurrency(rowRider.SumAssured)+"");
						}
					});
				}
				else if (rider[i] == "PR")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "PR"){
							$("#" + row.PageDesc + " .PRRiderTerm").html(rowRider.RiderTerm);					

							if(rowRider.PTypeCode == "LA"){
								$("#" + row.PageDesc + " .PRInsuredLives").html('2nd Life Assured');
							}
							else if (rowRider.PTypeCode == "PY")
							{
								$("#" + row.PageDesc + " .PRInsuredLives").html('Policy Owner');
								$("#" + row.PageDesc + " .PRInsuredLives_BM").html('Pemunya<br/>Polisi');
							}
							else
							{
								$("#" + row.PageDesc + " .PRInsuredLives").html('Payor');
							}
						}
					});
				}
				else if (rider[i] == "SP_PRE")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "SP_PRE"){
							$("#" + row.PageDesc + " .SP_PRERiderTerm").html(rowRider.RiderTerm);
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
						}
					});
				}
				else if (rider[i] == "SP_STD")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "SP_STD"){
							$("#" + row.PageDesc + " .SP_STDRiderTerm").html(rowRider.RiderTerm);
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
						}
					});
				}
				else if (rider[i] == "PTR")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "PTR"){
							$("#" + row.PageDesc + " .PTRRiderTerm").html(rowRider.RiderTerm);
							$("#" + row.PageDesc + " .PTRGYI").html(formatCurrency(rowRider.SumAssured)+"");
						}
					});
				}
			}
        }
	});
}

function getPlanRider(riderCode)
{
	var data;
	for (i=0; i<gdata.SI[0].SI_Temp_Trad_Details.data.length; i++) {
		data = gdata.SI[0].SI_Temp_Trad_Details.data[i];
		if (data.RiderCode == riderCode) {
			return italizeWBRider(data.col0_1);
		}
	}	
	return "";
}

function italizeWBRider(strData) 
{
	var indexFound = strData.indexOf("-");
	if (indexFound > -1) {
		var spaceAfter = strData.indexOf(" ", indexFound);
		var substr = strData.substring(indexFound, spaceAfter);
		var newData = strData.replace(substr, "<i>"+substr+"</i>");
		return newData;
	} else {
		return strData;
	}
}

function Insured(PersonType, Sequence){
	if(PersonType == 'LA'){
		if(Sequence == '1'){
			return 'Life Assured';
		} else {
			return '2nd Life Assured';
	    }
	} else {
	    return 'Policy Owner';
	}
}

function InsuredBM(PersonType, Sequence){
	if(PersonType == 'LA'){
		if(Sequence == '1'){
			return 'Hayat Diinsuranskan';
		} else {
			return 'Hayat Diinsuranskan ke-2';
	    }
	} else {
	    return 'Pemunya Polisi';
	}
}

function writeEstimateTotalPremium(lang)
{
	var type;
	var planRider;
    var col5Total, col6Total, col7Total, col8Total;
    
    col5Total = 0.00;
    col6Total = 0.00;
    col7Total = 0.00;
    col8Total = 0.00;
    
    var tempArray = [];
	
	$.each(gdata.SI[0].SI_Store_Premium.data, function(index, SI_Store_Premium) {
		if (SI_Store_Premium.FromAge == "(null)" && SI_Store_Premium.ToAge == "(null)"){
			type = SI_Store_Premium.Type;
			planRider = "Rider";
			if (type == "B"){
				type = gdata.SI[0].PlanCode;
				if (lang == "EN") {
					planRider = "Basic Plan";
				} else if (lang == "BM") {
					planRider = "Pelan Asas";
				}
			}
           
			col5Total = col5Total + parseFloat(formatCurrency(SI_Store_Premium.Annually).replace(/,/g,'').replace('-', '0'));
			col6Total = col6Total + parseFloat(formatCurrency(SI_Store_Premium.SemiAnnually).replace(/,/g,'').replace('-', '0'));
			col7Total = col7Total + parseFloat(formatCurrency(SI_Store_Premium.Quarterly).replace(/,/g,'').replace('-', '0'));
			col8Total = col8Total + parseFloat(formatCurrency(SI_Store_Premium.Monthly).replace(/,/g,'').replace('-', '0'));
			
			if(type == 'PLCP'){
				tempArray.push(SI_Store_Premium);
				$(".table-estimate > tbody").append('<tr><td>' + getPlanRider('PLCP') + 
					'</td><td style="text-align:center">' + planRider +
					'</td><td style="text-align:right">' + tempArray[0].Annually +
					'</td><td style="text-align:right">' + tempArray[0].SemiAnnually + 
					'</td><td style="text-align:right">' + tempArray[0].Quarterly +
					'</td><td style="text-align:right">' + tempArray[0].Monthly + 
					'</td></tr>');
			} else {
				$(".table-estimate > tbody").append('<tr><td>' + getPlanRider(type) +
					'</td><td style="text-align:center">' + planRider + 
					'</td><td style="text-align:right">' + SI_Store_Premium.Annually + 
					'</td><td style="text-align:right">' + SI_Store_Premium.SemiAnnually +
					'</td><td style="text-align:right">' + SI_Store_Premium.Quarterly + 
					'</td><td style="text-align:right">' + SI_Store_Premium.Monthly + 
					'</td></tr>');
					
				if(type == 'LCWP'){ //insert PLCP record after LCWP
					if(tempArray.length > 0){
						$(".table-estimate > tbody").append('<tr><td>' + getPlanRider('PLCP') +
							'</td><td style="text-align:center">' + planRider +
							'</td><td style="text-align:right">' + tempArray[0].Annually +
							'</td><td style="text-align:right">' + tempArray[0].SemiAnnually + 
							'</td><td style="text-align:right">' + tempArray[0].Quarterly + 
							'</td><td style="text-align:right">' + tempArray[0].Monthly +
							'</td></tr>');	
					}
				}
			}
		}
	});
	
	if (lang == "EN"){
		$('.table-estimate > tfoot').append('<tr>' + '<td colspan="2" style="text-align:left;padding: 0px 0px 0px 5px;"><b>Total Premium</b></td>' + 
			'<td style="text-align:right"><b>' + formatCurrency(col5Total.toFixed(2)) + '</b></td>' + '<td style="text-align:right"><b>' +
			formatCurrency(col6Total.toFixed(2)) + '</b></td>' + '<td style="text-align:right"><b>' + formatCurrency(col7Total.toFixed(2)) + '</b></td>' + 
			'<td style="text-align:right"><b>' + formatCurrency(col8Total.toFixed(2)) + '</b></td>' + '</tr>');
		$('.table-tax > tbody').append('<tr>' + '<td style="text-align:left">Service tax chargeable</td>' + 
			'<td style="text-align:center">' + formatCurrency(col5Total.toFixed(2) * 0.06) + '</td>' + '<td style="text-align:center">' +
			formatCurrency(col6Total.toFixed(2) * 0.06) + '</td>' + 
			'<td style="text-align:center">' + formatCurrency(col7Total.toFixed(2) * 0.06) + '</td>' + '<td style="text-align:center">' +
			formatCurrency(col8Total.toFixed(2) * 0.06) + '</td>' + '</tr>');
	} else {
		$('.table-estimate > tfoot').append('<tr>' + '<td colspan="2" style="text-align:left;padding: 0px 0px 0px 5px;"><b>Jumlah Bayaran Premium</b></td>' + 
			'<td style="text-align:right"><b>' + formatCurrency(col5Total.toFixed(2)) + '</b></td>' + '<td style="text-align:right"><b>' + 
			formatCurrency(col6Total.toFixed(2)) + '</b></td>' + '<td style="text-align:right"><b>' + formatCurrency(col7Total.toFixed(2)) + '</b></td>' + 
			'<td style="text-align:right"><b>' + formatCurrency(col8Total.toFixed(2)) + '</b></td>' + '</tr>');
		$('.table-tax > tbody').append('<tr>' + '<td style="text-align:left">Cukai Perkhidmatan yang Dikenakan</td>' + 
			'<td style="text-align:center">' + formatCurrency(col5Total.toFixed(2) * 0.06) + '</td>' + '<td style="text-align:center">' + 
			formatCurrency(col6Total.toFixed(2) * 0.06) + '</td>' + '<td style="text-align:center">' + formatCurrency(col7Total.toFixed(2) * 0.06) + '</td>' +
			'<td style="text-align:center">' + formatCurrency(col8Total.toFixed(2) * 0.06) + '</td>' + '</tr>');
	}
}

var PremiumDurationCount = 0;
function writePremiumDuration(lang)
{
    var premiumPayableUntill = gdata.SI[0].Trad_Details.data[0].PremiumPayableUntill;    
	PremiumDurationCount++;
	LAAge = gdata.SI[0].SI_Temp_trad_LA.data[0].Age;
    
	if(gdata.SI[0].PlanCode == "HLACP")
	{
		if (lang == "EN") {
	        $(".table-duration > tbody").append('<tr><td style="text-align:left">' + getPlanRider(gdata.SI[0].PlanCode) + 
	        	'</td><td style="text-align:center">Basic Plan</td><td style="text-align:center">Life Assured</td><td style="text-align:center">' +
	        	(parseInt(LAAge) + 6) + '</td></tr>');
	    } else {
	        $(".table-duration > tbody").append('<tr><td style="text-align:left">' + getPlanRider(gdata.SI[0].PlanCode) +
	        	'</td><td style="text-align:center">Pelan Asas</td><td style="text-align:center">Hayat Diinsuranskan</td><td style="text-align:center">' +
	        	(parseInt(LAAge) + 6) + '</td></tr>');
        }
	}
	else if(gdata.SI[0].PlanCode == "HLAWP")
	{
	    if (lang == "EN") {
	        $(".table-duration > tbody").append('<tr><td style="text-align:left">' + getPlanRider(gdata.SI[0].PlanCode) + 
	        	'</td><td style="text-align:center">Basic Plan</td><td style="text-align:center">Life Assured</td><td style="text-align:center">' +
	        	premiumPayableUntill + '</td></tr>');
	    } else {
	        $(".table-duration > tbody").append('<tr><td style="text-align:left">' + getPlanRider(gdata.SI[0].PlanCode) + 
	        	'</td><td style="text-align:center">Pelan Asas</td><td style="text-align:center">Hayat Diinsuranskan</td><td style="text-align:center">' +
	        	premiumPayableUntill + '</td></tr>');    
		}
	}
	else if(gdata.SI[0].PlanCode == "S100" || gdata.SI[0].PlanCode == "L100")
	{	
		term = gdata.SI[0].SI_Temp_Trad_Details.data[0].col4;
		if (term == 100) {
			LAAge = term;
		} else {
			LAAge = parseInt(LAAge) + parseInt(term);
		} 
		if (lang == "EN") {
			$(".table-duration > tbody").append('<tr><td style="text-align:left">' + getPlanRider(gdata.SI[0].PlanCode) + 
				'</td><td style="text-align:center">Basic Plan</td><td style="text-align:center">Life Assured</td><td style="text-align:center">'+LAAge+'</td></tr>');
	   } else {
	       	$(".table-duration > tbody").append('<tr><td style="text-align:left">' + getPlanRider(gdata.SI[0].PlanCode) + 
	       		'</td><td style="text-align:center">Pelan Asas</td><td style="text-align:center">Hayat Diinsuranskan</td><td style="text-align:center">'+LAAge+'</td></tr>');
	    }
	}
    
    var tempArray = [];
	if(gdata.SI[0].PlanCode == "HLAWP")
	{
		$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, Trad_Rider_Details) {
			if (Trad_Rider_Details.PlanOption == "(null)" || Trad_Rider_Details.PlanOption == "")
			{
				var PayingTerm = Trad_Rider_Details.PayingTerm;
				PremiumDurationCount++;
				
				if (lang == "EN") { //english
					if(Trad_Rider_Details.RiderCode == 'ETPDB' || Trad_Rider_Details.RiderCode == 'EDB' ) {
						LAAge = gdata.SI[0].SI_Temp_trad_LA.data[0].Age;
						$(".table-duration > tbody").append('<tr><td style="text-align:left">' + getPlanRider(Trad_Rider_Details.RiderCode) + 
						'</td><td style="text-align:center">Rider</td><td style="text-align:center">' + Insured(Trad_Rider_Details.PTypeCode, Trad_Rider_Details.Seq) +
						'</td><td style="text-align:center">' + premiumPayableUntill +
						'</td></tr>');
					} else if(Trad_Rider_Details.RiderCode == 'PLCP' || Trad_Rider_Details.RiderCode == 'LCWP') {
						tempArray.push(Trad_Rider_Details);		  
					} else {
						if(Trad_Rider_Details.PTypeCode == 'LA' && Trad_Rider_Details.Seq == '1') { //1st life assured
							LAAge = gdata.SI[0].SI_Temp_trad_LA.data[0].Age;
						} else if(Trad_Rider_Details.PTypeCode == 'LA' && Trad_Rider_Details.Seq == '2') { //2nd life assured
							LAAge = gdata.SI[0].SI_Temp_trad_LA.data[1].Age;
					  	} else { //payor	
						  	LAAge = gdata.SI[0].SI_Temp_trad_LA.data[1].Age;
					  	}
					  	
					  	$(".table-duration > tbody").append('<tr><td style="text-align:left">' + getPlanRider(Trad_Rider_Details.RiderCode) +
					  	'</td><td style="text-align:center">Rider</td><td style="text-align:center">' + Insured(Trad_Rider_Details.PTypeCode, Trad_Rider_Details.Seq) +
					  	'</td><td style="text-align:center">' + (parseInt(LAAge) + parseInt(PayingTerm)) + 
					  	'</td></tr>');
					}
				} else { //bm
					if(Trad_Rider_Details.RiderCode == 'ETPDB' || Trad_Rider_Details.RiderCode == 'EDB' ){
						LAAge = gdata.SI[0].SI_Temp_trad_LA.data[0].Age;
					  	$(".table-duration > tbody").append('<tr><td style="text-align:left">' + getPlanRider(Trad_Rider_Details.RiderCode) + 
					  	'</td><td style="text-align:center">Rider</td><td style="text-align:center">' + InsuredBM(Trad_Rider_Details.PTypeCode, Trad_Rider_Details.Seq) + 
					  	'</td><td style="text-align:center">' + premiumPayableUntill +
					  	'</td></tr>');
					} else if(Trad_Rider_Details.RiderCode == 'PLCP' || Trad_Rider_Details.RiderCode == 'LCWP') {
						tempArray.push(Trad_Rider_Details);
					} else {
						if(Trad_Rider_Details.PTypeCode == 'LA' && Trad_Rider_Details.Seq == '1') { //1st life assured
							LAAge = gdata.SI[0].SI_Temp_trad_LA.data[0].Age;
						} else if(Trad_Rider_Details.PTypeCode == 'LA' && Trad_Rider_Details.Seq == '2') { //2nd life assured
						  	LAAge = gdata.SI[0].SI_Temp_trad_LA.data[1].Age;
						} else { //payor
							LAAge = gdata.SI[0].SI_Temp_trad_LA.data[1].Age;
						}
						
					  	$(".table-duration > tbody").append('<tr><td style="text-align:left">' + getPlanRider(Trad_Rider_Details.RiderCode) + 
					  	'</td><td style="text-align:center">Rider</td><td style="text-align:center">' + InsuredBM(Trad_Rider_Details.PTypeCode, Trad_Rider_Details.Seq) + 
					  	'</td><td style="text-align:center">' + (parseInt(LAAge) + parseInt(PayingTerm)) +
					  	'</td></tr>');
					}
				}
			}
		});	    
		
		if(tempArray.length > 0){
			var LAAge = gdata.SI[0].SI_Temp_trad_LA.data[1].Age;
			var PayingTerm = tempArray[0].PayingTerm;
			
			if (lang == "EN"){
				$(".table-duration > tbody").append('<tr><td style="text-align:left">' + getPlanRider(tempArray[0].RiderCode) +
				'</td><td style="text-align:center">Rider</td><td style="text-align:center">' + Insured(tempArray[0].PTypeCode, tempArray[0].Seq) + 
				'</td><td style="text-align:center">' + (parseInt(LAAge) + parseInt(PayingTerm)) + 
				'</td></tr>');
			
				if(tempArray.length > 1){
					PayingTerm = tempArray[1].PayingTerm;
					$(".table-duration > tbody").append('<tr><td style="text-align:left">' + getPlanRider(tempArray[1].RiderCode) +
					'</td><td style="text-align:center">Rider</td><td style="text-align:center">' + Insured(tempArray[1].PTypeCode, tempArray[1].Seq) +
					'</td><td style="text-align:center">' + (parseInt(LAAge) + parseInt(PayingTerm)) + 
					'</td></tr>');		
				}
			} else {
				$(".table-duration > tbody").append('<tr><td style="text-align:left">' + getPlanRider(tempArray[0].RiderCode) + 
				'</td><td style="text-align:center">Rider</td><td style="text-align:center">' + InsuredBM(tempArray[0].PTypeCode, tempArray[0].Seq) + 
				'</td><td style="text-align:center">' + (parseInt(LAAge) + parseInt(PayingTerm)) + 
				'</td></tr>');
			
				if(tempArray.length > 1){
					PayingTerm = tempArray[1].PayingTerm;
					$(".table-duration > tbody").append('<tr><td style="text-align:left">' + getPlanRider(tempArray[1].RiderCode) + 
					'</td><td style="text-align:center">Rider</td><td style="text-align:center">' + InsuredBM(tempArray[1].PTypeCode, tempArray[1].Seq) + 
					'</td><td style="text-align:center">' + (parseInt(LAAge) + parseInt(PayingTerm)) +
					'</td></tr>');		
				}
			}			
		}
	} else {
		$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, Trad_Rider_Details) {
			if (Trad_Rider_Details.PlanOption == "(null)" || Trad_Rider_Details.PlanOption == "") {
				PremiumDurationCount++;
				
				if (lang == "EN") { //english
					if(Trad_Rider_Details.RiderCode == 'ETPDB' || Trad_Rider_Details.RiderCode == 'EDB' ) {
						LAAge = gdata.SI[0].SI_Temp_trad_LA.data[0].Age;
						$(".table-duration > tbody").append('<tr><td style="text-align:left">' + getPlanRider(Trad_Rider_Details.RiderCode) + 
						'</td><td style="text-align:center">Rider</td><td style="text-align:center">' + Insured(Trad_Rider_Details.PTypeCode, Trad_Rider_Details.Seq) + 
						'</td><td style="text-align:center">' + (parseInt(LAAge) + parseInt(6)) + 
						'</td></tr>');
               		} else {
						if(Trad_Rider_Details.PTypeCode == 'LA' && Trad_Rider_Details.Seq == '1') { //1st life assured
							LAAge = gdata.SI[0].SI_Temp_trad_LA.data[0].Age;
						} else if(Trad_Rider_Details.PTypeCode == 'LA' && Trad_Rider_Details.Seq == '2') { //2nd life assured
							LAAge = gdata.SI[0].SI_Temp_trad_LA.data[1].Age;
						} else { //payor
							LAAge = gdata.SI[0].SI_Temp_trad_LA.data[1].Age;
						}
						$(".table-duration > tbody").append('<tr><td style="text-align:left">' + getPlanRider(Trad_Rider_Details.RiderCode) + 
						'</td><td style="text-align:center">Rider</td><td style="text-align:center">' + Insured(Trad_Rider_Details.PTypeCode, Trad_Rider_Details.Seq) + 
						'</td><td style="text-align:center">' + (parseInt(LAAge) + parseInt(Trad_Rider_Details.RiderTerm)) +
						'</td></tr>');	
				   }
				} else { //bm
					if(Trad_Rider_Details.RiderCode == 'ETPDB' || Trad_Rider_Details.RiderCode == 'EDB' ) {
						LAAge = gdata.SI[0].SI_Temp_trad_LA.data[0].Age;
						$(".table-duration > tbody").append('<tr><td style="text-align:left">' + getPlanRider(Trad_Rider_Details.RiderCode) +
						'</td><td style="text-align:center">Rider</td><td style="text-align:center">' + InsuredBM(Trad_Rider_Details.PTypeCode, Trad_Rider_Details.Seq) + 
						'</td><td style="text-align:center">' + (parseInt(LAAge) + parseInt(6)) +
						'</td></tr>');
					} else {
						if(Trad_Rider_Details.PTypeCode == 'LA' && Trad_Rider_Details.Seq == '1') { //1st life assured
							LAAge = gdata.SI[0].SI_Temp_trad_LA.data[0].Age;
						} else if(Trad_Rider_Details.PTypeCode == 'LA' && Trad_Rider_Details.Seq == '2') { //2nd life assured
							LAAge = gdata.SI[0].SI_Temp_trad_LA.data[1].Age;
						} else { //payor
							LAAge = gdata.SI[0].SI_Temp_trad_LA.data[1].Age;
						}
						$(".table-duration > tbody").append('<tr><td style="text-align:left">' + getPlanRider(Trad_Rider_Details.RiderCode) + 
						'</td><td style="text-align:center">Rider</td><td style="text-align:center">' + InsuredBM(Trad_Rider_Details.PTypeCode, Trad_Rider_Details.Seq) +
						'</td><td style="text-align:center">' + (parseInt(LAAge) + parseInt(Trad_Rider_Details.RiderTerm)) + 
						'</td></tr>');
					}
				}
			}
		});
    }
}

function writeItem456_page3_page4()
{
	var temp;
	if (document.getElementById('durPage2') == null) {
		$(".item4-page3").show();
		$(".item5-page3").hide();
		$(".item6-page3").hide();		
		
		$(".item4-page4").hide();
		$(".item5-page4").show();
		$(".item6-page4").show();
	} else {
        document.getElementById('durationblock').innerHTML = "";    
		$(".item4-page3").hide();
		$(".item5-page3").hide();
		$(".item6-page3").hide();
		
		$(".item4-page4").show();
		$(".item5-page4").show();
		$(".item6-page4").show();
	}
}

function writeAttachingRider_1(lang)
{
	var tblHeader = "";
	var textExist = false;
	$.each(gdata.SI[0].SI_Temp_Pages_PDS.data, function(index, row) {
		if (row.riders != "" && row.riders != "(null)" && row.riders.substring(0,1) == "2"){
			riders = row.riders.substring(2);

			if(riders.charAt(riders.length-1) == ";"){
				rider = riders.slice(0, -1).split(";");
			} else {
				rider = riders.split(";");
			}
		   
			for (i=0;i<rider.length;i++) {
				tblRider = "#" + row.PageDesc + " #table-attachingRider1 tr." + rider[i];
				$(tblRider).css('display','table-row');
		
				if (rider[0] != "tblHeader") {
					$("#" + row.PageDesc + ' .2B').html('');
				} else {
					if(textExist == false) {
						if (lang == "EN") {
							$("#" + row.PageDesc + " .showOnlyAtFirstPage").html('<b><u>Attaching Rider(s)</u></b>');	
						} else {
							$("#" + row.PageDesc + " .showOnlyAtFirstPage").html('<b><u>Rider yang Dilampirkan</u></b>');	
						}
						textExist = true;
					}
				}
		
				if (rider[i] == "ACIR_MPP")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if (rowRider.RiderCode == "ACIR_MPP"){
							$("#" + row.PageDesc + " .ACIR_MPPRiderTerm").html(rowRider.RiderTerm);
							$("#" + row.PageDesc + " .ACIR_MPPRiderGYI").html(formatCurrency(rowRider.SumAssured)+"");
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
						}
					});
				}
				else if (rider[i] == "CCTR")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if (rowRider.RiderCode == "CCTR"){
							$("#" + row.PageDesc + " .CCTRRiderTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .CCTRRiderGYI").html(formatCurrency(rowRider.SumAssured)+"");
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
						}
					});
				} 
				else if (rider[i] == "CIR")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if (rowRider.RiderCode == "CIR"){
							$("#" + row.PageDesc + " .CIRRiderTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .CIRRiderGYI").html(formatCurrency(rowRider.SumAssured)+"");					
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
						}
					});
				} 
				else if (rider[i] == "CIWP") 
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if (rowRider.RiderCode == "CIWP"){
							$("#" + row.PageDesc + " .CIWPRiderTerm").html(rowRider.RiderTerm);
							$("#" + row.PageDesc + " .CIWPSA").html('('+CurrencyNoCents(rowRider.SumAssured)+'%)');
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
							$.each(gdata.SI[0].SI_Temp_Trad_Details.data, function(rowIndex, rowTemp) {
								if (rowTemp.RiderCode == "CIWP"){
									if(rowTemp.col2 == '-'){
										if (gdata.SI[0].PlanCode == "S100")  {
											$("#" + row.PageDesc + " .CIWPRiderGYI").html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Details.data[rowIndex+1].col2));
										} else {
											$("#" + row.PageDesc + " .CIWPRiderGYI").html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Details.data[rowIndex+1].col5));
										}
									}
								}
							});
						}
					});
				}
				else if (rider[i] == "CPA")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if (rowRider.RiderCode == "CPA"){
							$("#" + row.PageDesc + " .CPARiderTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .CPARiderGYI").html(formatCurrency(rowRider.SumAssured)+"");
						}
					});
				}
				else if (rider[i] == "EDB")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if (rowRider.RiderCode == "EDB"){
							$("#" + row.PageDesc + " .EDBRiderTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .EDBRiderGYI").html(formatCurrency(rowRider.SumAssured)+"");
							$("#" + row.PageDesc + " .EDBGYI").html(formatCurrency(rowRider.SumAssured)+"");
						}
					});
				}
				else if (rider[i] == "EDUWR")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if (rowRider.RiderCode == "EDUWR"){
							var covPeriod = 21 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age);
							$("#" + row.PageDesc + " .EDUWRTerm").html(rowRider.RiderTerm);
							$("#" + row.PageDesc + " .EDUWRGYI").html(formatCurrency(rowRider.SumAssured)+"");
						}
					});
				}
				else if (rider[i] == "ETPDB")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if (rowRider.RiderCode == "ETPDB"){
							$("#" + row.PageDesc + " .ETPDBRiderTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .ETPDBRiderGYI").html(formatCurrency(rowRider.SumAssured)+"");
							$("#" + row.PageDesc + " .ETPDBGYI").html(formatCurrency(rowRider.SumAssured)+"");
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
						}
					});
				}
				else if (rider[i] == "HB")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if (rowRider.RiderCode == "HB"){
							$("#" + row.PageDesc + " .HBRiderTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .HBRiderGYI").html(rowRider.Units + ' unit(s)');
							$("#" + row.PageDesc + " .HBRiderGYI_BM").html(rowRider.Units + ' unit');
							$("#" + row.PageDesc + " .HBBenefit").html(parseInt(rowRider.Units) * 45+".00");
						}
					});
				}
				else if (rider[i] == "ICR")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if (rowRider.RiderCode == "ICR"){
							$("#" + row.PageDesc + " .ICRRiderTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .ICRRiderGYI").html(formatCurrency(rowRider.SumAssured)+"");
							$("#" + row.PageDesc + " .ICRGYI").html(formatCurrency(rowRider.SumAssured)+"");
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
						}
					});
				}
				else if (rider[i] == "LCPR")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if (rowRider.RiderCode == "LCPR"){
							$("#" + row.PageDesc + " .LCPRRiderTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .LCPRRiderGYI").html(formatCurrency(rowRider.SumAssured)+"");
							$("#" + row.PageDesc + " .LCPRGYI").html(formatCurrency(rowRider.SumAssured)+"");
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
						}
					});
				}
				else if (rider[i] == "PA")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if (rowRider.RiderCode == "PA"){
							$("#" + row.PageDesc + " .PARiderTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .PARiderGYI").html(formatCurrency(rowRider.SumAssured)+"");
						}
					});
				}
				else if (rider[i] == "TPDYLA")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if (rowRider.RiderCode == "TPDYLA"){
							$("#" + row.PageDesc + " .ETPDRiderTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .ETPDRiderGYI").html(formatCurrency(rowRider.SumAssured)+"");
							$("#" + row.PageDesc + " .ETPDGYI").html(formatCurrency(rowRider.SumAssured)+"");
						}
					});
				}
				else if (rider[i] == "WBI6R30")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if (rowRider.RiderCode == "WBI6R30"){
							$("#" + row.PageDesc + " .WBI6R30Term").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .WBI6R30GYI").html(formatCurrency(rowRider.SumAssured)+"");
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
						}
					});
				}
				else if (rider[i] == "WBM6R")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if (rowRider.RiderCode == "WBM6R"){
							$("#" + row.PageDesc + " .WBM6RTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .WBM6RGYI").html(formatCurrency(rowRider.SumAssured)+"");
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
						}
					});
				}
				else if (rider[i] == "WA50R")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if (rowRider.RiderCode == "WA50R"){
							$("#" + row.PageDesc + " .WA50RTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .WA50RGYI").html(formatCurrency(rowRider.SumAssured)+"");
						}
					});
				}
				else if (rider[i] == "WB30R")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if  (rowRider.RiderCode == "WB30R"){
							$("#" + row.PageDesc + " .WB30RTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .WB30RGYI").html(formatCurrency(rowRider.SumAssured)+"");
						}
					});
				}
				else if (rider[i] == "WB50R")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if  (rowRider.RiderCode == "WB50R"){
							$("#" + row.PageDesc + " .WB50RTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .WB50RGYI").html(formatCurrency(rowRider.SumAssured)+"");
						}
					});
				}
				else if (rider[i] == "WBD10R30")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if  (rowRider.RiderCode == "WBD10R30"){
							$("#" + row.PageDesc + " .WBD10R30Term").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .WBD10R30GYI").html(formatCurrency(rowRider.SumAssured)+"");
						}
					});
				}
				else if (rider[i] == "WE50R")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if  (rowRider.RiderCode == "WE50R"){
							$("#" + row.PageDesc + " .WE50RTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .WE50RGYI").html(formatCurrency(rowRider.SumAssured)+"");
						}
					});
				}
				else if (rider[i] == "WP30R")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if  (rowRider.RiderCode == "WP30R"){
							$("#" + row.PageDesc + " .WP30RTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .WP30RSum").html(formatCurrency(rowRider.SumAssured)+"");		      
						}
					});
				}
				else if (rider[i] == "WP50R")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if  (rowRider.RiderCode == "WP50R"){
							$("#" + row.PageDesc + " .WP50RTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .WP50RSum").html(formatCurrency(rowRider.SumAssured)+"");		      
						}
					});
				}
				else if (rider[i] == "WPTPD30R")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if  (rowRider.RiderCode == "WPTPD30R"){
							$("#" + row.PageDesc + " .WPTPD30RTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .WPTPD30RRiderGYI").html(formatCurrency(rowRider.SumAssured)+"");
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
						}
					});
				}
				else if (rider[i] == "WPTPD50R")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if  (rowRider.RiderCode == "WPTPD50R"){
							$("#" + row.PageDesc + " .WPTPD50RTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .WPTPD50RRiderGYI").html(formatCurrency(rowRider.SumAssured)+"");
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
						}
					});
				}
				else if (rider[i] == "LCWP")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if (rowRider.RiderCode == "LCWP"){
							$("#" + row.PageDesc + " .LCWPRiderTerm").html(rowRider.RiderTerm);
							$("#" + row.PageDesc + " .LCWPSA").html('('+CurrencyNoCents(rowRider.SumAssured)+'%)');
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
					
							$.each(gdata.SI[0].SI_Temp_Trad_Details.data, function(rowIndex, rowTemp) {
								if (rowTemp.RiderCode == "LCWP"){
									if(rowTemp.col2 == '-'){
										if (gdata.SI[0].PlanCode == "S100")  {
											$("#" + row.PageDesc + " .LCWPRRiderGYI").html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Details.data[rowIndex+1].col2));	
										} else {
											$("#" + row.PageDesc + " .LCWPRRiderGYI").html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Details.data[rowIndex+1].col5));	
										}
									}
								}
							});
					
							if(rowRider.PTypeCode == "LA"){
								$("#" + row.PageDesc + " .LCWPInsuredLives").html('2nd Life<br/>Assured');
								$("#" + row.PageDesc + " .LCWPInsuredLives_BM").html('Hayat<br/>Diinsuranskan<br/>ke-2');
							}
							else if (rowRider.PTypeCode == "PY")
							{
								$("#" + row.PageDesc + " .LCWPInsuredLives").html('Policy<br/>Owner');
								$("#" + row.PageDesc + " .LCWPInsuredLives_BM").html('Pemunya<br/>Polisi');
							}
							else
							{
								$("#" + row.PageDesc + " .LCWPInsuredLives").html('Payor');
								$("#" + row.PageDesc + " .LCWPInsuredLives_BM").html('Payor');
							}
						}
					});
				}
				else if (rider[i] == "PR")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "PR"){
							$("#" + row.PageDesc + " .PRRiderTerm").html(rowRider.RiderTerm);
							$("#" + row.PageDesc + " .PRSA").html('('+CurrencyNoCents(rowRider.SumAssured)+'%)');
							$.each(gdata.SI[0].SI_Temp_Trad_Details.data, function(rowIndex, rowTemp) {
								if (rowTemp.RiderCode == "PR"){
									if(rowTemp.col2 == '-'){
										if (gdata.SI[0].PlanCode == "S100")  {
											$("#" + row.PageDesc + " .PRRiderGYI").html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Details.data[rowIndex+1].col2));
										} else {
											$("#" + row.PageDesc + " .PRRiderGYI").html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Details.data[rowIndex+1].col5));
										}
									}
								}
							});
					
							if(rowRider.PTypeCode == "LA"){
								$("#" + row.PageDesc + " .PRInsuredLives").html('2nd Life<br/>Assured');
								$("#" + row.PageDesc + " .PRInsuredLives_BM").html('Hayat<br/>Diinsuranskan<br/>ke-2');
							}
							else if (rowRider.PTypeCode == "PY")
							{
								$("#" + row.PageDesc + " .PRInsuredLives").html('Policy<br/>Owner');
								$("#" + row.PageDesc + " .PRInsuredLives_BM").html('Pemunya<br/>Polisi');
							}
							else
							{
								$("#" + row.PageDesc + " .PRInsuredLives").html('Payor');
								$("#" + row.PageDesc + " .PRInsuredLives_BM").html('Payor');
							}
						}
					});
				}
				else if (rider[i] == "SP_STD")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if (rowRider.RiderCode == "SP_STD"){
							$("#" + row.PageDesc + " .SP_STDRiderTerm").html(rowRider.RiderTerm);
							$("#" + row.PageDesc + " .SP_STDSA").html('('+CurrencyNoCents(rowRider.SumAssured)+'%)');
							$.each(gdata.SI[0].SI_Temp_Trad_Details.data, function(rowIndex, rowTemp) {
								if (rowTemp.RiderCode == "SP_STD"){
									if(rowTemp.col2 == '-'){
										if (gdata.SI[0].PlanCode == "S100")  {
											$("#" + row.PageDesc + " .SP_STDRiderGYI").html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Details.data[rowIndex+1].col2));
										} else {
											$("#" + row.PageDesc + " .SP_STDRiderGYI").html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Details.data[rowIndex+1].col5));
										}
									}
								}
							});
						}
					});
				}
				else if (rider[i] == "SP_PRE")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if (rowRider.RiderCode == "SP_PRE"){
							$("#" + row.PageDesc + " .SP_PRERiderTerm").html(rowRider.RiderTerm);
							$("#" + row.PageDesc + " .SP_PRESA").html('('+CurrencyNoCents(rowRider.SumAssured)+'%)');
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
					
							$.each(gdata.SI[0].SI_Temp_Trad_Details.data, function(rowIndex, rowTemp) {
								if (rowTemp.RiderCode == "SP_PRE"){
									if(rowTemp.col2 == '-'){
										if (gdata.SI[0].PlanCode == "S100")  {
											$("#" + row.PageDesc + " .SP_PRERiderGYI").html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Details.data[rowIndex+1].col2));
										} else {
											$("#" + row.PageDesc + " .SP_PRERiderGYI").html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Details.data[rowIndex+1].col5));
										}
									}
								}
							});
						}
					});
				}
				else if (rider[i] == "PLCP")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if  (rowRider.RiderCode == "PLCP"){
							$("#" + row.PageDesc + " .PLCPRiderTerm").html(rowRider.RiderTerm);
							$("#" + row.PageDesc + " .PLCPRiderGYI").html(formatCurrency(rowRider.SumAssured)+"");
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
						}
					});
				}
				else if (rider[i] == "PTR")
				{
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
						if  (rowRider.RiderCode == "PTR"){
							$("#" + row.PageDesc + " .PTRRiderTerm").html(rowRider.RiderTerm);
							$("#" + row.PageDesc + " .PTRRiderGYI").html(formatCurrency(rowRider.SumAssured)+"");
							$("#" + row.PageDesc + " .PTRGYI").html(formatCurrency(rowRider.SumAssured)+"");
						}
					});
				}
			}
		}
    });
}

function writeAttachingRider_1_2()
{
	var tblHeader = "";
	$.each(gdata.SI[0].SI_Temp_Pages_PDS.data, function(index, row) {
           
		if (row.riders != "" && row.riders != "(null)" && row.riders.substring(0,1) == "2"){
			riders = row.riders.substring(2);
		   
			if(riders.charAt(riders.length-1) == ";"){
			     rider = riders.slice(0, -1).split(";");
			}
			else{
			     rider = riders.split(";");
			}
		   
			for (i=0;i<rider.length;i++){
				tblRider = "#" + row.PageDesc + " #table-attachingRider1_2 tr." + rider[i];
				$(tblRider).css('display','table-row');	
				if (rider[0] != "tblHeader") {
					$("#" + row.PageDesc + ' .2B').html('');
					if (rider[i] == "WBI6R30"){
						$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
							if (rowRider.RiderCode == "WBI6R30"){
								$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
							}
						});
					}
				}
			}
		}
    });
}

function writeAttachingRider_2(lang)
{
	var tblHeader = "";
	var textExist = false;
	$.each(gdata.SI[0].SI_Temp_Pages_PDS.data, function(index, row) {
		if (row.riders != "" && row.riders != "(null)" && row.riders.substring(0,1) == "5"){
			riders = row.riders.substring(2);
			if(riders.charAt(riders.length-1) == ";") {
				rider = riders.slice(0, -1).split(";");
			} else {
				rider = riders.split(";");
			}
			
			for (i=0;i<rider.length;i++){
				if (rider[i] == 'tblFooter') {
					tblFooter = "#" + row.PageDesc + " #rujuk";
					$(tblFooter).css('display','inline');
				} else if (!textExist && rider[i] == 'tblHeader') {
					if (lang == "EN") {
						$("#showOnlyAtFirstPage2").html('<b><u>Attaching Rider(s)</u></b>');	
					} else {
						$("#showOnlyAtFirstPage2").html('<b><u>Rider yang Dilampirkan</u></b>');	
					}
					textExist = true;
				}
				
				if (rider[i] == "LCWP" || rider[i] == "CIWP" || rider[i] == "PR" || rider[i] == "SP_PRE" || rider[i] == "SP_STD"){
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(idx, rowRider) {
						if (rowRider.RiderCode == rider[i]){
							$("#" + row.PageDesc + " ."+rider[i]+"SA").html('('+CurrencyNoCents(rowRider.SumAssured)+'%)');
						}
					});	
				}
				tblRider = "#" + row.PageDesc + " #table-attachingRider2 tr." + rider[i];
				$(tblRider).css('display','table-row');
			}
		}
	});	
}

function writeAttachingRider_2_2()
{
	var tblHeader = "";
	$.each(gdata.SI[0].SI_Temp_Pages_PDS.data, function(index, row) {
		if (row.riders != "" && row.riders != "(null)" && row.riders.substring(0,1) == "5"){
			riders = row.riders.substring(2);

			if(riders.charAt(riders.length-1) == ";"){
				rider = riders.slice(0, -1).split(";");
			} else {
				rider = riders.split(";");
			}
			
			for (i=0;i<rider.length;i++){
				if (rider[i] == 'tblFooter'){
					tblFooter = "#" + row.PageDesc + " #rujuk"
					$(tblFooter).css('display','inline');
				}

				tblRider = "#" + row.PageDesc + " #table-attachingRider2_2 tr." + rider[i];
				$(tblRider).css('display','table-row');
			}
		}
	});	
}

function writeCancel(lang)
{
	var desc = new Array();
	desc[0] = "If you terminate this rider prematurely, you may get less than the amount you have paid.";
	desc[1] = "If you terminate this rider prematurely, there will be no refund and the termination will take effect from next premium due date if the Basic Policy remains in force.";
	desc[2] = "Upon cancellation, you are entitled to a certain amount of refund of the premium provided that you have not made any claim on the policy.";
	
	var descBM = new Array();
	descBM[0] = "Jika anda menamatkan rider ini sebelum tempoh matang, anda akan mendapat kurang daripada jumlah yang telah anda bayar.";
	descBM[1] = "Jika rider ini ditamatkan sebelum tempoh matang, tidak akan ada pembayaran balik dan penamatan tersebut akan berkuat kuasa dari tarikh genap tempoh premium yang berikutnya jika Polisi Asas masih berkuat kuasa.";
	descBM[2] = "Jika tiada tuntutan dibuat, anda akan menerima kembali premium yang ditetapkan.";
	
	toHide = 1;
	$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, Trad_Rider_Details) {
    	if (Trad_Rider_Details.PlanOption == "(null)" || Trad_Rider_Details.PlanOption == "")
        {
        	if (Trad_Rider_Details.RiderCode == "CCTR"){
        		toHide = 0;
				if (lang == "EN") {
					temp = desc[0];
				} else {
					temp = descBM[0];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' +
					getPlanRider(Trad_Rider_Details.RiderCode) + '</td><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + temp + '</td></tr>');
			}
			else if (Trad_Rider_Details.RiderCode == "ACIR_MPP")
			{
				toHide = 0;
				if (lang == "EN") {
					temp = desc[0];
				} else {
					temp = descBM[0];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' +
					getPlanRider(Trad_Rider_Details.RiderCode) + '</td><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + temp + '</td></tr>');
			}
			else if (Trad_Rider_Details.RiderCode == "CIR")
			{
				toHide = 0;
				if (lang == "EN") {
					temp = desc[0];
				} else {
					temp = descBM[0];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' +
					getPlanRider(Trad_Rider_Details.RiderCode) + '</td><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + temp + '</td></tr>')
			}
			else if (Trad_Rider_Details.RiderCode == "CIWP")
			{
				toHide = 0;
				if (lang == "EN") {
				temp = desc[0];
				} else {
					temp = descBM[0];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' +
					getPlanRider(Trad_Rider_Details.RiderCode) + '</td><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + temp + '</td></tr>')
			}
			else if (Trad_Rider_Details.RiderCode == "CPA")
			{
				toHide = 0;
				if (lang == "EN") {
					temp = desc[1];
				} else {
					temp = descBM[1];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' +
					getPlanRider(Trad_Rider_Details.RiderCode) + '</td><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + temp + '</td></tr>')
			}
			else if (Trad_Rider_Details.RiderCode == "EDB")
			{
				toHide = 0;
				if (lang == "EN") {
					temp = desc[0];
				} else {
					temp = descBM[0];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + 
					getPlanRider(Trad_Rider_Details.RiderCode) + '</td><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + temp + '</td></tr>')
			}
			else if (Trad_Rider_Details.RiderCode == "TPDYLA")
			{
				toHide = 0;
				if (lang == "EN") {
					temp = desc[1];
				} else {
					temp = descBM[1];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + 
					getPlanRider(Trad_Rider_Details.RiderCode) + '</td><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + temp + '</td></tr>')
			}
			else if (Trad_Rider_Details.RiderCode == "ETPDB")
			{
				toHide = 0;
				if (lang == "EN") {
					temp = desc[0];
				} else {
					temp = descBM[0];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + 
					getPlanRider(Trad_Rider_Details.RiderCode) + '</td><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + temp + '</td></tr>')
			}
			else if (Trad_Rider_Details.RiderCode == "HB")
			{
				toHide = 0;
				if (lang == "EN") {
					temp = desc[2];
				} else {
					temp = descBM[2];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 0px 0px 0px 5px;">' + 
					getPlanRider(Trad_Rider_Details.RiderCode) + '</td><td style="padding: 0px 0px 0px 5px;">' + temp + '</td></tr>')
			}
			else if (Trad_Rider_Details.RiderCode == "ICR")
			{
				toHide = 0;
				if (lang == "EN") {
					temp = desc[1];
				} else {
					temp = descBM[1];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + 
					getPlanRider(Trad_Rider_Details.RiderCode) + '</td><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + temp + '</td></tr>')
			}
			else if (Trad_Rider_Details.RiderCode == "LCPR")
			{
				toHide = 0;
				if (lang == "EN") {
					temp = desc[0];
				} else {
					temp = descBM[0];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + 
					getPlanRider(Trad_Rider_Details.RiderCode) + '</td><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + temp + '</td></tr>')
			}
			else if (Trad_Rider_Details.RiderCode == "PA")
			{
				toHide = 0;
				if (lang == "EN") {
					temp = desc[1];
				} else {
					temp = descBM[1];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + 
					getPlanRider(Trad_Rider_Details.RiderCode) + '</td><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + temp + '</td></tr>')
			}
			else if (Trad_Rider_Details.RiderCode == "LCWP")
			{
				toHide = 0;
				if (lang == "EN") {
					temp = desc[0];
				} else {
					temp = descBM[0];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + 
					getPlanRider(Trad_Rider_Details.RiderCode) + '</td><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + temp + '</td></tr>')
			}
			else if (Trad_Rider_Details.RiderCode == "PR")
			{
				toHide = 0;
				if (lang == "EN") {
					temp = desc[0];
				} else {
					temp = descBM[0];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + 
					getPlanRider(Trad_Rider_Details.RiderCode) + '</td><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + temp + '</td></tr>')
			}
			else if (Trad_Rider_Details.RiderCode == "SP_STD")
			{
				toHide = 0;
				if (lang == "EN") {
					temp = desc[0];
				} else {
					temp = descBM[0];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + 
					getPlanRider(Trad_Rider_Details.RiderCode) + '</td><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + temp + '</td></tr>')
			}
			else if (Trad_Rider_Details.RiderCode == "SP_PRE")
			{
				toHide = 0;
				if (lang == "EN") {
					temp = desc[0];
				} else {
					temp = descBM[0];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + 
					getPlanRider(Trad_Rider_Details.RiderCode) + '</td><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + temp + '</td></tr>')
			}
			else if (Trad_Rider_Details.RiderCode == "PLCP")
			{
				toHide = 0;
				if (lang == "EN") {
					temp = desc[0];
				} else {
					temp = descBM[0];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + 
					getPlanRider(Trad_Rider_Details.RiderCode) + '</td><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + temp + '</td></tr>')
			}
			else if (Trad_Rider_Details.RiderCode == "PTR")
			{
				toHide = 0;
				if (lang == "EN") {
					temp = desc[0];
				} else {
					temp = descBM[0];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + 
					getPlanRider(Trad_Rider_Details.RiderCode) + '</td><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + temp + '</td></tr>')
			}
			else if (Trad_Rider_Details.RiderCode == "WB30R")
			{
				toHide = 0;
				if (lang == "EN") {
					temp = desc[0];
				} else {
					temp = descBM[0];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + 
					getPlanRider(Trad_Rider_Details.RiderCode) + '</td><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + temp + '</td></tr>')
			}   
			else if (Trad_Rider_Details.RiderCode == "WB50R")
			{
				toHide = 0;
				if (lang == "EN") {
					temp = desc[0];
				} else {
					temp = descBM[0];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + 
					getPlanRider(Trad_Rider_Details.RiderCode) + '</td><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + temp + '</td></tr>')
			}
			else if (Trad_Rider_Details.RiderCode == "WBI6R30")
			{
				toHide = 0;
				if (lang == "EN") {
					temp = desc[0];
				} else {
					temp = descBM[0];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + 
					getPlanRider(Trad_Rider_Details.RiderCode) + '</td><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + temp + '</td></tr>')
			}
			else if (Trad_Rider_Details.RiderCode == "WBM6R"){
				toHide = 0;
				if (lang == "EN") {
					temp = desc[0];
				} else {
					temp = descBM[0];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + getPlanRider(Trad_Rider_Details.RiderCode) +
					'</td><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + temp + '</td></tr>')
			}
			else if (Trad_Rider_Details.RiderCode == "WBD10R30")
			{
				toHide = 0;
				if (lang == "EN") {
					temp = desc[0];
				} else {
					temp = descBM[0];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + 
					getPlanRider(Trad_Rider_Details.RiderCode) + '</td><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + temp + '</td></tr>')
			}
			else if (Trad_Rider_Details.RiderCode == "EDUWR")
			{
				toHide = 0;
				if (lang == "EN") {
					temp = desc[0];
				} else {
					temp = descBM[0];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + 
					getPlanRider(Trad_Rider_Details.RiderCode) + '</td><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + temp + '</td></tr>')
			}
			else if (Trad_Rider_Details.RiderCode == "WP30R")
			{
				toHide = 0;
				if (lang == "EN") {
					temp = desc[0];
				} else {
					temp = descBM[0];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + 
					getPlanRider(Trad_Rider_Details.RiderCode) + '</td><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + temp + '</td></tr>')
			}
			else if (Trad_Rider_Details.RiderCode == "WP50R")
			{
				toHide = 0;
				if (lang == "EN") {
					temp = desc[0];
				} else {
					temp = descBM[0];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + 
					getPlanRider(Trad_Rider_Details.RiderCode) + '</td><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + temp + '</td></tr>')
			}
			else if (Trad_Rider_Details.RiderCode == "WPTPD30R")
			{
				toHide = 0;
				if (lang == "EN") {
					temp = desc[0];
				} else {
					temp = descBM[0];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + 
					getPlanRider(Trad_Rider_Details.RiderCode) + '</td><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + temp + '</td></tr>')
			}
			else if (Trad_Rider_Details.RiderCode == "WPTPD50R")
			{
				toHide = 0;
				if (lang == "EN") {
					temp = desc[0];
				} else {
					temp = descBM[0];
				}
				$(".table-Cancel > tbody").append('<tr><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + 
					getPlanRider(Trad_Rider_Details.RiderCode) + '</td><td style="padding: 1px 0px 1px 5px;vertical-align: text-top">' + temp + '</td></tr>')
			} 
		}
	});
	
	if (toHide == 1)
	{
        $('.item10BB').css('display','none');
	}
}

function writePDS_C()
{
	$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, row) {
		if (row.RiderCode == "C+"){
			
			CRiderTerm = row.RiderTerm;
			CRiderHL = row.HL1KSA;
			CRiderHLTerm = row.HL1KSATerm;
			CRiderTempHL = row.TempHL1KSA;
			CRiderTempHLTerm = row.TempHL1KSATerm;
			CRiderSA = row.SumAssured;
			
			if(row.PlanOption == 'Level'){
				$('.COption').html('Level Cover');
				$('.COption_BM').html('Perlindungan Biasa');
			}
			else if(row.PlanOption == 'Increasing'){
				$('.COption').html('Increasing Cover');
				$('.COption_BM').html('Perlindungan Meningkat');
			}
			else if(row.PlanOption == 'Level_NCB'){
				$('.COption').html('Level Cover and No Claims Benefit');
				$('.COption_BM').html('Perlindungan Biasa dan Faedah Tanpa Tuntutan');
			}
			else if(row.PlanOption == 'Increasing_NCB'){
				$('.COption').html('Increasing Cover and No Claims Benefit');
				$('.COption_BM').html('Perlindungan Meningkat dan Faedah Tanpa Tuntutan');
			}

			$('.CSumAssured').html(formatCurrency(row.SumAssured));
			$('.CRiderTerm').html(row.RiderTerm);

			$('#VeryEarlyCancers').html('50% of Rider Sum Assured');
			$('#EarlyCancers').html('150% of Rider Sum Assured');
			$('#AdvancedCancers').html('250% of Rider Sum Assured');
			$('#VeryEarlyCancers_BM').html('50% daripada Jumlah Rider Diinsuranskan');
			$('#EarlyCancers_BM').html('150% daripada Jumlah Rider Diinsuranskan');
			$('#AdvancedCancers_BM').html('250% daripada Jumlah Rider Diinsuranskan');
			if(row.PlanOption == 'Level'){ 
				$('#cGuaranteedIncreasingSumAssured').html('');
				$('#cNoClaimBenefit').html('');
				$('#cGuaranteedIncreasingSumAssured_BM').html('');
				$('#cNoClaimBenefit_BM').html('');
				$('.CPayableAge').html((parseInt(row.RiderTerm) + parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age)));
			}
			else if(row.PlanOption == 'Increasing'){ 
				$('#cGuaranteedIncreasingSumAssured').html('<u><b>Guaranteed Increasing Sum Assured</b></u><br/>The Rider Sum Assured shall increase by 10% every 2 years with the first such increase starting on 2nd Anniversary of the Commencement Date of this Policy and the last on the 20th Anniversary of this Policy and<br/>remains level thereafter.<br/><br/>');
				$('#cNoClaimBenefit').html('');
				$('#cGuaranteedIncreasingSumAssured_BM').html('<u><b>Jumlah Diinsuranskan Meningkat Terjamin</b></u><br/>Jumlah Rider Diinsuranskan akan meningkat bersamaan dengan 10% bagi setiap 2 tahun dengan peningkatan pertama tersebut bermula pada Ulang tahun ke-2 bagi Tarikh Permulaan Polisi ini dan<br/>peningkatan yang terakhir pada Ulang tahun ke-20 Polisi dan kekal sama kemudian dari ini.<br/><br/>');
				$('#cNoClaimBenefit_BM').html('');
				$('.CPayableAge').html((parseInt(row.RiderTerm) + parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age)));
			}
			else if(row.PlanOption == 'Level_NCB'){
				$('#cGuaranteedIncreasingSumAssured').html('');
				$('#cNoClaimBenefit').html('<u><b>No Claim Benefit</b></u><br/>Upon survival of the Life Assured on the Expiry Date of this Policy and provided that no claim has been admitted prior to this date, the Company will pay the Policy Owner a No Claim benefit<br/>equivalent to RM ' + formatCurrency(row.SumAssured) + '.<br/><br/>');
				$('#cGuaranteedIncreasingSumAssured_BM').html('');
				$('#cNoClaimBenefit_BM').html('<u><b>Faedah Tanpa Tuntutan</b></u><br/>Selagi Hayat Diinsurankan masih hidup pada Tarikh Tamat Tempoh Polisi ini dengan syarat tiada tuntutanyang dimohon sebelum tarikh tersebut. Syarikat akan membayar Pemunya Polisi Faedah<br/>Tanpa Tuntutan bersamaan dengan RM ' + formatCurrency(row.SumAssured) + '.<br/><br/>');
				$('.CPayableAge').html((parseInt(row.RiderTerm) + parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age)));
			}
			else if(row.PlanOption == 'Increasing_NCB'){
				$('#cGuaranteedIncreasingSumAssured').html('<u><b>Guaranteed Increasing Sum Assured</b></u><br/>The Rider Sum Assured shall increase by 10% every 2 years with the first such increase starting on 2nd Anniversary of the Commencement Date of this Policy and the last on the 20th Anniversary of this Policy and<br/>remains level thereafter.<br/><br/>');
				$('#cNoClaimBenefit').html('<u><b>No Claim Benefit</b></u><br/>Upon survival of the Life Assured on the Expiry Date of this Policy and provided that no claim has been admitted prior to this date, the Company will pay the Policy Owner a No Claim benefit<br/>equivalent to RM ' + formatCurrency(row.SumAssured) + '.<br/><br/>');
				$('#cGuaranteedIncreasingSumAssured_BM').html('<u><b>Jumlah Diinsuranskan Meningkat Terjamin</b></u><br/>Jumlah Rider Diinsuranskan akan meningkat bersamaan dengan 10% bagi setiap 2 tahun dengan peningkatan pertama tersebut bermula pada Ulang tahun ke-2 bagi Tarikh Permulaan Polisi ini dan<br/>peningkatan yang terakhir pada Ulang tahun ke-20 Polisi ini dan kekal sama kemudian dari ini.<br/><br/>');
				$('#cNoClaimBenefit_BM').html('<u><b>Faedah Tanpa Tuntutan</b></u><br/>Selagi Hayat Diinsurankan masih hidup pada Tarikh Tamat Tempoh Polisi ini dengan syarat tiada tuntutanyang dimohon sebelum tarikh tersebut. Syarikat akan membayar Pemunya Polisi Faedah<br/>Tanpa Tuntutan bersamaan dengan RM ' + formatCurrency(row.SumAssured) + '.<br/><br/>');
				$('.CPayableAge').html((parseInt(row.RiderTerm) + parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age)));
			}
			
			$.each(gdata.SI[0].SI_Store_Premium.data, function(idx, r) {
				if (r.Type == "C+"){
					$('.CValueA').html(r.Annually);
					$('.CValueB').html(r.SemiAnnually);
					$('.CValueC').html(r.Quarterly);
					$('.CValueD').html(r.Monthly);
				
					CRiderPrem = r.Annually.replace(',', '');
			     	return false;
				}
            });
           
			if(CRiderTerm > 20){
				PolicyTerm = 20;
			} else {
				PolicyTerm = CRiderTerm;
			}
   
			i = 1;
			$.each(gCommision.Rates[0].Trad_Sys_Commission.data, function(idx, r) {
				if (r.PolTerm == PolicyTerm)
				{
					if(CRiderHL){
						if(parseInt(i) <=  parseInt(CRiderHLTerm)){
							actualPremium = parseFloat(r.Rate)/100 * parseFloat(CRiderPrem);
						} else {
							actualPremium = (parseFloat(r.Rate)/100 ) * ((parseFloat(CRiderPrem)) - (parseFloat(CRiderSA)/1000 * parseFloat(CRiderHL)));
						}
					} else {
						actualPremium = parseFloat(r.Rate)/100 * parseFloat(CRiderPrem);
					}
	  
					if(CRiderTempHL){
						if(parseInt(i) > parseInt(CRiderTempHLTerm)){
							actualPremium = parseFloat(actualPremium) - ((parseFloat(r.Rate)/100 ) * (parseFloat(CRiderSA)/1000 * parseFloat(CRiderTempHL)));
						}
					}
					
					$('#CYear'+i).html("RM " + formatCurrency(parseFloat(actualPremium)));
					i++;
				}
			});
			return false;
		}
	});
}

function writePDS_HMM()
{
	$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, row) {
		if (row.RiderCode == "HMM")
		{		
			AttachHMM = true;
			HMMRiderTerm = row.RiderTerm;
			HMMRiderHL = row.HLPercentage;
			HMMRiderHLTerm = row.HLPercentageTerm;
			HMMRiderTempHL = row.TempHL1KSA;
			HMMRiderTempHLTerm = row.TempHL1KSATerm;

			$('.HMMRiderTerm').html(row.RiderTerm);
			$('.HMMPlanOption').html(row.PlanOption);
			$('.HMMOption').html(row.PlanOption + " with deductible of RM " + row.Deductible);
			$('.HMMOption_BM').html(row.PlanOption + " dengan penolakan sebanyak RM " + row.Deductible);
			$('.HMMPayableAge').html((parseInt(row.RiderTerm) + parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age)));

			$.each(gdata.SI[0].SI_Store_Premium.data, function(index, row) {
				if (row.Type == "HMM" && row.FromAge == "(null)"){
					$('.HMMValueA').html(row.Annually);
					$('.HMMValueB').html(row.SemiAnnually);
					$('.HMMValueC').html(row.Quarterly);
					$('.HMMValueD').html(row.Monthly);

					HMMRiderPrem = row.Annually.replace(',', '');
					return false;
				}
			});

			firstAge = parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age);

			var LAAge;
			var zzz = 0;
			var PremList = new Array();
			for (LAAge = 0;LAAge<7;LAAge++)
			{
				zzz = firstAge + LAAge;
				$.each(gdata.SI[0].SI_Store_Premium.data, function(index, row) {
					if (row.Type == "HMM" && row.FromAge != "(null)")
					{
						if (parseInt(row.FromAge) <= zzz && parseInt(row.ToAge) >= zzz)
						{
							PremList[LAAge] = row.Annually;
						}
					}
				
				});
			}
		   
			if(HMMRiderTerm > 21){
				PolicyTerm = 20;
			} else {
				PolicyTerm = HMMRiderTerm;
			}
		   
			j = 1;
			$.each(gCommision.Rates[0].Trad_Sys_Commission.data, function(index, row) {
				if (row.PolTerm == PolicyTerm)
				{
					//base value is the actual rate for HMM. Value stored in SI.store premium is the value added with HL no tempHL
					if(HMMRiderHL && HMMRiderTempHL ){
						  BaseValue = parseFloat(PremList[j - 1])/ (( parseFloat(HMMRiderHL)/100 ) + 1);
					} else if(HMMRiderHL && !HMMRiderTempHL) {
						  BaseValue = parseFloat(PremList[j - 1])/ (( parseFloat(HMMRiderHL)/100) + 1); 
					} else if(!HMMRiderHL && HMMRiderTempHL) {
						  BaseValue = parseFloat(PremList[j - 1])/// (( parseFloat(HMMRiderTempHL)/100) + 1);
					} else {
						  BaseValue = parseFloat(PremList[j - 1]);
					}
							
					if(!HMMRiderHL) {
						  TotalPremium = parseFloat(BaseValue);
					} else {
						if(!HMMRiderTempHL){
							TotalPremium = parseFloat(BaseValue);
						} else {
							if(parseInt(j) <=  parseInt(HMMRiderHLTerm) && parseInt(j) <=  parseInt(HMMRiderTempHLTerm) ){
								TotalPremium = parseFloat(BaseValue) * (1 + (parseFloat(HMMRiderHL) + parseFloat(HMMRiderTempHL))/100);	
							}
							else if(parseInt(j) <=  parseInt(HMMRiderHLTerm) && parseInt(j) >  parseInt(HMMRiderTempHLTerm) ){
								TotalPremium = parseFloat(BaseValue) * (1 + (parseFloat(HMMRiderHL) + parseFloat(0.00))/100);	
							}
							else if(parseInt(j) >  parseInt(HMMRiderHLTerm) && parseInt(j) <=  parseInt(HMMRiderTempHLTerm) ){
								TotalPremium = parseFloat(BaseValue) * (1 + (parseFloat(0.00) + parseFloat(HMMRiderTempHL))/100);	
							}
							else if(parseInt(j) >  parseInt(HMMRiderHLTerm) && parseInt(j) >  parseInt(HMMRiderTempHLTerm) ){
								TotalPremium = parseFloat(BaseValue);	
							}
						}					
					}

					$('#HMMYear'+j).html('RM ' +formatCurrency(parseFloat(row.Rate)/100 * parseFloat(TotalPremium)));
					j++;
				}
			});
			return false;
		}
	});
}


function writePDS_HS()
{
	$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, row) {
		if (row.RiderCode == "HSP_II")
		{
			AttachHSP = true;
			HSRiderTerm = row.RiderTerm;
			HSRiderHL = row.HLPercentage;
			HSRiderHLTerm = row.HLPercentageTerm;
			HSRiderTempHL = row.TempHL1KSA;
			HSRiderTempHLTerm = row.TempHL1KSATerm;

			$('.HSRiderTerm').html(row.RiderTerm);
			$('.HSPlanOption').html(row.PlanOption);
			$('.HSPayableAge').html((parseInt(row.RiderTerm) + parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age)));

			$.each(gdata.SI[0].SI_Store_Premium.data, function(index, row) {
				if (row.Type == "HSP_II" && row.FromAge == "(null)") {
					$('.HSValueA').html(row.Annually);
					$('.HSValueB').html(row.SemiAnnually);
					$('.HSValueC').html(row.Quarterly);
					$('.HSValueD').html(row.Monthly);
				
					HSRiderPrem = row.Annually.replace(',', '');
					return false;
				}
			});
		
			firstAge = parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age);
		
			var LAAge;
			var zzz = 0;
			var PremList = new Array();
			for (LAAge = 0;LAAge<7;LAAge++)
			{
				zzz = firstAge + LAAge;
				$.each(gdata.SI[0].SI_Store_Premium.data, function(index, row) {
					if (row.Type == "HSP_II" && row.FromAge != "(null)")
					{	
						if (parseInt(row.FromAge) <= zzz && parseInt(row.ToAge) >= zzz)
						{
							PremList[LAAge] = row.Annually;
						}
					}
				});
			}

			if(HSRiderTerm > 21){
				PolicyTerm = 20;
			} else {
				PolicyTerm = HSRiderTerm;
			}
		
			j = 1;
			$.each(gCommision.Rates[0].Trad_Sys_Commission.data, function(index, row) {
				if (row.PolTerm == PolicyTerm)
				{
					if(HSRiderHL && HSRiderTempHL ){
						BaseValue = parseFloat(PremList[j - 1])/ (( parseFloat(HSRiderHL)/100 ) + 1);
					} else if(HSRiderHL && !HSRiderTempHL) {
						BaseValue = parseFloat(PremList[j - 1])/ (( parseFloat(HSRiderHL)/100) + 1); 
					} else if(!HSRiderHL && HSRiderTempHL) {
						BaseValue = parseFloat(PremList[j - 1]);
					} else {
						BaseValue = parseFloat(PremList[j - 1]);
					}
					
					if(!HSRiderHL){
						TotalPremium = parseFloat(BaseValue);
					} else {
						if(!HSRiderTempHL){
							TotalPremium = parseFloat(BaseValue);
						} else {
							if(parseInt(j) <=  parseInt(HSRiderHLTerm) && parseInt(j) <=  parseInt(HSRiderTempHLTerm) ){
								TotalPremium = parseFloat(BaseValue) * (1 + (parseFloat(HSRiderHL) + parseFloat(HSRiderTempHL))/100);	
							} else if(parseInt(j) <=  parseInt(HSRiderHLTerm) && parseInt(j) >  parseInt(HSRiderTempHLTerm) ){
								TotalPremium = parseFloat(BaseValue) * (1 + (parseFloat(HSRiderHL) + parseFloat(0.00))/100);	
							} else if(parseInt(j) >  parseInt(HSRiderHLTerm) && parseInt(j) <=  parseInt(HSRiderTempHLTerm) ){
								TotalPremium = parseFloat(BaseValue) * (1 + (parseFloat(0.00) + parseFloat(HSRiderTempHL))/100);	
							} else if(parseInt(j) >  parseInt(HSRiderHLTerm) && parseInt(j) >  parseInt(HSRiderTempHLTerm) ){
								TotalPremium = parseFloat(BaseValue);	
							}
						}					
					}
			
					$('#HSYear'+j).html('RM ' +formatCurrency(parseFloat(row.Rate)/100 * parseFloat(TotalPremium)));
					j++;
				}
			});		
			return false;
		}
	});
}

function writePDS_MG2()
{
	$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, row) {
		if (row.RiderCode == "MG_II")
		{
			AttachMG2 = true;
			MG2RiderTerm = row.RiderTerm;
			MG2RiderHL = row.HLPercentage;
			MG2RiderHLTerm = row.HLPercentageTerm;
			MG2RiderTempHL = row.TempHL1KSA;
			MG2RiderTempHLTerm = row.TempHL1KSATerm;
           
			$('.MG2RiderTerm').html(row.RiderTerm);
			$('.MG2PlanOption').html(row.PlanOption);
			$('.MG2PayableAge').html((parseInt(row.RiderTerm) + parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age)));

			$.each(gdata.SI[0].SI_Store_Premium.data, function(index, row) {
				if (row.Type == "MG_II" && row.FromAge == "(null)"){
					$('.MG2ValueA').html(row.Annually);
					$('.MG2ValueB').html(row.SemiAnnually);
					$('.MG2ValueC').html(row.Quarterly);
					$('.MG2ValueD').html(row.Monthly);
					
					MG2RiderPrem = row.Annually.replace(',', '');
					return false;
				}
			});

			firstAge = parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age);

			var LAAge;
           	var zzz = 0;
           	var PremList = new Array();
           	for (LAAge = 0;LAAge<7;LAAge++)
           	{
           		zzz = firstAge + LAAge;
           		$.each(gdata.SI[0].SI_Store_Premium.data, function(index, row) {
           			if (row.Type == "MG_II" && row.FromAge != "(null)")
           			{
           				if (parseInt(row.FromAge) <= zzz && parseInt(row.ToAge) >= zzz)
           				{
           					PremList[LAAge] = row.Annually;
           				}
           			}
           		});
           	}
           	
           	if(MG2RiderTerm > 20){
           		PolicyTerm = 20;
           	} else {
           		PolicyTerm = MG2RiderTerm;
           	}
           	
           	j = 1;
           	$.each(gCommision.Rates[0].Trad_Sys_Commission.data, function(index, row) {
           		if (row.PolTerm == PolicyTerm)
           		{
           			if(MG2RiderHL && MG2RiderTempHL ) {
           				BaseValue = parseFloat(PremList[j - 1])/ (( parseFloat(MG2RiderHL)/100 ) + 1);
           			} else if(MG2RiderHL && !MG2RiderTempHL) {
           				BaseValue = parseFloat(PremList[j - 1])/ (( parseFloat(MG2RiderHL)/100) + 1); 
           			} else if(!MG2RiderHL && MG2RiderTempHL) {
           				BaseValue = parseFloat(PremList[j - 1]);
           			} else {
           				BaseValue = parseFloat(PremList[j - 1]);
           			}		  
           			
           			if(!MG2RiderHL){
           				TotalPremium = parseFloat(BaseValue);
           			} else {
           				if(!MG2RiderTempHL){
           					TotalPremium = parseFloat(BaseValue);
           				} else {
           					if(parseInt(j) <=  parseInt(MG2RiderHLTerm) && parseInt(j) <=  parseInt(MG2RiderTempHLTerm) ){
           						TotalPremium = parseFloat(BaseValue) * (1 + (parseFloat(MG2RiderHL) + parseFloat(MG2RiderTempHL))/100);	
           					} else if(parseInt(j) <=  parseInt(MG2RiderHLTerm) && parseInt(j) >  parseInt(MG2RiderTempHLTerm) ){
           						TotalPremium = parseFloat(BaseValue) * (1 + (parseFloat(MG2RiderHL) + parseFloat(0.00))/100);	
           					} else if(parseInt(j) >  parseInt(MG2RiderHLTerm) && parseInt(j) <=  parseInt(MG2RiderTempHLTerm) ){
           						TotalPremium = parseFloat(BaseValue) * (1 + (parseFloat(0.00) + parseFloat(MG2RiderTempHL))/100);	
           					} else if(parseInt(j) >  parseInt(MG2RiderHLTerm) && parseInt(j) >  parseInt(MG2RiderTempHLTerm) ){
           						TotalPremium = parseFloat(BaseValue);	
           					}
           				}
           				
           			}
           			
           			$('.MG2Year'+j).html('RM ' +formatCurrency(parseFloat(row.Rate)/100 * parseFloat(TotalPremium)));
           			j++;
           		}   
           	});		
           	return false;
		}
	});
}

function writePDS_MG4()
{
    $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, row) {
    	if (row.RiderCode == "MG_IV")
    	{
			AttachMG4 = true;
			MG4RiderTerm = row.RiderTerm;
			MG4RiderHL = row.HLPercentage;
			MG4RiderHLTerm = row.HLPercentageTerm;
			MG4RiderTempHL = row.TempHL1KSA;
			MG4RiderTempHLTerm = row.TempHL1KSATerm;

			$('.MG4RiderTerm').html(row.RiderTerm);
			$('.MG4PlanOption').html(row.PlanOption);
			$('.MG4PayableAge').html((parseInt(row.RiderTerm) + parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age)));

			$.each(gdata.SI[0].SI_Store_Premium.data, function(index, row) {
				if (row.Type == "MG_IV" && row.FromAge == "(null)"){
					$('.MG4ValueA').html(row.Annually);
					$('.MG4ValueB').html(row.SemiAnnually);
					$('.MG4ValueC').html(row.Quarterly);
					$('.MG4ValueD').html(row.Monthly);

					MG4RiderPrem = row.Annually.replace(',', '');
					return false;
				}
			});
			firstAge = parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age);
           
			var LAAge;
			var zzz = 0;
			var PremList = new Array();
			for (LAAge = 0;LAAge<7;LAAge++)
			{
				zzz = firstAge + LAAge;
				$.each(gdata.SI[0].SI_Store_Premium.data, function(index, row) {
					if (row.Type == "MG_IV" && row.FromAge != "(null)")
					{
						if (parseInt(row.FromAge) <= zzz && parseInt(row.ToAge) >= zzz)
						{
							PremList[LAAge] = row.Annually;
						}
					}
				});
           	}
           
           	if(MG4RiderTerm > 20){
           		PolicyTerm = 20;
           	} else {
           		PolicyTerm = MG4RiderTerm;
           	}
           
           	j = 1;
           	$.each(gCommision.Rates[0].Trad_Sys_Commission.data, function(index, row) {
           		if (row.PolTerm == PolicyTerm)
           		{
           			if(MG4RiderHL && MG4RiderTempHL ) {
           				BaseValue = parseFloat(PremList[j - 1])/ (( parseFloat(MG4RiderHL)/100 ) + 1);
           			} else if(MG4RiderHL && !MG4RiderTempHL) {
	                  	BaseValue = parseFloat(PremList[j - 1])/ (( parseFloat(MG4RiderHL)/100) + 1); 
                  	} else if(!MG4RiderHL && MG4RiderTempHL) {
                  		BaseValue = parseFloat(PremList[j - 1]);
                  	} else {
                  		BaseValue = parseFloat(PremList[j - 1]);
                  	}
                  
		  			if(!MG4RiderHL){
			      		TotalPremium = parseFloat(BaseValue);
			      	} else {
			      		if(!MG4RiderTempHL) {
			      			TotalPremium = parseFloat(BaseValue);
			      		} else {
			      			if(parseInt(j) <=  parseInt(MG4RiderHLTerm) && parseInt(j) <=  parseInt(MG4RiderTempHLTerm) ) {
			      				TotalPremium = parseFloat(BaseValue) * (1 + (parseFloat(MG4RiderHL) + parseFloat(MG4RiderTempHL))/100);	
			      			} else if(parseInt(j) <=  parseInt(MG4RiderHLTerm) && parseInt(j) >  parseInt(MG4RiderTempHLTerm)) {
			      				TotalPremium = parseFloat(BaseValue) * (1 + (parseFloat(MG4RiderHL) + parseFloat(0.00))/100);
			      			} else if(parseInt(j) >  parseInt(MG4RiderHLTerm) && parseInt(j) <=  parseInt(MG4RiderTempHLTerm) ) {
			      				TotalPremium = parseFloat(BaseValue) * (1 + (parseFloat(0.00) + parseFloat(MG4RiderTempHL))/100);	
			      			} else if(parseInt(j) >  parseInt(MG4RiderHLTerm) && parseInt(j) >  parseInt(MG4RiderTempHLTerm) ) {
			      				TotalPremium = parseFloat(BaseValue);	
			      			}
			      		}
			      	}
			      	
					$('#MG4Year'+j).html('RM ' +formatCurrency(parseFloat(row.Rate)/100 * parseFloat(TotalPremium)));
					j++;
				}
			});
			return false;
		}
	});
}

function writeI20R_1()
{
	$('.titleI20R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.I20R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Ilustrasi ' + 
		gdata.SI[0].SI_Trad_Rider_Profile.I20R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.I20R[0].data, function(index, SI_Temp_Trad_RiderIllus) {
		$('#table-I20R1 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' +
			SI_Temp_Trad_RiderIllus.col1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col3 + '</td><td>' +
			SI_Temp_Trad_RiderIllus.col4 + '</td><td>' + SI_Temp_Trad_RiderIllus.col5 + '</td><td>' + SI_Temp_Trad_RiderIllus.col6 + '</td><td>' + 
			SI_Temp_Trad_RiderIllus.col7 + '</td><td>' + SI_Temp_Trad_RiderIllus.col8 + '</td><td>' + SI_Temp_Trad_RiderIllus.col9 + '</td><td>' + 
			SI_Temp_Trad_RiderIllus.col10 + '</td><td>' + SI_Temp_Trad_RiderIllus.col11+ '</td></tr>');
	});
	writeInvestmentScenariosRight();
}

function writeI20R_2()
{
	var colType = 0;
	if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A')//payment description
    {
    	$('#col1I20R2').html('Accumulated Cash Dividend<br/><br/><i>Dividen Tunai Terkumpul<br/>(9)</i>');        
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col2I20R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(10)</i>');
            $('#col3I20R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4I20R2').html('-<br/><br/>-');
            
            $('#col4AI20R2').html('-');
            $('#col4BI20R2').html('-');
            colType = 1;
        }
        else
        {
        	$('#col2I20R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(10)</i>');
            $('#col3I20R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(11)</i>');
            $('#col4I20R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas<br/>Kematian/TPD<br/>(12)</i>');
            colType = 2;
        }
    }
    else if (gdata.SI[0].SI_Trad_Details.data[0].CashDividend == 'P')
    {       	    
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col1I20R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(9)</i>');
            $('#col2I20R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)</i>');
            $('#col3I20R2').html('-<br/><br/>-');
            $('#col4I20R2').html('-<br/><br/>-');
            $('#col3AI20R2').html('-');
            $('#col3BI20R2').html('-');
            $('#col4AI20R2').html('-');
            $('#col4BI20R2').html('-');
            colType = 3;
        }
        else
        {
        	$('#col1I20R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(9)</i>');
            $('#col2I20R2').html('Terminal Dividend Payable on Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas Penyerahan/Kematangan<br/>(10)</i>');
            $('#col3I20R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4I20R2').html('-<br/><br/>-');
            $('#col4AI20R2').html('-');
            $('#col4BI20R2').html('-');
            colType = 4;
        }
    }
	$('.titleI20R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.I20R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Ilustrasi ' + 
		gdata.SI[0].SI_Trad_Rider_Profile.I20R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.I20R[0].data, function(index, SI_Temp_Trad_RiderIllus) {		
		if (colType == 1){
			$('#table-I20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + 
				SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' +
				SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' +
				SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
		}
		else if (colType == 2)
        {
        	$('#table-I20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' +
        		SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' +
           		SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + 
           		SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' +
           		SI_Temp_Trad_RiderIllus.col21 + '</td></tr>');  	
		}
		else if (colType == 3)
		{
			$('#table-I20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + 
				SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + 
				SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + 
				'-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
		}
		else if (colType == 4)
		{
			$('#table-I20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + 
				SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' +
				SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + 
				SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
		}
	});
}

function writeI30R_1()
{
	$('.titleI30R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.I30R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Ilustrasi ' + 
		gdata.SI[0].SI_Trad_Rider_Profile.I30R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.I30R[0].data, function(index, SI_Temp_Trad_RiderIllus) {		
    	$('#table-I30R1 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + 
    		SI_Temp_Trad_RiderIllus.col1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col3 + '</td><td>' +
    		SI_Temp_Trad_RiderIllus.col4 + '</td><td>' + SI_Temp_Trad_RiderIllus.col5 + '</td><td>' + SI_Temp_Trad_RiderIllus.col6 + '</td><td>' +
    		SI_Temp_Trad_RiderIllus.col7 + '</td><td>' + SI_Temp_Trad_RiderIllus.col8 + '</td><td>' + SI_Temp_Trad_RiderIllus.col9 + '</td><td>' + 
    		SI_Temp_Trad_RiderIllus.col10 + '</td><td>' + SI_Temp_Trad_RiderIllus.col11+ '</td></tr>');
    });
	writeInvestmentScenariosRight();
}

function writeI30R_2()
{
	var colType = 0;
	if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A')//payment description
    {
        $('#col1I30R2').html('Accumulated Cash Dividend<br/><br/><i>Dividen Tunai Terkumpul<br/>(9)</i>');
        
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col2I30R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(10)</i>');
            $('#col3I30R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4I30R2').html('-<br/><br/>-');
            
            $('#col4AI30R2').html('-');
            $('#col4BI30R2').html('-');
            colType = 1;
        }
        else
        {
        	$('#col2I30R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(10)</i>');
            $('#col3I30R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(11)</i>');
            $('#col4I30R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas<br/>Kematian/TPD<br/>(12)</i>');
            colType = 2;
        }
    }
    else if (gdata.SI[0].SI_Trad_Details.data[0].CashDividend == 'P')
    {       	    
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col1I30R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(9)</i>');
            $('#col2I30R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)</i>');
            $('#col3I30R2').html('-<br/><br/>-');
            $('#col4I30R2').html('-<br/><br/>-');
            $('#col3AI30R2').html('-');
            $('#col3BI30R2').html('-');
            $('#col4AI30R2').html('-');
            $('#col4BI30R2').html('-');
            colType = 3;
        }
        else
        {
        	$('#col1I30R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(9)</i>');
            $('#col2I30R2').html('Terminal Dividend Payable on Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas Penyerahan/Kematangan<br/>(10)</i>');
            $('#col3I30R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4I30R2').html('-<br/><br/>-');
            $('#col4AI30R2').html('-');
            $('#col4BI30R2').html('-');
            colType = 4;
        }
    }
    $('.titleI30R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.I30R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Ilustrasi ' + 
    	gdata.SI[0].SI_Trad_Rider_Profile.I30R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.I30R[0].data, function(index, SI_Temp_Trad_RiderIllus) {	
		if (colType == 1){
			$('#table-I30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + 
				SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' +
				SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + 
				SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
		}
		else if (colType == 2)
		{
			$('#table-I30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' +
				SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + 
				SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' +
				SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + 
				SI_Temp_Trad_RiderIllus.col21 + '</td></tr>');  	
        }
        else if (colType == 3)
    	{
           	$('#table-I20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + 
           		SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' +
           		SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + 
           		'-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        }
        else if (colType == 4)
        {
           	$('#table-I20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' +
           		SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + 
           		SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' +
           		SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
    });
}

function writeI40R_1()
{
	$('.titleI40R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.I40R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Ilustrasi ' +
		gdata.SI[0].SI_Trad_Rider_Profile.I40R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.I40R[0].data, function(index, SI_Temp_Trad_RiderIllus) {		
    	$('#table-I40R1 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + 
    		SI_Temp_Trad_RiderIllus.col1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col3 + '</td><td>' + 
    		SI_Temp_Trad_RiderIllus.col4 + '</td><td>' + SI_Temp_Trad_RiderIllus.col5 + '</td><td>' + SI_Temp_Trad_RiderIllus.col6 + '</td><td>' +
    		SI_Temp_Trad_RiderIllus.col7 + '</td><td>' + SI_Temp_Trad_RiderIllus.col8 + '</td><td>' + SI_Temp_Trad_RiderIllus.col9 + '</td><td>' + 
    		SI_Temp_Trad_RiderIllus.col10 + '</td><td>' + SI_Temp_Trad_RiderIllus.col11+ '</td></tr>');
    });
	writeInvestmentScenariosRight();
}

function writeI40R_2()
{
	var colType = 0;
	if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A')//payment description
    {
        $('#col1I40R2').html('Accumulated Cash Dividend<br/><br/><i>Dividen Tunai Terkumpul<br/>(9)</i>');
        
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col2I40R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(10)</i>');
            $('#col3I40R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4I40R2').html('-<br/><br/>-');
            
            $('#col4AI40R2').html('-');
            $('#col4BI40R2').html('-');
            colType = 1;
        }
        else
        {
        	$('#col2I40R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(10)</i>');
            $('#col3I40R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(11)</i>');
            $('#col4I40R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas<br/>Kematian/TPD<br/>(12)</i>');
            colType = 2;
        }
    }
    else if (gdata.SI[0].SI_Trad_Details.data[0].CashDividend == 'P')
    {       	    
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col1I40R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(9)</i>');
            $('#col2I40R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)</i>');
            $('#col3I40R2').html('-<br/><br/>-');
            $('#col4I40R2').html('-<br/><br/>-');
            $('#col3AI40R2').html('-');
            $('#col3BI40R2').html('-');
            $('#col4AI40R2').html('-');
            $('#col4BI40R2').html('-');
            colType = 3;
        }
        else
        {
        	$('#col1I40R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(9)</i>');
            $('#col2I40R2').html('Terminal Dividend Payable on Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas Penyerahan/Kematangan<br/>(10)</i>');
            $('#col3I40R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4I40R2').html('-<br/><br/>-');
            $('#col4AI40R2').html('-');
            $('#col4BI40R2').html('-');
            colType = 4;
        }
    }
    $('.titleI40R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.I40R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Ilustrasi ' + 
    	gdata.SI[0].SI_Trad_Rider_Profile.I40R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.I40R[0].data, function(index, SI_Temp_Trad_RiderIllus) {		
        if (colType == 1){
        	$('#table-I40R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' +
        		SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + 
        		SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + 
        		SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
        else if (colType == 2)
        {
        	$('#table-I40R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + 
        		SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + 
        		SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + 
        		SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' +
        		SI_Temp_Trad_RiderIllus.col21 + '</td></tr>'); 
        }
        else if (colType == 3)
        {
        	$('#table-I40R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' +
        		SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + 
        		SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + 
        		'-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        }
        else if (colType == 4)
        {
        	$('#table-I40R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' +
        		SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + 
        		SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + 
        		SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
    });
}

function writeID20R_1()
{
	$('.titleID20R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.ID20R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Ilustrasi ' +
		gdata.SI[0].SI_Trad_Rider_Profile.ID20R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.ID20R[0].data, function(index, SI_Temp_Trad_RiderIllus) {		
		$('#table-ID20R1 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' +
			SI_Temp_Trad_RiderIllus.col1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col3 + '</td><td>' + 
			SI_Temp_Trad_RiderIllus.col4 + '</td><td>' + SI_Temp_Trad_RiderIllus.col5 + '</td><td>' + SI_Temp_Trad_RiderIllus.col6 + '</td><td>' + 
			SI_Temp_Trad_RiderIllus.col7 + '</td><td>' + SI_Temp_Trad_RiderIllus.col8 + '</td><td>' + SI_Temp_Trad_RiderIllus.col9 + '</td><td>' +
			SI_Temp_Trad_RiderIllus.col10 + '</td><td>' + SI_Temp_Trad_RiderIllus.col11+ '</td></tr>');
    });
	writeInvestmentScenariosRight();
}

function writeID20R_2()
{
	var colType = 0;
	if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A')//payment description
    {
        $('#col1ID20R2').html('Accumulated Cash Dividend<br/><br/><i>Dividen Tunai Terkumpul<br/>(9)</i>');
        
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col2ID20R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(10)</i>');
            $('#col3ID20R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4ID20R2').html('-<br/><br/>-');
            
            $('#col4AID20R2').html('-');
            $('#col4BID20R2').html('-');
            colType = 1;
        }
        else
        {
        	$('#col2ID20R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(10)</i>');
            $('#col3ID20R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(11)</i>');
            $('#col4ID20R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas<br/>Kematian/TPD<br/>(12)</i>');
            colType = 2;
        }
    }
    else if (gdata.SI[0].SI_Trad_Details.data[0].CashDividend == 'P')
    {       	    
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col1ID20R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(9)</i>');
            $('#col2ID20R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)</i>');
            $('#col3ID20R2').html('-<br/><br/>-');
            $('#col4ID20R2').html('-<br/><br/>-');
            $('#col3AID20R2').html('-');
            $('#col3BID20R2').html('-');
            $('#col4AID20R2').html('-');
            $('#col4BID20R2').html('-');
            colType = 3;
        }
        else
        {
        	$('#col1ID20R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(9)</i>');
            $('#col2ID20R2').html('Terminal Dividend Payable on Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas Penyerahan/Kematangan<br/>(10)</i>');
            $('#col3ID20R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4ID20R2').html('-<br/><br/>-');
            $('#col4AID20R2').html('-');
            $('#col4BID20R2').html('-');
            colType = 4;
        }
    }
    $('.titleID20R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.ID20R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Ilustrasi ' + 
    	gdata.SI[0].SI_Trad_Rider_Profile.ID20R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.ID20R[0].data, function(index, SI_Temp_Trad_RiderIllus) {		
		if (colType == 1){
			$('#table-ID20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' +
				SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + 
				SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + 
				SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
        else if (colType == 2)
        {
           	$('#table-ID20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + 
           		SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + 
           		SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + 
           		SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + 
           		SI_Temp_Trad_RiderIllus.col21 + '</td></tr>');  	
        }
        else if (colType == 3)
        {
        	$('#table-ID20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + 
        		SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' +
        		SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' +
        		'-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        }
        else if (colType == 4)
        {
        	$('#table-ID20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + 
        		SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + 
        		SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' +
        		SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
   });
}

function writeID30R_1()
{
	$('.titleID30R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.ID30R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Ilustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.ID30R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.ID30R[0].data, function(index, SI_Temp_Trad_RiderIllus) {
		$('#table-ID30R1 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + 
			SI_Temp_Trad_RiderIllus.col1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col3 + '</td><td>' +
			SI_Temp_Trad_RiderIllus.col4 + '</td><td>' + SI_Temp_Trad_RiderIllus.col5 + '</td><td>' + SI_Temp_Trad_RiderIllus.col6 + '</td><td>' + 
			SI_Temp_Trad_RiderIllus.col7 + '</td><td>' + SI_Temp_Trad_RiderIllus.col8 + '</td><td>' + SI_Temp_Trad_RiderIllus.col9 + '</td><td>' + 
			SI_Temp_Trad_RiderIllus.col10 + '</td><td>' + SI_Temp_Trad_RiderIllus.col11+ '</td></tr>');
    });
	writeInvestmentScenariosRight();
}

function writeID30R_2()
{
	var colType = 0;
	if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A')//payment description
    {
        $('#col1ID30R2').html('Accumulated Cash Dividend<br/><br/><i>Dividen Tunai Terkumpul<br/>(9)</i>');
        
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col2ID30R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(10)</i>');
            $('#col3ID30R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4ID30R2').html('-<br/><br/>-');
            
            $('#col4AID30R2').html('-');
            $('#col4BID30R2').html('-');
            colType = 1;
        }
        else
        {
        	$('#col2ID30R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(10)</i>');
            $('#col3ID30R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(11)</i>');
            $('#col4ID30R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas<br/>Kematian/TPD<br/>(12)</i>');
            colType = 2;
        }
    }
    else if (gdata.SI[0].SI_Trad_Details.data[0].CashDividend == 'P')
    {       	    
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col1ID30R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(9)</i>');
            $('#col2ID30R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)</i>');
            $('#col3ID30R2').html('-<br/><br/>-');
            $('#col4ID30R2').html('-<br/><br/>-');
            $('#col3AID30R2').html('-');
            $('#col3BID30R2').html('-');
            $('#col4AID30R2').html('-');
            $('#col4BID30R2').html('-');
            colType = 3;
        }
        else
        {
        	$('#col1ID30R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(9)</i>');
            $('#col2ID30R2').html('Terminal Dividend Payable on Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas Penyerahan/Kematangan<br/>(10)</i>');
            $('#col3ID30R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4ID30R2').html('-<br/><br/>-');
            $('#col4AID30R2').html('-');
            $('#col4BID30R2').html('-');
            colType = 4;
        }
    }
    $('.titleID30R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.ID30R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Ilustrasi ' + 
    	gdata.SI[0].SI_Trad_Rider_Profile.ID30R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.ID30R[0].data, function(index, SI_Temp_Trad_RiderIllus) {		
		if (colType == 1)
		{
			$('#table-ID30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' +
				SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' +
				SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + 
				SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
		}
        else if (colType == 2)
        {
        	$('#table-ID30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + 
           		SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + 
           		SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + 
           		SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + 
           		SI_Temp_Trad_RiderIllus.col21 + '</td></tr>');  	
        }
        else if (colType == 3)
        {
           	$('#table-ID30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + 
           		SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' +
           		SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' +
           		'-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        }
        else if (colType == 4)
        {
           	$('#table-ID30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' +
           		SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' +
           		SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + 
           		SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
    });
}

function writeID40R_1()
{
	$('.titleID40R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.ID40R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Ilustrasi ' + 
		gdata.SI[0].SI_Trad_Rider_Profile.ID40R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.ID40R[0].data, function(index, SI_Temp_Trad_RiderIllus) {		
		$('#table-ID40R1 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + 
			SI_Temp_Trad_RiderIllus.col1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col3 + '</td><td>' + 
			SI_Temp_Trad_RiderIllus.col4 + '</td><td>' + SI_Temp_Trad_RiderIllus.col5 + '</td><td>' + SI_Temp_Trad_RiderIllus.col6 + '</td><td>' + 
			SI_Temp_Trad_RiderIllus.col7 + '</td><td>' + SI_Temp_Trad_RiderIllus.col8 + '</td><td>' + SI_Temp_Trad_RiderIllus.col9 + '</td><td>' + 
			SI_Temp_Trad_RiderIllus.col10 + '</td><td>' + SI_Temp_Trad_RiderIllus.col11+ '</td></tr>');
    });
	writeInvestmentScenariosRight();
}

function writeID40R_2()
{
	var colType = 0;
	if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A')//payment description
    {
        $('#col1ID40R2').html('Accumulated Cash Dividend<br/><br/><i>Dividen Tunai Terkumpul<br/>(9)</i>');
        
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col2ID40R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(10)</i>');
            $('#col3ID40R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4ID40R2').html('-<br/><br/>-');
            
            $('#col4AID40R2').html('-');
            $('#col4BID40R2').html('-');
            colType = 1;
        }
        else
        {
        	$('#col2ID40R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(10)</i>');
            $('#col3ID40R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(11)</i>');
            $('#col4ID40R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas<br/>Kematian/TPD<br/>(12)</i>');
            colType = 2;
        }
    }
    else if (gdata.SI[0].SI_Trad_Details.data[0].CashDividend == 'P')
    {       	    
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col1ID40R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(9)</i>');
            $('#col2ID40R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)</i>');
            $('#col3ID40R2').html('-<br/><br/>-');
            $('#col4ID40R2').html('-<br/><br/>-');
            $('#col3AID40R2').html('-');
            $('#col3BID40R2').html('-');
            $('#col4AID40R2').html('-');
            $('#col4BID40R2').html('-');
            colType = 3;
        }
        else
        {
        	$('#col1ID40R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(9)</i>');
            $('#col2ID40R2').html('Terminal Dividend Payable on Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas Penyerahan/Kematangan<br/>(10)</i>');
            $('#col3ID40R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4ID40R2').html('-<br/><br/>-');
            $('#col4AID40R2').html('-');
            $('#col4BID40R2').html('-');
            colType = 4;
        }
    }
    $('.titleID40R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.ID40R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Ilustrasi ' + 
    	gdata.SI[0].SI_Trad_Rider_Profile.ID40R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.ID40R[0].data, function(index, SI_Temp_Trad_RiderIllus) {
		if (colType == 1){
			$('#table-ID40R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' +
				SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' +
				SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + 
				SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
        else if (colType == 2)
        {
           	$('#table-ID40R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + 
           		SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + 
           		SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' +
           		SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' +
           		SI_Temp_Trad_RiderIllus.col21 + '</td></tr>');  	
	   }
	   else if (colType == 3)
	   {
           	$('#table-ID40R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' +
           		SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' +
           		SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + 
           		'-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
	   }
	   else if (colType == 4)
	   {
           	$('#table-ID40R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' +
           		SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' +
           		SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' +
           		SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
		}
    });
}

function writeIE20R_1()
{
	$('.titleIE20R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.IE20R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Ilustrasi ' + 
		gdata.SI[0].SI_Trad_Rider_Profile.IE20R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.IE20R[0].data, function(index, SI_Temp_Trad_RiderIllus) {		
    	$('#table-IE20R1 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' +
    		SI_Temp_Trad_RiderIllus.col1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col3 + '</td><td>' + 
    		SI_Temp_Trad_RiderIllus.col4 + '</td><td>' + SI_Temp_Trad_RiderIllus.col5 + '</td><td>' + SI_Temp_Trad_RiderIllus.col6 + '</td><td>' +
    		SI_Temp_Trad_RiderIllus.col7 + '</td><td>' + SI_Temp_Trad_RiderIllus.col8 + '</td><td>' + SI_Temp_Trad_RiderIllus.col9 + '</td><td>' +
    		SI_Temp_Trad_RiderIllus.col10 + '</td><td>' + SI_Temp_Trad_RiderIllus.col11+ '</td></tr>');
    });
	writeInvestmentScenariosRight();
}

function writeIE20R_2()
{
	var colType = 0;
	if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A')//payment description
    {
        $('#col1IE20R2').html('Accumulated Cash Dividend<br/><br/><i>Dividen Tunai Terkumpul<br/>(9)</i>');
        
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col2IE20R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(10)</i>');
            $('#col3IE20R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4IE20R2').html('-<br/><br/>-');
            
            $('#col4AIE20R2').html('-');
            $('#col4BIE20R2').html('-');
            colType = 1;
        }
        else
        {
        	$('#col2IE20R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(10)</i>');
            $('#col3IE20R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(11)</i>');
            $('#col4IE20R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas<br/>Kematian/TPD<br/>(12)</i>');
            colType = 2;
        }
    }
    else if (gdata.SI[0].SI_Trad_Details.data[0].CashDividend == 'P')
    {       	    
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col1IE20R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(9)</i>');
            $('#col2IE20R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)</i>');
            $('#col3IE20R2').html('-<br/><br/>-');
            $('#col4IE20R2').html('-<br/><br/>-');
            $('#col3AIE20R2').html('-');
            $('#col3BIE20R2').html('-');
            $('#col4AIE20R2').html('-');
            $('#col4BIE20R2').html('-');
            colType = 3;
        }
        else
        {
        	$('#col1IE20R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(9)</i>');
            $('#col2IE20R2').html('Terminal Dividend Payable on Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas Penyerahan/Kematangan<br/>(10)</i>');
            $('#col3IE20R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4IE20R2').html('-<br/><br/>-');
            $('#col4AIE20R2').html('-');
            $('#col4BIE20R2').html('-');
            colType = 4;
        }
    }
    $('.titleIE20R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.IE20R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Ilustrasi ' + 
    	gdata.SI[0].SI_Trad_Rider_Profile.IE20R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.IE20R[0].data, function(index, SI_Temp_Trad_RiderIllus) {
		if (colType == 1){
			$('#table-IE20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' +
				SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + 
				SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + 
				SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
		}
		else if (colType == 2)
		{
			$('#table-IE20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' +
           		SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' +
           		SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + 
           		SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + 
           		SI_Temp_Trad_RiderIllus.col21 + '</td></tr>'); 
        }
        else if (colType == 3)
        {
        	$('#table-IE20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + 
        		SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' +
        		SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' +
        		'-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        }
        else if (colType == 4)
        {
        	$('#table-IE20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + 
        		SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' +
        		SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + 
        		SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
    });
}

function writeIE30R_1()
{
	$('.titleIE30R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.IE30R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Ilustrasi ' + 
		gdata.SI[0].SI_Trad_Rider_Profile.IE30R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.IE20R[0].data, function(index, SI_Temp_Trad_RiderIllus) {		
		$('#table-IE20R1 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' +
			SI_Temp_Trad_RiderIllus.col1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col3 + '</td><td>' +
			SI_Temp_Trad_RiderIllus.col4 + '</td><td>' + SI_Temp_Trad_RiderIllus.col5 + '</td><td>' + SI_Temp_Trad_RiderIllus.col6 + '</td><td>' + 
			SI_Temp_Trad_RiderIllus.col7 + '</td><td>' + SI_Temp_Trad_RiderIllus.col8 + '</td><td>' + SI_Temp_Trad_RiderIllus.col9 + '</td><td>' + 
			SI_Temp_Trad_RiderIllus.col10 + '</td><td>' + SI_Temp_Trad_RiderIllus.col11+ '</td></tr>');
	});
	writeInvestmentScenariosRight();
}

function writeIE30R_2()
{
	var colType = 0;
	if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A')//payment description
    {
        $('#col1IE30R2').html('Accumulated Cash Dividend<br/><br/><i>Dividen Tunai Terkumpul<br/>(9)</i>');
        
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col2IE30R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(10)</i>');
            $('#col3IE30R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4IE30R2').html('-<br/><br/>-');
            
            $('#col4AIE30R2').html('-');
            $('#col4BIE30R2').html('-');
            colType = 1;
        }
        else
        {
        	$('#col2IE30R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(10)</i>');
            $('#col3IE30R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(11)</i>');
            $('#col4IE30R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas<br/>Kematian/TPD<br/>(12)</i>');
            colType = 2;
        }
    }
    else if (gdata.SI[0].SI_Trad_Details.data[0].CashDividend == 'P')
    {       	    
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col1IE30R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Kematangan<br/>(9)</i>');
            $('#col2IE30R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)</i>');
            $('#col3IE30R2').html('-<br/><br/>-');
            $('#col4IE20R2').html('-<br/><br/>-');
            $('#col3AIE30R2').html('-');
            $('#col3BIE30R2').html('-');
            $('#col4AIE30R2').html('-');
            $('#col4BIE30R2').html('-');
            colType = 3;
        }
        else
        {
        	$('#col1IE30R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(9)</i>');
            $('#col2IE30R2').html('Terminal Dividend Payable on Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas Penyerahan/Kematangan<br/>(10)</i>');
            $('#col3IE30R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4IE30R2').html('-<br/><br/>-');
            $('#col4AIE30R2').html('-');
            $('#col4BIE30R2').html('-');
            colType = 4;
        }
    }
    $('.titleIE30R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.IE30R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Ilustrasi ' + 
    	gdata.SI[0].SI_Trad_Rider_Profile.IE30R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.IE30R[0].data, function(index, SI_Temp_Trad_RiderIllus) {
		if (colType == 1){
			$('#table-IE30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' +
				SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' +
				SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' +
				SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
		}
		else if (colType == 2)
		{
			$('#table-IE30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' +
				SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' +
				SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + 
				SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' +
				SI_Temp_Trad_RiderIllus.col21 + '</td></tr>'); 
		}
		else if (colType == 3)
		{
			$('#table-IE30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + 
				SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' +
				SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + 
				'-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
		}
		else if (colType == 4)
		{
			$('#table-IE30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + 
				SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' +
				SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + 
				SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
		}
	});
}

function writeSummary3()
{
	var colType = 0;
	
	$('.TotPremPaid2').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].TotPremPaid2));
    $('.SurrenderValueHigh2').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].SurrenderValueHigh2));
    $('.SurrenderValueLow2').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].SurrenderValueLow2));
    $('.TotYearlyIncome2').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].TotYearlyIncome2));
		
	if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A')//payment description
    {
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('.note').html('Note: Assumes after the expiry of the Income Rider(s), accumulated Cash Dividends (if any) &amp; Terminal Dividend (if any) of the rider(s) are accumulated till end of the basic plan term.<br/>');
            $('.noteM').html('<i>Nota: Anggapan selepas tamat tempoh Income Rider, Dividen Tunai Terkumpul (jika ada) dan Dividen Terminal (jika ada) rider akan dikumpul hingga akhir tempoh pelan asas.</i><br/>');
            $('.accumulationYearlyIncome').hide(); //~ description
            $('.premiumPaymentOption').hide(); //# description
            
            $('#col1Summary3').html('Total Accumulated Cash<br/>Dividends (End Of Year)<br/><br/><i>Jumlah Dividend Tunai<br/>Terkumpul (Akhir Tahun)</i>');
            $('#col2Summary3').html('Total Surrender Value (End<br/>of Year)<br/><br/><i>Jumlah Nilai Penyerahan<br/>(Akhir Tahun)</i>');
            $('#col3Summary3').html('Total Death/TPD Benefit (End<br/>of Year)*^<br/><br/><i>Jumlah Faedah Kematian/TPD<br/>(Akhir Tahun)</i>');
            $('#col4Summary3').html('-<br/><br/>-');
            $('#col4ASummary3').html('-');
            $('#col4BSummary3').html('-');
            colType = 1;
        }
        else
        {
        	$('.note').html('Note: Assumes after the expiry of the Income Rider(s),accumulated Yearly Income (if any), accumulated Cash Dividends (if any) &amp; Terminal Dividend (if any) of the rider(s) are accumulated till end of the basic plan term.<br/>');
            $('.noteM').html('<i>Nota: Anggapan selepas tamat tempoh Income Rider, Pendapatan Tahunan Terkumpul (jika ada), Dividen Tunai Terkumpul (jika ada) dan Dividen Terminal (jika ada) rider akan dikumpul hingga akhir tempoh pelan asas.</i><br/>');
            $('#col1Summary3').html('Total Accumulated Yearly<br/>Income (End Of Year)<br/><br/><i>Jumlah Pendapatan Tahunan<br/>Terkumpul (Akhir Tahun)</i>');
            $('#col2Summary3').html('Total Accumulated Cash<br/>Dividends (End Of Year)<br/><br/><i>Jumlah Dividend Tunai<br/>Terkumpul (Akhir Tahun)</i>');
            $('#col3Summary3').html('Total Surrender Value (End<br/>of Year)~<br/><br/><i>Jumlah Nilai Penyerahan<br/>(Akhir Tahun)</i>');
            $('#col4Summary3').html('Total Death/TPD Benefit (End<br/>of Year)*^~<br/><br/><i>Jumlah Faedah Kematian/TPD<br/>(Akhir Tahun)</i>');
            colType = 2;
        }
    }
    else if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'P')
    {
    	if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col1Summary3').html('Total Surrender Value (End<br/>of Year)<br/><br/><i>Jumlah Nilai Penyerahan<br/>(Akhir Tahun)</i>');
            $('#col2Summary3').html('Total Death/TPD Benefit (End<br/>of Year)*^<br/><br/><i>Jumlah Faedah Kematian/TPD<br/>(Akhir Tahun)</i>');
            $('#col3Summary3').html('-<br/><br/>-');
            $('#col4Summary3').html('-<br/><br/>-');
            $('#col3ASummary3').html('-');
            $('#col3BSummary3').html('-');
            $('#col4ASummary3').html('-');
            $('#col4BSummary3').html('-');
            $('.ccumulationYearlyIncome').hide(); //~ description
            $('.premiumPaymentOption').hide(); //# description
            colType = 3;
        }
        else
        {
        	$('.note').html('Note: Assumes after the expiry of the Income Rider(s),accumulated Yearly Income (if any) of the rider(s) are accumulated till end of the basic plan term.<br/>');
            $('.noteM').html('<i>Nota: Anggapan selepas tamat tempoh Income Rider, Pendapatan Tahunan Terkumpul (jika ada) rider akan dikumpul hingga akhir tempoh pelan asas.</i><br/>');
            
            
            $('#col1Summary3').html('Total Accumulated Yearly<br/>Income (End Of Year)<br/><br/><i>Jumlah Pendapatan Tahunan<br/>Terkumpul (Akhir Tahun)</i>');
            $('#col2Summary3').html('Total Surrender Value (End<br/>of Year)~<br/><br/><i>Jumlah Nilai Penyerahan<br/>(Akhir Tahun)</i>');
            $('#col3Summary3').html('Total Death/TPD Benefit (End<br/>of Year)*^~<br/><br/><i>Jumlah Faedah Kematian/TPD<br/>(Akhir Tahun)</i>');
            $('#col4Summary3').html('-<br/><br/>-');
            $('#col4ASummary3').html('-');
            $('#col4BSummary3').html('-');
            colType = 4;
        }
    }   
    
	$.each(gdata.SI[0].SI_Temp_Trad_Summary.data, function(index, SI_Temp_Trad_Summary) {
		if (colType == 1){
			$('#table-Summary3 > tbody').append('<tr><td>' + SI_Temp_Trad_Summary.col0_1 + '</td><td>' + SI_Temp_Trad_Summary.col0_2 + '</td><td>' +
				SI_Temp_Trad_Summary.col1 + '</td><td>' + SI_Temp_Trad_Summary.col2 + '</td><td>' + SI_Temp_Trad_Summary.col3 + '</td><td>' +
				SI_Temp_Trad_Summary.col4 + '</td><td>' + SI_Temp_Trad_Summary.col5 + '</td><td>' + SI_Temp_Trad_Summary.col6 + '</td><td>' + 
				SI_Temp_Trad_Summary.col7 + '</td><td>' + SI_Temp_Trad_Summary.col8 + '</td><td>' + SI_Temp_Trad_Summary.col9 + '</td><td>' + 
				SI_Temp_Trad_Summary.col10 + '</td><td>' + SI_Temp_Trad_Summary.col11 + '</td><td>' + SI_Temp_Trad_Summary.col12 + '</td><td>' +
				SI_Temp_Trad_Summary.col13 + '</td><td>&nbsp;</td><td>&nbsp;</td></tr>');
		}
		else if (colType == 2)
		{
			$('#table-Summary3 > tbody').append('<tr><td>' + SI_Temp_Trad_Summary.col0_1 + '</td><td>' + SI_Temp_Trad_Summary.col0_2 + '</td><td>' +
				SI_Temp_Trad_Summary.col1 + '</td><td>' + SI_Temp_Trad_Summary.col2 + '</td><td>' + SI_Temp_Trad_Summary.col3 + '</td><td>' + 
				SI_Temp_Trad_Summary.col4 + '</td><td>' + SI_Temp_Trad_Summary.col5 + '</td><td>' + SI_Temp_Trad_Summary.col6 + '</td><td>' + 
				SI_Temp_Trad_Summary.col7 + '</td><td>' + SI_Temp_Trad_Summary.col8 + '</td><td>' + SI_Temp_Trad_Summary.col9 + '</td><td>' + 
				SI_Temp_Trad_Summary.col10 + '</td><td>' + SI_Temp_Trad_Summary.col11 + '</td><td>' + SI_Temp_Trad_Summary.col12 + '</td><td>' + 
				SI_Temp_Trad_Summary.col13 + '</td><td>' + SI_Temp_Trad_Summary.col14 + '</td><td>' + SI_Temp_Trad_Summary.col15 + '</td></tr>');
		}
		else if (colType == 3)
		{
			$('#table-Summary3 > tbody').append('<tr><td>' + SI_Temp_Trad_Summary.col0_1 + '</td><td>' + SI_Temp_Trad_Summary.col0_2 + '</td><td>' + 
				SI_Temp_Trad_Summary.col1 + '</td><td>' + SI_Temp_Trad_Summary.col2 + '</td><td>' + SI_Temp_Trad_Summary.col3 + '</td><td>' + 
				SI_Temp_Trad_Summary.col4 + '</td><td>' + SI_Temp_Trad_Summary.col5 + '</td><td>' + SI_Temp_Trad_Summary.col6 + '</td><td>' + 
				SI_Temp_Trad_Summary.col7 + '</td><td>' + SI_Temp_Trad_Summary.col10 + '</td><td>' + SI_Temp_Trad_Summary.col11 + '</td><td>' +
				SI_Temp_Trad_Summary.col12 + '</td><td>' + SI_Temp_Trad_Summary.col13 + '</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>');
        }
        else if (colType == 4)
        {
        	$('#table-Summary3 > tbody').append('<tr><td>' + SI_Temp_Trad_Summary.col0_1 + '</td><td>' + SI_Temp_Trad_Summary.col0_2 + '</td><td>' + 
        		SI_Temp_Trad_Summary.col1 + '</td><td>' + SI_Temp_Trad_Summary.col2 + '</td><td>' + SI_Temp_Trad_Summary.col3 + '</td><td>' +
        		SI_Temp_Trad_Summary.col4 + '</td><td>' + SI_Temp_Trad_Summary.col5 + '</td><td>' + SI_Temp_Trad_Summary.col6 + '</td><td>' +
        		SI_Temp_Trad_Summary.col7 + '</td><td>' + SI_Temp_Trad_Summary.col8 + '</td><td>' + SI_Temp_Trad_Summary.col9 + '</td><td>' + 
        		SI_Temp_Trad_Summary.col12 + '</td><td>' + SI_Temp_Trad_Summary.col13 + '</td><td>' + SI_Temp_Trad_Summary.col14 + '</td><td>' + 
        		SI_Temp_Trad_Summary.col15 + '</td><td>&nbsp;</td><td>&nbsp;</td></tr>');
        }
    });    
}

function writeRiderPage1()
{
    if(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data.length > 0){
    	$('#rider1Page1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[0].col1);
        $('#rider2Page1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[0].col5);
        $('#rider3Page1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[0].col9);
        
        $('#col0_1_EPage1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[1].col0_1);
        $('#col0_2_EPage1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[1].col0_2);
        
        $('#col0_1_MPage1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[2].col0_1);
        $('#col0_2_MPage1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[2].col0_2);
        
        for (var i = 1; i < 2; i++) {
            for (var j = 1; j < 13; j++) {//row header
                row = gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[i];
                $('#col' + j + '_EPage1').html(eval('row.col' + j));
                row = gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[i+1];
                $('#col' + j + '_MPage1').html(eval('row.col' + j));
            }
        }
        
        for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data.length; i++) {//row data
            row = gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[i];
            $('#table-Rider1 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + 
            	row.col3 + '</td><td>' + row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + 
            	row.col9 + '</td><td>' + row.col10 + '</td><td>' + row.col11 + '</td><td>' + row.col12 +'</td></tr>');
        }
    }
}

function writeRiderPage2()
{
    if(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data.length > 0){        
        $('#rider1Page2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[0].col1);
        $('#rider2Page2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[0].col5);
        $('#rider3Page2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[0].col9);
        
        $('#col0_1_EPage2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[1].col0_1);
        $('#col0_2_EPage2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[1].col0_2);
        
        $('#col0_1_MPage2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[2].col0_1);
        $('#col0_2_MPage2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[2].col0_2);
        
        for (var i = 1; i < 2; i++) {
            for (var j = 1; j < 13; j++) {//row header
                row = gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[i];
                $('#col' + j + '_EPage2').html(eval('row.col' + j));
                row = gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[i+1];
                $('#col' + j + '_MPage2').html(eval('row.col' + j));
            }
        }
        
        for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data.length; i++) {//row data
            row = gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[i];
            $('#table-Rider2 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' +
            	row.col3 + '</td><td>' + row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + 
            	row.col9 + '</td><td>' + row.col10 + '</td><td>' + row.col11 + '</td><td>' + row.col12 +'</td></tr>');
        }
    }
}

function writeRiderPage3()
{
    if(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data.length > 0){
        $('#rider1Page3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[0].col1);
        $('#rider2Page3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[0].col5);
        $('#rider3Page3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[0].col9);
        
        $('#col0_1_EPage3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[1].col0_1);
        $('#col0_2_EPage3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[1].col0_2);
        
        $('#col0_1_MPage3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[2].col0_1);
        $('#col0_2_MPage3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[2].col0_2);
        
        for (var i = 1; i < 2; i++) {
            for (var j = 1; j < 13; j++) {//row header
                row = gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[i];
                $('#col' + j + '_EPage3').html(eval('row.col' + j));
                row = gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[i+1];
                $('#col' + j + '_MPage3').html(eval('row.col' + j));
            }
        }
        
        for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data.length; i++) {//row data
            row = gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[i];
            $('#table-Rider3 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + 
            	row.col3 + '</td><td>' + row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' +
            	row.col9 + '</td><td>' + row.col10 + '</td><td>' + row.col11 + '</td><td>' + row.col12 +'</td></tr>');
        }
    }
}

function writeRiderPage4()
{
    if(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data.length > 0){
        $('#rider1Page4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[0].col1);
        $('#rider2Page4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[0].col5);
        $('#rider3Page4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[0].col9);
        
        $('#col0_1_EPage4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[1].col0_1);
        $('#col0_2_EPage4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[1].col0_2);
        
        $('#col0_1_MPage4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[2].col0_1);
        $('#col0_2_MPage4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[2].col0_2);
        
        for (var i = 1; i < 2; i++) {
            for (var j = 1; j < 13; j++) {//row header
                row = gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[i];
                $('#col' + j + '_EPage4').html(eval('row.col' + j));
                row = gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[i+1];
                $('#col' + j + '_MPage4').html(eval('row.col' + j));
            }
        }
        
        for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data.length; i++) {//row data
            row = gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[i];
            $('#table-Rider4 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' +
            	row.col3 + '</td><td>' + row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + 
            	row.col9 + '</td><td>' + row.col10 + '</td><td>' + row.col11 + '</td><td>' + row.col12 +'</td></tr>');
        }
    }
}

function writeRiderPage5()
{
    if(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data.length > 0){
        $('#rider1Page5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[0].col1);
        $('#rider2Page5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[0].col5);
        $('#rider3Page5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[0].col9);
        
        $('#col0_1_EPage5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[1].col0_1);
        $('#col0_2_EPage5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[1].col0_2);
        
        $('#col0_1_MPage5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[2].col0_1);
        $('#col0_2_MPage5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[2].col0_2);
        
        for (var i = 1; i < 2; i++) {
            for (var j = 1; j < 13; j++) {//row header
                row = gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[i];
                $('#col' + j + '_EPage5').html(eval('row.col' + j));
                row = gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[i+1];
                $('#col' + j + '_MPage5').html(eval('row.col' + j));
            }
        }
        
        for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data.length; i++) {//row data
            row = gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[i];
            $('#table-Rider5 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' +
            	row.col3 + '</td><td>' + row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' +
            	row.col9 + '</td><td>' + row.col10 + '</td><td>' + row.col11 + '</td><td>' + row.col12 +'</td></tr>');
        }
    }
}

function writeRiderPage6()
{
    if(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data.length > 0){
        $('#rider1Page6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[0].col1);
        $('#rider2Page6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[0].col5);
        $('#rider3Page6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[0].col9);
        
        $('#col0_1_EPage6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[1].col0_1);
        $('#col0_2_EPage6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[1].col0_2);
        
        $('#col0_1_MPage6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[2].col0_1);
        $('#col0_2_MPage6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[2].col0_2);
        
        for (var i = 1; i < 2; i++) {
            for (var j = 1; j < 13; j++) {//row header
                row = gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[i];
                $('#col' + j + '_EPage6').html(eval('row.col' + j));
                row = gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[i+1];
                $('#col' + j + '_MPage6').html(eval('row.col' + j));
            }
        }
        
        for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data.length; i++) {//row data
            row = gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[i];
            $('#table-Rider6 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' +
            	row.col3 + '</td><td>' + row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' +
            	row.col9 + '</td><td>' + row.col10 + '</td><td>' + row.col11 + '</td><td>' + row.col12 +'</td></tr>');
        }
    }
}

function writeRiderPage7()
{
    if(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data.length > 0){
        $('#rider1Page7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[0].col1);
        $('#rider2Page7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[0].col5);
        $('#rider3Page7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[0].col9);
        
        $('#col0_1_EPage7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[1].col0_1);
        $('#col0_2_EPage7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[1].col0_2);
        
        $('#col0_1_MPage7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[2].col0_1);
        $('#col0_2_MPage7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[2].col0_2);
        
        for (var i = 1; i < 2; i++) {
            for (var j = 1; j < 13; j++) {//row header
                row = gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[i];
                $('#col' + j + '_EPage7').html(eval('row.col' + j));
                row = gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[i+1];
                $('#col' + j + '_MPage7').html(eval('row.col' + j));
            }
        }
        
        for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data.length; i++) {//row data
            row = gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[i];
            $('#table-Rider7 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + 
            	row.col3 + '</td><td>' + row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' +
            	row.col9 + '</td><td>' + row.col10 + '</td><td>' + row.col11 + '</td><td>' + row.col12 +'</td></tr>');
        }
    }
}

function writeRiderPage8()
{
    if(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data.length > 0){
        $('#rider1Page8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[0].col1);
        $('#rider2Page8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[0].col5);
        $('#rider3Page8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[0].col9);
        
        $('#col0_1_EPage8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[1].col0_1);
        $('#col0_2_EPage8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[1].col0_2);
        
        $('#col0_1_MPage8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[2].col0_1);
        $('#col0_2_MPage8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[2].col0_2);
        
        for (var i = 1; i < 2; i++) {
            for (var j = 1; j < 13; j++) {//row header
                row = gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[i];
                $('#col' + j + '_EPage8').html(eval('row.col' + j));
                row = gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[i+1];
                $('#col' + j + '_MPage8').html(eval('row.col' + j));
            }
        }
        
        for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data.length; i++) {//row data
            row = gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[i];
            $('#table-Rider8 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + 
            	row.col3 + '</td><td>' + row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + 
            	row.col9 + '</td><td>' + row.col10 + '</td><td>' + row.col11 + '</td><td>' + row.col12 +'</td></tr>');
        }
    }
}

function setPageDesc(page){
	loadRptVers();
    db.transaction(function(transaction) {
    	transaction.executeSql('select count(*) as pCount from SI_Temp_Pages', [], function(transaction, result) {
    		if (result != null && result.rows != null) {
    			var row = result.rows.item(0); 
    			$('.totalPages').html(row.pCount);
    		}
    	},errorHandler);
    },errorHandler,nullHandler);
    
	sPage = page    
    db.transaction(function(transaction) {
    	transaction.executeSql("Select PageNum from SI_Temp_Pages where htmlName = '" + sPage + "'", [], function(transaction, result) {
    		if (result != null && result.rows != null) {
    			var row = result.rows.item(0); 
    			$('.currentPage').html(row.PageNum);
    		}
    	},errorHandler);
    },errorHandler,nullHandler);
    
    db.transaction(function(transaction) {
    	transaction.executeSql("Select agentName,agentCode from agent_profile LIMIT 1", [], function(transaction, result) {
	    	if (result != null && result.rows != null) {
	    		var row = result.rows.item(0); 
	    		$('#agentName').html(row.agentName);
	    		$('#agentCode').html(row.agentCode);
	    	}
	    },errorHandler);
	},errorHandler,nullHandler);
}

function writeInvestmentScenarios(){
	$('.investmentScenarios').html('<table id="table-notes"><tr><td width="50%" valign="top">&nbsp;</td><td width="50%" valign="top">The Illustration show the possible level of benefits you may expect on two investment scenarios :<br/><i>Ilustrasi ini menunjukkan jangkaan tahap faedah berdasarkan dua senario pelaburan :</i><br/>1. Scenario A (Sce. A) = Assumes the participating fund earns 6.25% every year<br/>&nbsp;&nbsp;&nbsp;&nbsp;<i>Senario A (Sce. A) = Anggapan dana penyertaan memperolehi 6.25% setiap tahun</i><br/>2. Scenario B (Sce. B) = Assumes the participating fund earns 4.25% every year<br/>&nbsp;&nbsp;&nbsp;&nbsp;<i>Senario B (Sce. B) = Anggapan dana penyertaan memperolehi 4.25% setiap tahun</i><br/><br/><div style="width:600px;height:30px;border:2px solid black;padding: 5px 0px 0px 5px">Guaranteed = Minimum you will receive regardless of the Company investment.<br/><i>Terjamin = Minimum yang akan anda perolehi tanpa bergantung kepada pencapaian pelaburan syarikat.</i></div></td></tr></table>');
}

function writeInvestmentScenariosRight(){
	$('.investmentScenariosRight').html('The Illustration show the possible level of benefits you may expect on two investment scenarios :<br/><i>Ilustrasi ini menunjukkan jangkaan tahap faedah berdasarkan dua senario pelaburan :</i><br/>1. Scenario A (Sce. A) = Assumes the participating fund earns 6.50% every year<br/>&nbsp;&nbsp;&nbsp;&nbsp;<i>Senario A (Sce. A) = Anggapan dana penyertaan memperolehi 6.50% setiap tahun</i><br/>2. Scenario B (Sce. B) = Assumes the participating fund earns 4.50% every year<br/>&nbsp;&nbsp;&nbsp;&nbsp;<i>Senario B (Sce. B) = Anggapan dana penyertaan memperolehi 4.50% setiap tahun</i><br/><br/><div style="width:480px;height:30px;border:2px solid black;padding: 5px 0px 0px 5px">Guaranteed = Minimum you will receive regardless of the Company investment.<br/><i>Terjamin = Minimum yang akan anda perolehi tanpa bergantung kepada pencapaian pelaburan syarikat.</i></div>');
}

function formatCurrency(num) {
	if (num == "-") {
		return "-";
	}
	num = num.toString().replace(/\$|\,/g, '');
	
    if (isNaN(num)) num = "0";
    sign = (num == (num = Math.abs(num)));
    num = Math.floor(num * 100 + 0.50000000001);
    cents = num % 100;
    num = Math.floor(num / 100).toString();
    if (cents < 10) cents = "0" + cents;
    for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++) {
    	num = num.substring(0, num.length - (4 * i + 3)) + ',' + num.substring(num.length - (4 * i + 3));
    }
    return (((sign) ? '' : '-') + '' + num + '.' + cents);
}

function CurrencyNoCents(num) {
    if (num == "-") return "-";
    
    if (typeof num == 'string') {
   	 	val = num.replace(/\$|\,/g, '');
   	 	
   	 	cent = val.indexOf(".");
   	 	if (cent > 0) {
   	 		centval = val.substring(cent+1, 2);
   	 		val = val.substring(0, cent);
			if (parseInt(centval) > 50) {
				val = parseInt(val) + 1;
			}
   	 	}
   	} else {
   		val = num.toString().replace(/\$|\,/g, '');
   	}
    if (isNaN(val)) val = "0";
    sign = (val == (val = Math.abs(val)));
    val = val.toString();
    for (var i = 0; i < Math.floor((val.length - (1 + i)) / 3); i++) {
    	val = val.substring(0, val.length - (4 * i + 3)) + ',' + val.substring(val.length - (4 * i + 3));
    }
    
    return (((sign) ? '' : '-') + '' + val);
}

function gup(name)
{
	name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
	var regexS = "[\\?&]"+name+"=([^&#]*)";
	var regex = new RegExp( regexS );
	var results = regex.exec( window.location.href );
	if( results == null ) {
		return "";
	} else {
		return results[1];
	}
}
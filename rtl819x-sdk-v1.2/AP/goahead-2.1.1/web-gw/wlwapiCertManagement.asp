<html>
<head>
<meta http-equiv="Content-Type" content="text/html">
<SCRIPT language=Javascript src="language.js"></SCRIPT>
<title>Cerfitication Information</title>
<style>
.on {display:on}
.off {display:none}
</style>
<SCRIPT language=JavaScript> 
var page_max_cert_num = 5;
var isIE = (document.all)? true:false;
var num_click = 0;
var query_id = -1;
var max_cert_period = 628556052;
var question;
var cur_index=0;
var itemsShowed=0;
var myData = <% getInfo("wapiCert");%>;
var total_cert = myData.length;
var DataArray = new Array();
var TRStyle="<tr onmouseover=\"this.style.background='#E7E7E9';\" onmouseout =\"this.style.background='';this.style.borderColor=''\" >";
var TDCheckBoxHeader="<td width=\"7%\" height=\"26\" align=\"center\" class=\"s1\">\
	<input align=\"center\" type=\"checkbox\" name=\"CHECKBOX\" height=\"26\" value=";
var TDCheckBoxTail="></td>";
var TDNameHeader="<td width=\"38%\" height=\"26\" align=\"center\" class=\"s1\">";
var TDSerialHeader="<td width=\"15%\" height=\"26\" align=\"center\" class=\"s1\">";
var TDValidTimeHeader="<td width=\"12%\" height=\"26\" align=\"center\" class=\"s1\">";
var TDValidTimeLeftHeader="<td width=\"12%\" height=\"26\" align=\"center\" class=\"s1\">";
var TDTypeHeader="<td width=\"7%\" height=\"26\" align=\"center\" class=\"s1\">";
var TDStatusHeader="<td width=\"9%\" height=\"26\" align=\"center\" class=\"s1\">";
var TDTail="</td>";
var TRTail="</tr>";

function mysubmit()
{
	if(num_click == 1)
	{
		return false;
	}
	num_click = 1;
	document.fm1.submit();
}
function pageup()
{
	var query_idx = document.fm1.SELECT1.value;
	var query_val;
	var index;
	if (query_idx == "2") 
	{
			
			query_val = document.fm1.CERT_INFO.value;
			if (query_val.length == 0)
			{
				alert("Please Input Serial Number!");
				document.fm1.CERT_INFO.focus();
				return false;
			}

			if (query_val.length != 8)
                        {
                                alert("Length Of Serial Number Error!");
                                document.fm1.CERT_INFO.focus();
                                return false;
                        }
	}

	document.fm1.UP_DOWN.value="UP";
	index=cur_index-page_max_cert_num;
	if(index < 0)
		index=0;
	DataShow(index);
	return true;
}
function pagedown()
{
	var query_idx = document.fm1.SELECT1.value;
	var query_val;
	var index;

	if (query_idx == "2") 
	{
			
			query_val = document.fm1.CERT_INFO.value;
			if (query_val.length == 0)
			{
				alert("Please Input Serial Number!");
				document.fm1.CERT_INFO.focus();
				return false;
			}

			if (query_val.length != 8)
                        {
                                alert("Length Of Serial Number Error!");
                                document.fm1.CERT_INFO.focus();
                                return false;
                        }
	}
	document.fm1.UP_DOWN.value="DOWN";
	if(cur_index > total_cert)
		return false;
	index=cur_index+page_max_cert_num;
	DataShow(index);
	return true;
}

//////////////////////////////////////////////////
// a : 1---revoke  2----unrevoke 3----del  4---active
function cert_mng(a, sn)
{
	var question;
	if (a==1)
	{
		question = confirm("Cancel the certification?");
		if(!question)
		{
			return;
		}		
	}
	document.fm1.CERT_MNG.value = a;
	document.fm1.CERT_SN.value = sn;
	mysubmit();
}

function cert_revoke(n)
{
	var i;
	var num = 0;
	var sn = "";
	var revoke_n = 0;
	var question;
	
	if (n < 1)
	{
		alert("Sorry, no Cert to revoke!");
		return;
	
	}
	
	if (n == 1)
	{
		if (document.fm1.CHECKBOX.checked)
		{
			sn = document.fm1.CHECKBOX.value+":";
			revoke_n++;
		}
	}
	else
	{	
		if(n > total_cert)
			n=total_cert;
		for (i=0; i<n; i++)
		if (document.fm1.CHECKBOX[i].checked)
		{
			sn = sn+document.fm1.CHECKBOX[i].value+":";
			revoke_n++;
		}
	}
	if (revoke_n == 0)
	{
		alert("sorry ,please select the certifications to remove");
                return;
	}

	question = confirm("Remove Selected Certifications?");
	if(!question)
	{
		return;
	}

	document.fm1.CERT_MNG.value = 1;
	document.fm1.CERT_SN.value = sn;
	mysubmit();
}
function clearAll()
{
//	if(total_cert < 1)
//	{
//		alert("No Certifications Exists");
//		return false;
//	}

	question = confirm("Before going, make sure that our system time has sync correctly already.\nHas our system time sync correctly yet?");
        if(!question)
        {
                return;
        }
		
	question = confirm("This will Clear all the certifications distributed and CA will be re-init, are you sure?");
        if(!question)
        {
                return;
        }
	document.fm1.CERT_MNG.value = 6;
	mysubmit();
	
}
function select_all()
{
        var i;
        var n = itemsShowed;
	 var select_n = 0;

        if (n < 1)
        {
                alert("sorry! No Certification To Selected");
                return;

        }
	 
	if (n == 1)
	{
		if (!document.fm1.CHECKBOX.disabled)
		{
			document.fm1.CHECKBOX.checked = true;
            select_n++;
		}

	}
	else
       for (i=0; i<n; i++)
       {
		if (!document.fm1.CHECKBOX[i].disabled)
		{
     		   	document.fm1.CHECKBOX[i].checked = true;
                 	select_n++;
		}
       }
       
	if (select_n == 0)
       {
                alert("Sorry! No Certification Selected");
                return;
       }
}

function wopen()
{
	if('<%getInfo("caCertExist");%>'=="0")
	{
		alert("Since CA cert is not ready now, please push button \"Clear All Certifications and Re-Init CA\" to intial CA files at first.");
		return false;
	}
	window.open("/wlwapiDistribute.asp","","width=800, height=600,scrollbars=yes,top=100,left=200");
	return false;
}

function regInput(obj, reg, inputStr)
{
	var docSel;
	if (isIE)
	{
		docSel	= document.selection.createRange();
		if (docSel.parentElement().tagName != "INPUT")	return false;
		oSel = docSel.duplicate();
		oSel.text = "";
		var srcRange	= obj.createTextRange();
		oSel.setEndPoint("StartToStart", srcRange);
		var str = oSel.text + inputStr + srcRange.text.substr(oSel.text.length);
		return reg.test(str);
	}
}

function IsNum(num)
{
	var number="0123456789";
	for(i=0;i<num.length;i++)
	{
		for(j=0;j<10;j++)
			if (num.charAt(i)==number.charAt(j)) break;
		if (j>=10) return (false);
	 }
	return (true);
}



function go_submit()
{
	var query_idx = document.fm1.SELECT1.value;
	var query_val;

	if (query_idx == "2") 
	{
			
			query_val = document.fm1.CERT_INFO.value;
			if (query_val.length == 0)
			{
				alert("Please Input Serial!");
				document.fm1.CERT_INFO.focus();
				return ;
			}

			if (query_val.length != 8)
                        {
                                alert("Lenght of Serial Error!");
                                document.fm1.CERT_INFO.focus();
                                return ;
                        }
	}

	if ((query_idx != query_id) || (query_param != -1))
	{
		document.fm1.QPAGE_FROM.value = 0;	
	}
	document.fm1.CERT_MNG.value = 5;
	mysubmit();
	return ;
}
function Data(name,serial,validtime,validtimeleft,type,status) 
{
        this.name = name;
        this.serial= serial;
        this.validtime = validtime;
        this.validtimeleft = validtimeleft;
        this.type = type;
        this.status = status ;
}
function layerWrite(id,nestref,text)
{
	document.getElementById(id).innerHTML = text;
}
function oncancle()
{
	document.getElementById("win_pop").style.display ='none';
	return;
}
function showDisplayInfo()
{
	var start;
	var end;
	var v;
	if(cur_index > (page_max_cert_num-1))
	{
		start=cur_index;
		document.fm1.b100.disabled=false;
	}
	else
	{
		start=0;
		document.fm1.b100.disabled=true;
	}
	start++;
	if((cur_index + page_max_cert_num)< total_cert)
	{
	 	end=(cur_index + page_max_cert_num);
		document.fm1.b101.disabled=false;
	}
	else
	{	
		end=total_cert;
		document.fm1.b101.disabled=true;
	}
	v="total "+total_cert+" display "+start+"-"+end+" of "+total_cert;
	itemsShowed=end-start+1;
	document.fm1.show_info.value=v;
}
function DataShow(index)
{
	var v ="";
	var count=0;
        v+="<table border=\"1\" width=\"98%\"  cellspacing=\"0\" cellpadding=\"0\" height=\"55\">\
        <caption>\
        <p align=\"center\"><font face=\"MS Serif\" size=\"4\" color=\"#808000\">Certification List</font></p>\
         </caption>\
        <thead id=\"tdid2\" style=\"background-color:\">\
        <tr>\
        <td width=\"7%\" height=\"52\" align=\"center\" class=\"tbhead\" rowspan=\"2\" alt=\'del\'>Selected</td>\
        <td width=\"38%\" height=\"52\" align=\"center\" class=\"tbhead\" rowspan=\"2\">Owner</td>\
        <td width=\"15%\" height=\"52\" align=\"center\" class=\"tbhead\" rowspan=\"2\">Serial.NO</td>\
        <td width=\"24%\" height=\"26\" align=\"center\" class=\"tbhead\" colspan=\"2\">Valid Time</td>\
        <td width=\"7%\" height=\"52\" align=\"center\" class=\"tbhead\" rowspan=\"2\">Type</td>\
        <td width=\"9%\" height=\"52\" align=\"center\" class=\"tbhead\" rowspan=\"2\">Status</td>\
        </tr>\
        <tr>\
        <td width=\"12%\" height=\"26\" align=\"center\" class=\"tbhead\">Total</td>\
        <td width=\"12%\" height=\"26\" align=\"center\" class=\"tbhead\">Left</td>\
        </tr></thead><tbody>";
	for(var i=index; i<DataArray.length && count<page_max_cert_num; i++) 
	{
		v +=TRStyle;
		v +=TDCheckBoxHeader+DataArray[i].serial+TDCheckBoxTail;
		v +=TDNameHeader+DataArray[i].name+TDTail;
		v +=TDSerialHeader+DataArray[i].serial+TDTail;
		v +=TDValidTimeHeader+DataArray[i].validtime+TDTail;
		v +=TDValidTimeLeftHeader+DataArray[i].validtimeleft+TDTail;
		v +=TDTypeHeader+DataArray[i].type+TDTail;
		v +=TDStatusHeader+DataArray[i].status+TDTail;
		count++;
	}
	if(count > 0)
		v+=TRTail;
 	v+="</tbody></table>";
	cur_index=index;
	layerWrite("myDiv", null, v);
	showDisplayInfo();
}

function set_selectIndex(which_value, obj){
    for (var pp=0; pp<obj.options.length; pp++){
        if (which_value == obj.options[pp].value){
            obj.selectedIndex = pp;
            break;
        }
    }
}
function initData()
{
	var i=0;
	var wapisearchindex= <%write(getIndex("wapiSearchIndex"));%>;
	
	for(i=0; i<myData.length ; i++ )
		DataArray[DataArray.length++] = new Data(myData[i][0], myData[i][1], myData[i][2], myData[i][3], myData[i][4], myData[i][5]);
	DataShow(cur_index);
	set_selectIndex(wapisearchindex,document.fm1.SELECT1);
	sel_handle(document.fm1.SELECT1);
}

function checkAsCer()
{
	if('<%getInfo("asCerExist");%>'=="0")
	{
		alert("Since as.cer is not ready now, please push button \"Clear All Certifications and Re-Init CA\" to intial CA files at first.");
		return false;
	}

	return true;
}
</SCRIPT>
</head>
<body id="bodyid" topMargin="0" onload="initData();"> 
<blockquote>
<h2><font color="#0000FF">Certification Management</font></h2>

  <form method="POST" name="fm1" action="/goform/formWapiCertManagement"> 
    <TABLE WIDTH="644" CELLSPACING=1 CELLPADDING=4 BORDER=1 height="145"> 
    <tr><font size=2>
 This page allows you to manage the certifications which our AP distributes. Here you may distribute, 
 clear, revoke, search any certification our AP distributes. Besides, you could download AS certification.
    </tr>

 	<tr><hr size=1 noshade align=top></tr>
 	
      <TR> 
        <TD id="tdid1" style="background-color:" width="633"  height="134" > <center> 
	  <DIV id="myDiv"></DIV>
          </center> 
          <center> 
            <table border="1" width="98%" cellspacing="0" cellpadding="0" height="31"> 
              <tr> 
                <td width="40%" height="31" valign="middle" align="center">
		<input name="show_info" size="32" class="lable_txt" maxlength="32" tabindex="0" value="total 0 display 0 of 0:" readonly>
		</td> 
		<td width="20%" height="31"> <p align="center">&nbsp;<input type=button onclick="javascript:select_all()"  align="top" value="Select All"></p></td>
                <td width="20%" height="31"> <p align="center">&nbsp;<input type=button id = b100 name=b100 onclick="return pageup()" onfoucs=this.blur value="Page up"></p></td> 
                <td width="20%" height="31"> <p align="center"> <input type=button id = b101 name=b101 onclick="return pagedown()" onfocus=this.blur() value="Page down"></p></td> 
              </tr> 
            </table> 
          </center> 
          <script language="javascript">
function sel_handle(sel)
{
		var selIndex = sel.selectedIndex;
		var type = 0;
		var cert_info = 0;
		var status = 0;
		switch (selIndex)
		{
   			case 1:
				var str1 = "<input name=\"CERT_INFO\" size=\"16\"  maxlength=\"8\"";
				var str2 = " onkeypress = \"return regInput(this,/^([0-9 a-f A-F])*$/, String.fromCharCode(event.keyCode))\" ";
				var str3 = " onpaste	= \"return regInput(this,/^([0-9 a-f A-F])*$/, window.clipboardData.getData('Text'))\" ";
				var str4 = " ondrop	    = \"return regInput(this,/^([0-9 a-f A-F])*$/,	event.dataTransfer.getData('Text'))\"";
				var str5 = " style=\"ime-mode:Disabled\"";
				//alert(str1+str2+str3+str4+">");
				document.getElementById("query_span_info").innerHTML = str1+str2+str3+str4+str5+">";
				query_param = 1;
				break;
			case 2:
				//document.getElementById("query_span_info").innerHTML ="<input name=\"CERT_INFO\" size=\"16\"  maxlength=\"32\" value=\"\" style=\"ime-mode:Disabled\">";
				document.getElementById("query_span_info").innerHTML ="<input name=\"CERT_INFO\" size=\"16\"  maxlength=\"32\" style=\"ime-mode:Disabled\">";
				query_param = 1;
				break;
		case 3:		
				 document.getElementById("query_span_info").innerHTML ="<select disabled=\"disabled\" size=\"1\" name=\"CERT_INFO\"><option value=\"1\"  selected>X.509</option><option value=\"2\"  >GBW</option></select>";
				query_param = 1;
				break;
		case 4:
                                document.getElementById("query_span_info").innerHTML ="<select size=\"1\" name=\"CERT_INFO\"><option value=\"0\">Activated<option value=\"2\">Revoked</option></select>";
				query_param = 1;
                                break;
			default:
				document.getElementById("query_span_info").innerHTML ="";
				query_param = -1;
				break;
		}
}

        </script> 
          <center> 
            <table border="1" width="98%" cellspacing="0" cellpadding="0" height="31"> 
              <tr> 
		  <td height=31 class=s1 align=center><INPUT type=button border=0 width="78" height="24" value="Revoke" onclick="cert_revoke(itemsShowed);"></a></td> 
                <td height=31 class=s1 align=center>
<INPUT type=button onClick="return wopen()" align="center" width="78" height="24" value="Distribute">
</td> 
			

                <td width="60%" height="31" class=s1 align=right>Search
		<select name="SELECT1"  style="font-size: 12px" onChange="sel_handle(this)"> 
                    <option value="1" selected>All</option>
                    <option value="2" >Serial.NO</option>
                    <option value="3" >Owner</option> 
                    <option value="4" >Type</option>
		    <option value="5" >Status</option>
                  </select> 
                  <span id=query_span_info></span> 
                  <input type="button" name="Submit_button" value="Search" onClick="go_submit()"> 
&nbsp; </td> 
              </tr> 
            </table> 
          </center> 
          <input type="hidden" name="AUTOREFRESH" value="0"> </TD> 
      </TR> 
     <TR>
	<TD  id="tdid3" style="background-color:" height=31 class=s1 align=center>
	<a target="_blank" href="/as.cer" onClick="return checkAsCer()"><font color="#FF0000">Click here to download X.509 Certification of the AS</font></a>
	</TD>
     </TR>
     <TR>
	<TD  id="tdid3" style="background-color:" height=31 class=s1 align=center>
	<font color="#FF0000"><INPUT type=button onClick="return clearAll()" align="center" width="78" height="24" value="Clear All Certifications and Re-Init CA"></font>
	</TD>
    </TR>
    </TABLE> 

    <input type="hidden" name="QCERT_INFO"  value=""> 
    <input type="hidden" name="UP_DOWN" value=""> 
    <input type="hidden" name="CERT_MNG"  value=""> 
    <input type="hidden" name="CERT_SN"  value=""> 
    <input type="hidden"  name="QPAGE_FROM" value="0">
    <input type="hidden" name="QPAGE_TO" value="10">
    <input type="hidden" name="MAX_CERT_PERIOD" value="">
    <input type="hidden" name="AP_FACT" value="0">
    <input type="hidden" name="next_webpage" value="/wlwapiCertManagement.asp">
  </form> 

<SCRIPT language=JavaScript>
sel_handle(document.fm1.SELECT1)
</SCRIPT>
<SCRIPT language=JavaScript> 
function init()
{
	if (parseInt(document.fm1.AP_FACT.value) == 6)
	{
		document.getElementById("bodyid").style.backgroundColor = "#F8FFEF";
		document.getElementById("tdid1").style.backgroundColor = "#FEFFEF";
		document.getElementById("tdid2").style.backgroundColor = "transparent";
		document.getElementById("tdid3").style.backgroundColor = "FEFFEF";
	}
	else if (parseInt(document.fm1.AP_FACT.value) == 7)
	{
		document.getElementById("bodyid").style.backgroundColor = "#EBF4FB";
		document.getElementById("tdid1").style.backgroundColor = "#EBFFFF";
		document.getElementById("tdid2").style.backgroundColor = "transparent";
		document.getElementById("tdid3").style.backgroundColor = "EBFFFF";
	}
	else
	{
		document.getElementById("bodyid").style.backgroundColor = "#FFFFFF";
		document.getElementById("tdid1").style.backgroundColor = "#ddddd0";
		document.getElementById("tdid2").style.backgroundColor = "#999999";
		document.getElementById("tdid3").style.backgroundColor = "ddddd0";
		
	}

}
//init();
</script> 
</blockquote>
</body>
</html>


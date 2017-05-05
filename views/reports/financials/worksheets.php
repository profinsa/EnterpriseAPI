<?php
/* 
Name of Page: financial 10 column worksheet page

Method: render report page

Date created: Nikita Zaharov, 02.05.2016

Use: this model used for 
- for loading data using stored procedures

Input parameters:
data - datasource

Output parameters:
- just render page

Called from:
controllers/financials

Calls:
datasource

Last Modified: 04.05.2016
Last Modified by: Nikita Zaharov
*/

function renderSheet($tdata){
    $rows = "";
    $sharedStrings = "";
    $lastRow;
    $currentRow = 6;

    foreach($tdata as $row){
	$sharedStrings .= "<si><t>" . preg_replace('/\&/', "&amp;", $row->GLAccountName) . "</t></si>";

	$rows .= "<row r=\"$currentRow\" spans=\"1:20\" ht=\"12.75\" customHeight=\"1\" x14ac:dyDescent=\"0.25\">" .
		 "<c r=\"A$currentRow\" s=\"4\" t=\"s\"><v>" . ( $currentRow + 6) . "</v></c>" .
		 "<c r=\"B$currentRow\" s=\"4\"><v>" . //Trial Dr
		 (($row->GLAccountNumber[0] == '1' || $row->GLAccountNumber[0] > '4') && $row->GLAccountBalance != 0 ?
		  $row->GLAccountBalance : "") .
		 "</v></c>" .
		 "<c r=\"C$currentRow\" s=\"3\" />" .
		 "<c r=\"D$currentRow\" s=\"4\" ><v>" . //Trial Cr
		 (($row->GLAccountNumber[0] > '1' && $row->GLAccountNumber[0] < '5') && $row->GLAccountBalance != 0 ?
		  $row->GLAccountBalance : "").
		 "</v></c>" .
		 "<c r=\"E$currentRow\" s=\"3\" />" .
		 "<c r=\"F$currentRow\" s=\"5\" />" .
		 "<c r=\"G$currentRow\" s=\"3\" />" .
		 "<c r=\"H$currentRow\" s=\"5\" />" .
		 "<c r=\"I$currentRow\" s=\"3\" />" .
		 "<c r=\"J$currentRow\" s=\"5\">" . //Adjusted Trial Dr
		 (($row->GLAccountNumber[0] == '1' || $row->GLAccountNumber[0] > '4') && $row->GLAccountBalance != 0?
					      "<f>=IF(NOT(SUM(B$currentRow+F$currentRow-H$currentRow)=0),SUM(B$currentRow+F$currentRow-H$currentRow),)</f>" : "") .
		 "</c>" .
		 "<c r=\"K$currentRow\" s=\"3\" />" .
		 "<c r=\"L$currentRow\" s=\"5\" >" . //Adjusted Trial Cr
		 (($row->GLAccountNumber[0] > '1' && $row->GLAccountNumber[0] < '5') && $row->GLAccountBalance != 0 ?
		  "<f>=IF(NOT(SUM(D$currentRow-F$currentRow+H$currentRow)=0),SUM(D$currentRow-F$currentRow+H$currentRow),)</f>" : "").
		 "</c>" .
		 "<c r=\"M$currentRow\" s=\"3\" />" .
		 "<c r=\"N$currentRow\" s=\"5\" >" . //Income Dr
		 ($row->GLAccountNumber[0] > '4' && $row->GLAccountBalance != 0 ? 
		  "<f>=IF(NOT(SUM(J$currentRow)=0),SUM(J$currentRow),)</f>" : "").
		 "</c>" .
		 
		 "<c r=\"O$currentRow\" s=\"3\" />" .
		 "<c r=\"P$currentRow\" s=\"5\" >" .//Income Cr
		 ($row->GLAccountNumber[0] == '4' && $row->GLAccountBalance != 0 ?
					      "<f>IF(NOT(SUM(L$currentRow)=0),SUM(L$currentRow),)</f>" : "").
		 "</c>" .
		 "<c r=\"Q$currentRow\" s=\"3\" />" .
		 "<c r=\"R$currentRow\" s=\"5\">" . //Balance Dr
		 ($row->GLAccountNumber[0] == '1' && $row->GLAccountBalance != 0 ?
					      "<f>=IF(NOT(SUM(J$currentRow)=0),SUM(J$currentRow),)</f>" : "").
		 "</c>" .
		 "<c r=\"S$currentRow\" s=\"3\" />".//Balance Cr
		 "<c r=\"T$currentRow\" s=\"5\" >" .
		 (($row->GLAccountNumber[0] == '2' || $row->GLAccountNumber[0] == '3') && $row->GLAccountBalance != 0 ?
										 "<f>=IF(NOT(SUM(L$currentRow)=0),SUM(L$currentRow),)</f>" : "").
		 "</c>" .
		 "</row>";
	$currentRow++;
    }
    
    $lastRow = $currentRow - 1;
    
    $rows .= "<row r=\"$currentRow\" spans=\"1:20\" ht=\"12.75\" customHeight=\"1\" x14ac:dyDescent=\"0.25\">" .
	     "<c r=\"A$currentRow\" s=\"6\" t=\"s\"><v>10</v></c>".
	     "<c r=\"B$currentRow\" s=\"4\"><f>IF(NOT(SUM(B5:B$lastRow)=0),SUM(B5:B$lastRow),)</f></c>" .
	     "<c r=\"C$currentRow\" s=\"3\" />" .
	     "<c r=\"D$currentRow\" s=\"4\"><f>IF(NOT(SUM(D5:D$lastRow)=0),SUM(D5:D$lastRow),)</f></c>" .
	     "<c r=\"E$currentRow\" s=\"3\" />" .
	     "<c r=\"F$currentRow\" s=\"7\"><f>IF(NOT(SUM(F5:F$lastRow)=0),SUM(F5:F$lastRow),)</f></c>" .
	     "<c r=\"G$currentRow\" s=\"3\" />" .
	     "<c r=\"H$currentRow\" s=\"7\"><f>IF(NOT(SUM(H5:H$lastRow)=0),SUM(H5:H$lastRow),)</f></c> " .
	     "<c r=\"I$currentRow\" s=\"3\" />" .
	     "<c r=\"J$currentRow\" s=\"7\"><f>IF(NOT(SUM(J5:J$lastRow)=0),SUM(J5:J$lastRow),)</f></c>" .
	     "<c r=\"K$currentRow\" s=\"3\" />" .
	     "<c r=\"L$currentRow\" s=\"7\"><f>IF(NOT(SUM(L5:L$lastRow)=0),SUM(L5:L$lastRow),)</f></c>" .
	     "<c r=\"M$currentRow\" s=\"3\" />" .
	     "<c r=\"N$currentRow\" s=\"7\"><f>IF(NOT(SUM(N5:N$lastRow)=0),SUM(N5:N$lastRow),)</f></c>" .
	     "<c r=\"O$currentRow\" s=\"3\" />" .
	     "<c r=\"P$currentRow\" s=\"7\"><f>IF(NOT(SUM(P5:P$lastRow)=0),SUM(P5:P$lastRow),)</f></c>" .
	     "<c r=\"Q$currentRow\" s=\"3\" />" .
	     "<c r=\"R$currentRow\" s=\"7\"><f>IF(NOT(SUM(R5:R$lastRow)=0),SUM(R5:R$lastRow),)</f></c>" .
	     "<c r=\"S79\" s=\"3\" />" .
	     "<c r=\"T$currentRow\" s=\"7\"><f>IF(NOT(SUM(T5:T$lastRow)=0),SUM(T5:T$lastRow),)</f></c>" .
	     "</row>";
    $currentRow++;
    $rows .= "<row r=\"$currentRow\" spans=\"1:20\" ht=\"12.75\" customHeight=\"1\" x14ac:dyDescent=\"0.25\">" .
	     "<c r=\"A$currentRow\" s=\"6\" />" .
	     "<c r=\"B$currentRow\" s=\"3\" />" .
	     "<c r=\"C$currentRow\" s=\"3\" />" .
	     "<c r=\"D$currentRow\" s=\"3\" />" .
	     "<c r=\"E$currentRow\" s=\"3\" />" .
	     "<c r=\"F$currentRow\" s=\"5\" />" .
	     "<c r=\"G$currentRow\" s=\"3\" />" .
	     "<c r=\"H$currentRow\" s=\"5\" />" .
	     "<c r=\"I$currentRow\" s=\"3\" />" .
	     "<c r=\"J$currentRow\" s=\"5\" />" .
	     "<c r=\"K$currentRow\" s=\"3\" />" .
	     "<c r=\"L$currentRow\" s=\"5\" />" .
	     "<c r=\"M$currentRow\" s=\"3\" />" . //Income Dr
	     "<c r=\"N$currentRow\" s=\"7\"><f>=IF(NOT(SUM(P" . ($lastRow + 1) . " -N" . ($lastRow + 1) . ")=0),SUM(P" . ($lastRow + 1) . " -N" . ($lastRow + 1) . "),)</f></c>" .
	     "<c r=\"O$currentRow\" s=\"3\" />" .
	     "<c r=\"P$currentRow\" s=\"5\" />" .
	     "<c r=\"Q$currentRow\" s=\"3\" />" .
	     "<c r=\"R$currentRow\" s=\"5\" />" .
	     "<c r=\"S$currentRow\" s=\"3\" />" .//Balance Cr
	     "<c r=\"T$currentRow\" s=\"7\"><f>=IF(NOT(SUM(R" . ($lastRow + 1) . " -T" . ($lastRow + 1) . ")=0),SUM(R" . ($lastRow + 1) . " -T" . ($lastRow + 1) . "),)</f></c></row>";
    $currentRow++;

    $rows .= "<row r=\"$currentRow\" spans=\"1:20\" ht=\"12.75\" customHeight=\"1\" x14ac:dyDescent=\"0.25\">" .
	     "<c r=\"A$currentRow\" s=\"6\" t=\"s\"><v>11</v></c>".
	     "<c r=\"B$currentRow\" s=\"3\" />" .
	     "<c r=\"C$currentRow\" s=\"3\" />" .
	     "<c r=\"D$currentRow\" s=\"3\" />" .
	     "<c r=\"E$currentRow\" s=\"3\" />" .
	     "<c r=\"F$currentRow\" s=\"5\" />" .
	     "<c r=\"G$currentRow\" s=\"3\" />" .
	     "<c r=\"H$currentRow\" s=\"5\" />" .
	     "<c r=\"I$currentRow\" s=\"3\" />" .
	     "<c r=\"J$currentRow\" s=\"5\" />" .
	     "<c r=\"K$currentRow\" s=\"3\" />" .
	     "<c r=\"L$currentRow\" s=\"5\" />" .
	     "<c r=\"M$currentRow\" s=\"3\" />" .
	     "<c r=\"N$currentRow\" s=\"7\"><f>IF(NOT(SUM(N" . ($lastRow + 1) . ":N". ($lastRow + 2) . ")=0),SUM(N" . ($lastRow + 1) . ":N". ($lastRow + 2) . "),)</f></c>" .
	     "<c r=\"O$currentRow\" s=\"3\" />" .
	     "<c r=\"P$currentRow\" s=\"7\"><f>IF(NOT(SUM(P" . ($lastRow + 1) . ")=0),SUM(P" . ($lastRow + 1) . "),)</f></c>" .
	     "<c r=\"Q$currentRow\" s=\"3\" />" .
	     "<c r=\"R$currentRow\" s=\"7\"><f>IF(NOT(SUM(R" . ($lastRow + 1) . ")=0),SUM(R" . ($lastRow + 1) . "),)</f></c>" .
	     "<c r=\"S$currentRow\" s=\"3\" />" .
	     "<c r=\"T$currentRow\" s=\"7\"><f>IF(NOT(SUM(T" . ($lastRow + 1) . ":T" . ($lastRow + 2) . ")=0),SUM(T" . ($lastRow + 1) . ":T" . ($lastRow + 2) . "),)</f></c>" .
	     "</row>";

    //generate sheet
    $tmpsheet = file_get_contents(__DIR__ . "/worksheets/sheet1.xml");
    $tmpsheet = preg_replace('/INSERTHEREINSERTHERE/', $rows, $tmpsheet);
    file_put_contents(__DIR__ . "/worksheets/sheet1.temp.xml", $tmpsheet);

    //generate shared strings for sheet
    $tmpstrings = file_get_contents(__DIR__ . "/worksheets/sharedStrings.xml");
    $tmpstrings = preg_replace('/INSERTHEREINSERTHERE/', $sharedStrings, $tmpstrings);
    file_put_contents(__DIR__ . "/worksheets/sharedStrings.temp.xml", $tmpstrings);
}
$tdata = $data->getData();
renderSheet($tdata);

$file = __DIR__ . "/worksheets/10columns.xlsx";
$zip = new ZipArchive;
if($zip->open($file) === TRUE){
    $zip->addFile(__DIR__ . "/worksheets/sheet1.temp.xml", 'xl/worksheets/sheet1.xml');
    $zip->addFile(__DIR__ . "/worksheets/sharedStrings.temp.xml", 'xl/sharedStrings.xml');
    $zip->close();
    
    header('Content-Description: File Transfer');
    header('Content-Type: application/octet-stream');
    header('Content-Disposition: attachment; filename="'.basename($file).'"');
    header('Expires: 0');
    header('Cache-Control: must-revalidate');
    header('Pragma: public');
    header('Content-Length: ' . filesize($file));
    readfile($file);
    exit;
    //    echo 'ok';
}else{
    echo "eee";
    //  echo 'ошибка';
}
?>

<?php
$user = $data->getUser();
$currencySymbol = $data->getCurrencySymbol()["symbol"];
?>


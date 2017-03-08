var fs = require('fs');
var mysql = require('mysql');

var mysql_config = {
    host     : 'localhost',
    user     : 'root',
    password : '32167',
    database : 'integralx'
};

function isEmpty(object) {
    for (var key in object)
        if (object.hasOwnProperty(key)) return true;
    return false;
}

function getFieldsFromTable(table, cb){
    var connection = mysql.createConnection(mysql_config);

    connection.connect();

    connection.query('describe vendortypes', function (error, results, fields) {
	var ind, _fields = {};
	if (error)
	    throw error;

	for(ind in results){
	    if(results[ind].Field != 'CompanyID' ||
	       results[ind].Field != 'DivisionID' ||
	       results[ind].Field != 'DepartmentID')
	    _fields[results[ind].Field] = results[ind];
	}
	cb(_fields);
    });

    connection.end();    
}

function parse_list(content, file){
    var ind, match, field, re;
    match = content.match(/lblPageHeader.+<\%\$(.+)\%>/i);
    if(match){
	field = match[1];
	field = field.replace(/\s*Translation:/,'');
	field = field.replace(/\s*List\s*/,'');	    
	file.label = field;

    }
    match = content.match(/ObjectName\=\"(\w+)\"[\s\S]+TableName\=\"(\w+)\"/im);
    if(match){
	file.objectName = match[1];
	file.tableName = match[2].toLowerCase();
    }
    match = content.match(/DataKeyNames\=\"([\w\,]+)\"/i);
    if(match){
	file.keyNames = match[1].split(",");
    }

    file.gridFields = [];
    file.columnNames = {};
    re = /BoundField\s*HeaderText\=\"<\%\$\s*Translation:([\w\s]+)\s*\%>\"\s*DataField\=\"([\w\s]+)\"/ig;
    while(match = re.exec(content)){
	file.gridFields.push(match[2]);
	file.columnNames[match[2]] = match[1].replace(/\s*$/, "");
    }
	
    //	console.log(content);
}

function parse_detail(content, file){
    var ind, match, field, re, group_re = /DetailsView[\s\n]+ID=\"(\w+)\"/g,
	groups_content = {}, group, groups = {}, group_name;

    while(match = group_re.exec(content)){
	if(group)
	    group.content = content.substring(group.index, match.index);
	group = groups_content[match[1]] = { index : match.index };
    }
    if(group)
	group.content = content.substring(group.index);

    for(ind in groups_content){
	group_name = ind.match(/(.*)Group/);
	if(group_name)
	    group_name = group_name[1];
	else
	    group_name = ind;
	group = groups[group_name] = {};
	while(groups_content[ind].content && (
	    (match = groups_content[ind].content.match(/BoundField\s*HeaderText\=\"<\%\$\s*Translation:([\w\s]+)\s*\%>\"\s*DataField\=\"([\w\s]+)\"/i)) ||
		(match = groups_content[ind].content.match(/TemplateField\s*HeaderText=\"<\%\$ Translation:([\w\s]+)\s*%>" SortExpression=\"(\w+)\"/i)))){
	    group[match[2]] = {
		inputType : "text",
		defaultValue : ""
	    };
	    if(!file.hasOwnProperty("columnNames"))
		file.columnNames = {};
	    file.columnNames[match[2]] = match[1].replace(/\s*$/, "");
	    groups_content[ind].content = groups_content[ind].content.substring(match.index + match[1].length);
	}
    }
//    console.log(match.index);
    file.groups = groups;
}

function parse_files(files){
    var content, ind;
    for(ind in files){
	if(files[ind].list){
	    content = fs.readFileSync(process.argv[2] + '/' + ind + 'List.aspx').toString();
	    parse_list(content, files[ind]);
	}
	if(files[ind].detail){
	    content = fs.readFileSync(process.argv[2] + '/' + ind + 'Detail.aspx').toString();
	    parse_detail(content, files[ind]);
	}
    }
}

function generate_model(file, title, menuTitle, cb){
    var content, find, fields, groups, group, gind;
    content = "<?php\nrequire \"./models/gridDataSource.php\";\nclass gridData extends gridDataSource{\nprotected $tableName = \"" + file.tableName + "\"\n;";

    content += "protected $gridFields =" + JSON.stringify(file.gridFields) + ";\n";
    content += "public $dashboardTitle =\"" + file.label + "\";\n";
    content += "public $breadCrumbTitle =\"" + file.label + "\";\n";
    content += "public $idField =\"" + file.keyNames[3] + "\";\n";

    content += "public $editCategories = [\n";
    groups = file.groups;
    for(gind in groups){
	content += "\"" + gind + "\" => [\n";

	group = groups[gind];
	for(find in group){
	    content += "\n\"" + find + "\" => [\n" +
		"\"inputType\" => \"" + group[find].inputType + "\",\n" +
		"\"defaultValue\" => \"" + group[find].defaultValue + "\"\n" +		    
		"],"; 
	}
	content = content.substring(0,content.length - 1);
	content += "\n]\n";
    }
    content = content.substring(0, content.length - 1);
    content += "];\n";

    content += "public $columnNames = [\n";
    fields = file.columnNames;
    for(find in fields){
	content += "\n\"" + find + "\" => \"" + fields[find] + "\",";
	//generate_model(
    }
    content = content.substring(0, content.length - 1);
    content += "];\n";
    
    content += "}?>\n";
    fs.writeFileSync('models/' + title + '.php', content);

    cb("\n[\n" +
       "\"id\" => \"" + menuTitle + "/" + title + "\",\n" +
       "\"full\" => $translation->translateLabel('" + file.label + "'),\n" +
       "\"href\"=> \"" + menuTitle + "/" + title  + "\",\n" +
       "\"short\" => \"" + (file.label? file.label.substring(0,2) : "") + "\"\n],");
 }

function process_model(file, title, menuTitle, cb){
    var group;
    if(!file.detail || isEmpty(file.groups)){
	getFieldsFromTable(file.tableName, function(fields){
	    var ind;
	    file.groups = {};
	    group = file.groups["Main"] = {};
	    for(ind in fields){
		if(!file.columnNames.hasOwnProperty(ind))
		    file.columnNames[ind] = ind;
		group[ind] = {
		    inputType : "text",
		    defaultValue : ""
		};
	    }
	    console.log(JSON.stringify(file, null, 3));
	    generate_model(file, title, menuTitle, cb);
	});
    }
}

function generate_models(files, menuTitle, fcounter){
    var _fcounter = 0;
    var ind, content;
    var menuCategories =
	    "$menuCategories[\"" + menuTitle +  "\"] = [\n" +
	    "\"type\" => \"submenu\",\n" +
	    "\"id\" => \"" + menuTitle + "\",\n" +
	    "\"full\" => $translation->translateLabel('" + menuTitle + "'),\n" +
	    "\"short\" => \"" + menuTitle.substring(0, 2) + "\",\n"+
	    "\"data\" => [\n";
	    
    //generating models content
    for(ind in files){
	if(!files[ind].list)
	    continue;
	process_model(files[ind], ind, menuTitle, function(_menuCategories){
	    _fcounter++;
	    menuCategories += _menuCategories;
	    if(_fcounter == fcounter){
		menuCategories = menuCategories.substring(0, menuCategories.length - 1);
		menuCategories += "\n]\n];\n";
		fs.writeFileSync('models/menuCategories.php', menuCategories);
	    }
	});
   }
}

function main(){
    var fcounter = 0;
    if(process.argv.length < 3){
	console.log('please specify a folder\nusage: convertor.js folder');
    }else{
	var dir = fs.readdirSync(process.argv[2]), ind;
	var files = {}, match;
	for(ind in dir){
	    if(match = dir[ind].match(/(.*)List\.aspx$/)){
		if(files.hasOwnProperty(match[1]))
		    files[match[1]].list = true;
		else
		    files[match[1]] = { list : true };
		fcounter++;
	    }else if(match = dir[ind].match(/(.*)Detail\.aspx$/)){
		if(files.hasOwnProperty(match[1]))
		    files[match[1]].detail = true;
		else
		    files[match[1]] = { detail : true };
	    }
	}
	
	parse_files(files);
	generate_models(files, process.argv[2].match(/\/(.+)/)[1], fcounter);
    }
}

main();

/*
 Name of Page: ASPX to php models convertor

 Method: It read *List.aspx files and created models for using it in integral accounting enterprise x

 Date created: Nikita Zaharov, 06.03.2016

 Use: 
 reads *List.aspx files, extracts table name, fileds, types and other and then created model for
 use in integralx project as screen. Also it generate menu model for menu(sidebar items with links)

 Input parameters:
 directory which contains .aspx files or pat to .aspx file

 Output parameters:
 - screen models for each .aspx file
 - menuCategories model(which contains menu items) for all .aspx files

 Called from:
 as command line tool

 Calls:
 mysql

 Last Modified: 09.03.2016
 Last Modified by: Nikita Zaharov
 */

var fs = require('fs');
var mysql = require('mysql');

var mysql_config = {
    host     : 'localhost',
    user     : 'root',
    password : '32167',
    database : 'integralx'
};

function isEmpty(object) {
    return JSON.stringify(object) == '{}';
}

var connection = mysql.createConnection(mysql_config);

connection.connect();

function getFieldsFromTable(table, cb){
    connection.query('describe ' + table, function (error, results, fields) {
	var ind, _fields = {};
	if(error){
	    cb(error);
	    return;
	}
	for(ind in results){
	    if(results[ind].Field != 'CompanyID' &&
	       results[ind].Field != 'DivisionID' &&
	       results[ind].Field != 'DepartmentID'&&
	       results[ind].Field != 'LockedBy'&&
	       results[ind].Field != 'LockTS')
	    _fields[results[ind].Field] = results[ind];
	}
	cb(undefined, _fields);
    });
}

function generate_model(file, title, menuTitle, cb){
    var content, find, fields, groups, group, gind;
    content = "<?php\n";
    content += "namespace App\\Models;\n require __DIR__ . \"/../../../Models/gridDataSource.php\";\n"; //for laravel
    content += "class gridData extends gridDataSource{\n"; //for laravel
    //content += "require \"./models/gridDataSource.php\";\n"; //for intergralx
    //content += "class gridData extends gridDataSource{\n"; //for intergralx
    content += "protected $tableName = \"" + file.tableName + "\";\n";

    content += "protected $gridFields =" + JSON.stringify(file.gridFields) + ";\n";
    content += "public $dashboardTitle =\"" + file.label + "\";\n";
    content += "public $breadCrumbTitle =\"" + file.label + "\";\n";
    content += "public $idField =\"" + (file.keyNames ? file.keyNames[3] : '') + "\";\n";

    content += "public $editCategories = [\n";
    groups = file.groups;
    for(gind in groups){
	content += "\"" + gind + "\" => [\n";

	group = groups[gind];
	for(find in group){
	    content += "\n\"" + find + "\" => [\n" +
		"\"inputType\" => \"" + group[find].inputType + "\",\n" +
		"\"defaultValue\" => \"" + group[find].defaultValue + "\"\n" +
		(group[find].hasOwnProperty("disabledEdit") ? ",\"disabledEdit\" => \"" + group[find].disabledEdit + "\"\n" : "") +
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
    fs.writeFileSync('models/' + file.outFile + '.php', content);

    cb("\n[\n" +
       "\"id\" => \"" + menuTitle + "/" + title + "\",\n" +
       "\"full\" => $translation->translateLabel('" + file.label + "'),\n" +
       "\"href\"=> \"" + menuTitle + "/" + title  + "\",\n" +
       "\"short\" => \"" + (file.label? file.label.substring(0,2) : "") + "\"\n],");
 }

function generate_models(files, menuTitle, fcounter, notGenerateMenu){
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
	process_model(files[ind], ind, menuTitle, function(err, _menuCategories){
	    _fcounter++;
	    menuCategories += err ? '' : _menuCategories;
	    console.log(_fcounter, fcounter);
	    if(_fcounter == fcounter){
		menuCategories = menuCategories.substring(0, menuCategories.length - 1);
		menuCategories += "\n]\n];\n";
		if(!notGenerateMenu)
		    fs.writeFileSync('models/menuCategories.php', menuCategories);
		connection.end();    
	    }
	});
   }
}

function process_model(file, title, menuTitle, cb){
    var group;
//    if(!file.detail || isEmpty(file.groups)){
    getFieldsFromTable(file.tableName, function(err, fields){
	if(err){
	    cb(err);
	    console.log(err);
	    return;
	}
	    
	var ind;
	file.groups = {};
	group = file.groups["Main"] = {};
	for(ind in fields){
	    //		console.log(fields[ind]);
	    if(!file.columnNames.hasOwnProperty(ind))
		file.columnNames[ind] = ind;
	    group[ind] = {
		defaultValue : ""
	    };
	    if(fields[ind].Type == 'datetime' || fields[ind].Type == 'timestamp'){
		group[ind].inputType = 'datepicker';
		group[ind].defaultValue = 'now';
	    }else
		group[ind].inputType = "text";
	}
	//	    console.log(JSON.stringify(file, null, 3));
	generate_model(file, title, menuTitle, cb);
    });
    //  }else{
    //	console.log(JSON.stringify(file, null, 3));
    //	generate_model(file, title, menuTitle, cb);
    //  }
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

function parse_files(files, fullpath){
    var content, ind;
    for(ind in files){
	if(fullpath){
		content = fs.readFileSync(files[ind].path).toString();
		parse_list(content, files[ind]);
	}else{
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

//main();

function make_all(){
    var menu = require("./menu.js").Node, ind, smenu, sind, items, iind;
    var files = [];
    var menuCategories = '';

    for(ind in menu){
	smenu = menu[ind].Node;
	console.log(menu[ind]._ObjectName, menu[ind]._Text); 
	menuCategories += "<?php \n $menuCategories[\"" + menu[ind]._Text.replace(/[\'\s"]/g,"") +  "\"] = [\n" +
	    "\"type\" => \"submenu\",\n" +
	    "\"id\" => \"" + menu[ind]._Text.replace(/[\'\s\W"]/g,"") + "\",\n" +
	    "\"full\" => $translation->translateLabel('" + menu[ind]._Text.replace("\'","\\'") + "'),\n" +
	    "\"short\" => \"" + menu[ind]._Text.substring(0, 2) + "\",\n"+
	    "\"data\" => [\n";
	for(sind in smenu){
	    console.log('  ', smenu[sind]._ObjectName, smenu[sind]._Text); 
	    items = smenu[sind].Node;
	    for(iind in items){
		if(items[iind]._NavigateUrl){
		    var parts = items[iind]._NavigateUrl.match(/\~\/(.+)\/(.+)\/(.+)/),
			path;
		    if(parts){
			if(!fs.existsSync('models/' + parts[1]))
			    fs.mkdirSync('models/' + parts[1]);
			if(!fs.existsSync('models/' + parts[1] + '/' + parts[2]))
			    fs.mkdirSync('models/' + parts[1] + '/' + parts[2]);
			//if(!fs.existsSync('models/' + parts[1] + '/' + parts[2] + '/' + parts[3]))
			  //  fs.mkdirSync('models/' + parts[1] + '/' + parts[2] + '/' + parts[3]);
			path = parts[1] + "/" + parts[2] + "/" + parts[3];
			if(fs.existsSync(path)){
			    files.push({
				outFile : path.match(/(.+)\.aspx/)[1],
				path : path,
				list : true
			    });
			}
			menuCategories += "\n    [\n" +
			    "    \"id\" => \"" + menu[ind]._Text.replace(/[\'\s\W"]/g,"") + "/" + items[iind]._Text.replace(/[\'\s\W"]/g,"") + "\",\n" +
			    "    \"full\" => $translation->translateLabel('" + items[iind]._Text.replace("\'","\\'") + "'),\n" +
			    "    \"href\"=> \"" + parts[1] + "/" + parts[2] + "/" + parts[3].match(/(.+)\.aspx/)[1]  + "\",\n" +
			    "    \"short\" => \"" + (items[iind]._Text? items[iind]._Text.substring(0,2) : "") + "\"\n],";
			//	console.log('    ', items[iind]);//items[iind]._NavigateUrl, items[iind]._Text); 
		    }
		}
	    }
	}
	menuCategories = menuCategories.substring(0, menuCategories.length - 1);
	menuCategories += "\n]\n];\n ?>";
    }
    
    parse_files(files, true);
    generate_models(files, 'general', files.length, true);
    fs.writeFileSync('models/menuCategoriesGenerated.php', menuCategories);
}

make_all();

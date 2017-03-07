var fs = require('fs');

function parse_list(content, file){
    var ind, match, field, re;
    match = content.match(/lblPageHeader.+<\%\$(.+)\%>/i);
    if(match){
	field = match[1];
	field = field.replace(/\s*Translation:/,'');
	field = field.replace(/\s*List\s*/,'');	    
	file.label = field;

    }
    match = content.match(/ObjectName\=\"(\w+)\".+TableName\=\"(\w+)\"/i);
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

function parse_files(files){
    var content, ind;
    for(ind in files){
	if(files[ind].list){
	    content = fs.readFileSync(process.argv[2] + '/' + ind + 'List.aspx').toString();
	    parse_list(content, files[ind]);
	}
    }
}

function generate_models(files){
    var ind, content, menuCategories = '', find, fields;
    
    //generating models content
    for(ind in files){
	content = "<?php\nrequire \"./models/gridDataSource.php\";\nclass gridData extends gridDataSource{\nprotected $tableName = \"" + files[ind].tableName + "\"\n;";

	content += "protected $gridFields =" + JSON.stringify(files[ind].gridFields) + ";\n";
	content += "public $dashboardTitle =\"" + files[ind].label + "\";\n";
	content += "public $breadCrumbTitle =\"" + files[ind].label + "\";\n";


	content += "public $columnNames = [\n";
	fields = files[ind].columnNames;
	for(find in fields){
	    content += "\"" + find + "\" => \"" + fields[find] + "\","; 
	}
	content = content.substring(0, content.length - 1);
	content += "];";
	
	content += "}?>\n";
	fs.writeFileSync('models/' + ind + '.php', content);
    }
}

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
	}else if(match = dir[ind].match(/(.*)Detail\.aspx$/)){
	    if(files.hasOwnProperty(match[1]))
		files[match[1]].detail = true;
	    else
		files[match[1]] = { detail : true };
	}
    }

    parse_files(files);
    generate_models(files);
    
    console.log(JSON.stringify(files, null, 3));
}

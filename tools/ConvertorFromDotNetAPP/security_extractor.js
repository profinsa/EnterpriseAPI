var fs = require('fs');

var dir = fs.readdirSync("./EnterpriseServer/Schema/Objects/App"), find, content;
var perm_re = /<permissions>([\s\S]+)<\/permissions>/mi, match, perm;
//console.log(fs.readFileSync("./EnterpriseServer/Schema/Objects/App/" + dir[3]).toString());
var files = {}, filename;
for(find in dir){
    filename = dir[find].match(/(.+)\.xml/)[1];
    files[filename] = {};
    content = fs.readFileSync("./EnterpriseServer/Schema/Objects/App/" + dir[find]).toString();
//    console.log(content);
    match = content.match(perm_re);
//    console.log(match);
    if(match){
	console.log(match[1]);
	perm = match[1].match(/SelectPermission=\"([\w\|]+)\"/);
	if(perm)
	    files[filename].select = perm[1];
	else
	    files[filename].select = "any";
	perm = match[1].match(/UpdatePermission=\"([\w\|]+)\"/);
	if(perm)
	    files[filename].update = perm[1];
	else
	    files[filename].update = "any";
	perm = match[1].match(/DeletePermission=\"([\w\|]+)\"/);
	if(perm)
	    files[filename].delete = perm[1];
	else
	    files[filename].delete = "any";
	perm = match[1].match(/InsertPermission=\"([\w\|]+)\"/);
	if(perm)
	    files[filename].insert = perm[1];
	else
	    files[filename].insert = "any";
    }else
	files[filename] = {
	    select : 'any',
	    update : 'any',
	    delete : 'any',
	    insert : 'any'
	};
}

var permissions = '<?php\nnamespace App\\Models;\nuse Illuminate\Support\Facades\DB;\nclass permissionsByFile{\npublic $permissions = [\n';
for(find in files){
    permissions += "    \"" + find + "\" => [\n";
    permissions += "        \"select\" => \"" + files[find].select + "\",\n";
    permissions += "        \"update\" => \"" + files[find].update + "\",\n";
    permissions += "        \"insert\" => \"" + files[find].insert + "\",\n";
    permissions += "        \"delete\" => \"" + files[find].delete + "\",\n    ],\n";
}
permissions = permissions.substring(0, permissions.length - 2);
permissions += "\n];\n}\n?>";
fs.writeFileSync('./models/permissionsGenerated.php', permissions);

var fs = require('fs');

var translation = JSON.parse(fs.readFileSync('translation.json'));

console.log(translation[0]);
var sql = '';

var ind, obj;
function escape(str){
    return str.replace(/\'/gm, "");
}
for(ind in translation){
    obj = translation[ind];
    sql += "UPDATE translation set ObjDescription='" + escape(obj.ObjDescription) +  "', " +
	"Arabic='" + escape(obj.Arabic) + "', " +
	"ChineseSimple='" + escape(obj.ChineseSimple) + "', " +
	"ChineseTrad='" + escape(obj.ChineseTrad) + "', " +
	"Dutch='" + escape(obj.Dutch) + "', " +
	"English='" + escape(obj.English) + "', " +
	"ChineseSimple='" + escape(obj.ChineseSimple) + "', " +
	"French='" + escape(obj.French) + "', " +
	"Fund='" + escape(obj.Fund) + "', " +
	"German='" + escape(obj.German) + "', " +
	"Hindi='" + escape(obj.Hindi) + "', " +
	"Italian='" + escape(obj.Italian) + "', " +
	"Japanese='" + escape(obj.Japanese) + "', " +
	"Korean='" + escape(obj.Korean) + "', " +
	"Portuguese='" + escape(obj.Portuguese) + "', " +
	"Russian='" + escape(obj.Russian) + "', " +
	"Spanish='" + escape(obj.Spanish) + "', " +
	"Swedish='" + escape(obj.Swedish) + "', " +
	"Thai='" + escape(obj.Thai) + "' " +
	"WHERE ObjID='" + escape(obj.ObjID) + "';\n";
}

fs.writeFileSync("translation.sql", sql);

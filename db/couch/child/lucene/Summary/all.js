{"analyzer" : "simple",
"index" : "function(doc) { 
if (doc['couchrest-type'] != 'Child' ) { return null; }
var result = new Document();
result.add(doc.name,{\"field\":\"name\"});
result.add(doc.unique_identifier,{\"field\":\"id\"});
result.add(new Date(),{\"field\":\"indexed_at\"});
return result;
}"
}
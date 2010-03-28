class Summary < CouchRestRails::Document
  use_database :child

  view_by :name,
          :map => "function(doc) {
              if ((doc['couchrest-type'] == 'Child') && doc['name'])
             {
                emit(doc['name'],doc);
             }
          }"

  view_by :unique_identifier,
          :map => "function(doc) {
              if ((doc['couchrest-type'] == 'Child') && doc['unique_identifier'])
             {
                emit(doc['unique_identifier'],doc);
             }
          }"

  self.design_doc['fulltext'] ||= {}
  self.design_doc['fulltext']['all'] = {
  "analyzer" => "simple",
  "index" => "function(doc) {
    if (doc['couchrest-type'] != 'Child' ) {
     return null; 
     }
     var result = new Document();
     result.add(doc.name,   {\"field\":\"name\"});
     result.add(doc.unique_identifier,     {\"field\":\"id\"});
     result.add(new Date(), {\"field\":\"indexed_at\"});
     return result;
   }"}
  
  def self.basic_search(childs_name, unique_id)
    x = lucene_search_results("all",
      {"name" => childs_name, "id" => unique_id})
    return [] if x == nil
    x.sort { |lhs,rhs| lhs["name"] <=> rhs["name"]}
  end

  private
  def self.lucene_search_results(index_to_search ,search_values)
    return nil if !search_values
    query_string = create_query_string(search_values)
    results = Summary.search(index_to_search, query_string) if !query_string.empty?
    results["rows"] if results != nil
  end
 
  def self.create_query_string(search_values)
      queries = []
      search_values.each_pair do
        |key, value| add_parameter(queries, key, value) 
      end
      queries.join(" AND ") 
  end
 
  def self.add_parameter(parameters, field, value)
    if (value && !value.empty?)
      parameters.push("#{field}:#{value}*")
    end
  end

end

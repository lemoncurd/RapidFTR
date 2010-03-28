begin

  env = ENV['RAILS_ENV'] || 'development'

  couchdb_config = YAML::load(ERB.new(IO.read(RAILS_ROOT + "/config/couchdb.yml")).result)[env]

  host      = couchdb_config["host"]      || 'localhost'
  port      = couchdb_config["port"]      || '5984'
  database  = couchdb_config["database"]
  username  = couchdb_config["username"]
  password  = couchdb_config["password"]
  ssl       = couchdb_config["ssl"]       || false
  db_prefix = couchdb_config["database_prefix"] || ""
  db_suffix = couchdb_config["database_suffix"] || ""
  host     = "localhost"  if host == nil
  port     = "5984"       if port == nil
  ssl      = false        if ssl == nil

  protocol = ssl ? 'https' : 'http'
  authorized_host = (username.blank? && password.blank?) ? host :
    "#{CGI.escape(username)}:#{CGI.escape(password)}@#{host}"

rescue

  raise "There was a problem with your config/couchdb.yml file. Check and make sure it's present and the syntax is correct."

else

  COUCHDB_CONFIG = {
    :host_path => "#{protocol}://#{authorized_host}:#{port}",
    :db_prefix => "#{db_prefix}",
    :db_suffix => "#{db_suffix}"
  }

  COUCHDB_SERVER = CouchRest.new COUCHDB_CONFIG[:host_path]

  class CouchRest::Database
    def search(design, index, query, options={})
      CouchRest.get CouchRest.paramify_url("#{@root}/_fti/#{design}/#{index}", options.merge(:q => query))
    end
  end

  class CouchRest::ExtendedDocument
    def self.search(index, query, options={})
      unless design_doc_fresh            
          refresh_design_doc_on(database)
      end
      options[:include_docs] = true
      ret = self.database.search(self.to_s, index, query, options)
      ret['rows'].collect!{|r| self.new(r['doc'])}
      ret
    end
  end

end

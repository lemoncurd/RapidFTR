
# Before each scenario...
Before do
#  CouchRestRails::Tests.setup
  CouchRestRails::Lucene.push
  # force an initial search to 'prime' couchdb-lucene
  Summary.basic_search("random_string", nil);
end

# After each scenario...
After do
#  CouchRestRails::Tests.teardown
end
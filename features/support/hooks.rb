
# Before each scenario...
Before do
#  CouchRestRails::Tests.setup
  CouchRestRails::Lucene.push
end

# After each scenario...
After do
#  CouchRestRails::Tests.teardown
end
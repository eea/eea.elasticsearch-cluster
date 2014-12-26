curl -XPUT 'http://172.17.0.33:9200/_river/rdf_river/_meta' -d '{
  "type" : "eeaRDF",
  "eeaRDF" : {
     "uris" : ["http://dd.eionet.europa.eu/vocabulary/aq/pollutant/rdf",
               "http://dd.eionet.europa.eu/vocabulary/aq/measurementmethod/rdf"]
   }
}'

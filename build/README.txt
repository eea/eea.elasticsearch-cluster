Building and publishing images to the amplab account:
  1. make sure IMAGE_PREFIX="" (see build_all_elasticsearch.sh)
  2. build_all_elasticsearch.sh
  3. set IMAGE_PREFIX="eeacms/"
  4. build_all_elasticsearch.sh
  5. tag_all.sh
  6. push_all.sh 

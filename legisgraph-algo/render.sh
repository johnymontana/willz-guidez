GUIDES=../

function render {
$GUIDES/run.sh legis-graph-algo.adoc index.html +1 "$@"
}

if [ "$1" == "publish" ]; then
  URL=guides.neo4j.com/legisgraphalgo
  render http://$URL -a csv-url=file:/// -a env-training
  s3cmd put --recursive -P *.html img s3://${URL}/
  s3cmd put -P index.html s3://${URL}

  echo "Publication Done"
else
  URL=localhost:8001
# copy the csv files to $NEO4J_HOME/import
  #render http://$URL -a csv-url=file:/// -a env-training
  #render http://$URL -a csv-url=https://raw.githubusercontent.com/johnymontana/la-datascience-pop/master/data/ -a env-training
  render http://$URL -a csv-url=file:/// -a env-training
  echo "Starting Websever at $URL Ctrl-c to stop"
  python $GUIDES/http-server.py
fi
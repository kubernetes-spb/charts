IMG=fulldive/elasticsearch-kubernetes:5.4.2
docker build -t $IMG .
docker push $IMG
echo "Done: $IMG"

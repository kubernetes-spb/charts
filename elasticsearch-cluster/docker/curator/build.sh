VERSION=5.1.1
IMG=fulldive/elasticsearch-curator:$VERSION
docker build --build-arg VERSION=$VERSION -t $IMG .
docker push $IMG
echo "Done: $IMG"

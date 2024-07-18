BASEDIR=$(dirname $0)
UNITYPATH=$BASEDIR/..
BEACONMODELNAME=beacon-v2-default-model

for KIND in src json
do
	mkdir -p $UNITYPATH/models/$KIND/$BEACONMODELNAME
	mkdir -p $UNITYPATH/framework/$KIND	
done

# recurring conversion from the source files to the exported versions
$BASEDIR/beaconYamler.py -i $UNITYPATH/models/src/$BEACONMODELNAME -t yaml -x json -o $UNITYPATH/models/json/$BEACONMODELNAME
$BASEDIR/beaconYamler.py -i $UNITYPATH/framework/src -t yaml -x json -o $UNITYPATH/framework/json

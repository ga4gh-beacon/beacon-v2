BASEDIR=$(dirname $0)
UNITYPATH=$BASEDIR/..

# initial conversion from separate schemas
BEACONMODELPATH=$BASEDIR/../../beacon-v2-Models/BEACON-V2-Model
BEACONFRAMEWORKPATH=$BASEDIR/../../beacon-framework-v2

BEACONMODELNAME=beacon-v2-default-model

for UPSTREAM in $BEACONMODELPATH $BEACONFRAMEWORKPATH
do
	echo "pulling $UPSTREAM"
	git -C $UPSTREAM pull
done

for KIND in src json
do
	mkdir -p $UNITYPATH/models/$KIND/$BEACONMODELNAME
	mkdir -p $UNITYPATH/framework/$KIND	
done

$BASEDIR/beaconYamler.py -i $BEACONMODELPATH -t json -x yaml -o $UNITYPATH/models/src/$BEACONMODELNAME
$BASEDIR/beaconYamler.py -i $BEACONFRAMEWORKPATH -t json -x yaml -o $UNITYPATH/framework/src

# recurring conversion from the source files to the exported versions
$BASEDIR/beaconYamler.py -i $UNITYPATH/models/src/$BEACONMODELNAME -t yaml -x json -o $UNITYPATH/models/json/$BEACONMODELNAME
$BASEDIR/beaconYamler.py -i $UNITYPATH/framework/src -t yaml -x json -o $UNITYPATH/framework/json

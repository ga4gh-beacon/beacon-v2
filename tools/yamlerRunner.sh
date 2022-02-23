BASEDIR=$(dirname $0)
UNITYPATH=$BASEDIR/..

# initial conversion from separate schemas
BEACONMODELPATH=$BASEDIR/../../beacon-v2-Models/BEACON-V2-Model
BEACONFRAMEWORKPATH=$BASEDIR/../../beacon-framework-v2

$BASEDIR/beaconYamler.py -i $BEACONMODELPATH -t json -x yaml -o $UNITYPATH/models/src
$BASEDIR/beaconYamler.py -i $BEACONFRAMEWORKPATH -t json -x yaml -o $UNITYPATH/framework/src

# recurring conversion from the source files to the exported versions
$BASEDIR/beaconYamler.py -i $UNITYPATH/models/src -t yaml -x json -o $UNITYPATH/models/json
$BASEDIR/beaconYamler.py -i $UNITYPATH/framework/src -t yaml -x json -o $UNITYPATH/framework/json

$BASEDIR/beaconYamler.py -i $UNITYPATH/models/src -t yaml -x yaml -o $UNITYPATH/models/yaml
$BASEDIR/beaconYamler.py -i $UNITYPATH/framework/src -t yaml -x yaml -o $UNITYPATH/framework/yaml

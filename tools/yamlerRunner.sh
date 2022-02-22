BASEDIR=$(dirname $0)
UNITYPATH=$BASEDIR/..

# initial conversion from separate schemas
# BEACONMODELPATH=$BASEDIR/../../beacon-v2-Models/BEACON-V2-Model
# BEACONFRAMEWORKPATH=$BASEDIR/../../beacon-framework-v2

# $BASEDIR/yamler.py -i $BEACONMODELPATH -t json -o $UNITYPATH/models/src
# $BASEDIR/yamler.py -i $BEACONFRAMEWORKPATH -t json -o $UNITYPATH/framework/src

# recurring conversion from the source files to the exported versions
$BASEDIR/yamler.py -i $UNITYPATH/models/src -t yaml -x json -o $UNITYPATH/models/json
$BASEDIR/yamler.py -i $UNITYPATH/framework/src -t yaml -x json -o $UNITYPATH/framework/json

$BASEDIR/yamler.py -i $UNITYPATH/models/src -t yaml -x yaml -o $UNITYPATH/models/yaml
$BASEDIR/yamler.py -i $UNITYPATH/framework/src -t yaml -x yaml -o $UNITYPATH/framework/yaml

#!/bin/bash
echo qtbase-opensource-src | ./tools/gen_dsc_source.bash >> linglong.yaml
./modules.list.sh | ./tools/gen_dsc_source.bash >> linglong.yaml
./depend-deb-list.sh | ./tools/gen_deb_source.bash >> linglong.yaml
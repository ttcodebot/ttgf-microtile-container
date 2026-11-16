#!/usr/bin/env bash
# LVS of an assembled micro tile container with LibreLane: Magic extracts the layout
# from the GDS (including the contents of the micro tiles), Netgen compares it with
# the stitched netlist (container + micro tiles in one file).
#
# Usage: lvs/run.sh <gds> <netlist> <run tag>
set -euo pipefail
GDS=$(realpath "$1")
NETLIST=$(realpath "$2")
TAG="$3"
MACRO=$(basename "$NETLIST" .v)
HERE=$(dirname "$(realpath "$0")")

cat > "config_$TAG.json" <<EOF
{
  "DESIGN_NAME": "$MACRO",
  "VERILOG_FILES": ["$NETLIST"],
  "CLOCK_PORT": "clk",
  "VDD_PIN": "VPWR",
  "GND_PIN": "VGND",
  "MAGIC_EXT_USE_GDS": true,
  "LVS_INCLUDE_MARCO_NETLISTS": false
}
EOF
# The extraction step also wants a DEF in its input state. It is not read when the
# layout comes from the GDS.
cat > "state_$TAG.json" <<EOF
{
  "gds": "$GDS",
  "def": "$HERE/unused.def",
  "pnl": "$NETLIST",
  "nl": "$NETLIST",
  "metrics": {}
}
EOF
python -m librelane ${LIBRELANE_ARGS:---docker-no-tty --dockerized} --pdk gf180mcuD \
  --run-tag "$TAG" --overwrite --hide-progress-bar \
  --from Magic.SpiceExtraction --to Checker.LVS \
  -i "state_$TAG.json" "config_$TAG.json"
grep -h "Final result" runs/"$TAG"/*netgen-lvs/reports/lvs.netgen.rpt

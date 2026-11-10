# PDN configuration for the micro tile container (gf180mcuD).
#
# The container has the standard Tiny Tapeout power grid: vertical Metal4 stripes
# (VPWR / VGND pairs) over Metal1 standard cell rails, no horizontal layer.
#
# The micro tiles use Metal1 to Metal3. Their power pins are horizontal Metal3
# stripes, so the Metal4 stripes of the container run straight over the micro tiles
# and the macro grid below drops a Via3 array wherever a Metal4 stripe crosses a
# Metal3 stripe of the same net. No alignment between the two grids is needed.

source $::env(SCRIPTS_DIR)/openroad/common/set_global_connections.tcl
set_global_connections

set_voltage_domain -name CORE -power $::env(VDD_NET) -ground $::env(GND_NET)

# Standard cell grid: Metal4 stripes, exported as the power pins of the tile
define_pdn_grid \
    -name stdcell_grid \
    -starts_with POWER \
    -voltage_domain CORE \
    -pins $::env(PDN_VERTICAL_LAYER)

add_pdn_stripe \
    -grid stdcell_grid \
    -layer $::env(PDN_VERTICAL_LAYER) \
    -width $::env(PDN_VWIDTH) \
    -pitch $::env(PDN_VPITCH) \
    -offset $::env(PDN_VOFFSET) \
    -spacing $::env(PDN_VSPACING) \
    -starts_with POWER \
    -extend_to_core_ring

# Standard cell rails
add_pdn_stripe \
    -grid stdcell_grid \
    -layer $::env(PDN_RAIL_LAYER) \
    -width $::env(PDN_RAIL_WIDTH) \
    -followpins

add_pdn_connect \
    -grid stdcell_grid \
    -layers "$::env(PDN_RAIL_LAYER) $::env(PDN_VERTICAL_LAYER)"

# Micro tiles: connect their Metal3 power stripes to the Metal4 stripes above
define_pdn_grid \
    -macro \
    -default \
    -name macro \
    -starts_with POWER \
    -halo "$::env(PDN_HORIZONTAL_HALO) $::env(PDN_VERTICAL_HALO)"

add_pdn_connect \
    -grid macro \
    -layers "Metal3 $::env(PDN_VERTICAL_LAYER)"

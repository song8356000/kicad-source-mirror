#
# This program source code file is part of KiCad, a free EDA CAD application.
#
# Copyright (C) 2017 CERN
# @author Alejandro García Montoro <alejandro.garciamontoro@gmail.com>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, you may find one here:
# http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
# or you may search the http://www.gnu.org website for the version 2 license,
# or you may write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA


include_directories( BEFORE ${INC_BEFORE} )

include_directories(
    ${CMAKE_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/include
    ${CMAKE_SOURCE_DIR}/pcbnew
    ${CMAKE_SOURCE_DIR}/qa/qa_utils
    ${INC_AFTER}
    )

set( QA_EESCHEMA_SRCS
    # need the mock Pgm for many functions
    mocks_eeschema.cpp

    eeschema_test_utils.cpp
    uuid_test_utils.cpp

    # The main test entry points
    test_module.cpp

    # Base internal units (1=100nm) testing.
    test_sch_biu.cpp

    # Shared between programs, but dependent on the BIU
    ${CMAKE_SOURCE_DIR}/qa/common/test_format_units.cpp
    ${CMAKE_SOURCE_DIR}/qa/common/test_array_options.cpp

    sch_plugins/altium/test_altium_parser_sch.cpp

    test_eagle_plugin.cpp
    test_lib_part.cpp
    test_netlists.cpp
    test_ee_item.cpp
    test_sch_pin.cpp
    test_sch_rtree.cpp
    test_sch_sheet.cpp
    test_sch_sheet_path.cpp
    test_sch_sheet_list.cpp
    test_sch_symbol.cpp
)


# Spice specific testing routine
if( KICAD_SPICE )
    set( QA_EESCHEMA_SRCS
        ${QA_EESCHEMA_SRCS}
        # Simulation tests
        sim/test_netlist_exporter_pspice_sim.cpp
    )
endif()

add_executable( qa_eeschema
    ${QA_EESCHEMA_SRCS}
)

target_link_libraries( qa_eeschema
    eeschema_kiface_objects
    common
    pcbcommon
    scripting
    kimath
    qa_utils
    markdown_lib
    ${GDI_PLUS_LIBRARIES}
    ${Boost_LIBRARIES}
)

# Eeschema tests, so pretend to be eeschema (for units, etc)
target_compile_definitions( qa_eeschema
    PUBLIC EESCHEMA
)

# Pass in the default data location
set_source_files_properties( eeschema_test_utils.cpp PROPERTIES
    COMPILE_DEFINITIONS "QA_EESCHEMA_DATA_LOCATION=(\"${CMAKE_CURRENT_SOURCE_DIR}/data\")"
)

kicad_add_boost_test( qa_eeschema qa_eeschema )


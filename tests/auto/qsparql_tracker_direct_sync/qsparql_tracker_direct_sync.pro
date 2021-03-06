include(../sparqltest.pri)
CONFIG += qt warn_on console depend_includepath
QT += testlib
HEADERS += ../tracker_direct_common.h
SOURCES  += tst_qsparql_tracker_direct_sync.cpp ../tracker_direct_common.cpp

check.depends = $$TARGET
check.commands = ./tst_qsparql_tracker_direct_sync

memcheck.depends = $$TARGET
memcheck.commands = $$VALGRIND $$VALGRIND_OPT ./tst_qsparql_tracker_direct_sync

QMAKE_EXTRA_TARGETS += check memcheck

#QT = sparql # enable this later


########### next target ###############

set(krunner_qalculatorrunner_SRCS
    qalculatorrunner.cpp
)

kde4_add_plugin(krunner_qalculatorrunner ${krunner_qalculatorrunner_SRCS})
target_link_libraries(krunner_qalculatorrunner ${KDE4_KDEUI_LIBS} ${QT_QTSCRIPT_LIBRARY} ${KDE4_PLASMA_LIBS})

install(TARGETS krunner_qalculatorrunner DESTINATION ${PLUGIN_INSTALL_DIR} )


########### install files ###############

install(FILES plasma-runner-qalculator.desktop DESTINATION ${SERVICES_INSTALL_DIR})


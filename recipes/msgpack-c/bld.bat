mkdir build
cd build

IF "%ARCH%"=="32" (
    SET EXTRA_COMPILE_FLAGS=
) ELSE (
    SET EXTRA_COMPILE_FLAGS=/wd4267 /wd4244
)

SET GENERATOR=%CMAKE_GENERATOR%

IF "%TARGET_ARCH%"=="x64" IF "%CONDA_PY%"=="27" SET GENERATOR=NMake Makefiles

cmake ^
    -G "%GENERATOR%" ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_CXX_FLAGS='"/D_VARIADIC_MAX=10 /EHsc %EXTRA_COMPILE_FLAGS%"' ^
    -DCMAKE_C_FLAGS="%COMPILE_FLAGS%" ^
    -DBoost_INCLUDE_DIRS=%LIBRARY_PREFIX%\include ^
    -DMSGPACK_BOOST_DIR=%LIBRARY_PREFIX%\include ^
    -DMSGPACK_BOOST=YES ^
    -DCMAKE_BUILD_TYPE=Release ^
    ..

cmake --build . --config Release
cmake --build . --config Release --target install

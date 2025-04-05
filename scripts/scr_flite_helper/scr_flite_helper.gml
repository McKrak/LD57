function flite_speak(_str, _voice = "awb", _mean = 95, _sd = 11, _rate = 1.1) {
    execute_shell_simple($"{ROOT_DIR}\\Vox\\flite.exe", $"-voice {_voice} -s int_f0_target_mean={_mean} -s int_f0_target_stddev={_sd} -s duration_stretch={_rate} \"{_str}\"",,0);      
}
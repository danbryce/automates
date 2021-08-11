from automates.apps.automates.execute_driver import execute_gromet_experiment_json


def test_execute_sir_simple_mock():
    input_json = {
        "command": "simulate-gsl",
        "definition": {"type": "easel", "source": {"model": '{"name": "SIR-simple"}'}},
        "start": 0,
        "end": 120.0,
        "step": 30.0,
        "domain_parameter": "SIR-simple::SIR-simple::sir::0::--::dt::0",
        "parameters": {
            "SIR-simple::SIR-simple::sir::0::--::beta::0": 0.5,
            "SIR-simple::SIR-simple::sir::0::--::s::0": 100000,
            "SIR-simple::SIR-simple::sir::0::--::i::0": 1,
            "SIR-simple::SIR-simple::sir::0::--::r::0": 0,
            "SIR-simple::SIR-simple::sir::0::--::gamma::0": 0.07,
        },
        "outputs": [
            "SIR-simple::SIR-simple::sir::0::--::s::1",
            "SIR-simple::SIR-simple::sir::0::--::i::1",
            "SIR-simple::SIR-simple::sir::0::--::r::1",
        ],
    }
    result = execute_gromet_experiment_json(input_json)

    expected = {
        "body": {
            "domain_parameter": [0, 30, 60, 90, 120],
            "values": {
                "SIR-simple::SIR-simple::sir::0::--::i::1": [
                    13.899850001499987,
                    193.17455602717965,
                    2678.622276802565,
                    35981.04345749553,
                    273225.5469052609,
                ],
                "SIR-simple::SIR-simple::sir::0::--::r::1": [
                    2.1,
                    31.289685003149977,
                    436.9562526602273,
                    6062.063033945615,
                    81622.25429468622,
                ],
                "SIR-simple::SIR-simple::sir::0::--::s::1": [
                    99985.0001499985,
                    99776.53575896967,
                    96885.4214705372,
                    57957.893508558845,
                    -254846.80119994713,
                ],
            },
        },
        "status": 200,
    }

    assert expected == result


def test_execute_chime_sir_mock():
    input_json = {
        "command": "simulate-gsl",
        "definition": {"type": "easel", "source": {"model": '{"name": "CHIME-SIR"}'}},
        "start": 0,
        "end": 120.0,
        "step": 30,
        "domain_parameter": "CHIME_SIR::CHIME_SIR::main::0::--::n_days::0",
        "parameters": {
            "CHIME_SIR::CHIME_SIR::main::0::--::growth_rate::0": 0.0,
            "CHIME_SIR::CHIME_SIR::main::0::--::beta::0": 0.0,
            "CHIME_SIR::CHIME_SIR::main::0::--::i_day::0": 17.0,
            "CHIME_SIR::CHIME_SIR::main::0::--::N_p::0": 3,
            "CHIME_SIR::CHIME_SIR::main::0::--::infections_days::0": 14.0,
            "CHIME_SIR::CHIME_SIR::main::0::--::relative_contact_rate::0": 0.05,
            "CHIME_SIR::CHIME_SIR::main::0::--::s_n::0": 200,
            "CHIME_SIR::CHIME_SIR::main::0::--::i_n::0": 1,
            "CHIME_SIR::CHIME_SIR::main::0::--::r_n::0": 1,
        },
        "outputs": [
            "CHIME_SIR::CHIME_SIR::main::0::--::s_a::1",
            "CHIME_SIR::CHIME_SIR::main::0::--::i_a::1",
            "CHIME_SIR::CHIME_SIR::main::0::--::e_a::1",
            "CHIME_SIR::CHIME_SIR::main::0::--::r_a::1",
        ],
    }
    result = execute_gromet_experiment_json(input_json)

    expected = {
        "body": {
            "domain_parameter": [0, 30, 60, 90, 120],
            "values": {
                "CHIME_SIR::CHIME_SIR::main::0::--::e_a::1": [0.0, 0.0, 0.0, 0.0, 0.0],
                "CHIME_SIR::CHIME_SIR::main::0::--::i_a::1": [
                    0.0,
                    0.8933233135653156,
                    0.7806198884453974,
                    0.6712711762750359,
                    0.5693715755370689,
                ],
                "CHIME_SIR::CHIME_SIR::main::0::--::r_a::1": [
                    0.0,
                    2.965680650912271,
                    4.763081925816063,
                    6.3215644582752715,
                    7.652866183157096,
                ],
                "CHIME_SIR::CHIME_SIR::main::0::--::s_a::1": [
                    0.0,
                    198.14099603552242,
                    196.45629818573855,
                    195.00716436544968,
                    193.77776224130582,
                ],
            },
        },
        "status": 200,
    }

    assert result == expected
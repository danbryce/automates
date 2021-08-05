def drive(start, end, step, parameters):
    step_results = {"S": list(), "I": list(), "R": list(), "dt": list()}

    for i in range(start, end + 1, step):
        (S, I, R) = sir(
            parameters["S"],
            parameters["I"],
            parameters["R"],
            parameters["beta"],
            parameters["gamma"],
            i,
        )

        step_results["S"].append(S)
        step_results["I"].append(I)
        step_results["R"].append(R)
        step_results["dt"].append(i)

    return step_results


"""
Derived from the following:

    ********************************************************************************
    !     Input Variables:
    !     S        Amount of susceptible members at the current timestep
    !     I        Amount of infected members at the current timestep
    !     R        Amount of recovered members at the current timestep
    !     beta     Rate of transmission via contact
    !     gamma    Rate of recovery from infection
    !     dt       Next inter-event time
    !
    !     State Variables:
    !     infected    Increase in infected at the current timestep
    !     recovered   Increase in recovered at the current timestep
    ********************************************************************************
        subroutine sir(S, I, R, beta, gamma, dt)
            implicit none
            double precision S, I, R, beta, gamma, dt
            double precision infected, recovered

            infected = ((beta*S*I) / (S + I + R)) * dt
            recovered = (gamma*I) * dt

            S = S - infected
            I = I + infected - recovered
            R = R + recovered
        end subroutine sir
"""


def sir(S: float, I: float, R: float, beta: float, gamma: float, dt: float):
    """
    !     Input Variables:
    !     S        Amount of susceptible members at the current timestep
    !     I        Amount of infected members at the current timestep
    !     R        Amount of recovered members at the current timestep
    !     beta     Rate of transmission via contact
    !     gamma    Rate of recovery from infection
    !     dt       Next inter-event time
    !
    !     State Variables:
    !     infected    Increase in infected at the current timestep
    !     recovered   Increase in recovered at the current timestep
    """

    infected = ((beta * S * I) / (S + I + R)) * dt
    recovered = (gamma * I) * dt

    S = S - infected
    I = I + infected - recovered
    R = R + recovered

    return (S, I, R)
